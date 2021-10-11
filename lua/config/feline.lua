require("feline").setup {
	preset = "default",
	custom_providers = {
		lsp_status = function()
			return #vim.lsp.buf_get_clients() > 0 and require("lsp-status").status() or ""
		end,

		lsp_progress = function()
			return #vim.lsp.buf_get_clients() > 0 and require("lsp").lsp_progress() or ""
		end,
	},
}

local components = require("feline.presets")["default"]

if components.active[1] then
	table.insert(components.active[1], {
		provider = "lsp_client_names",
		left_sep = "  ",
	})
	table.insert(components.active[1], {
		provider = "lsp_progress",
		left_sep = " ",
		-- right_sep = ' ',
	})
end

-- enable full-path type for file_info
-- https://github.com/famiu/feline.nvim/blob/3b46ef0bbf87732435ef54c1fef4f8cc9fceec3f/doc/feline.txt#L801
-- https://github.com/famiu/feline.nvim/blob/3b46ef0bbf87732435ef54c1fef4f8cc9fceec3f/lua/feline/presets/default.lua#L27
if components.active[1][3] and components.active[1][3].provider == "file_info" then
	components.active[1][3].provider = {
		name = "file_info",
		opts = {
			type = "full-path",
		},
	}

	components.active[1][3].short_provider = {
		name = "file_info",
		opts = {
			type = "short-path",
		},
	}
	-- this will not work, see function parse_provider https://github.com/famiu/feline.nvim/blob/3b46ef0bbf87732435ef54c1fef4f8cc9fceec3f/lua/feline/generator.lua#L217
	-- components.active[1][3].opts = { type = "full-path" }
end

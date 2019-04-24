Received: from eggs.gnu.org ([209.51.188.92]:45538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN69-0001z4-Ew
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuw-00065g-Cg
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuw-000654-3k
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id n25so6515699wmk.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:50 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Wed, 24 Apr 2019 21:46:00 +0300
Message-Id: <20190424184600.8445-20-arilou@gmail.com>
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 20/20] gdbstub: Refactor parse handle packet
 to work with a static array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 386 ++++++++++++++++++++++--------------------------------
 1 file changed, 158 insertions(+), 228 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 61ab630d9e..69b3a5185e 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2257,240 +2257,170 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "");
 }
 
-static int gdb_handle_packet(GDBState *s, const char *line_buf)
+static void handle_extend_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    put_packet(gdb_ctx->s, "OK");
+}
+
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     char thread_id[16];
 
+    /* TODO: Make this return the correct value for user-mode.  */
+    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
+                      sizeof(thread_id));
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s;",
+             GDB_SIGNAL_TRAP, thread_id);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+    /*
+     * Remove all the breakpoints when this query is issued,
+     * because gdb is doing and initial connect and the state
+     * should be cleaned up.
+     */
+    gdb_breakpoint_remove_all();
+}
+
+static void handle_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    /* Kill the target */
+    error_report("QEMU: Terminated via GDBstub");
+    exit(0);
+}
+
+static GdbCmdParseEntry gdb_packet_table[0x100] = {
+    ['!'] = {
+        .handler = handle_extend_mode,
+        .cmd = "!",
+        .cmd_startswith = 1
+    },
+    ['?'] = {
+        .handler = handle_target_halt,
+        .cmd = "?",
+        .cmd_startswith = 1
+    },
+    ['c'] = {
+        .handler = handle_continue,
+        .cmd = "c",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['C'] = {
+        .handler = handle_cont_with_sig,
+        .cmd = "C",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    ['v'] = {
+        .handler = handle_v_commands,
+        .cmd = "v",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['k'] = {
+        .handler = handle_kill,
+        .cmd = "k",
+        .cmd_startswith = 1
+    },
+    ['D'] = {
+        .handler = handle_detach,
+        .cmd = "D",
+        .cmd_startswith = 1,
+        .schema = "?.l0"
+    },
+    ['s'] = {
+        .handler = handle_step,
+        .cmd = "s",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['F'] = {
+        .handler = handle_file_io,
+        .cmd = "F",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['g'] = {
+        .handler = handle_read_all_regs,
+        .cmd = "g",
+        .cmd_startswith = 1
+    },
+    ['G'] = {
+        .handler = handle_write_all_regs,
+        .cmd = "G",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['m'] = {
+        .handler = handle_read_mem,
+        .cmd = "m",
+        .cmd_startswith = 1,
+        .schema = "L,L0"
+    },
+    ['M'] = {
+        .handler = handle_write_mem,
+        .cmd = "M",
+        .cmd_startswith = 1,
+        .schema = "L,L:s0"
+    },
+    ['p'] = {
+        .handler = handle_get_reg,
+        .cmd = "p",
+        .cmd_startswith = 1,
+        .schema = "L0"
+    },
+    ['P'] = {
+        .handler = handle_set_reg,
+        .cmd = "P",
+        .cmd_startswith = 1,
+        .schema = "L?s0"
+    },
+    ['Z'] = {
+        .handler = handle_insert_bp,
+        .cmd = "Z",
+        .cmd_startswith = 1,
+        .schema = "l?L?L0"
+    },
+    ['z'] = {
+        .handler = handle_remove_bp,
+        .cmd = "z",
+        .cmd_startswith = 1,
+        .schema = "l?L?L0"
+    },
+    ['H'] = {
+        .handler = handle_set_thread,
+        .cmd = "H",
+        .cmd_startswith = 1,
+        .schema = "o.t0"
+    },
+    ['T'] = {
+        .handler = handle_thread_alive,
+        .cmd = "T",
+        .cmd_startswith = 1,
+        .schema = "t0"
+    },
+    ['q'] = {
+        .handler = handle_gen_query,
+        .cmd = "q",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+    ['Q'] = {
+        .handler = handle_gen_set,
+        .cmd = "Q",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+};
+
+static int gdb_handle_packet(GDBState *s, const char *line_buf)
+{
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
-    case '!':
-        put_packet(s, "OK");
-        break;
-    case '?':
-        /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
-        put_packet(s, buf);
-        /* Remove all the breakpoints when this query is issued,
-         * because gdb is doing and initial connect and the state
-         * should be cleaned up.
-         */
-        gdb_breakpoint_remove_all();
-        break;
-    case 'c':
-        {
-            static GdbCmdParseEntry continue_cmd_desc = {
-                .handler = handle_continue,
-                .cmd = "c",
-                .cmd_startswith = 1,
-                .schema = "L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
-        }
-        break;
-    case 'C':
-        {
-            static GdbCmdParseEntry cont_with_sig_cmd_desc = {
-                .handler = handle_cont_with_sig,
-                .cmd = "C",
-                .cmd_startswith = 1,
-                .schema = "l0"
-            };
-            process_string_cmd(s, NULL, line_buf, &cont_with_sig_cmd_desc, 1);
-        }
-        break;
-    case 'v':
-        {
-            static GdbCmdParseEntry v_cmd_desc = {
-                .handler = handle_v_commands,
-                .cmd = "v",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &v_cmd_desc, 1);
-        }
-        break;
-    case 'k':
-        /* Kill the target */
-        error_report("QEMU: Terminated via GDBstub");
-        exit(0);
-    case 'D':
-        {
-            static GdbCmdParseEntry deatch_cmd_desc = {
-                .handler = handle_detach,
-                .cmd = "D",
-                .cmd_startswith = 1,
-                .schema = "?.l0"
-            };
-            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);
-        }
-        break;
-    case 's':
-        {
-            static GdbCmdParseEntry step_cmd_desc = {
-                .handler = handle_step,
-                .cmd = "s",
-                .cmd_startswith = 1,
-                .schema = "L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &step_cmd_desc, 1);
-        }
-        break;
-    case 'F':
-        {
-            static GdbCmdParseEntry file_io_cmd_desc = {
-                .handler = handle_file_io,
-                .cmd = "F",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &file_io_cmd_desc, 1);
-        }
-        break;
-    case 'g':
-        {
-            static GdbCmdParseEntry read_all_regs_cmd_desc = {
-                .handler = handle_read_all_regs,
-                .cmd = "g",
-                .cmd_startswith = 1
-            };
-            process_string_cmd(s, NULL, line_buf, &read_all_regs_cmd_desc, 1);
-        }
-        break;
-    case 'G':
-        {
-            static GdbCmdParseEntry write_all_regs_cmd_desc = {
-                .handler = handle_write_all_regs,
-                .cmd = "G",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &write_all_regs_cmd_desc, 1);
-        }
-        break;
-    case 'm':
-        {
-            static GdbCmdParseEntry read_mem_cmd_desc = {
-                .handler = handle_read_mem,
-                .cmd = "m",
-                .cmd_startswith = 1,
-                .schema = "L,L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &read_mem_cmd_desc, 1);
-        }
-        break;
-    case 'M':
-        {
-            static GdbCmdParseEntry write_mem_cmd_desc = {
-                .handler = handle_write_mem,
-                .cmd = "M",
-                .cmd_startswith = 1,
-                .schema = "L,L:s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &write_mem_cmd_desc, 1);
-        }
-        break;
-    case 'p':
-        {
-            static GdbCmdParseEntry get_reg_cmd_desc = {
-                .handler = handle_get_reg,
-                .cmd = "p",
-                .cmd_startswith = 1,
-                .schema = "L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &get_reg_cmd_desc, 1);
-        }
-        break;
-    case 'P':
-        {
-            static GdbCmdParseEntry set_reg_cmd_desc = {
-                .handler = handle_set_reg,
-                .cmd = "P",
-                .cmd_startswith = 1,
-                .schema = "L?s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &set_reg_cmd_desc, 1);
-        }
-        break;
-    case 'Z':
-        {
-            static GdbCmdParseEntry insert_bp_cmd_desc = {
-                .handler = handle_insert_bp,
-                .cmd = "Z",
-                .cmd_startswith = 1,
-                .schema = "l?L?L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &insert_bp_cmd_desc, 1);
-        }
-        break;
-    case 'z':
-        {
-            static GdbCmdParseEntry remove_bp_cmd_desc = {
-                .handler = handle_remove_bp,
-                .cmd = "z",
-                .cmd_startswith = 1,
-                .schema = "l?L?L0"
-            };
-            process_string_cmd(s, NULL, line_buf, &remove_bp_cmd_desc, 1);
-        }
-        break;
-    case 'H':
-        {
-            static GdbCmdParseEntry set_thread_cmd_desc = {
-                .handler = handle_set_thread,
-                .cmd = "H",
-                .cmd_startswith = 1,
-                .schema = "o.t0"
-            };
-            process_string_cmd(s, NULL, line_buf, &set_thread_cmd_desc, 1);
-        }
-        break;
-    case 'T':
-        {
-            static GdbCmdParseEntry thread_alive_cmd_desc = {
-                .handler = handle_thread_alive,
-                .cmd = "T",
-                .cmd_startswith = 1,
-                .schema = "t0"
-            };
-            process_string_cmd(s, NULL, line_buf, &thread_alive_cmd_desc, 1);
-        }
-        break;
-    case 'q':
-        {
-            static GdbCmdParseEntry gen_query_cmd_desc = {
-                .handler = handle_gen_query,
-                .cmd = "q",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &gen_query_cmd_desc, 1);
-        }
-        break;
-    case 'Q':
-        {
-            static GdbCmdParseEntry gen_set_cmd_desc = {
-                .handler = handle_gen_set,
-                .cmd = "Q",
-                .cmd_startswith = 1,
-                .schema = "s0"
-            };
-            process_string_cmd(s, NULL, line_buf, &gen_set_cmd_desc, 1);
-        }
-        break;
-    default:
-        /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
-        break;
+    if (process_string_cmd(s, NULL, line_buf,
+                           &gdb_packet_table[*(uint8_t *)line_buf], 1)) {
+        put_packet(s, "");
     }
+
     return RS_IDLE;
 }
 
-- 
2.20.1

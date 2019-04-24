Received: from eggs.gnu.org ([209.51.188.92]:45555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6C-0001zm-Ly
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuo-0005zX-Ge
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMum-0005wr-Il
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id v14so6525029wmf.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Wed, 24 Apr 2019 21:45:55 +0300
Message-Id: <20190424184600.8445-15-arilou@gmail.com>
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 15/20] gdbstub: Implement file io (F pkt)
 with new infra
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
 gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b9ac9401ed..772bcd2e1f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1782,6 +1782,39 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int num_syscall_params;
+    GdbCmdVariant syscall_params[3] = {};
+
+    if (!gdb_ctx->num_params) {
+        return;
+    }
+
+    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_params,
+                         &num_syscall_params)) {
+        return;
+    }
+
+    if (!num_syscall_params) {
+        return;
+    }
+
+    if (gdb_ctx->s->current_syscall_cb) {
+        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
+                                       (target_ulong)syscall_params[0].val_ull,
+                                       (target_ulong)syscall_params[1].val_ull);
+        gdb_ctx->s->current_syscall_cb = NULL;
+    }
+
+    if (syscall_params[2].opcode == (uint8_t)'C') {
+        put_packet(gdb_ctx->s, "T02");
+        return;
+    }
+
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1922,28 +1955,13 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         return RS_IDLE;
     case 'F':
         {
-            target_ulong ret;
-            target_ulong err;
-
-            ret = strtoull(p, (char **)&p, 16);
-            if (*p == ',') {
-                p++;
-                err = strtoull(p, (char **)&p, 16);
-            } else {
-                err = 0;
-            }
-            if (*p == ',')
-                p++;
-            type = *p;
-            if (s->current_syscall_cb) {
-                s->current_syscall_cb(s->c_cpu, ret, err);
-                s->current_syscall_cb = NULL;
-            }
-            if (type == 'C') {
-                put_packet(s, "T02");
-            } else {
-                gdb_continue(s);
-            }
+            static GdbCmdParseEntry file_io_cmd_desc = {
+                .handler = handle_file_io,
+                .cmd = "F",
+                .cmd_startswith = 1,
+                .schema = "s0"
+            };
+            process_string_cmd(s, NULL, line_buf, &file_io_cmd_desc, 1);
         }
         break;
     case 'g':
-- 
2.20.1

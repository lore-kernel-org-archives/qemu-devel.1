Received: from eggs.gnu.org ([209.51.188.92]:60886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQS-0000Yc-S6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQR-0002BB-Ty
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQR-0002A9-O2
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id h18so10619551wml.1
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:31 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:26:35 +0300
Message-Id: <20190425132636.31636-21-arilou@gmail.com>
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 20/21] gdbstub: Implement target halted (?
 pkt) with new infra
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
 gdbstub.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 779da2aa77..8838241209 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2248,13 +2248,30 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "");
 }
 
+static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    char thread_id[16];
+
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
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     const char *p;
     int ch;
     uint8_t mem_buf[MAX_PACKET_LENGTH];
     char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
-    char thread_id[16];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
@@ -2266,15 +2283,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         put_packet(s, "OK");
         break;
     case '?':
-        /* TODO: Make this return the correct value for user-mode.  */
-        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
-                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread_id)));
-        put_packet(s, buf);
-        /* Remove all the breakpoints when this query is issued,
-         * because gdb is doing and initial connect and the state
-         * should be cleaned up.
-         */
-        gdb_breakpoint_remove_all();
+        {
+            static const GdbCmdParseEntry target_halted_cmd_desc = {
+                .handler = handle_target_halt,
+                .cmd = "?",
+                .cmd_startswith = 1
+            };
+            cmd_parser = &target_halted_cmd_desc;
+        }
         break;
     case 'c':
         {
-- 
2.20.1

Received: from eggs.gnu.org ([209.51.188.92]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJN6J-0002Db-A6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJMuQ-0005Vl-Ox
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJMuQ-0005Uw-JI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:46:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id t17so26522679wrw.13
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 11:46:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Wed, 24 Apr 2019 21:45:44 +0300
Message-Id: <20190424184600.8445-4-arilou@gmail.com>
In-Reply-To: <20190424184600.8445-1-arilou@gmail.com>
References: <20190424184600.8445-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/20] gdbstub: Implement continue (c pkt)
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
 gdbstub.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 7704edd69c..47b1e7e7a4 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1532,6 +1532,16 @@ static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
+    }
+
+    gdb_ctx->s->signal = 0;
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1567,13 +1577,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         gdb_breakpoint_remove_all();
         break;
     case 'c':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static GdbCmdParseEntry continue_cmd_desc = {
+                .handler = handle_continue,
+                .cmd = "c",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
         }
-        s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'C':
         s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
         if (s->signal == -1)
-- 
2.20.1

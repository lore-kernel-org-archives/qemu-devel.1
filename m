Received: from eggs.gnu.org ([209.51.188.92]:60699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQ6-0000EG-Ex
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeQ5-0001og-LJ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeQ5-0001ln-Et
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:28:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id n25so10602140wmk.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:28:09 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu, 25 Apr 2019 16:26:31 +0300
Message-Id: <20190425132636.31636-17-arilou@gmail.com>
In-Reply-To: <20190425132636.31636-1-arilou@gmail.com>
References: <20190425132636.31636-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 16/21] gdbstub: Implement step (s pkt) with
 new infra
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
index 18949120be..809503c20a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1806,6 +1806,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params) {
+        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_ull);
+    }
+
+    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1938,13 +1948,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 's':
-        if (*p != '\0') {
-            addr = strtoull(p, (char **)&p, 16);
-            gdb_set_cpu_pc(s, addr);
+        {
+            static const GdbCmdParseEntry step_cmd_desc = {
+                .handler = handle_step,
+                .cmd = "s",
+                .cmd_startswith = 1,
+                .schema = "L0"
+            };
+            cmd_parser = &step_cmd_desc;
         }
-        cpu_single_step(s->c_cpu, sstep_flags);
-        gdb_continue(s);
-        return RS_IDLE;
+        break;
     case 'F':
         {
             static const GdbCmdParseEntry file_io_cmd_desc = {
-- 
2.20.1

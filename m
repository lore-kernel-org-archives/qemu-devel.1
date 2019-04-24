Received: from eggs.gnu.org ([209.51.188.92]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk8-0003mH-2J
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJNk6-00040i-O6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJNk5-0003wj-SI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:39:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id a12so3510654wrq.10
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:39:39 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Wed, 24 Apr 2019 22:38:47 +0300
Message-Id: <20190424193859.31817-9-arilou@gmail.com>
In-Reply-To: <20190424193859.31817-1-arilou@gmail.com>
References: <20190424193859.31817-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/21] gdbstub: Implement set register (P
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
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 80f2a92da6..49db09ef52 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1635,6 +1635,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int reg_size;
+
+    if (!gdb_has_xml) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    reg_size = strlen(gdb_ctx->params[1].data) / 2;
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
+    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
+                       gdb_ctx->params[0].val_ull);
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1879,15 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'P':
-        if (!gdb_has_xml)
-            goto unknown_command;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == '=')
-            p++;
-        reg_size = strlen(p) / 2;
-        hextomem(mem_buf, p, reg_size);
-        gdb_write_register(s->g_cpu, mem_buf, addr);
-        put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry set_reg_cmd_desc = {
+                .handler = handle_set_reg,
+                .cmd = "P",
+                .cmd_startswith = 1,
+                .schema = "L?s0"
+            };
+            cmd_parser = &set_reg_cmd_desc;
+        }
         break;
     case 'Z':
         {
-- 
2.20.1

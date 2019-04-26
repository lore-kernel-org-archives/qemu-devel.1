Received: from eggs.gnu.org ([209.51.188.92]:45317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmf-0000dE-E5
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsb3-0004Rr-Fl
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:26 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsb3-0004Q5-9U
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so2438658wre.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:25 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Fri, 26 Apr 2019 07:35:46 +0300
Message-Id: <20190426043558.6888-10-arilou@gmail.com>
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 09/21] gdbstub: Implement set register (P
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b42425b24c..10e3f12a68 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1634,6 +1634,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
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
@@ -1878,15 +1899,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
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

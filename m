Received: from eggs.gnu.org ([209.51.188.92]:59728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69y-0004nl-Vx
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69o-0002le-Rf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM69i-0000Wg-Az
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:29:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id b10so1274932wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:14 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 10:26:25 +0300
Message-Id: <20190502072641.4667-12-arilou@gmail.com>
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 11/27] gdbstub: Implement write memory (M
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
Cc: alex.bennee@linaro.org, liran.alon@oracle.com, Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index e9a3d0c2bc..8dc2e1d507 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1685,6 +1685,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    /* hextomem() reads 2*len bytes */
+    if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
+             gdb_ctx->params[1].val_ull);
+    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val_ull,
+                               gdb_ctx->mem_buf,
+                               gdb_ctx->params[1].val_ull, true)) {
+        put_packet(gdb_ctx->s, "E14");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1893,24 +1918,14 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'M':
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (*p == ':')
-            p++;
-
-        /* hextomem() reads 2*len bytes */
-        if (len > strlen(p) / 2) {
-            put_packet (s, "E22");
-            break;
-        }
-        hextomem(mem_buf, p, len);
-        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len,
-                                   true) != 0) {
-            put_packet(s, "E14");
-        } else {
-            put_packet(s, "OK");
+        {
+            static const GdbCmdParseEntry write_mem_cmd_desc = {
+                .handler = handle_write_mem,
+                .cmd = "M",
+                .cmd_startswith = 1,
+                .schema = "L,L:s0"
+            };
+            cmd_parser = &write_mem_cmd_desc;
         }
         break;
     case 'p':
-- 
2.20.1

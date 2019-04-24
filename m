Received: from eggs.gnu.org ([209.51.188.92]:43914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIzL-0004gM-CJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJIs7-0000XR-Mk
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJIs7-0000Ve-G9
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:27:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id t17so13737680wrr.4
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:27:39 -0700 (PDT)
From: arilou@gmail.com
Date: Wed, 24 Apr 2019 17:27:02 +0300
Message-Id: <20190424142714.28460-8-arilou@gmail.com>
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
References: <20190424142714.28460-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/20] gdbstub: Implement remove breakpoint
 (z pkt) with new infra
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

From: Jon Doron <arilou@gmail.com>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 67cb140031..d0b27da518 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1627,6 +1627,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    int res;
+
+    if (gdb_ctx->num_params < 3) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    res = gdb_breakpoint_remove(gdb_ctx->params[1].val_ull,
+                                gdb_ctx->params[2].val_ull,
+                                gdb_ctx->params[0].val_ul);
+    if (res >= 0) {
+        put_packet(gdb_ctx->s, "OK");
+        return;
+    } else if (res == -ENOSYS) {
+        put_packet(gdb_ctx->s, "");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "E22");
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1892,23 +1915,15 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'z':
-        type = strtoul(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        addr = strtoull(p, (char **)&p, 16);
-        if (*p == ',')
-            p++;
-        len = strtoull(p, (char **)&p, 16);
-        if (ch == 'Z')
-            res = gdb_breakpoint_insert(addr, len, type);
-        else
-            res = gdb_breakpoint_remove(addr, len, type);
-        if (res >= 0)
-             put_packet(s, "OK");
-        else if (res == -ENOSYS)
-            put_packet(s, "");
-        else
-            put_packet(s, "E22");
+        {
+            static GdbCmdParseEntry remove_bp_cmd_desc = {
+                .handler = handle_remove_bp,
+                .cmd = "z",
+                .cmd_startswith = 1,
+                .schema = "l?L?L0"
+            };
+            process_string_cmd(s, NULL, line_buf, &remove_bp_cmd_desc, 1);
+        }
         break;
     case 'H':
         {
-- 
2.20.1

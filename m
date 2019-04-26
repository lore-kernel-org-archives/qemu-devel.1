Received: from eggs.gnu.org ([209.51.188.92]:45320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsmh-0000dG-JA
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsax-0004Mg-3w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:22 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsav-0004Ja-9L
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:36:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id h11so2330683wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:36:17 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Fri, 26 Apr 2019 07:35:42 +0300
Message-Id: <20190426043558.6888-6-arilou@gmail.com>
In-Reply-To: <20190426043558.6888-1-arilou@gmail.com>
References: <20190426043558.6888-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 05/21] gdbstub: Implement continue with
 signal (C pkt) with new infra
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
 gdbstub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 89f1ab6524..469aaeb875 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1532,6 +1532,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
     gdb_continue(gdb_ctx->s);
 }
 
+static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    unsigned long signal = 0;
+
+    if (gdb_ctx->num_params) {
+        signal = gdb_ctx->params[0].val_ul;
+    }
+
+    gdb_ctx->s->signal = gdb_signal_to_target(signal);
+    if (gdb_ctx->s->signal == -1) {
+        gdb_ctx->s->signal = 0;
+    }
+    gdb_continue(gdb_ctx->s);
+}
+
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
     CPUState *cpu;
@@ -1579,11 +1594,16 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         }
         break;
     case 'C':
-        s->signal = gdb_signal_to_target (strtoul(p, (char **)&p, 16));
-        if (s->signal == -1)
-            s->signal = 0;
-        gdb_continue(s);
-        return RS_IDLE;
+        {
+            static const GdbCmdParseEntry cont_with_sig_cmd_desc = {
+                .handler = handle_cont_with_sig,
+                .cmd = "C",
+                .cmd_startswith = 1,
+                .schema = "l0"
+            };
+            cmd_parser = &cont_with_sig_cmd_desc;
+        }
+        break;
     case 'v':
         if (strncmp(p, "Cont", 4) == 0) {
             p += 4;
-- 
2.20.1

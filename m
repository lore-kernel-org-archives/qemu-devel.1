Received: from eggs.gnu.org ([209.51.188.92]:59523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM69I-0004B1-EO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM694-0002DK-HW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM68u-0000sd-IW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so1794839wrp.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:27:41 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 10:26:41 +0300
Message-Id: <20190502072641.4667-28-arilou@gmail.com>
In-Reply-To: <20190502072641.4667-1-arilou@gmail.com>
References: <20190502072641.4667-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 27/27] gdbstub: Add support to write a MSR
 for KVM target
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

gdb> maint packet Qqemu.kvm.Wrmsr:MsrIndex,Value

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index d5cdda190a..2d9a8e6942 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2145,7 +2145,8 @@ static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
              "sstepbits;sstep;PhyMemMode");
 
     if (kvm_enabled()) {
-        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";kvm.Rdmsr");
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+                ";kvm.Rdmsr;kvm.Wrmsr");
     }
 
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
@@ -2196,6 +2197,26 @@ static void handle_query_kvm_read_msr(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
+static void handle_set_kvm_write_msr(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    if (gdb_ctx->num_params < 2) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (kvm_arch_write_msr(gdbserver_state->c_cpu, gdb_ctx->params[0].val_ul,
+                           gdb_ctx->params[1].val_ull)) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    put_packet(gdb_ctx->s, "OK");
+}
+
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
     {
@@ -2302,6 +2323,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] = {
         .cmd_startswith = 1,
         .schema = "l0"
     },
+    {
+        .handler = handle_set_kvm_write_msr,
+        .cmd = "qemu.kvm.Wrmsr:",
+        .cmd_startswith = 1,
+        .schema = "l,L0"
+    },
 };
 
 static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
-- 
2.20.1

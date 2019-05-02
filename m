Received: from eggs.gnu.org ([209.51.188.92]:42831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6th-0003YR-7K
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM6te-00087a-WB
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM6te-000814-O4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:16:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so1477857wmf.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 01:16:48 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
Date: Thu,  2 May 2019 11:15:53 +0300
Message-Id: <20190502081554.5521-27-arilou@gmail.com>
In-Reply-To: <20190502081554.5521-1-arilou@gmail.com>
References: <20190502081554.5521-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 26/27] gdbstub: Add support to read a MSR
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>

gdb> maint packet qqemu.kvm.Rdmsr:MsrIndex

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 gdbstub.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index 34da10260d..f48c3a2b5f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2141,7 +2141,14 @@ static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    put_packet(gdb_ctx->s, "sstepbits;sstep;PhyMemMode");
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
+             "sstepbits;sstep;PhyMemMode");
+
+    if (kvm_enabled()) {
+        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";kvm.Rdmsr");
+    }
+
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
 static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
@@ -2166,6 +2173,29 @@ static void handle_set_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "OK");
 }
 
+static void handle_query_kvm_read_msr(GdbCmdContext *gdb_ctx, void *user_ctx)
+{
+    uint64_t msr_val;
+
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    if (!gdb_ctx->num_params) {
+        put_packet(gdb_ctx->s, "E22");
+        return;
+    }
+
+    if (kvm_arch_read_msr(gdbserver_state->c_cpu, gdb_ctx->params[0].val_ul,
+                          &msr_val)) {
+        put_packet(gdb_ctx->s, "E00");
+        return;
+    }
+
+    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%" PRIx64, msr_val);
+    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
+}
+
 static GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     /* Order is important if has same prefix */
     {
@@ -2250,6 +2280,12 @@ static GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_qemu_phy_mem_mode,
         .cmd = "qemu.PhyMemMode",
     },
+    {
+        .handler = handle_query_kvm_read_msr,
+        .cmd = "qemu.kvm.Rdmsr:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
 };
 
 static GdbCmdParseEntry gdb_gen_set_table[] = {
-- 
2.20.1

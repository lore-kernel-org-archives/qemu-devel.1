Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7p-00084W-BF
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7l-00006e-RU
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:29 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:38 +1100
Message-Id: <20170301044405.1792-24-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/50] target/ppc: add mcrxrx instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

mcrxrx: Move to CR from XER Extended

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 982e66f..6e6868b 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3819,6 +3819,28 @@ static void gen_mcrxr(DisasContext *ctx)
     tcg_gen_movi_tl(cpu_ca, 0);
 }
 
+#ifdef TARGET_PPC64
+/* mcrxrx */
+static void gen_mcrxrx(DisasContext *ctx)
+{
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv_i32 dst = cpu_crf[crfD(ctx->opcode)];
+
+    /* copy OV and OV32 */
+    tcg_gen_shli_tl(t0, cpu_ov, 1);
+    tcg_gen_or_tl(t0, t0, cpu_ov32);
+    tcg_gen_shli_tl(t0, t0, 2);
+    /* copy CA and CA32 */
+    tcg_gen_shli_tl(t1, cpu_ca, 1);
+    tcg_gen_or_tl(t1, t1, cpu_ca32);
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_trunc_tl_i32(dst, t0);
+    tcg_temp_free(t0);
+    tcg_temp_free(t1);
+}
+#endif
+
 /* mfcr mfocrf */
 static void gen_mfcr(DisasContext *ctx)
 {
@@ -6488,6 +6510,7 @@ GEN_HANDLER(mtcrf, 0x1F, 0x10, 0x04, 0x00000801, PPC_MISC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(mtmsrd, 0x1F, 0x12, 0x05, 0x001EF801, PPC_64B),
 GEN_HANDLER_E(setb, 0x1F, 0x00, 0x04, 0x0003F801, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(mcrxrx, 0x1F, 0x00, 0x12, 0x007FF801, PPC_NONE, PPC2_ISA300),
 #endif
 GEN_HANDLER(mtmsr, 0x1F, 0x12, 0x04, 0x001EF801, PPC_MISC),
 GEN_HANDLER(mtspr, 0x1F, 0x13, 0x0E, 0x00000000, PPC_MISC),
-- 
2.9.3

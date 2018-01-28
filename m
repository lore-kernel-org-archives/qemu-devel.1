Received: from eggs.gnu.org ([2001:4830:134:3::10]:52207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBI-0002xb-3q
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBE-00007p-Jv
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:12 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBE-00007J-Df
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:08 -0500
Received: by mail-pf0-x241.google.com with SMTP id 17so1815176pfw.11
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:08 -0800
Message-Id: <20180128231528.22719-24-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 23/43] target/hppa: Implement LDWA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5b77688fc0..3d441ef4ac 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2954,12 +2954,50 @@ static DisasJumpType trans_stby(DisasContext *ctx, uint32_t insn,
     return nullify_end(ctx, DISAS_NEXT);
 }
 
+#ifndef CONFIG_USER_ONLY
+static DisasJumpType trans_ldwa_idx_i(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
+{
+    int hold_mmu_idx = ctx->mmu_idx;
+    DisasJumpType ret;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+
+    /* ??? needs fixing for hppa64 -- ldda does not follow the same
+       format wrt the sub-opcode in bits 6:9.  */
+    ctx->mmu_idx = MMU_PHYS_IDX;
+    ret = trans_ld_idx_i(ctx, insn, di);
+    ctx->mmu_idx = hold_mmu_idx;
+    return ret;
+}
+
+static DisasJumpType trans_ldwa_idx_x(DisasContext *ctx, uint32_t insn,
+                                      const DisasInsn *di)
+{
+    int hold_mmu_idx = ctx->mmu_idx;
+    DisasJumpType ret;
+
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+
+    /* ??? needs fixing for hppa64 -- ldda does not follow the same
+       format wrt the sub-opcode in bits 6:9.  */
+    ctx->mmu_idx = MMU_PHYS_IDX;
+    ret = trans_ld_idx_x(ctx, insn, di);
+    ctx->mmu_idx = hold_mmu_idx;
+    return ret;
+}
+#endif
+
 static const DisasInsn table_index_mem[] = {
     { 0x0c001000u, 0xfc001300, trans_ld_idx_i }, /* LD[BHWD], im */
     { 0x0c000000u, 0xfc001300, trans_ld_idx_x }, /* LD[BHWD], rx */
     { 0x0c001200u, 0xfc001300, trans_st_idx_i }, /* ST[BHWD] */
     { 0x0c0001c0u, 0xfc0003c0, trans_ldcw },
     { 0x0c001300u, 0xfc0013c0, trans_stby },
+#ifndef CONFIG_USER_ONLY
+    { 0x0c001180u, 0xfc00d3c0, trans_ldwa_idx_i }, /* LDWA, im */
+    { 0x0c000180u, 0xfc00d3c0, trans_ldwa_idx_x }, /* LDWA, rx */
+#endif
 };
 
 static DisasJumpType trans_ldil(DisasContext *ctx, uint32_t insn)
-- 
2.14.3

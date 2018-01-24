Received: from eggs.gnu.org ([2001:4830:134:3::10]:51186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURf-0004qp-0y
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURb-0001ws-E7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:07 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURb-0001wV-8G
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:03 -0500
Received: by mail-pg0-x242.google.com with SMTP id 136so3810326pgd.8
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:03 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.00 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:03 -0800
Message-Id: <20180124232625.30105-24-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 23/45] target/hppa: Implement LDWA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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

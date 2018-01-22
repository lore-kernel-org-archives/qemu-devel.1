Received: from eggs.gnu.org ([2001:4830:134:3::10]:60536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT10-00064r-5v
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1edT0w-0006sF-Du
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:22 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1edT0w-0006rq-8C
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:43:18 -0500
Received: by mail-pg0-x241.google.com with SMTP id u1so6097458pgr.0
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 19:43:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 21 Jan 2018 19:42:13 -0800
Message-Id: <20180122034217.19593-40-richard.henderson@linaro.org>
In-Reply-To: <20180122034217.19593-1-richard.henderson@linaro.org>
References: <20180122034217.19593-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 39/43] target/hppa: Implement STWA
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
 target/hppa/translate.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8884754f05..74f78ab4e0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3097,6 +3097,22 @@ static DisasJumpType trans_ldwa_idx_x(DisasContext *ctx, uint32_t insn,
     ctx->mmu_idx = hold_mmu_idx;
     return ret;
 }
+
+static DisasJumpType trans_stwa_idx_i(DisasContext *ctx, uint32_t insn,
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
+    ret = trans_st_idx_i(ctx, insn, di);
+    ctx->mmu_idx = hold_mmu_idx;
+    return ret;
+}
 #endif
 
 static const DisasInsn table_index_mem[] = {
@@ -3106,8 +3122,9 @@ static const DisasInsn table_index_mem[] = {
     { 0x0c0001c0u, 0xfc0003c0, trans_ldcw },
     { 0x0c001300u, 0xfc0013c0, trans_stby },
 #ifndef CONFIG_USER_ONLY
-    { 0x0c001180u, 0xfc00d3c0, trans_ldwa_idx_i }, /* LDWA, im */
     { 0x0c000180u, 0xfc00d3c0, trans_ldwa_idx_x }, /* LDWA, rx */
+    { 0x0c001180u, 0xfc00d3c0, trans_ldwa_idx_i }, /* LDWA, im */
+    { 0x0c001380u, 0xfc00d3c0, trans_stwa_idx_i }, /* STWA, im */
 #endif
 };
 
-- 
2.14.3

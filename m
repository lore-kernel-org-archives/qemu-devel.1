Received: from eggs.gnu.org ([2001:4830:134:3::10]:59758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqM-0003QV-CY
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqL-000535-CM
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:10 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewWqL-00052a-6H
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:09 -0400
Received: by mail-pf0-x241.google.com with SMTP id h11so3095123pfn.4
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:39:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Mar 2018 01:38:54 +0800
Message-Id: <20180315173855.22456-3-richard.henderson@linaro.org>
In-Reply-To: <20180315173855.22456-1-richard.henderson@linaro.org>
References: <20180315173855.22456-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 2/3] tcg/i386: Support INDEX_op_dup2_vec for
 -m32
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

Unknown why -m32 was passing with gcc but not clang; it should have
failed for both.  This would be used for tcg_gen_dup_i64_vec, and
visible with the right TB and an aarch64 guest.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index fc05909d1d..d7e59e79c5 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2696,6 +2696,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_x86_packus_vec:
         insn = packus_insn[vece];
         goto gen_simd;
+#if TCG_TARGET_REG_BITS == 32
+    case INDEX_op_dup2_vec:
+        /* Constraints have already placed both 32-bit inputs in xmm regs.  */
+        insn = OPC_PUNPCKLDQ;
+        goto gen_simd;
+#endif
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
         if (type == TCG_TYPE_V256) {
@@ -3045,6 +3051,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_x86_vperm2i128_vec:
     case INDEX_op_x86_punpckl_vec:
     case INDEX_op_x86_punpckh_vec:
+#if TCG_TARGET_REG_BITS == 32
+    case INDEX_op_dup2_vec:
+#endif
         return &x_x_x;
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
-- 
2.14.3

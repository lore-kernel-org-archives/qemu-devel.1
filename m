Received: from eggs.gnu.org ([2001:4830:134:3::10]:35448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eobW2-0001zR-S5
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eobVO-0001Q1-Mc
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:01:26 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eobVO-0001PA-BX
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:00:46 -0500
Received: by mail-pg0-x243.google.com with SMTP id l131so1136866pga.2
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 13:00:46 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-169-147.tukw.qwest.net.
	[97.113.169.147])
	by smtp.gmail.com with ESMTPSA id x7sm51973140pfd.3.2018.02.21.13.00.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 21 Feb 2018 13:00:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 21 Feb 2018 13:00:42 -0800
Message-Id: <20180221210042.28630-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg/i386: Support INDEX_op_dup2_vec for -m32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unknown why -m32 was passing with gcc but not clang; it should have
failed for both.  This would be used for tcg_gen_dup_i64_vec, and
visible with the right TB and an aarch64 guest.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 45943e540c..5e8f59dc47 100644
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

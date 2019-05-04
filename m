Received: from eggs.gnu.org ([209.51.188.92]:41894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbx-0007tk-8W
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbw-0004Ll-2K
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbv-0004LP-SX
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:24 -0400
Received: by mail-pl1-x642.google.com with SMTP id l2so3719837plt.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 May 2019 22:52:46 -0700
Message-Id: <20190504055300.18426-18-richard.henderson@linaro.org>
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 17/31] tcg/aarch64: Support vector variable
 shift opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@redhat.com

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  2 +-
 tcg/aarch64/tcg-target.opc.h |  2 ++
 tcg/aarch64/tcg-target.inc.c | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ce2bb1f90b..f5640a229b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -134,7 +134,7 @@ typedef enum {
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
index 4816a6c3d4..59e1d3f7f7 100644
--- a/tcg/aarch64/tcg-target.opc.h
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -1,3 +1,5 @@
 /* Target-specific opcodes for host vector expansion.  These will be
    emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
    consider these to be UNSPEC with names.  */
+
+DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 15ab35adf7..7d842cad47 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -536,12 +536,14 @@ typedef enum {
     I3616_CMEQ      = 0x2e208c00,
     I3616_SMAX      = 0x0e206400,
     I3616_SMIN      = 0x0e206c00,
+    I3616_SSHL      = 0x0e204400,
     I3616_SQADD     = 0x0e200c00,
     I3616_SQSUB     = 0x0e202c00,
     I3616_UMAX      = 0x2e206400,
     I3616_UMIN      = 0x2e206c00,
     I3616_UQADD     = 0x2e200c00,
     I3616_UQSUB     = 0x2e202c00,
+    I3616_USHL      = 0x2e204400,
 
     /* AdvSIMD two-reg misc.  */
     I3617_CMGT0     = 0x0e208800,
@@ -2256,6 +2258,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out_insn(s, 3614, SSHR, is_q, a0, a1, (16 << vece) - a2);
         break;
+    case INDEX_op_shlv_vec:
+        tcg_out_insn(s, 3616, USHL, is_q, vece, a0, a1, a2);
+        break;
+    case INDEX_op_aa64_sshl_vec:
+        tcg_out_insn(s, 3616, SSHL, is_q, vece, a0, a1, a2);
+        break;
     case INDEX_op_cmp_vec:
         {
             TCGCond cond = args[3];
@@ -2323,7 +2331,11 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
         return 1;
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        return -1;
     case INDEX_op_mul_vec:
         return vece < MO_64;
 
@@ -2335,6 +2347,32 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
                        TCGArg a0, ...)
 {
+    va_list va;
+    TCGv_vec v0, v1, v2, t1;
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+
+    switch (opc) {
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        /* Right shifts are negative left shifts for AArch64.  */
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t1, v2);
+        opc = (opc == INDEX_op_shrv_vec
+               ? INDEX_op_shlv_vec : INDEX_op_aa64_sshl_vec);
+        vec_gen_3(opc, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        tcg_temp_free_vec(t1);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    va_end(va);
 }
 
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
@@ -2516,6 +2554,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_aa64_sshl_vec:
         return &w_w_w;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-- 
2.17.1

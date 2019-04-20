Received: from eggs.gnu.org ([209.51.188.92]:40465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-00010D-5X
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXU-0000kq-CU
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:57 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXT-0000CP-Hn
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: by mail-pg1-x543.google.com with SMTP id y3so3581595pgk.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:33 -1000
Message-Id: <20190420073442.7488-30-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 29/38] tcg/i386: Support vector comparison
 select value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

We already had backend support for this feature, but with a
backend-specific opcode.  Remove the old name, and reorder
the arguments to match the generic opcode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.opc.h |  1 -
 tcg/i386/tcg-target.inc.c | 13 ++++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 683e029980..acdf96b99d 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -190,7 +190,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
     (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index e5fa88ba25..d761cca0cd 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -3,7 +3,6 @@
    consider these to be UNSPEC with names.  */
 
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
 DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
 DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 3dae0bf0c5..50296b4b2f 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2921,13 +2921,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out8(s, sub);
         break;
 
-    case INDEX_op_x86_vpblendvb_vec:
+    case INDEX_op_cmpsel_vec:
         insn = OPC_VPBLENDVB;
         if (type == TCG_TYPE_V256) {
             insn |= P_VEXL;
         }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
-        tcg_out8(s, args[3] << 4);
+        tcg_out_vex_modrm(s, insn, a0, a2, args[3]);
+        tcg_out8(s, a1 << 4);
         break;
 
     case INDEX_op_x86_psrldq_vec:
@@ -3223,7 +3223,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sari_vec:
     case INDEX_op_x86_psrldq_vec:
         return &x_x;
-    case INDEX_op_x86_vpblendvb_vec:
+    case INDEX_op_cmpsel_vec:
         return &x_x_x_x;
 
     default:
@@ -3241,6 +3241,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_andc_vec:
+    case INDEX_op_cmpsel_vec:
         return 1;
     case INDEX_op_cmp_vec:
         return -1;
@@ -3537,9 +3538,7 @@ static void expand_vec_minmax(TCGType type, unsigned vece,
         TCGv_vec t2;
         t2 = v1, v1 = v2, v2 = t2;
     }
-    vec_gen_4(INDEX_op_x86_vpblendvb_vec, type, vece,
-              tcgv_vec_arg(v0), tcgv_vec_arg(v1),
-              tcgv_vec_arg(v2), tcgv_vec_arg(t1));
+    tcg_gen_cmpsel_vec(vece, v0, t1, v1, v2);
     tcg_temp_free_vec(t1);
 }
 
-- 
2.17.1

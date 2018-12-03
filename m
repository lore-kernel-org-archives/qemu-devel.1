Received: from eggs.gnu.org ([2001:4830:134:3::10]:35369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqm9-0001Zz-0Y
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTqm8-0003Os-9U
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:48 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTqm8-0003OY-4m
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:08:48 -0500
Received: by mail-oi1-x243.google.com with SMTP id a77so11361978oii.5
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:08:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  3 Dec 2018 10:08:37 -0600
Message-Id: <20181203160840.15115-3-richard.henderson@linaro.org>
In-Reply-To: <20181203160840.15115-1-richard.henderson@linaro.org>
References: <20181203160840.15115-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 2/5] tcg/i386: Implement
 INDEX_op_extr{lh}_i64_i32 for 32-bit guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, alex.bennee@linaro.org

This preserves the invariant that all TCG_TYPE_I32 values are
zero-extended in the 64-bit host register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     | 5 +++--
 tcg/i386/tcg-target.inc.c | 6 ++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2441658865..c523d5f5e1 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -135,8 +135,9 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_direct_jump      1
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_extrl_i64_i32    0
-#define TCG_TARGET_HAS_extrh_i64_i32    0
+/* Keep target addresses zero-extended in a register.  */
+#define TCG_TARGET_HAS_extrl_i64_i32    (TARGET_LONG_BITS == 32)
+#define TCG_TARGET_HAS_extrh_i64_i32    (TARGET_LONG_BITS == 32)
 #define TCG_TARGET_HAS_div2_i64         1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_ext8s_i64        1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6bf4f84b20..ab31dfa66d 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2546,12 +2546,16 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_extu_i32_i64:
     case INDEX_op_ext32u_i64:
+    case INDEX_op_extrl_i64_i32:
         tcg_out_ext32u(s, a0, a1);
         break;
     case INDEX_op_ext_i32_i64:
     case INDEX_op_ext32s_i64:
         tcg_out_ext32s(s, a0, a1);
         break;
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_shifti(s, SHIFT_SHR + P_REXW, a0, 32);
+        break;
 #endif
 
     OP_32_64(deposit):
@@ -2915,6 +2919,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
+    case INDEX_op_extrh_i64_i32:
         return &r_0;
 
     case INDEX_op_ext8s_i32:
@@ -2930,6 +2935,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
-- 
2.17.2

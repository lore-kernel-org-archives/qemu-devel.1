Received: from eggs.gnu.org ([2001:4830:134:3::10]:58894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe17-0006Bi-Dp
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe14-0007Nt-92
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:56 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:39889)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe11-000792-M7
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:19:52 -0500
Received: by mail-oi1-x22a.google.com with SMTP id i6so3464302oia.6
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:19:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:10 -0600
Message-Id: <20181214031923.29527-21-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 19/32] tcg/i386: Implement
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
Cc: peter.maydell@linaro.org

This preserves the invariant that all TCG_TYPE_I32 values are
zero-extended in the 64-bit host register.

Reviewed-by: Emilio G. Cota <cota@braap.org>
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
index 695b406b4e..fe864e9ef9 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2549,12 +2549,16 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
@@ -2918,6 +2922,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_neg_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
+    case INDEX_op_extrh_i64_i32:
         return &r_0;
 
     case INDEX_op_ext8s_i32:
@@ -2933,6 +2938,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
-- 
2.17.2

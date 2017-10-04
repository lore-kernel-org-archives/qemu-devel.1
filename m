Received: from eggs.gnu.org ([2001:4830:134:3::10]:38200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodu-0008DY-EU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodt-0002gV-MR
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:38 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:53435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzodt-0002g5-Im
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:37 -0400
Received: by mail-qt0-x232.google.com with SMTP id 47so21026765qts.10
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:18 -0400
Message-Id: <20171004184325.24157-6-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 05/12] target/arm: Decode aa64 armv8.1
 scalar/vector x indexed element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 0ea47a9dff..b02aad8cd7 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10749,12 +10749,23 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         is_long = true;
         /* fall through */
     case 0xc: /* SQDMULH */
-    case 0xd: /* SQRDMULH */
         if (u) {
             unallocated_encoding(s);
             return;
         }
         break;
+    case 0xd: /* SQRDMULH / SQRDMLAH */
+        if (u && !arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
+            unallocated_encoding(s);
+            return;
+        }
+        break;
+    case 0xf: /* SQRDMLSH */
+        if (!u || !arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
+            unallocated_encoding(s);
+            return;
+        }
+        break;
     case 0x8: /* MUL */
         if (u || is_scalar) {
             unallocated_encoding(s);
@@ -10941,13 +10952,36 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                                tcg_op, tcg_idx);
                 }
                 break;
-            case 0xd: /* SQRDMULH */
+            case 0xd: /* SQRDMULH / SQRDMLAH */
+                if (u) { /* SQRDMLAH */
+                    read_vec_element_i32(s, tcg_res, rd, pass,
+                                         is_scalar ? size : MO_32);
+                    if (size == 1) {
+                        gen_helper_neon_qrdmlah_s16(tcg_res, cpu_env,
+                                                    tcg_op, tcg_idx, tcg_res);
+                    } else {
+                        gen_helper_neon_qrdmlah_s32(tcg_res, cpu_env,
+                                                    tcg_op, tcg_idx, tcg_res);
+                    }
+                } else { /* SQRDMULH */
+                    if (size == 1) {
+                        gen_helper_neon_qrdmulh_s16(tcg_res, cpu_env,
+                                                    tcg_op, tcg_idx);
+                    } else {
+                        gen_helper_neon_qrdmulh_s32(tcg_res, cpu_env,
+                                                    tcg_op, tcg_idx);
+                    }
+                }
+                break;
+            case 0xf: /* SQRDMLSH */
+                read_vec_element_i32(s, tcg_res, rd, pass,
+                                     is_scalar ? size : MO_32);
                 if (size == 1) {
-                    gen_helper_neon_qrdmulh_s16(tcg_res, cpu_env,
-                                                tcg_op, tcg_idx);
+                    gen_helper_neon_qrdmlsh_s16(tcg_res, cpu_env,
+                                                tcg_op, tcg_idx, tcg_res);
                 } else {
-                    gen_helper_neon_qrdmulh_s32(tcg_res, cpu_env,
-                                                tcg_op, tcg_idx);
+                    gen_helper_neon_qrdmlsh_s32(tcg_res, cpu_env,
+                                                tcg_op, tcg_idx, tcg_res);
                 }
                 break;
             default:
-- 
2.13.6

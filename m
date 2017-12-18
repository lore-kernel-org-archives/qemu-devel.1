Received: from eggs.gnu.org ([2001:4830:134:3::10]:40962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9X-0005te-O3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9W-00088X-Q7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:35 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9W-00087X-K6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:34 -0500
Received: by mail-pl0-x243.google.com with SMTP id d21so5200451pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:18 -0800
Message-Id: <20171218172425.18200-5-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/11] target/arm: Decode aa64 armv8.1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3836e94135..85fc7af491 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11857,12 +11857,23 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
@@ -12100,13 +12111,36 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
2.14.3

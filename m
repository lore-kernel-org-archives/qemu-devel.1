Received: from eggs.gnu.org ([2001:4830:134:3::10]:41023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9a-0005wk-CM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQz9Z-0008Cf-J1
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:38 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQz9Z-0008BY-E6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:24:37 -0500
Received: by mail-pl0-x241.google.com with SMTP id d21so5200521pll.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:24:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:24:20 -0800
Message-Id: <20171218172425.18200-7-richard.henderson@linaro.org>
In-Reply-To: <20171218172425.18200-1-richard.henderson@linaro.org>
References: <20171218172425.18200-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 06/11] target/arm: Decode aa32 armv8.1 two
 reg and a scalar
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a9587ae242..1a0b0eaced 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6973,11 +6973,43 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         }
                         neon_store_reg64(cpu_V0, rd + pass);
                     }
+                    break;
+                case 14: /* VQRDMLAH scalar */
+                case 15: /* VQRDMLSH scalar */
+                    if (!arm_dc_feature(s, ARM_FEATURE_V8_1_SIMD)) {
+                        return 1;
+                    }
+                    if (u && ((rd | rn) & 1)) {
+                        return 1;
+                    }
+                    tmp2 = neon_get_scalar(size, rm);
+                    for (pass = 0; pass < (u ? 4 : 2); pass++) {
+                        void (*fn)(TCGv_i32, TCGv_env, TCGv_i32,
+                                   TCGv_i32, TCGv_i32);
 
-
+                        tmp = neon_load_reg(rn, pass);
+                        tmp3 = neon_load_reg(rd, pass);
+                        if (op == 14) {
+                            if (size == 1) {
+                                fn = gen_helper_neon_qrdmlah_s16;
+                            } else {
+                                fn = gen_helper_neon_qrdmlah_s32;
+                            }
+                        } else {
+                            if (size == 1) {
+                                fn = gen_helper_neon_qrdmlsh_s16;
+                            } else {
+                                fn = gen_helper_neon_qrdmlsh_s32;
+                            }
+                        }
+                        fn(tmp, cpu_env, tmp, tmp2, tmp3);
+                        tcg_temp_free_i32(tmp3);
+                        neon_store_reg(rd, pass, tmp);
+                    }
+                    tcg_temp_free_i32(tmp2);
                     break;
-                default: /* 14 and 15 are RESERVED */
-                    return 1;
+                default:
+                    g_assert_not_reached();
                 }
             }
         } else { /* size == 3 */
-- 
2.14.3

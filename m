Received: from eggs.gnu.org ([2001:4830:134:3::10]:38250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodw-0008Fh-UM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodw-0002ip-5O
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:40 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzodw-0002iK-1d
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:40 -0400
Received: by mail-qt0-x22b.google.com with SMTP id a43so15131436qta.0
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:20 -0400
Message-Id: <20171004184325.24157-8-richard.henderson@linaro.org>
In-Reply-To: <20171004184325.24157-1-richard.henderson@linaro.org>
References: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 07/12] target/arm: Decode aa32 armv8.1 two
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0cd58710b3..ee1e364fb5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6941,10 +6941,42 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
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
+                default:
                     return 1;
                 }
             }
-- 
2.13.6

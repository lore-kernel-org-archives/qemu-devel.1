Received: from eggs.gnu.org ([2001:4830:134:3::10]:43634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWq-0003Ag-Bb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWm-000538-DS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eriWm-00051l-5Q
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 06:07:04 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eriWl-0001Q5-8A
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Mar 2018 11:06:32 +0000
Message-Id: <20180302110640.28004-32-peter.maydell@linaro.org>
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/39] target/arm: Decode aa32 armv8.1 two reg
 and a scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180228193125.20577-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 05fa6a53f9..9169b6b367 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -76,6 +76,10 @@ static const char *regnames[] =
     { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
       "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
 
+/* Function prototypes for gen_ functions calling Neon helpers.  */
+typedef void NeonGenThreeOpEnvFn(TCGv_i32, TCGv_env, TCGv_i32,
+                                 TCGv_i32, TCGv_i32);
+
 /* initialize TCG globals.  */
 void arm_translate_init(void)
 {
@@ -6985,11 +6989,45 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         }
                         neon_store_reg64(cpu_V0, rd + pass);
                     }
-
-
                     break;
-                default: /* 14 and 15 are RESERVED */
-                    return 1;
+                case 14: /* VQRDMLAH scalar */
+                case 15: /* VQRDMLSH scalar */
+                    {
+                        NeonGenThreeOpEnvFn *fn;
+
+                        if (!arm_dc_feature(s, ARM_FEATURE_V8_RDM)) {
+                            return 1;
+                        }
+                        if (u && ((rd | rn) & 1)) {
+                            return 1;
+                        }
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
+
+                        tmp2 = neon_get_scalar(size, rm);
+                        for (pass = 0; pass < (u ? 4 : 2); pass++) {
+                            tmp = neon_load_reg(rn, pass);
+                            tmp3 = neon_load_reg(rd, pass);
+                            fn(tmp, cpu_env, tmp, tmp2, tmp3);
+                            tcg_temp_free_i32(tmp3);
+                            neon_store_reg(rd, pass, tmp);
+                        }
+                        tcg_temp_free_i32(tmp2);
+                    }
+                    break;
+                default:
+                    g_assert_not_reached();
                 }
             }
         } else { /* size == 3 */
-- 
2.16.2

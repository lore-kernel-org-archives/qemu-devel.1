Received: from eggs.gnu.org ([209.51.188.92]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf4-0004Y9-Pc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf2-00018x-SK
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNf0-00014I-TY
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so26886014wrw.13
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 13:57:24 +0100
Message-Id: <20190416125744.27770-7-peter.maydell@linaro.org>
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/26] target/arm: Decode FP instructions for M
 profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org

Correct the decode of the M-profile "coprocessor and
floating-point instructions" space:
 * op0 == 0b11 is always unallocated
 * if the CPU has an FPU then all insns with op1 == 0b101
   are floating point and go to disas_vfp_insn()

For the moment we leave VLLDM and VLSTM as NOPs; in
a later commit we will fill in the proper implementation
for the case where an FPU is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bb539111179..d280b3a9a3a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11727,10 +11727,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     case 6: case 7: case 14: case 15:
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            /* We don't currently implement M profile FP support,
-             * so this entire space should give a NOCP fault, with
-             * the exception of the v8M VLLDM and VLSTM insns, which
-             * must be NOPs in Secure state and UNDEF in Nonsecure state.
+            /* 0b111x_11xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx */
+            if (extract32(insn, 24, 2) == 3) {
+                goto illegal_op; /* op0 = 0b11 : unallocated */
+            }
+
+            /*
+             * Decode VLLDM and VLSTM first: these are nonstandard because:
+             *  * if there is no FPU then these insns must NOP in
+             *    Secure state and UNDEF in Nonsecure state
+             *  * if there is an FPU then these insns do not have
+             *    the usual behaviour that disas_vfp_insn() provides of
+             *    being controlled by CPACR/NSACR enable bits or the
+             *    lazy-stacking logic.
              */
             if (arm_dc_feature(s, ARM_FEATURE_V8) &&
                 (insn & 0xffa00f00) == 0xec200a00) {
@@ -11744,6 +11753,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 /* Just NOP since FP support is not implemented */
                 break;
             }
+            if (arm_dc_feature(s, ARM_FEATURE_VFP) &&
+                ((insn >> 8) & 0xe) == 10) {
+                /* FP, and the CPU supports it */
+                if (disas_vfp_insn(s, insn)) {
+                    goto illegal_op;
+                }
+                break;
+            }
+
             /* All other insns: NOCP */
             gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
                                default_exception_el(s));
-- 
2.20.1

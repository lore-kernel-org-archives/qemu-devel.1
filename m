Received: from eggs.gnu.org ([209.51.188.92]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ee-0004fW-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eX-0006cb-4c
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:37585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eV-0006Ev-UJ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:16 -0400
Received: by mail-wr1-x42f.google.com with SMTP id r6so17126930wrm.4
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:57 +0100
Message-Id: <20190429170030.11323-10-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/42] target/arm: Decode FP instructions for M
 profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Correct the decode of the M-profile "coprocessor and
floating-point instructions" space:
 * op0 == 0b11 is always unallocated
 * if the CPU has an FPU then all insns with op1 == 0b101
   are floating point and go to disas_vfp_insn()

For the moment we leave VLLDM and VLSTM as NOPs; in
a later commit we will fill in the proper implementation
for the case where an FPU is present.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-7-peter.maydell@linaro.org
---
 target/arm/translate.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6a11921d0b8..0747f7847a9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11728,10 +11728,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -11745,6 +11754,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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

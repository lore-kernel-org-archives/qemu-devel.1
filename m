Received: from eggs.gnu.org ([209.51.188.92]:36445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJZ0-0001QV-Gl
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYu-0003sI-Qw
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:18 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYu-0003rE-KE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:12 -0500
Received: by mail-wr1-x42f.google.com with SMTP id i16so21421981wrs.13
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.09.09 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:09:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:29 +0000
Message-Id: <20190228110835.16159-11-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/16] target/arm: Gate "miscellaneous FP" insns
 by ID register field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There is a set of VFP instructions which we implement in
disas_vfp_v8_insn() and gate on the ARM_FEATURE_V8 bit.
These were all first introduced in v8 for A-profile, but in
M-profile they appeared in v7M. Gate them on the MVFR2
FPMisc field instead, and rename the function appropriately.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190222170936.13268-3-peter.maydell@linaro.org
---
 target/arm/cpu.h       | 20 ++++++++++++++++++++
 target/arm/translate.c | 25 +++++++++++++------------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 36ea3b58567..ff9ba387b42 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3328,6 +3328,26 @@ static inline bool isar_feature_aa32_fp16_dpconv(const ARMISARegisters *id)
     return FIELD_EX64(id->mvfr1, MVFR1, FPHP) > 1;
 }
 
+static inline bool isar_feature_aa32_vsel(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 1;
+}
+
+static inline bool isar_feature_aa32_vcvt_dr(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 2;
+}
+
+static inline bool isar_feature_aa32_vrint(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 3;
+}
+
+static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->mvfr2, MVFR2, FPMISC) >= 4;
+}
+
 /*
  * 64-bit feature tests via id registers.
  */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b7702fb49f7..d845923a96b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3357,14 +3357,10 @@ static const uint8_t fp_decode_rm[] = {
     FPROUNDING_NEGINF,
 };
 
-static int disas_vfp_v8_insn(DisasContext *s, uint32_t insn)
+static int disas_vfp_misc_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t rd, rn, rm, dp = extract32(insn, 8, 1);
 
-    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
-        return 1;
-    }
-
     if (dp) {
         VFP_DREG_D(rd, insn);
         VFP_DREG_N(rn, insn);
@@ -3375,15 +3371,18 @@ static int disas_vfp_v8_insn(DisasContext *s, uint32_t insn)
         rm = VFP_SREG_M(insn);
     }
 
-    if ((insn & 0x0f800e50) == 0x0e000a00) {
+    if ((insn & 0x0f800e50) == 0x0e000a00 && dc_isar_feature(aa32_vsel, s)) {
         return handle_vsel(insn, rd, rn, rm, dp);
-    } else if ((insn & 0x0fb00e10) == 0x0e800a00) {
+    } else if ((insn & 0x0fb00e10) == 0x0e800a00 &&
+               dc_isar_feature(aa32_vminmaxnm, s)) {
         return handle_vminmaxnm(insn, rd, rn, rm, dp);
-    } else if ((insn & 0x0fbc0ed0) == 0x0eb80a40) {
+    } else if ((insn & 0x0fbc0ed0) == 0x0eb80a40 &&
+               dc_isar_feature(aa32_vrint, s)) {
         /* VRINTA, VRINTN, VRINTP, VRINTM */
         int rounding = fp_decode_rm[extract32(insn, 16, 2)];
         return handle_vrint(insn, rd, rm, dp, rounding);
-    } else if ((insn & 0x0fbc0e50) == 0x0ebc0a40) {
+    } else if ((insn & 0x0fbc0e50) == 0x0ebc0a40 &&
+               dc_isar_feature(aa32_vcvt_dr, s)) {
         /* VCVTA, VCVTN, VCVTP, VCVTM */
         int rounding = fp_decode_rm[extract32(insn, 16, 2)];
         return handle_vcvt(insn, rd, rm, dp, rounding);
@@ -3427,10 +3426,12 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
     }
 
     if (extract32(insn, 28, 4) == 0xf) {
-        /* Encodings with T=1 (Thumb) or unconditional (ARM):
-         * only used in v8 and above.
+        /*
+         * Encodings with T=1 (Thumb) or unconditional (ARM):
+         * only used for the "miscellaneous VFP features" added in v8A
+         * and v7M (and gated on the MVFR2.FPMisc field).
          */
-        return disas_vfp_v8_insn(s, insn);
+        return disas_vfp_misc_insn(s, insn);
     }
 
     dp = ((insn & 0xf00) == 0xb00);
-- 
2.20.1

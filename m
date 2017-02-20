Received: from eggs.gnu.org ([2001:4830:134:3::10]:44222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cftFo-0002Rk-Jp
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cftFn-00067s-Rf
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:04:08 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 18:41:10 +0000
Message-Id: <1487616072-9226-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] arm: Don't decode MRS(banked) or
 MSR(banked) for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>

M profile doesn't have the MSR(banked) and MRS(banked) instructions
and uses the encodings for different kinds of M-profile MRS/MSR.
Guard the relevant bits of the decode logic to make sure we don't
accidentally fall into them by accident on M-profile.

(The bit being checked for this (bit 5) is part of the SYSm field on
M-profile, but since no currently allocated system registers have
encodings with bit 5 of SYSm set, this hasn't been a problem in
practice.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 895b399..0f8548f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10488,7 +10488,8 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         gen_exception_return(s, tmp);
                         break;
                     case 6: /* MRS */
-                        if (extract32(insn, 5, 1)) {
+                        if (extract32(insn, 5, 1) &&
+                            !arm_dc_feature(s, ARM_FEATURE_M)) {
                             /* MRS (banked) */
                             int sysm = extract32(insn, 16, 4) |
                                 (extract32(insn, 4, 1) << 4);
@@ -10509,7 +10510,8 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         store_reg(s, rd, tmp);
                         break;
                     case 7: /* MRS */
-                        if (extract32(insn, 5, 1)) {
+                        if (extract32(insn, 5, 1) &&
+                            !arm_dc_feature(s, ARM_FEATURE_M)) {
                             /* MRS (banked) */
                             int sysm = extract32(insn, 16, 4) |
                                 (extract32(insn, 4, 1) << 4);
-- 
2.7.4

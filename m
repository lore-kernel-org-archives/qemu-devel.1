Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpl-0007dw-4f
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpk-0003pW-8B
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cpwpk-0003lz-1O
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpa-0007Tg-Hf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:54:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 12:54:34 +0000
Message-Id: <1490014476-25672-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
References: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/4] arm: Don't decode MRS(banked) or
 MSR(banked) for M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

M profile doesn't have the MSR(banked) and MRS(banked) instructions
and uses the encodings for different kinds of M-profile MRS/MSR.
Guard the relevant bits of the decode logic to make sure we don't
accidentally fall into them by accident on M-profile.

(The bit being checked for this (bit 5) is part of the SYSm field on
M-profile, but since no currently allocated system registers have
encodings with bit 5 of SYSm set, this hasn't been a problem in
practice.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1487616072-9226-3-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 216852b..a5f5a28 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10500,7 +10500,8 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         gen_exception_return(s, tmp);
                         break;
                     case 6: /* MRS */
-                        if (extract32(insn, 5, 1)) {
+                        if (extract32(insn, 5, 1) &&
+                            !arm_dc_feature(s, ARM_FEATURE_M)) {
                             /* MRS (banked) */
                             int sysm = extract32(insn, 16, 4) |
                                 (extract32(insn, 4, 1) << 4);
@@ -10521,7 +10522,8 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
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

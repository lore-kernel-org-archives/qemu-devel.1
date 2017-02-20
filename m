Received: from eggs.gnu.org ([2001:4830:134:3::10]:44227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cftFo-0002S5-W4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cftFo-00068C-C5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:04:09 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 18:41:09 +0000
Message-Id: <1487616072-9226-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/4] arm: HVC and SMC encodings don't exist for
 M profile
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

M profile doesn't have the HVC or SMC encodings, so make them always
UNDEF rather than generating calls to helper functions that assume
A/R profile.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9fded03..895b399 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10365,6 +10365,9 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                     goto illegal_op;
 
                 if (insn & (1 << 26)) {
+                    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                        goto illegal_op;
+                    }
                     if (!(insn & (1 << 20))) {
                         /* Hypervisor call (v7) */
                         int imm16 = extract32(insn, 16, 4) << 12
-- 
2.7.4

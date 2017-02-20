Received: from eggs.gnu.org ([2001:4830:134:3::10]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cftFn-0002Qu-PK
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cftFn-00067O-2T
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:04:07 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 18:41:11 +0000
Message-Id: <1487616072-9226-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/4] arm: Enforce should-be-1 bits in MRS
 decoding
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

The MRS instruction requires that bits [19..16] are all 1s, and for
A/R profile also that bits [7..0] are all 0s.  At this point in the
decode tree we have checked all of the rest of the instruction but
were allowing these to be any value.  If these bits are not set then
the result is architecturally UNPREDICTABLE, but choosing to UNDEF is
more helpful to the user and avoids unexpected odd behaviour if the
encodings are used for some purpose in future architecture versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0f8548f..9090356 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10498,6 +10498,14 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                             break;
                         }
 
+                        if (extract32(insn, 16, 4) != 0xf) {
+                            goto illegal_op;
+                        }
+                        if (!arm_dc_feature(s, ARM_FEATURE_M) &&
+                            extract32(insn, 0, 8) != 0) {
+                            goto illegal_op;
+                        }
+
                         /* mrs cpsr */
                         tmp = tcg_temp_new_i32();
                         if (arm_dc_feature(s, ARM_FEATURE_M)) {
@@ -10525,6 +10533,12 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
                             goto illegal_op;
                         }
+
+                        if (extract32(insn, 16, 4) != 0xf ||
+                            extract32(insn, 0, 8) != 0) {
+                            goto illegal_op;
+                        }
+
                         tmp = load_cpu_field(spsr);
                         store_reg(s, rd, tmp);
                         break;
-- 
2.7.4

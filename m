Received: from eggs.gnu.org ([2001:4830:134:3::10]:44067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpl-0007dy-Oa
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpl-0003px-0Q
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cpwpk-0003lz-Pi
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:54:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cpwpa-0007TI-1d
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:54:38 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 12:54:33 +0000
Message-Id: <1490014476-25672-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
References: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/4] arm: HVC and SMC encodings don't exist for
 M profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

M profile doesn't have the HVC or SMC encodings, so make them always
UNDEF rather than generating calls to helper functions that assume
A/R profile.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1487616072-9226-2-git-send-email-peter.maydell@linaro.org
---
 target/arm/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b859f10..216852b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10377,6 +10377,9 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
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

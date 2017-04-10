Received: from eggs.gnu.org ([2001:4830:134:3::10]:60836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCf-0000n4-2t
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxdCc-0006ry-PU
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:34:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 18:13:32 +0100
Message-Id: <1491844419-12485-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/9] arm: Thumb shift operations should not
 permit interworking branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

In Thumb mode, the only instructions which can cause an interworking
branch by writing the PC are BLX, BX, BXJ, LDR, POP and LDM. Unlike
ARM mode, data processing instructions which target the PC do not
cause interworking branches.

When we added support for doing interworking branches on writes to
PC from data processing instructions in commit 21aeb3430ce7ba, we
accidentally changed a Thumb instruction to have interworking
branch behaviour for writes to PC. (MOV, MOVS register-shifted
register, encoding T2; this is the standard encoding for
LSL/LSR/ASR/ROR (register).)

For this encoding, behaviour with Rd == R15 is specified as
UNPREDICTABLE, so allowing an interworking branch is within
spec, but it's confusing and differs from our handling of this
class of UNPREDICTABLE for other Thumb ALU operations. Make
it perform a simple (non-interworking) branch like the others.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fe3f442..ddc62b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9959,7 +9959,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
             gen_arm_shift_reg(tmp, op, tmp2, logic_cc);
             if (logic_cc)
                 gen_logic_CC(tmp);
-            store_reg_bx(s, rd, tmp);
+            store_reg(s, rd, tmp);
             break;
         case 1: /* Sign/zero extend.  */
             op = (insn >> 20) & 7;
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F90-0008Oh-3S
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8y-00085A-NU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F8y-00084S-F6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8x-0006yI-Iu
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:41:03 +0100
Message-Id: <1492706470-10921-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/24] arm: Thumb shift operations should not
 permit interworking branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1491844419-12485-3-git-send-email-peter.maydell@linaro.org
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

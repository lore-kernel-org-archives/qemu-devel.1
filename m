Received: from eggs.gnu.org ([2001:4830:134:3::10]:59607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vr-000124-F9
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vq-00057S-L1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vq-000541-Ex
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:30 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vm-0003RT-V9
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:13 +0000
Message-Id: <1485531137-2362-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/22] armv7m: R14 should reset to 0xffffffff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For M profile (unlike A profile) the reset value of R14 is specified
as 0xffffffff.  (The rationale is that this is an illegal exception
return value, so if guest code tries to return to it it will result
in a helpful exception.)

Registers r0 to r12 and the flags are architecturally UNKNOWN on
reset, so we leave those at zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1485285380-10565-11-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0814f73..e9f10f7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -196,6 +196,9 @@ static void arm_cpu_reset(CPUState *s)
          */
         env->v7m.ccr = R_V7M_CCR_STKALIGN_MASK;
 
+        /* Unlike A/R profile, M profile defines the reset LR value */
+        env->regs[14] = 0xffffffff;
+
         /* Load the initial SP and PC from the vector table at address 0 */
         rom = rom_ptr(0);
         if (rom) {
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zx-0000cF-Mw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zw-0000b8-Kx
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:29 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:20 +0000
Message-Id: <1485285380-10565-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
References: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 10/10] armv7m: R14 should reset to 0xffffffff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Liviu Ionescu <ilg@livius.net>

For M profile (unlike A profile) the reset value of R14 is specified
as 0xffffffff.  (The rationale is that this is an illegal exception
return value, so if guest code tries to return to it it will result
in a helpful exception.)

Registers r0 to r12 and the flags are architecturally UNKNOWN on
reset, so we leave those at zero.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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

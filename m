Received: from eggs.gnu.org ([2001:4830:134:3::10]:59657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vt-00014A-BA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vs-00058W-Ii
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:33 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vs-00055y-Bz
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vk-0003Pb-Kx
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:24 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:08 +0000
Message-Id: <1485531137-2362-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/22] armv7m: honour CCR.STACKALIGN on
 exception entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

The CCR.STACKALIGN bit controls whether the CPU is supposed to force
8-alignment of the stack pointer on entry to the exception handler.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Message-id: 1485285380-10565-6-git-send-email-peter.maydell@linaro.org
[PMM: commit message and comment tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce7e43b..7dc30f5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6110,10 +6110,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         return; /* Never happens.  Keep compiler happy.  */
     }
 
-    /* Align stack pointer.  */
-    /* ??? Should only do this if Configuration Control Register
-       STACKALIGN bit is set.  */
-    if (env->regs[13] & 4) {
+    /* Align stack pointer if the guest wants that */
+    if ((env->regs[13] & 4) && (env->v7m.ccr & R_V7M_CCR_STKALIGN_MASK)) {
         env->regs[13] -= 4;
         xpsr |= 0x200;
     }
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vx-00018k-2Z
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vw-0005B6-8S
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vw-000541-2V
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vg-0003MG-FP
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:20 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:31:59 +0000
Message-Id: <1485531137-2362-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/22] armv7m: Explicit error for bad vector
 table
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

Give an explicit error and abort when a load
from the vector table fails. Architecturally this
should HardFault (which will then immediately
fail to load the HardFault vector and go into Lockup).
Since we don't model Lockup, just report this guest
error via cpu_abort(). This is more helpful than the
previous behaviour of reading a zero, which is the
address of the reset stack pointer and not a sensible
location to jump to.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1484937883-1068-4-git-send-email-peter.maydell@linaro.org
[PMM: expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ad23de3..8edb08c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6014,6 +6014,30 @@ static void arm_log_exception(int idx)
     }
 }
 
+static uint32_t arm_v7m_load_vector(ARMCPU *cpu)
+
+{
+    CPUState *cs = CPU(cpu);
+    CPUARMState *env = &cpu->env;
+    MemTxResult result;
+    hwaddr vec = env->v7m.vecbase + env->v7m.exception * 4;
+    uint32_t addr;
+
+    addr = address_space_ldl(cs->as, vec,
+                             MEMTXATTRS_UNSPECIFIED, &result);
+    if (result != MEMTX_OK) {
+        /* Architecturally this should cause a HardFault setting HSFR.VECTTBL,
+         * which would then be immediately followed by our failing to load
+         * the entry vector for that HardFault, which is a Lockup case.
+         * Since we don't model Lockup, we just report this guest error
+         * via cpu_abort().
+         */
+        cpu_abort(cs, "Failed to read from exception vector table "
+                  "entry %08x\n", (unsigned)vec);
+    }
+    return addr;
+}
+
 void arm_v7m_cpu_do_interrupt(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -6095,7 +6119,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
     /* Clear IT bits */
     env->condexec_bits = 0;
     env->regs[14] = lr;
-    addr = ldl_phys(cs->as, env->v7m.vecbase + env->v7m.exception * 4);
+    addr = arm_v7m_load_vector(cpu);
     env->regs[15] = addr & 0xfffffffe;
     env->thumb = addr & 1;
 }
-- 
2.7.4

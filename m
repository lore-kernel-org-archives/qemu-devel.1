Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeP-00083T-94
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAyeO-00030e-JP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 10:42:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 15:42:30 +0100
Message-Id: <20181012144235.19646-6-peter.maydell@linaro.org>
In-Reply-To: <20181012144235.19646-1-peter.maydell@linaro.org>
References: <20181012144235.19646-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/10] target/arm: ISR_EL1 bits track virtual
 interrupts if IMO/FMO set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The A/I/F bits in ISR_EL1 should track the virtual interrupt
status, not the physical interrupt status, if the associated
HCR_EL2.AMO/IMO/FMO bit is set. Implement this, rather than
always showing the physical interrupt status.

We don't currently implement anything to do with external
aborts, so this applies only to the I and F bits (though it
ought to be possible for the outer guest to present a virtual
external abort to the inner guest, even if QEMU doesn't
emulate physical external aborts, so there is missing
functionality in this area).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 84b40031b6f..65e431e03b3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1328,12 +1328,26 @@ static uint64_t isr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     CPUState *cs = ENV_GET_CPU(env);
     uint64_t ret = 0;
 
-    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
-        ret |= CPSR_I;
+    if (arm_hcr_el2_imo(env)) {
+        if (cs->interrupt_request & CPU_INTERRUPT_VIRQ) {
+            ret |= CPSR_I;
+        }
+    } else {
+        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+            ret |= CPSR_I;
+        }
     }
-    if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
-        ret |= CPSR_F;
+
+    if (arm_hcr_el2_fmo(env)) {
+        if (cs->interrupt_request & CPU_INTERRUPT_VFIQ) {
+            ret |= CPSR_F;
+        }
+    } else {
+        if (cs->interrupt_request & CPU_INTERRUPT_FIQ) {
+            ret |= CPSR_F;
+        }
     }
+
     /* External aborts are not possible in QEMU so A bit is always clear */
     return ret;
 }
-- 
2.19.0

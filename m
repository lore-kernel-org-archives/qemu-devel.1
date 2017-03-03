Received: from eggs.gnu.org ([2001:4830:134:3::10]:42222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cjmO1-0007k0-DX
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cjmO0-0007uZ-EW
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:32:41 -0500
From: Andrew Jones <drjones@redhat.com>
Date: Fri,  3 Mar 2017 13:32:32 +0100
Message-Id: <20170303123232.4967-1-drjones@redhat.com>
Subject: [Qemu-devel] [PATCH] [RFT] target/arm/arm-powerctl: Fix psci info
 return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

The power state spec section 5.1.5 AFFINITY_INFO defines the
affinity info return values as

  0 ON
  1 OFF
  2 ON_PENDING

I grepped QEMU for power_state to ensure that no assumptions
of OFF=0 were being made.

Signed-off-by: Andrew Jones <drjones@redhat.com>

---

I found this with the yet to be committed kvm-unit-tests test
https://lists.cs.columbia.edu/pipermail/kvmarm/2017-February/023820.html

I've added the RFT because I didn't bother to confirm Linux is still
happy (although I can't see why it wouldn't be happier).

 target/arm/cpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 25ceaabb5ded..a8aabce7ddd5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -536,8 +536,8 @@ typedef void ARMELChangeHook(ARMCPU *cpu, void *opaque);
 /* These values map onto the return values for
  * QEMU_PSCI_0_2_FN_AFFINITY_INFO */
 typedef enum ARMPSCIState {
-    PSCI_OFF = 0,
-    PSCI_ON = 1,
+    PSCI_ON = 0,
+    PSCI_OFF = 1,
     PSCI_ON_PENDING = 2
 } ARMPSCIState;
 
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THw-0001Fg-Gj
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THv-0003HB-MO
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:41 +1000
Message-Id: <20170424015927.8933-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/47] target/ppc: Improve accuracy of guest HTM
 availability on P8s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sam Bobroff <sam.bobroff@au1.ibm.com>

On Power8 hosts it is currently theoretically possible for QEMU/KVM-HV guests
to receive a ibm,pa-features property indicating that HTM support is available
when it is not.  The situation would occur if the platform firmware of
a Power8 host cleared the HTM bit of the ibm,pa-features property.
QEMU would query KVM for the availability of HTM, which will return no
support, but workaround code in kvm_arch_init_vcpu() would then
re-enable it because KVM_HV is in use and the processor is P8.

This patch adjusts the workaround in kvm_arch_init_vcpu() so that it does not
enable HTM (in the above case) unless the host kernel indicates to the QEMU
process, via the auxiliary vector, that userspace can use HTM (via the HWCAP2
bit KVM_FEATURE2_HTM).

The reason to use the value from the auxiliary vector is that it is
set based only on what the host kernel found in the ibm,pa-features
HTM bit at boot time.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 64017ac..c3d4262 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,6 +49,7 @@
 #if defined(TARGET_PPC64)
 #include "hw/ppc/spapr_cpu_core.h"
 #endif
+#include "elf.h"
 
 //#define DEBUG_KVM
 
@@ -509,8 +510,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     case POWERPC_MMU_2_07:
         if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
             /* KVM-HV has transactional memory on POWER8 also without the
-             * KVM_CAP_PPC_HTM extension, so enable it here instead. */
-            cap_htm = true;
+             * KVM_CAP_PPC_HTM extension, so enable it here instead as
+             * long as it's availble to userspace on the host. */
+            if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
+                cap_htm = true;
+            }
         }
         break;
     default:
-- 
2.9.3

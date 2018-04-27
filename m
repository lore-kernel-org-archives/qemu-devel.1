Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzac-0002ES-6Y
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzab-0002LH-1c
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:24 +1000
Message-Id: <20180427092126.24812-48-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 47/49] target/ppc: Don't bother with MSR_EP in
 cpu_ppc_set_papr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

cpu_ppc_set_papr() removes the EP and HV bits from the MSR mask.  While
removing the HV bit makes sense (a cpu in PAPR mode should never be
emulated in hypervisor mode), the EP bit is just bizarre.  Although it's
true that a papr mode guest shouldn't be able to change the exception
prefix, the MSR[EP] bit doesn't even exist on the cpus supported for PAPR
mode, so it's pointless to do anything with it here.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/translate_init.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index bb79d23b50..808f6c1a08 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8874,12 +8874,11 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 
     cpu->vhyp = vhyp;
 
-    /* PAPR always has exception vectors in RAM not ROM. To ensure this,
-     * MSR[IP] should never be set.
-     *
-     * We also disallow setting of MSR_HV
+    /*
+     * With a virtual hypervisor mode we never allow the CPU to go
+     * hypervisor mode itself
      */
-    env->msr_mask &= ~((1ull << MSR_EP) | MSR_HVB);
+    env->msr_mask &= ~MSR_HVB;
 
     /* Set emulated LPCR to not send interrupts to hypervisor. Note that
      * under KVM, the actual HW LPCR will be set differently by KVM itself,
-- 
2.14.3

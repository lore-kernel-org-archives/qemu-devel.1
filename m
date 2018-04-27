Received: from eggs.gnu.org ([2001:4830:134:3::10]:60182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzb8-0002mx-Av
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzb7-0002Xp-Cz
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:23:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:25 +1000
Message-Id: <20180427092126.24812-49-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 48/49] spapr: Set compatibility mode before the
 rest of spapr_cpu_reset()
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

Although the order doesn't really matter at the moment, it's possible
other initializastions could depend on the compatiblity mode, so make sure
we set it first in spapr_cpu_reset().

While we're at it drop the test against first_cpu.  Setting the compat mode
to the value it already has is redundant, but harmless, so we might as well
make a small simplification to the code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 94afeb399e..01dbc69424 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -31,6 +31,11 @@ static void spapr_cpu_reset(void *opaque)
 
     cpu_reset(cs);
 
+    /* Set compatibility mode to match the boot CPU, which was either set
+     * by the machine reset code or by CAS. This should never fail.
+     */
+    ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
+
     /* All CPUs start halted.  CPU0 is unhalted from the machine level
      * reset code and the rest are explicitly started up by the guest
      * using an RTAS call */
@@ -45,12 +50,6 @@ static void spapr_cpu_reset(void *opaque)
         env->spr[SPR_LPCR] &= ~pcc->lpcr_pm;
     }
 
-    /* Set compatibility mode to match the boot CPU, which was either set
-     * by the machine reset code or by CAS. This should never fail.
-     */
-    if (cs != first_cpu) {
-        ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
-    }
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
-- 
2.14.3

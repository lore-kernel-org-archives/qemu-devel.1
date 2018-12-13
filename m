Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICe-0004Dd-BE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXICa-0002qP-Hk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 23:02:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Dec 2018 15:01:19 +1100
Message-Id: <20181213040126.6768-21-david@gibson.dropbear.id.au>
In-Reply-To: <20181213040126.6768-1-david@gibson.dropbear.id.au>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/27] spapr: export and rename the
 xics_max_server_number() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The XIVE sPAPR IRQ backend will use it to define the number of ENDs of
the IC controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 8 ++++----
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 625f467c3e..0293a23739 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -150,7 +150,7 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int=
 i)
                        (void *)(uintptr_t) i);
 }
=20
-static int xics_max_server_number(sPAPRMachineState *spapr)
+int spapr_max_server_number(sPAPRMachineState *spapr)
 {
     assert(spapr->vsmt);
     return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
@@ -1268,7 +1268,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
+    spapr_dt_xics(spapr_max_server_number(spapr), fdt, PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2467,7 +2467,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
     if (smc->pre_2_10_has_unused_icps) {
         int i;
=20
-        for (i =3D 0; i < xics_max_server_number(spapr); i++) {
+        for (i =3D 0; i < spapr_max_server_number(spapr); i++) {
             /* Dummy entries get deregistered when real ICPState objects
              * are registered during CPU core hotplug.
              */
@@ -2587,7 +2587,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
     /* VSMT must be set in order to be able to compute VCPU ids, ie to
-     * call xics_max_server_number() or spapr_vcpu_id().
+     * call spapr_max_server_number() or spapr_vcpu_id().
      */
     spapr_set_vsmt_mode(spapr, &error_fatal);
=20
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6279711fe8..198764066d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -737,6 +737,7 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
                           Error **errp);
 void spapr_clear_pending_events(sPAPRMachineState *spapr);
+int spapr_max_server_number(sPAPRMachineState *spapr);
=20
 /* CPU and LMB DRC release callbacks. */
 void spapr_core_release(DeviceState *dev);
--=20
2.19.2

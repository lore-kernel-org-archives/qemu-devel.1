Received: from eggs.gnu.org ([2001:4830:134:3::10]:44153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWv-0006of-7F
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWq-0003Nn-Qt
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:33 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:40124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgWq-0003L7-Fq
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:28 -0500
Received: from player714.ha.ovh.net (unknown [10.109.159.69])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0576C1EBB7F
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:27 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:29 +0100
Message-Id: <20181205232251.10446-16-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 15/37] spapr: export and rename the
 xics_max_server_number() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE sPAPR IRQ backend will use it to define the number of ENDs of
the IC controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h | 1 +
 hw/ppc/spapr.c         | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6279711fe8f7..198764066dc9 100644
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e470efe7993c..a689f853e020 100644
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
@@ -1270,7 +1270,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spa=
pr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
+    spapr_dt_xics(spapr_max_server_number(spapr), fdt, PHANDLE_XICP);
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -2469,7 +2469,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
     if (smc->pre_2_10_has_unused_icps) {
         int i;
=20
-        for (i =3D 0; i < xics_max_server_number(spapr); i++) {
+        for (i =3D 0; i < spapr_max_server_number(spapr); i++) {
             /* Dummy entries get deregistered when real ICPState objects
              * are registered during CPU core hotplug.
              */
@@ -2589,7 +2589,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
=20
     /* VSMT must be set in order to be able to compute VCPU ids, ie to
-     * call xics_max_server_number() or spapr_vcpu_id().
+     * call spapr_max_server_number() or spapr_vcpu_id().
      */
     spapr_set_vsmt_mode(spapr, &error_fatal);
=20
--=20
2.17.2

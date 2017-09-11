Received: from eggs.gnu.org ([2001:4830:134:3::10]:35984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIw-0002Uw-A2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1drSIr-00054a-BI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:26 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1drSIr-00054K-1Y
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:15:21 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 14321AB263
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 19:15:20 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 11 Sep 2017 19:12:35 +0200
Message-Id: <20170911171235.29331-22-clg@kaod.org>
In-Reply-To: <20170911171235.29331-1-clg@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 21/21] spapr: activate XIVE exploitation
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

A couple of adjustments need to be done to activate XIVE exploitation
mode. First, the hypervisor should advertise support for both models
XIVE legacy and XIVE exploitation in "ibm,arch-vec-5-platform-support".

The sPAPR machine starts with the XICS interrupt model (the default
behavior could be changed later on for POWER9) and, depending on the
guest capabilities, the XIVE exploitation mode is negotiated during
CAS. A reset is then performed to rebuild the device tree with new
XIVE properties under the "interrupt-controller" node.

Finally, the MMIO regions for the ESB and TIMA should be mapped at
reset time and post_load when XIVE exploitation mode is on.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c       | 33 ++++++++++++++++++++++++++++++---
 hw/ppc/spapr_hcall.c |  6 ++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d8b25be70cd8..aaf1be7a50fe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -942,7 +942,8 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr, v=
oid *fdt)
 /* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU feat=
ures
  * that the guest may request and thus the valid values for bytes 24..26=
 of
  * option vector 5: */
-static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
+static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr,
+                                          void *fdt, int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
=20
@@ -961,6 +962,13 @@ static void spapr_dt_ov5_platform_support(void *fdt,=
 int chosen)
         } else {
             val[3] =3D 0x00; /* Hash */
         }
+
+        /* TODO: introduce a kvmppc_has_cap_xive() ? Works with
+         * irqchip=3Doff for now
+         */
+        if (spapr->xive) {
+            val[1] =3D 0x80; /* OV5_XIVE_BOTH */
+        }
     } else {
         if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
             /* V3 MMU supports both hash and radix (with dynamic switchi=
ng) */
@@ -969,6 +977,9 @@ static void spapr_dt_ov5_platform_support(void *fdt, =
int chosen)
             /* Otherwise we can only do hash */
             val[3] =3D 0x00;
         }
+        if (spapr->xive) {
+            val[1] =3D 0x80;  /* OV5_XIVE_BOTH */
+        }
     }
     _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
                      val, sizeof(val)));
@@ -1027,7 +1038,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
         _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout=
_path));
     }
=20
-    spapr_dt_ov5_platform_support(fdt, chosen);
+    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
=20
     g_free(stdout_path);
     g_free(bootlist);
@@ -1106,7 +1117,13 @@ static void *spapr_build_fdt(sPAPRMachineState *sp=
apr,
     _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
=20
     /* /interrupt controller */
-    spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    } else {
+        /* populate device tree for XIVE */ ;
+        spapr_xive_populate(spapr->xive, fdt, PHANDLE_XICP);
+        spapr_xive_mmio_map(spapr->xive);
+    }
=20
     ret =3D spapr_populate_memory(spapr, fdt);
     if (ret < 0) {
@@ -1552,6 +1569,10 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         }
     }
=20
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_xive_mmio_map(spapr->xive);
+    }
+
     return err;
 }
=20
@@ -2332,6 +2353,7 @@ static void ppc_spapr_init(MachineState *machine)
                                XICS_IRQS_SPAPR + xics_max_server_number(=
),
                                xics_max_server_number(),
                                &error_fatal);
+            spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
         }
     }
=20
@@ -3463,6 +3485,11 @@ static qemu_irq spapr_qirq_get(XICSFabric *dev, in=
t irq)
         return NULL;
     }
=20
+    /* use XIVE qirqs when XIVE exploitation mode is on */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        return spapr->xive->qirqs[irq - spapr->ics->offset];
+    }
+
     return spapr->ics->qirqs[irq - spapr->ics->offset];
 }
=20
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 92f1e21358b8..ba00b8d3fdd6 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1613,6 +1613,12 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
             (spapr_h_cas_compose_response(spapr, args[1], args[2],
                                           ov5_updates) !=3D 0);
     }
+
+    /* We need to rebuild the device tree for XIVE, generate a reset */
+    if (!spapr->cas_reboot) {
+        spapr->cas_reboot =3D spapr_ovec_test(ov5_updates, OV5_XIVE_EXPL=
OIT);
+    }
+
     spapr_ovec_cleanup(ov5_updates);
=20
     if (spapr->cas_reboot) {
--=20
2.13.5

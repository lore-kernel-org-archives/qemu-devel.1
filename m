Received: from eggs.gnu.org ([2001:4830:134:3::10]:42493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnut-0005Mu-6D
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnup-0004aR-1a
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:43 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:46710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnuo-0004ZB-QR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:38 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A14CBFCE2E
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:37 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:39 +0200
Message-Id: <1499274819-15607-27-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 26/26] spapr: force XIVE exploitation mode
 for POWER9 (HACK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The CAS negotiation process determines the interrupt controller model
to use in the guest but currently, the sPAPR machine make uses of the
controller very early in the initialization sequence. The interrupt
source is used to allocate IRQ numbers and populate the device tree
and the interrupt presenter objects are created along with the CPU.

One solution would be use a bitmap to allocate these IRQ numbers and
then instantiate the interrupt source object of the correct type with
the bitmap as a constructor parameter.

As for the interrupt presenter objects, we could allocated them later
in the boot process. May be on demand, when a CPU is first notified.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ca3a6bc2ea16..623fc776c886 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -237,6 +237,38 @@ error:
     return NULL;
 }
=20
+static XiveICSState *spapr_xive_ics_create(XIVE *x, int nr_irqs, Error *=
*errp)
+{
+    Error *local_err =3D NULL;
+    int irq_base;
+    Object *obj;
+
+    /*
+     * TODO: use an XICS_IRQ_BASE alignment to be in sync with XICS
+     * irq numbers. we should probably simplify the XIVE model or use
+     * a common allocator. a bitmap maybe ?
+     */
+    irq_base =3D xive_alloc_hw_irqs(x, nr_irqs, XICS_IRQ_BASE);
+    if (irq_base < 0) {
+        error_setg(errp, "Failed to allocate %d irqs", nr_irqs);
+        return NULL;
+    }
+
+    obj =3D object_new(TYPE_ICS_XIVE);
+    object_property_add_child(OBJECT(x), "hw", obj, NULL);
+
+    xive_ics_create(ICS_XIVE(obj), x, irq_base, nr_irqs, 16 /* 64KB page=
 */,
+                    XIVE_SRC_TRIGGER, &local_err);
+    if (local_err) {
+        goto error;
+    }
+    return ICS_XIVE(obj);
+
+error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
                                   int smt_threads)
 {
@@ -814,6 +846,11 @@ static int spapr_dt_cas_updates(sPAPRMachineState *s=
papr, void *fdt,
     /* /interrupt controller */
     if (!spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)) {
         spapr_dt_xics(xics_max_server_number(), fdt, PHANDLE_XICP);
+    } else {
+        xive_spapr_populate(spapr->xive, fdt);
+
+        /* Install XIVE MMIOs */
+        xive_mmio_map(spapr->xive);
     }
=20
     offset =3D fdt_path_offset(fdt, "/chosen");
@@ -963,6 +1000,13 @@ static void spapr_dt_ov5_platform_support(void *fdt=
, int chosen)
         } else {
             val[3] =3D 0x00; /* Hash */
         }
+
+        /* TODO: introduce a kvmppc_has_cap_xive() ? Works with
+         * irqchip=3Doff for now
+         */
+        if (first_ppc_cpu->env.excp_model & POWERPC_EXCP_POWER9) {
+            val[1] =3D 0x01;
+        }
     } else {
         if (first_ppc_cpu->env.mmu_model & POWERPC_MMU_V3) {
             /* V3 MMU supports both hash and radix (with dynamic switchi=
ng) */
@@ -971,6 +1015,9 @@ static void spapr_dt_ov5_platform_support(void *fdt,=
 int chosen)
             /* Otherwise we can only do hash */
             val[3] =3D 0x00;
         }
+        if (first_ppc_cpu->env.excp_model & POWERPC_EXCP_POWER9) {
+            val[1] =3D 0x01;
+        }
     }
     _FDT(fdt_setprop(fdt, chosen, "ibm,arch-vec-5-platform-support",
                      val, sizeof(val)));
@@ -2237,6 +2284,21 @@ static void ppc_spapr_init(MachineState *machine)
     spapr->ov5 =3D spapr_ovec_new();
     spapr->ov5_cas =3D spapr_ovec_new();
=20
+    /* TODO: force XIVE mode by default on POWER9.
+     *
+     * Switching from XICS to XIVE is badly broken. The ICP type is
+     * incorrect and the ICS is needed before the CAS negotiation to
+     * allocate irq numbers ...
+     */
+    if (strstr(machine->cpu_model, "POWER9") ||
+        !strcmp(machine->cpu_model, "host")) {
+        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
+
+        spapr->icp_type =3D TYPE_XIVE_ICP;
+        spapr->ics =3D ICS_BASE(
+            spapr_xive_ics_create(spapr->xive, XICS_IRQS_SPAPR, &error_f=
atal));
+    }
+
     if (smc->dr_lmb_enabled) {
         spapr_ovec_set(spapr->ov5, OV5_DRCONF_MEMORY);
         spapr_validate_node_memory(machine, &error_fatal);
--=20
2.7.5

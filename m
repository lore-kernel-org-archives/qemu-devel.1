Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vs-0008U1-7o
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98vo-0008T0-A9
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:00 -0400
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:45698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98vn-0008Rn-WD
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:44:56 -0400
Received: from player792.ha.ovh.net (unknown [10.109.108.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8B7D01574EE
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:44:54 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:08 +0200
Message-Id: <20180419124331.3915-13-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/35] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The sPAPRXive object is designed to be always available, so it is
created unconditionally on newer machines. Depending on the
configuration and the guest capabilities, the CAS negotiation process
will decide which interrupt mode to activate: legacy or XIVE
exploitation.

The XIVE model makes use of the full range of the IRQ number space.
The IRQ numbers for the CPU IPIs in XIVE are allocated at the bottom
of this space, below XICS_IRQ_BASE, to preserve compatibility with
XICS which does not use that range.

That leaves us with 4K possible IPIs. This should be enough for
sometime given that the maximum number of CPUs is 1024 for the sPAPR
machine under QEMU. For the record, the biggest POWER8 or POWER9
system has a maximum of 1536 HW threads (16 sockets, 192 cores, SMT8).

Also make sure that the allocated IRQ numbers are kept in sync between
XICS and XIVE, when available.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - introduced the xive_system_init() routine
 - handled vsmt by moving the allocation of the IPIS after the CPUs
   are initialized

 hw/ppc/spapr.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr.h |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b459c0076792..8bbd2a677935 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -56,6 +56,7 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/spapr_xive.h"
 #include "hw/pci/msi.h"
=20
 #include "hw/pci/pci.h"
@@ -209,6 +210,48 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
     }
 }
=20
+static sPAPRXive *spapr_xive_create(sPAPRMachineState *spapr,
+                                    const char *type_xive, int nr_irqs,
+                                    Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(type_xive);
+    object_property_add_child(OBJECT(spapr), "xive", obj, &error_abort);
+    object_property_set_int(obj, nr_irqs, "nr-irqs",  &local_err);
+    if (local_err) {
+        goto error;
+    }
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+    return SPAPR_XIVE(obj);
+error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+static void xive_system_init(MachineState *machine, int nr_irqs, Error *=
*errp)
+{
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
+
+    /* We don't have KVM support yet, so check for irqchip=3Don */
+    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
+        error_report("kernel_irqchip requested. no XIVE support");
+        exit(1);
+    }
+
+    if (spapr->xive) {
+        return;
+    }
+
+    spapr->xive =3D spapr_xive_create(spapr, TYPE_SPAPR_XIVE, nr_irqs, e=
rrp);
+}
+
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
                                   int smt_threads)
 {
@@ -2473,6 +2516,12 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* Set up Interrupt Controller before we create the VCPUs */
     xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
=20
+    if (spapr->xive_exploitation) {
+        /* XIVE uses the full range of IRQ numbers. */
+        xive_system_init(machine, XICS_IRQ_BASE + XICS_IRQS_SPAPR,
+                         &error_fatal);
+    }
+
     /* Set up containers for ibm,client-architecture-support negotiated =
options
      */
     spapr->ov5 =3D spapr_ovec_new();
@@ -2503,6 +2552,14 @@ static void spapr_machine_init(MachineState *machi=
ne)
     /* init CPUs */
     spapr_init_cpus(spapr);
=20
+    /* Allocate the first IRQ numbers for the CPU IPIs, below
+     * XICS_IRQ_BASE, which is unused by XICS. */
+    if (spapr->xive_exploitation) {
+        for (i =3D 0; i < xics_max_server_number(spapr); ++i) {
+            spapr_xive_irq_enable(spapr->xive, i, false);
+        }
+    }
+
     if (kvm_enabled()) {
         /* Enable H_LOGICAL_CI_* so SLOF can talk to in-kernel devices *=
/
         kvmppc_enable_logical_ci_hcalls();
@@ -3752,6 +3809,9 @@ static int ics_find_free_block(ICSState *ics, int n=
um, int alignnum)
 static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
 {
     ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
+    if (spapr->xive_exploitation) {
+        spapr_xive_irq_enable(spapr->xive, irq, lsi);
+    }
 }
=20
 int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
@@ -3842,6 +3902,9 @@ void spapr_irq_free(sPAPRMachineState *spapr, int i=
rq, int num)
             memset(&ics->irqs[i], 0, sizeof(ICSIRQState));
         }
     }
+    if (spapr->xive_exploitation) {
+        spapr_xive_irq_disable(spapr->xive, irq);
+    }
 }
=20
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3f8980310492..875f658973a1 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -14,6 +14,7 @@ struct sPAPRNVRAM;
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 typedef struct sPAPRPendingHPT sPAPRPendingHPT;
+typedef struct sPAPRXive sPAPRXive;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -166,6 +167,7 @@ struct sPAPRMachineState {
=20
     const char *icp_type;
     uint8_t xive_exploitation;
+    sPAPRXive  *xive;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
--=20
2.13.6

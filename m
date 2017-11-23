Received: from eggs.gnu.org ([2001:4830:134:3::10]:39529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcE-00021W-Ai
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHrcB-0002nP-56
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:30 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:55544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHrcA-0002mb-W0
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:32:27 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 03DC5175AF9
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 14:32:26 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 14:29:47 +0100
Message-Id: <20171123132955.1261-18-clg@kaod.org>
In-Reply-To: <20171123132955.1261-1-clg@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE object is designed to be always available, so it is created
unconditionally on newer machines. Depending on the configuration and
the guest capabilities, the CAS negotiation process will decide which
interrupt model to use, legacy or XIVE.

The XIVE model makes use of the full range of the IRQ number space
because the IRQ numbers for the CPU IPIs are allocated in the range
below XICS_IRQ_BASE, which is unused by XICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5d3325ca3c88..0e0107c8272c 100644
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
@@ -204,6 +205,29 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
     }
 }
=20
+static sPAPRXive *spapr_xive_create(sPAPRMachineState *spapr, int nr_irq=
s,
+                                    Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    obj =3D object_new(TYPE_SPAPR_XIVE);
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
+    return SPAPR_XIVE(obj);
+error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
                                   int smt_threads)
 {
@@ -2360,6 +2384,16 @@ static void ppc_spapr_init(MachineState *machine)
     /* Set up Interrupt Controller before we create the VCPUs */
     xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
=20
+    /* We don't have KVM support yet, so check for irqchip=3Don */
+    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
+        error_report("kernel_irqchip requested. no XIVE support");
+    } else {
+        /* XIVE uses the full range of IRQ numbers. The CPU IPIs will
+         * use the range below XICS_IRQ_BASE, which is unused by XICS. *=
/
+        spapr->xive =3D spapr_xive_create(spapr, XICS_IRQ_BASE + XICS_IR=
QS_SPAPR,
+                                        &error_fatal);
+    }
+
     /* Set up containers for ibm,client-architecture-support negotiated =
options
      */
     spapr->ov5 =3D spapr_ovec_new();
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9a3885593c86..90e2b0f6c678 100644
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
@@ -127,6 +128,7 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
=20
     const char *icp_type;
+    sPAPRXive  *xive;
 };
=20
 #define H_SUCCESS         0
--=20
2.13.6

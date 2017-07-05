Received: from eggs.gnu.org ([2001:4830:134:3::10]:42260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnua-00056K-Ee
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuW-0004JQ-E4
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:24 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:59183)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnuW-0004IQ-7P
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:20 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 26EEAFCE22
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:19 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:36 +0200
Message-Id: <1499274819-15607-24-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 23/26] spapr: add a XIVE object to the
 sPAPR machine
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

Let's create the XIVE object whether it used or not by the
machine. CAS will decide which model will be used for the interrupt
controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0256e7a537bf..45527b4c5eca 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -54,6 +54,7 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/xive.h"
 #include "hw/pci/msi.h"
=20
 #include "hw/pci/pci.h"
@@ -204,6 +205,38 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
     }
 }
=20
+static XIVE *spapr_xive_create(sPAPRMachineState *spapr, int nr_servers,
+                               Error **errp)
+{
+    Error *local_err =3D NULL;
+    Object *obj;
+
+    /* TODO: We don't have KVM support yet so check irqchip=3Doff here *=
/
+    if (kvm_enabled() && machine_kernel_irqchip_required(MACHINE(spapr))=
) {
+        error_prepend(errp, "kernel_irqchip requested but unavailable");
+        return NULL;
+    }
+
+    obj =3D object_new(TYPE_XIVE);
+    object_property_add_child(OBJECT(spapr), "xive", obj, &error_abort);
+    object_property_set_int(obj, nr_servers, "nr-targets", &local_err);
+    if (local_err) {
+        goto error;
+    }
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        goto error;
+    }
+
+    /* Install hcalls */
+    xive_spapr_init(spapr);
+
+    return XIVE(obj);
+error:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
 static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu=
,
                                   int smt_threads)
 {
@@ -2192,6 +2225,14 @@ static void ppc_spapr_init(MachineState *machine)
     /* Set up Interrupt Controller before we create the VCPUs */
     xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
=20
+    /* Set up XIVE. CAS will choose whether the guest runs in XICS
+     * (legacy mode) or XIVE Exploitation mode
+     *
+     * TODO: if XIVE creation fails, force the use of XICS legacy
+     */
+    spapr->xive =3D spapr_xive_create(spapr, xics_max_server_number(),
+                                    &error_fatal);
+
     /* Set up containers for ibm,client-set-architecture negotiated opti=
ons */
     spapr->ov5 =3D spapr_ovec_new();
     spapr->ov5_cas =3D spapr_ovec_new();
--=20
2.7.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgz-0007R5-Ov
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqgu-0008GL-8B
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:53 -0500
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:60131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqgt-000820-Nw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:39:48 -0500
Received: from player688.ha.ovh.net (unknown [10.109.146.86])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 10ECE2095D0
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:39:31 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:12 +0100
Message-Id: <20181211223823.13770-2-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 01/12] spapr: introduce a new machine IRQ
 backend for XIVE
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

The XIVE IRQ backend uses the same layout as the new XICS backend but
covers the full range of the IRQ number space. The IRQ numbers for the
CPU IPIs are allocated at the bottom of this space, below 4K, to
preserve compatibility with XICS which does not use that range.

This should be enough given that the maximum number of CPUs is 1024
for the sPAPR machine under QEMU. For the record, the biggest POWER8
or POWER9 system has a maximum of 1536 HW threads (16 sockets, 192
cores, SMT8).

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v7:

 - removed spapr_xive_create()
 - reworked spapr_irq_init_xive() to use qdev_create()
=20
 include/hw/ppc/spapr.h     |  2 +
 include/hw/ppc/spapr_irq.h |  2 +
 hw/ppc/spapr_irq.c         | 93 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 198764066dc9..cb3082d319af 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -16,6 +16,7 @@ typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 typedef struct sPAPRPendingHPT sPAPRPendingHPT;
 typedef struct ICSState ICSState;
+typedef struct sPAPRXive sPAPRXive;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -175,6 +176,7 @@ struct sPAPRMachineState {
     const char *icp_type;
     int32_t irq_map_nr;
     unsigned long *irq_map;
+    sPAPRXive  *xive;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
     sPAPRCapabilities def, eff, mig;
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index bd7301e6d9c6..23cdb51b879e 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -13,6 +13,7 @@
 /*
  * IRQ range offsets per device type
  */
+#define SPAPR_IRQ_IPI        0x0
 #define SPAPR_IRQ_EPOW       0x1000  /* XICS_IRQ_BASE offset */
 #define SPAPR_IRQ_HOTPLUG    0x1001
 #define SPAPR_IRQ_VIO        0x1100  /* 256 VIO devices */
@@ -42,6 +43,7 @@ typedef struct sPAPRIrq {
=20
 extern sPAPRIrq spapr_irq_xics;
 extern sPAPRIrq spapr_irq_xics_legacy;
+extern sPAPRIrq spapr_irq_xive;
=20
 void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f8b651de0ec9..1f5aac55d370 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
 #include "sysemu/kvm.h"
=20
@@ -205,6 +206,98 @@ sPAPRIrq spapr_irq_xics =3D {
     .print_info  =3D spapr_irq_print_info_xics,
 };
=20
+/*
+ * XIVE IRQ backend.
+ */
+static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
+{
+    MachineState *machine =3D MACHINE(spapr);
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    uint32_t nr_servers =3D spapr_max_server_number(spapr);
+    DeviceState *dev;
+    int i;
+
+    /* KVM XIVE device not yet available */
+    if (kvm_enabled()) {
+        if (machine_kernel_irqchip_required(machine)) {
+            error_setg(errp, "kernel_irqchip requested. no KVM XIVE supp=
ort");
+            return;
+        }
+    }
+
+    dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
+    qdev_prop_set_uint32(dev, "nr-irqs", smc->irq->nr_irqs);
+    /*
+     * 8 XIVE END structures per CPU. One for each available priority
+     */
+    qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
+    qdev_init_nofail(dev);
+
+    spapr->xive =3D SPAPR_XIVE(dev);
+
+    /* Enable the CPU IPIs */
+    for (i =3D 0; i < nr_servers; ++i) {
+        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
+    }
+}
+
+static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, bool =
lsi,
+                                Error **errp)
+{
+    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
+        error_setg(errp, "IRQ %d is invalid", irq);
+        return -1;
+    }
+    return 0;
+}
+
+static void spapr_irq_free_xive(sPAPRMachineState *spapr, int irq, int n=
um)
+{
+    int i;
+
+    for (i =3D irq; i < irq + num; ++i) {
+        spapr_xive_irq_free(spapr->xive, i);
+    }
+}
+
+static qemu_irq spapr_qirq_xive(sPAPRMachineState *spapr, int irq)
+{
+    return spapr_xive_qirq(spapr->xive, irq);
+}
+
+static void spapr_irq_print_info_xive(sPAPRMachineState *spapr,
+                                      Monitor *mon)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+
+        xive_tctx_pic_print_info(XIVE_TCTX(cpu->intc), mon);
+    }
+
+    spapr_xive_pic_print_info(spapr->xive, mon);
+}
+
+/*
+ * XIVE uses the full IRQ number space. Set it to 8K to be compatible
+ * with XICS.
+ */
+
+#define SPAPR_IRQ_XIVE_NR_IRQS     0x2000
+#define SPAPR_IRQ_XIVE_NR_MSIS     (SPAPR_IRQ_XIVE_NR_IRQS - SPAPR_IRQ_M=
SI)
+
+sPAPRIrq spapr_irq_xive =3D {
+    .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
+    .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
+
+    .init        =3D spapr_irq_init_xive,
+    .claim       =3D spapr_irq_claim_xive,
+    .free        =3D spapr_irq_free_xive,
+    .qirq        =3D spapr_qirq_xive,
+    .print_info  =3D spapr_irq_print_info_xive,
+};
+
 /*
  * sPAPR IRQ frontend routines for devices
  */
--=20
2.17.2

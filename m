Received: from eggs.gnu.org ([2001:4830:134:3::10]:44991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgYE-0007zb-NB
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgY8-0004Ii-H0
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:54 -0500
Received: from 4.mo178.mail-out.ovh.net ([46.105.49.171]:38340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgY7-0004Ei-Sa
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:25:48 -0500
Received: from player714.ha.ovh.net (unknown [10.109.146.32])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 8FC2541390
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:25:45 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:44 +0100
Message-Id: <20181205232251.10446-31-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 30/37] spapr/xive: enable XIVE MMIOs at reset
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

Depending on the interrupt mode chosen, enable or disable the XIVE
MMIOs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h | 1 +
 hw/intc/spapr_xive.c        | 9 +++++++++
 hw/ppc/spapr_irq.c          | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 277771eeb4d5..735e916d3844 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -65,6 +65,7 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t n=
r_servers, void *fdt,
                    uint32_t phandle);
 void spapr_xive_reset_tctx(sPAPRXive *xive);
 void spapr_xive_map_mmio(sPAPRXive *xive);
+void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable);
=20
 /*
  * KVM XIVE device helpers
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b030cfe7f136..68d2a6fd8177 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -196,6 +196,15 @@ void spapr_xive_map_mmio(sPAPRXive *xive)
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
=20
+void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable)
+{
+    memory_region_set_enabled(&xive->source.esb_mmio, enable);
+    memory_region_set_enabled(&xive->tm_mmio, enable);
+
+    /* Disable the END ESBs until a guest OS makes use of them */
+    memory_region_set_enabled(&xive->end_source.esb_mmio, false);
+}
+
 /*
  * When a Virtual Processor is scheduled to run on a HW thread, the
  * hypervisor pushes its identifier in the OS CAM line. Emulate the
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f9b5564b271c..94bb4d27758a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -216,6 +216,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState *=
spapr, Error **errp)
     CPU_FOREACH(cs) {
         spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
     }
+
+    /* Deactivate the XIVE MMIOs */
+    if (spapr->xive) {
+        spapr_xive_enable_mmio(spapr->xive, false);
+    }
 }
=20
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
@@ -365,6 +370,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
      * to come after the XiveTCTX reset handlers.
      */
     spapr_xive_reset_tctx(spapr->xive);
+
+    /* Activate the XIVE MMIOs */
+    spapr_xive_enable_mmio(spapr->xive, true);
 }
=20
 /*
--=20
2.17.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhV-0007sY-Hz
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWqhS-0000iu-Bs
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:25 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:40225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWqhS-0000em-0z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 17:40:22 -0500
Received: from player688.ha.ovh.net (unknown [10.109.159.159])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id E1012176CB6
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 23:40:19 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Dec 2018 23:38:21 +0100
Message-Id: <20181211223823.13770-11-clg@kaod.org>
In-Reply-To: <20181211223823.13770-1-clg@kaod.org>
References: <20181211223823.13770-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 10/12] spapr: enable XIVE MMIOs at reset
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

Depending on the interrupt mode of the machine, enable or disable the
XIVE MMIOs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v7:

 - renamed spapr_xive_enable_mmio() to spapr_xive_mmio_set_enabled()

 include/hw/ppc/spapr_xive.h | 1 +
 hw/intc/spapr_xive.c        | 9 +++++++++
 hw/ppc/spapr_irq.c          | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 728735dbcfbe..9b49871bdb1a 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -48,5 +48,6 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
+void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index aaa5865c4080..cd1b2c06f88b 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -179,6 +179,15 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
=20
+void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable)
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
index 814500f22d34..b1319905327f 100644
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
+        spapr_xive_mmio_set_enabled(spapr->xive, false);
+    }
 }
=20
 #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
@@ -341,6 +346,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
         /* (TCG) Set the OS CAM line of the thread interrupt context. */
         spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
     }
+
+    /* Activate the XIVE MMIOs */
+    spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
=20
 /*
--=20
2.17.2

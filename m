Received: from eggs.gnu.org ([208.118.235.92]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYu-00042j-TL
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYr-0006cE-Ni
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:59:28 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:50133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1geZYr-0006be-Gr
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:59:25 -0500
Received: from player773.ha.ovh.net (unknown [10.109.160.217])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 34A8810EEAF
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 06:59:24 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  2 Jan 2019 06:57:43 +0100
Message-Id: <20190102055743.5052-11-clg@kaod.org>
In-Reply-To: <20190102055743.5052-1-clg@kaod.org>
References: <20190102055743.5052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/10] spapr: enable XIVE MMIOs at reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Depending on the interrupt mode of the machine, enable or disable the
XIVE MMIOs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h | 1 +
 hw/intc/spapr_xive.c        | 9 +++++++++
 hw/ppc/spapr_irq.c          | 9 +++++++++
 3 files changed, 19 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 9ee524fdb218..7fdc25057420 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -47,5 +47,6 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
+void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index eea28337e807..d391177ab81f 100644
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
index d110b8cdeec7..5fce72fe0f6c 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -375,6 +375,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
         /* (TCG) Set the OS CAM line of the thread interrupt context. */
         spapr_xive_set_tctx_os_cam(cpu->tctx);
     }
+
+    /* Activate the XIVE MMIOs */
+    spapr_xive_mmio_set_enabled(spapr->xive, true);
 }
=20
 static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
@@ -549,6 +552,12 @@ static int spapr_irq_post_load_dual(sPAPRMachineStat=
e *spapr, int version_id)
=20
 static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
 {
+    /*
+     * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
+     * if selected.
+     */
+    spapr_xive_mmio_set_enabled(spapr->xive, false);
+
     spapr_irq_current(spapr)->reset(spapr, errp);
 }
=20
--=20
2.20.1

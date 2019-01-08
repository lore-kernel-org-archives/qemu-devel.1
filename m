Received: from eggs.gnu.org ([209.51.188.92]:58809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09r-00073V-2y
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09p-0007kh-SJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:46:00 +1100
Message-Id: <20190108224600.23125-30-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/29] spapr: enable XIVE MMIOs at reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Depending on the interrupt mode of the machine, enable or disable the
XIVE MMIOs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c        | 9 +++++++++
 hw/ppc/spapr_irq.c          | 9 +++++++++
 include/hw/ppc/spapr_xive.h | 1 +
 3 files changed, 19 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index eea28337e8..d391177ab8 100644
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
index d110b8cdee..5fce72fe0f 100644
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
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 9ee524fdb2..7fdc250574 100644
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
--=20
2.20.1

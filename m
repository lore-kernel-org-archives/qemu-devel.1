Received: from eggs.gnu.org ([2001:4830:134:3::10]:57592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wE-0000UU-Qt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wA-0000In-RV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:22 -0400
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:57109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wA-0000Ho-Fw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:18 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.84])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 1C0DC1B3526
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:17 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:12 +0200
Message-Id: <20180419124331.3915-17-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 16/35] spapr: introduce a helper to map the
 XIVE memory regions
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

When the XIVE exploitation interrupt mode is activated, the machine
needs to expose to the guest the MMIO regions used by the controller :

  - Event State Buffers
  - Thread Interrupt Management Area for the OS and User views

Migration will also need to reflect the current interrupt mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 Changes since v2:
=20
 - introduced spapr_xive_mmio_unmap()
 - introduced spapr_machine_reset() for reset and post_load
=20
 hw/intc/spapr_xive.c        | 24 ++++++++++++++++++++++++
 hw/ppc/spapr.c              | 22 ++++++++++++++++++++++
 include/hw/ppc/spapr_xive.h |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index d0d5a7d7f969..7aba6e571a93 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -239,3 +239,27 @@ bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_=
t lisn)
     xive_source_irq_set(xsrc, lisn - xsrc->offset, false);
     return true;
 }
+
+void spapr_xive_mmio_map(sPAPRXive *xive)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    /* ESBs */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xsrc), 0, xsrc->esb_base);
+
+    /* Thread Management Interrupt Area: User and OS views */
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->tm_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->tm_base + (1 << TM_SH=
IFT));
+}
+
+void spapr_xive_mmio_unmap(sPAPRXive *xive)
+{
+    XiveSource *xsrc =3D &xive->source;
+
+    /* ESBs */
+    sysbus_mmio_unmap(SYS_BUS_DEVICE(xsrc), 0);
+
+    /* Thread Management Interrupt Area: User and OS views */
+    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 0);
+    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 1);
+}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d4bc6f56c9d4..a9770f8f0a6e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1519,6 +1519,19 @@ static int spapr_reset_drcs(Object *child, void *o=
paque)
     return 0;
 }
=20
+/* Setup XIVE exploitation or legacy mode as required by CAS */
+static void spapr_reset_interrupt(sPAPRMachineState *spapr, Error **errp=
)
+{
+    /* Reset XIVE if enabled */
+    if (spapr->xive_exploitation) {
+        spapr_xive_mmio_unmap(spapr->xive);
+    }
+
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
+        spapr_xive_mmio_map(spapr->xive);
+    }
+}
+
 static void spapr_machine_reset(void)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
@@ -1555,6 +1568,8 @@ static void spapr_machine_reset(void)
         ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
     }
=20
+    spapr_reset_interrupt(spapr, &error_fatal);
+
     qemu_devices_reset();
=20
     /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
@@ -1664,6 +1679,7 @@ static int spapr_post_load(void *opaque, int versio=
n_id)
 {
     sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
     int err =3D 0;
+    Error *local_err =3D NULL;
=20
     err =3D spapr_caps_post_migration(spapr);
     if (err) {
@@ -1698,6 +1714,12 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
         }
     }
=20
+    spapr_reset_interrupt(spapr, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
     return err;
 }
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 416f51404ce2..0373b1c995bc 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -35,6 +35,8 @@ typedef struct sPAPRXive {
 bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+void spapr_xive_mmio_map(sPAPRXive *xive);
+void spapr_xive_mmio_unmap(sPAPRXive *xive);
=20
 /*
  * sPAPR encoding of EQ indexes
--=20
2.13.6

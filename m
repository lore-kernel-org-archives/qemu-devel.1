Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuU-00050O-44
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnuQ-0004Fr-4F
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:18 -0400
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:43386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnuP-0004FE-U8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:16:14 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id F1ACAFCD9C
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:16:12 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:35 +0200
Message-Id: <1499274819-15607-23-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 22/26] ppc/xive: create an XIVE interrupt
 source to handle IPIs
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

Isolate the IPIs in their own interrupt source.

This is not strictly needed for sPAPR, but it might useful for
PowerNV.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive-internal.h |  2 ++
 hw/intc/xive.c          | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index 5e8b78a1ea6a..f37e07f00038 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -204,6 +204,8 @@ struct XIVE {
     uint32_t     tm_shift;
     hwaddr       tm_base;
     MemoryRegion tm_iomem;
+
+    XiveICSState ipi_xs;
 };
=20
 void xive_reset(void *dev);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 42eefbe7fd65..257b324e1d32 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -821,6 +821,9 @@ static uint32_t xive_alloc_ipi_irqs(XIVE *x, uint32_t=
 count, uint32_t align)
 #define TM_SHIFT         16
 #define TM_BAR_SIZE      (XIVE_TM_RING_COUNT * (1 << TM_SHIFT))
=20
+/* One 64k page. OPAL has two */
+#define IPI_ESB_SHIFT    (16)
+
 static uint64_t xive_esb_default_read(void *p, hwaddr offset, unsigned s=
ize)
 {
     qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
@@ -863,12 +866,18 @@ void xive_reset(void *dev)
=20
 static void xive_init(Object *obj)
 {
-    ;
+    XIVE *x =3D XIVE(obj);
+
+    object_initialize(&x->ipi_xs, sizeof(x->ipi_xs), TYPE_ICS_XIVE);
+    object_property_add_child(obj, "ipis", OBJECT(&x->ipi_xs), NULL);
 }
=20
 static void xive_realize(DeviceState *dev, Error **errp)
 {
+    Error *error =3D NULL;
     XIVE *x =3D XIVE(dev);
+    uint32_t ipi_base;
+    int i;
=20
     if (!x->nr_targets) {
         error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
@@ -917,6 +926,19 @@ static void xive_realize(DeviceState *dev, Error **e=
rrp)
                           "xive.tm", TM_BAR_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->tm_iomem);
=20
+    /* IPI source */
+    ipi_base =3D xive_alloc_ipi_irqs(x, x->nr_targets, 1);
+
+    xive_ics_create(&x->ipi_xs, x, ipi_base, x->nr_targets,
+                    IPI_ESB_SHIFT, XIVE_SRC_TRIGGER, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
+    for (i =3D 0; i < ICS_BASE(&x->ipi_xs)->nr_irqs; i++) {
+        ics_set_irq_type(ICS_BASE(&x->ipi_xs), i, false);
+    }
     qemu_register_reset(xive_reset, dev);
 }
=20
--=20
2.7.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSntC-0003md-D0
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dSnt8-0002zy-Ds
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:58 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:56930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dSnt8-0002zF-3g
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:14:54 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id C4F2EFCC94
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 19:14:52 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Jul 2017 19:13:22 +0200
Message-Id: <1499274819-15607-10-git-send-email-clg@kaod.org>
In-Reply-To: <1499274819-15607-1-git-send-email-clg@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 09/26] ppc/xive: add an overall memory
 region for the ESBs
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

Each source adds its own ESB mempry region to the overall ESB memory
region of the controller. It will be mapped in the CPU address space
when XIVE is activated.

The default mapping address for the ESB memory region is the same one
used on baremetal.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive-internal.h |  5 +++++
 hw/intc/xive.c          | 44 +++++++++++++++++++++++++++++++++++++++++++=
-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
index 8e755aa88a14..c06be823aad0 100644
--- a/hw/intc/xive-internal.h
+++ b/hw/intc/xive-internal.h
@@ -98,6 +98,7 @@ struct XIVE {
     SysBusDevice parent;
=20
     /* Properties */
+    uint32_t     chip_id;
     uint32_t     nr_targets;
=20
     /* IRQ number allocator */
@@ -111,6 +112,10 @@ struct XIVE {
     void         *sbe;
     XiveIVE      *ivt;
     XiveEQ       *eqdt;
+
+    /* ESB and TIMA memory location */
+    hwaddr       vc_base;
+    MemoryRegion esb_iomem;
 };
=20
 void xive_reset(void *dev);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8f8bb8b787bd..a1cb87a07b76 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -312,6 +312,7 @@ static void xive_ics_realize(ICSState *ics, Error **e=
rrp)
     XiveICSState *xs =3D ICS_XIVE(ics);
     Object *obj;
     Error *err =3D NULL;
+    XIVE *x;
=20
     obj =3D object_property_get_link(OBJECT(xs), "xive", &err);
     if (!obj) {
@@ -319,7 +320,7 @@ static void xive_ics_realize(ICSState *ics, Error **e=
rrp)
                    __func__, error_get_pretty(err));
         return;
     }
-    xs->xive =3D XIVE(obj);
+    x =3D xs->xive =3D XIVE(obj);
=20
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
@@ -338,6 +339,11 @@ static void xive_ics_realize(ICSState *ics, Error **=
errp)
                           "xive.esb",
                           (1ull << xs->esb_shift) * ICS_BASE(xs)->nr_irq=
s);
=20
+    /* Install the ESB memory region in the overall one */
+    memory_region_add_subregion(&x->esb_iomem,
+                                ICS_BASE(xs)->offset * (1 << xs->esb_shi=
ft),
+                                &xs->esb_iomem);
+
     qemu_register_reset(xive_ics_reset, xs);
 }
=20
@@ -375,6 +381,32 @@ static const TypeInfo xive_ics_info =3D {
  */
 #define MAX_HW_IRQS_ENTRIES (8 * 1024)
=20
+/* VC BAR contains set translations for the ESBs and the EQs. */
+#define VC_BAR_DEFAULT   0x10000000000ull
+#define VC_BAR_SIZE      0x08000000000ull
+
+#define P9_MMIO_BASE     0x006000000000000ull
+#define P9_CHIP_BASE(id) (P9_MMIO_BASE | (0x40000000000ull * (uint64_t) =
(id)))
+
+static uint64_t xive_esb_default_read(void *p, hwaddr offset, unsigned s=
ize)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
+                  __func__, offset, size);
+    return 0;
+}
+
+static void xive_esb_default_write(void *opaque, hwaddr offset, uint64_t=
 value,
+                unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
+                  __func__, offset, value, size);
+}
+
+static const MemoryRegionOps xive_esb_default_ops =3D {
+    .read =3D xive_esb_default_read,
+    .write =3D xive_esb_default_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
=20
 void xive_reset(void *dev)
 {
@@ -435,10 +467,20 @@ static void xive_realize(DeviceState *dev, Error **=
errp)
     x->eqdt =3D g_malloc0(x->nr_targets * XIVE_EQ_PRIORITY_COUNT *
                         sizeof(XiveEQ));
=20
+    /* VC BAR. That's the full window but we will only map the
+     * subregions in use. */
+    x->vc_base =3D (hwaddr)(P9_CHIP_BASE(x->chip_id) | VC_BAR_DEFAULT);
+
+    /* install default memory region handlers to log bogus access */
+    memory_region_init_io(&x->esb_iomem, NULL, &xive_esb_default_ops,
+                          NULL, "xive.esb", VC_BAR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->esb_iomem);
+
     qemu_register_reset(xive_reset, dev);
 }
=20
 static Property xive_properties[] =3D {
+    DEFINE_PROP_UINT32("chip-id", XIVE, chip_id, 0),
     DEFINE_PROP_UINT32("nr-targets", XIVE, nr_targets, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
--=20
2.7.5

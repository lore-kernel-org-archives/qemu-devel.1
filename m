Received: from eggs.gnu.org ([2001:4830:134:3::10]:38839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBv-00028F-Rd
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxBr-0003la-46
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:11 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:36846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxBq-0003kj-Q8
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:51:07 -0400
Received: from player169.ha.ovh.net (unknown [10.109.105.30])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6169E1A18E
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:51:05 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:44 +0200
Message-Id: <20180607155003.1580-10-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 09/28] ppc/xive: add support for the EQ
 Event State buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Event Queue Descriptor also contains two Event State Buffers
providing further coalescing of interrupts, one for the notification
event (ESn) and one for the escalation events (ESe). A MMIO page is
assigned for each to control the EOI through loads only. Stores are
not allowed.

The EQ ESB are modeled through an object resembling the 'XiveSource'
It is stateless as the EQ state bits are backed into the XiveEQ
structure under the XiveRouter and the MMIO accesses follow the same
rules as the standard source ESBs.

EQ ESBs are not supported by the Linux drivers neither on OPAL nor on
sPAPR. Nnevetherless, it provides a mean to study the question in the
future and validates a bit more the XIVE model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  20 +++++++
 hw/intc/xive.c        | 159 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 2 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fc2ed7319f0f..e5f6800b50d3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -209,6 +209,26 @@ int xive_router_set_eq(XiveRouter *xrtr, uint8_t eq_=
blk, uint32_t eq_idx,
                        XiveEQ *eq);
=20
 /*
+ * XIVE EQ ESBs
+ */
+
+#define TYPE_XIVE_EQ_SOURCE "xive-eq-source"
+#define XIVE_EQ_SOURCE(obj) \
+    OBJECT_CHECK(XiveEQSource, (obj), TYPE_XIVE_EQ_SOURCE)
+
+typedef struct XiveEQSource {
+    SysBusDevice parent;
+
+    uint32_t        nr_eqs;
+
+    /* ESB memory region */
+    uint32_t        esb_shift;
+    MemoryRegion    esb_mmio;
+
+    XiveRouter      *xrtr;
+} XiveEQSource;
+
+/*
  * For legacy compatibility, the exceptions define up to 256 different
  * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
  * and the least favored level 0xFF.
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ae5c7f545d30..64d8d15385bc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -584,8 +584,18 @@ static void xive_router_eq_notify(XiveRouter *xrtr, =
uint8_t eq_blk,
      * futher even coalescing in the Router
      */
     if (!(eq.w0 & EQ_W0_UCOND_NOTIFY)) {
-        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
-        return;
+        uint8_t pq =3D GETFIELD(EQ_W1_ESn, eq.w1);
+        bool notify =3D xive_esb_trigger(&pq);
+
+        if (pq !=3D GETFIELD(EQ_W1_ESn, eq.w1)) {
+            eq.w1 =3D SETFIELD(EQ_W1_ESn, eq.w1, pq);
+            xive_router_set_eq(xrtr, eq_blk, eq_idx, &eq);
+        }
+
+        /* ESn[Q]=3D1 : end of notification */
+        if (!notify) {
+            return;
+        }
     }
=20
     /*
@@ -687,6 +697,150 @@ void xive_router_print_ive(XiveRouter *xrtr, uint32=
_t lisn, XiveIVE *ive,
 }
=20
 /*
+ * EQ ESB MMIO loads
+ */
+static uint64_t xive_eq_source_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    XiveEQSource *xsrc =3D XIVE_EQ_SOURCE(opaque);
+    XiveRouter *xrtr =3D xsrc->xrtr;
+    uint32_t offset =3D addr & 0xFFF;
+    uint8_t eq_blk;
+    uint32_t eq_idx;
+    XiveEQ eq;
+    uint32_t eq_esmask;
+    uint8_t pq;
+    uint64_t ret =3D -1;
+
+    eq_blk =3D xrtr->chip_id;
+    eq_idx =3D addr >> (xsrc->esb_shift + 1);
+    if (xive_router_get_eq(xrtr, eq_blk, eq_idx, &eq)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ %x/%x\n", eq_blk, eq=
_idx);
+        return -1;
+    }
+
+    if (!(eq.w0 & EQ_W0_VALID)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: EQ %x/%x is invalid\n",
+                      eq_blk, eq_idx);
+        return -1;
+    }
+
+    eq_esmask =3D addr_is_even(addr, xsrc->esb_shift) ? EQ_W1_ESn : EQ_W=
1_ESe;
+    pq =3D GETFIELD(eq_esmask, eq.w1);
+
+    switch (offset) {
+    case XIVE_ESB_LOAD_EOI ... XIVE_ESB_LOAD_EOI + 0x7FF:
+        ret =3D xive_esb_eoi(&pq);
+
+        /* Forward the source event notification for routing ?? */
+        break;
+
+    case XIVE_ESB_GET ... XIVE_ESB_GET + 0x3FF:
+        ret =3D pq;
+        break;
+
+    case XIVE_ESB_SET_PQ_00 ... XIVE_ESB_SET_PQ_00 + 0x0FF:
+    case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
+    case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
+    case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
+        ret =3D xive_esb_set(&pq, (offset >> 8) & 0x3);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid EQ ESB load addr %=
d\n",
+                      offset);
+        return -1;
+    }
+
+    if (pq !=3D GETFIELD(eq_esmask, eq.w1)) {
+        eq.w1 =3D SETFIELD(eq_esmask, eq.w1, pq);
+        xive_router_set_eq(xrtr, eq_blk, eq_idx, &eq);
+    }
+
+    return ret;
+}
+
+/*
+ * EQ ESB MMIO stores are invalid
+ */
+static void xive_eq_source_write(void *opaque, hwaddr addr,
+                                 uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr 0x%"
+                  HWADDR_PRIx"\n", addr);
+}
+
+static const MemoryRegionOps xive_eq_source_ops =3D {
+    .read =3D xive_eq_source_read,
+    .write =3D xive_eq_source_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+static void xive_eq_source_realize(DeviceState *dev, Error **errp)
+{
+    XiveEQSource *xsrc =3D XIVE_EQ_SOURCE(dev);
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'xive' not found: ");
+        return;
+    }
+
+    xsrc->xrtr =3D XIVE_ROUTER(obj);
+
+    if (!xsrc->nr_eqs) {
+        error_setg(errp, "Number of interrupt needs to be greater than 0=
");
+        return;
+    }
+
+    if (xsrc->esb_shift !=3D XIVE_ESB_4K &&
+        xsrc->esb_shift !=3D XIVE_ESB_64K) {
+        error_setg(errp, "Invalid ESB shift setting");
+        return;
+    }
+
+    /*
+     * Each EQ is assigned an even/odd pair of MMIO pages, the even page
+     * manages the ESn field while the odd page manages the ESe field.
+     */
+    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
+                          &xive_eq_source_ops, xsrc, "xive.eq",
+                          (1ull << (xsrc->esb_shift + 1)) * xsrc->nr_eqs=
);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
+}
+
+static Property xive_eq_source_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-eqs", XiveEQSource, nr_eqs, 0),
+    DEFINE_PROP_UINT32("shift", XiveEQSource, esb_shift, XIVE_ESB_64K),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_eq_source_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc    =3D "XIVE EQ Source";
+    dc->props   =3D xive_eq_source_properties;
+    dc->realize =3D xive_eq_source_realize;
+}
+
+static const TypeInfo xive_eq_source_info =3D {
+    .name          =3D TYPE_XIVE_EQ_SOURCE,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(XiveEQSource),
+    .class_init    =3D xive_eq_source_class_init,
+};
+
+/*
  * XIVE Fabric
  */
 static const TypeInfo xive_fabric_info =3D {
@@ -700,6 +854,7 @@ static void xive_register_types(void)
     type_register_static(&xive_source_info);
     type_register_static(&xive_fabric_info);
     type_register_static(&xive_router_info);
+    type_register_static(&xive_eq_source_info);
 }
=20
 type_init(xive_register_types)
--=20
2.13.6

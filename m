Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW52H-0001RR-H2
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gW52D-0004Aq-77
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:46:41 -0500
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:33559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gW52C-0003rA-VV
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:46:37 -0500
Received: from player695.ha.ovh.net (unknown [10.109.159.157])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id DE7E8ECF44
	for <qemu-devel@nongnu.org>; Sun,  9 Dec 2018 20:46:28 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sun,  9 Dec 2018 20:45:52 +0100
Message-Id: <20181209194610.29727-2-clg@kaod.org>
In-Reply-To: <20181209194610.29727-1-clg@kaod.org>
References: <20181209194610.29727-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 01/19] ppc/xive: add support for the END
 Event State Buffers
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

The Event Notification Descriptor (END) XIVE structure also contains
two Event State Buffers providing further coalescing of interrupts,
one for the notification event (ESn) and one for the escalation events
(ESe). A MMIO page is assigned for each to control the EOI through
loads only. Stores are not allowed.

The END ESBs are modeled through an object resembling the 'XiveSource'
It is stateless as the END state bits are backed into the XiveEND
structure under the XiveRouter and the MMIO accesses follow the same
rules as for the XiveSource ESBs.

END ESBs are not supported by the Linux drivers neither on OPAL nor on
sPAPR. Nevetherless, it provides a mean to study the question in the
future and validates a bit more the XIVE model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v6:

 - removed the 'chip-id' field from XiveRouter
 - introduced a 'block-id' field in XiveENDSource to lookup the XIVE
   END structure when doing a load in the MMIO ESB
 - removed reset XiveENDSource handler

 include/hw/ppc/xive.h |  21 ++++++
 hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 4851d3b3a41f..014f64aa98f6 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -336,6 +336,27 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t en=
d_blk, uint32_t end_idx,
 int xive_router_write_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t en=
d_idx,
                           XiveEND *end, uint8_t word_number);
=20
+/*
+ * XIVE END ESBs
+ */
+
+#define TYPE_XIVE_END_SOURCE "xive-end-source"
+#define XIVE_END_SOURCE(obj) \
+    OBJECT_CHECK(XiveENDSource, (obj), TYPE_XIVE_END_SOURCE)
+
+typedef struct XiveENDSource {
+    DeviceState parent;
+
+    uint32_t        nr_ends;
+    uint8_t         block_id;
+
+    /* ESB memory region */
+    uint32_t        esb_shift;
+    MemoryRegion    esb_mmio;
+
+    XiveRouter      *xrtr;
+} XiveENDSource;
+
 /*
  * For legacy compatibility, the exceptions define up to 256 different
  * priorities. P9 implements only 9 levels : 8 active levels [0 - 7]
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 41d8ba1540d0..2196ce8de059 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -612,8 +612,18 @@ static void xive_router_end_notify(XiveRouter *xrtr,=
 uint8_t end_blk,
      * even futher coalescing in the Router
      */
     if (!xive_end_is_notify(&end)) {
-        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
-        return;
+        uint8_t pq =3D GETFIELD_BE32(END_W1_ESn, end.w1);
+        bool notify =3D xive_esb_trigger(&pq);
+
+        if (pq !=3D GETFIELD_BE32(END_W1_ESn, end.w1)) {
+            end.w1 =3D SETFIELD_BE32(END_W1_ESn, end.w1, pq);
+            xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
+        }
+
+        /* ESn[Q]=3D1 : end of notification */
+        if (!notify) {
+            return;
+        }
     }
=20
     /*
@@ -692,6 +702,151 @@ void xive_eas_pic_print_info(XiveEAS *eas, uint32_t=
 lisn, Monitor *mon)
                    (uint32_t) GETFIELD_BE64(EAS_END_DATA, eas->w));
 }
=20
+/*
+ * END ESB MMIO loads
+ */
+static uint64_t xive_end_source_read(void *opaque, hwaddr addr, unsigned=
 size)
+{
+    XiveENDSource *xsrc =3D XIVE_END_SOURCE(opaque);
+    uint32_t offset =3D addr & 0xFFF;
+    uint8_t end_blk;
+    uint32_t end_idx;
+    XiveEND end;
+    uint32_t end_esmask;
+    uint8_t pq;
+    uint64_t ret =3D -1;
+
+    end_blk =3D xsrc->block_id;
+    end_idx =3D addr >> (xsrc->esb_shift + 1);
+
+    if (xive_router_get_end(xsrc->xrtr, end_blk, end_idx, &end)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_blk,
+                      end_idx);
+        return -1;
+    }
+
+    if (!xive_end_is_valid(&end)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: END %x/%x is invalid\n",
+                      end_blk, end_idx);
+        return -1;
+    }
+
+    end_esmask =3D addr_is_even(addr, xsrc->esb_shift) ? END_W1_ESn : EN=
D_W1_ESe;
+    pq =3D GETFIELD_BE32(end_esmask, end.w1);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid END ESB load addr =
%d\n",
+                      offset);
+        return -1;
+    }
+
+    if (pq !=3D GETFIELD_BE32(end_esmask, end.w1)) {
+        end.w1 =3D SETFIELD_BE32(end_esmask, end.w1, pq);
+        xive_router_write_end(xsrc->xrtr, end_blk, end_idx, &end, 1);
+    }
+
+    return ret;
+}
+
+/*
+ * END ESB MMIO stores are invalid
+ */
+static void xive_end_source_write(void *opaque, hwaddr addr,
+                                  uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr 0x%"
+                  HWADDR_PRIx"\n", addr);
+}
+
+static const MemoryRegionOps xive_end_source_ops =3D {
+    .read =3D xive_end_source_read,
+    .write =3D xive_end_source_write,
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
+static void xive_end_source_realize(DeviceState *dev, Error **errp)
+{
+    XiveENDSource *xsrc =3D XIVE_END_SOURCE(dev);
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
+    if (!xsrc->nr_ends) {
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
+     * Each END is assigned an even/odd pair of MMIO pages, the even pag=
e
+     * manages the ESn field while the odd page manages the ESe field.
+     */
+    memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
+                          &xive_end_source_ops, xsrc, "xive.end",
+                          (1ull << (xsrc->esb_shift + 1)) * xsrc->nr_end=
s);
+}
+
+static Property xive_end_source_properties[] =3D {
+    DEFINE_PROP_UINT8("block-id", XiveENDSource, block_id, 0),
+    DEFINE_PROP_UINT32("nr-ends", XiveENDSource, nr_ends, 0),
+    DEFINE_PROP_UINT32("shift", XiveENDSource, esb_shift, XIVE_ESB_64K),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void xive_end_source_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->desc    =3D "XIVE END Source";
+    dc->props   =3D xive_end_source_properties;
+    dc->realize =3D xive_end_source_realize;
+}
+
+static const TypeInfo xive_end_source_info =3D {
+    .name          =3D TYPE_XIVE_END_SOURCE,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(XiveENDSource),
+    .class_init    =3D xive_end_source_class_init,
+};
+
 /*
  * XIVE Fabric
  */
@@ -706,6 +861,7 @@ static void xive_register_types(void)
     type_register_static(&xive_source_info);
     type_register_static(&xive_fabric_info);
     type_register_static(&xive_router_info);
+    type_register_static(&xive_end_source_info);
 }
=20
 type_init(xive_register_types)
--=20
2.17.2

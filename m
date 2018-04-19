Received: from eggs.gnu.org ([2001:4830:134:3::10]:58117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wz-0001Dh-BO
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wv-0000sa-CK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:09 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:54955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wv-0000rA-21
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:05 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.71])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id C7E2912E61E
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:46:03 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:20 +0200
Message-Id: <20180419124331.3915-25-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 24/35] spapr/xive: add common realize
 routine for KVM
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

The XiveSource and sPAPRXive device models will be shared between the
emulated and the KVM mode. The difference will reside in the way the
memory regions are initialized and in the qemu_irq handler. Introduce
common realize routines to share some code.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 17 +++++++++++++++--
 hw/intc/xive.c              | 21 ++++++++++++++++-----
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xive.h       |  3 +++
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index f0c2fe52b3c6..bd604089ad49 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -84,9 +84,8 @@ static void spapr_xive_init(Object *obj)
     object_property_add_child(obj, "source", OBJECT(&xive->source), NULL=
);
 }
=20
-static void spapr_xive_realize(DeviceState *dev, Error **errp)
+void spapr_xive_common_realize(sPAPRXive *xive, int esb_shift, Error **e=
rrp)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(dev);
     XiveSource *xsrc =3D &xive->source;
     Error *local_err =3D NULL;
=20
@@ -105,6 +104,8 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
                             &error_fatal);
     object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
                             &error_fatal);
+    object_property_set_int(OBJECT(xsrc), esb_shift, "shift",
+                            &error_fatal);
     object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive),
                                    &error_fatal);
     object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
@@ -122,6 +123,18 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
      * level views of the TIMA.
      */
     xive->tm_base =3D XIVE_TM_BASE;
+}
+
+static void spapr_xive_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    Error *local_err =3D NULL;
+
+    spapr_xive_common_realize(xive, XIVE_ESB_64K_2PAGE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     memory_region_init_io(&xive->tm_mmio_user, OBJECT(xive),
                           &xive_tm_user_ops, xive, "xive.tima.user",
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 11af3bf1184a..520b532dbf09 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -903,13 +903,13 @@ static void xive_source_reset(DeviceState *dev)
     }
 }
=20
-static void xive_source_realize(DeviceState *dev, Error **errp)
+void xive_source_common_realize(XiveSource *xsrc, qemu_irq_handler handl=
er,
+                                Error **errp)
 {
-    XiveSource *xsrc =3D XIVE_SOURCE(dev);
     Object *obj;
     Error *local_err =3D NULL;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "xive", &local_err);
+    obj =3D object_property_get_link(OBJECT(xsrc), "xive", &local_err);
     if (!obj) {
         error_propagate(errp, local_err);
         error_prepend(errp, "required link 'xive' not found: ");
@@ -931,13 +931,24 @@ static void xive_source_realize(DeviceState *dev, E=
rror **errp)
         return;
     }
=20
-    xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
-                                     xsrc->nr_irqs);
+    xsrc->qirqs =3D qemu_allocate_irqs(handler, xsrc, xsrc->nr_irqs);
     xsrc->status =3D g_malloc0(xsrc->nr_irqs);
=20
     /* Allocate the SBEs (State Bit Entry). 2 bits, so 4 entries per byt=
e */
     xsrc->sbe_size =3D DIV_ROUND_UP(xsrc->nr_irqs, 4);
     xsrc->sbe =3D g_malloc0(xsrc->sbe_size);
+}
+
+static void xive_source_realize(DeviceState *dev, Error **errp)
+{
+    XiveSource *xsrc =3D XIVE_SOURCE(dev);
+    Error *local_err =3D NULL;
+
+    xive_source_common_realize(xsrc, xive_source_set_irq, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     /* TODO: H_INT_ESB support, which removing the ESB MMIOs */
=20
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 41e2784403b2..f3ac084a71be 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -51,6 +51,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor=
 *mon);
 void spapr_xive_mmio_map(sPAPRXive *xive);
 void spapr_xive_mmio_unmap(sPAPRXive *xive);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, int lisn);
+void spapr_xive_common_realize(sPAPRXive *xive, int esb_shift, Error **e=
rrp);
=20
 /*
  * sPAPR encoding of EQ indexes
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 36de10af0109..b040cf580fc9 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -175,6 +175,9 @@ static inline qemu_irq xive_source_qirq(XiveSource *x=
src, uint32_t srcno)
     return xsrc->qirqs[srcno];
 }
=20
+void xive_source_common_realize(XiveSource *xsrc, qemu_irq_handler handl=
er,
+                                Error **errp);
+
 /*
  * XIVE Interrupt Presenter
  */
--=20
2.13.6

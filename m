Received: from eggs.gnu.org ([2001:4830:134:3::10]:39352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxDA-0003AZ-8u
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxD5-0004Q9-Hs
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:28 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:53848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxD5-0004PE-Bq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:23 -0400
Received: from player169.ha.ovh.net (unknown [10.109.120.103])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D5F92105B52
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:21 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:58 +0200
Message-Id: <20180607155003.1580-24-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 23/28] spapr/xive: add common realize
 routine for KVM
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

The XiveSource and sPAPRXive device models will be shared between the
TCG and the KVM mode. The difference will reside in the way the memory
regions are initialized and in the qemu_irq handler.

Introduce common realize routines to share some code.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h |  1 +
 include/hw/ppc/xive.h       |  3 +++
 hw/intc/spapr_xive.c        | 15 +++++++++++++--
 hw/intc/xive.c              | 22 +++++++++++++++++-----
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 1284784f1152..4aa04bc48ccb 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -55,6 +55,7 @@ bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t li=
sn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn);
+void spapr_xive_common_realize(sPAPRXive *xive, Error **errp);
=20
 /*
  * sPAPR VP and EQ indexing helpers
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index d943770efd9d..7a54b3ce594f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -183,6 +183,9 @@ static inline void xive_source_irq_set(XiveSource *xs=
rc, uint32_t srcno,
     }
 }
=20
+void xive_source_common_realize(XiveSource *xsrc, qemu_irq_handler handl=
er,
+                                Error **errp);
+
 /*
  * XIVE Router
  */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 91f9b28ebcc4..2812b1a1a030 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -84,9 +84,8 @@ static void spapr_xive_instance_init(Object *obj)
     object_property_add_child(obj, "eq_source", OBJECT(&xive->eq_source)=
, NULL);
 }
=20
-static void spapr_xive_realize(DeviceState *dev, Error **errp)
+void spapr_xive_common_realize(sPAPRXive *xive, Error **errp)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(dev);
     XiveSource *xsrc =3D &xive->source;
     XiveEQSource *eq_xsrc =3D &xive->eq_source;
     Error *local_err =3D NULL;
@@ -132,6 +131,18 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
     /* Allocate the routing tables */
     xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
     xive->eqdt =3D g_new0(XiveEQ, xive->nr_eqs);
+}
+
+static void spapr_xive_realize(DeviceState *dev, Error **errp)
+{
+    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    Error *local_err =3D NULL;
+
+    spapr_xive_common_realize(xive, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
     /* TIMA */
     memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_tm_ops, xi=
ve,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5cf9fc4e1cb3..4d073c37bbda 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1003,13 +1003,13 @@ static void xive_source_reset(DeviceState *dev)
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
@@ -1031,14 +1031,26 @@ static void xive_source_realize(DeviceState *dev,=
 Error **errp)
         return;
     }
=20
-    xsrc->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc,
-                                     xsrc->nr_irqs);
+    xsrc->qirqs =3D qemu_allocate_irqs(handler, xsrc, xsrc->nr_irqs);
=20
     xsrc->status =3D g_malloc0(xsrc->nr_irqs);
=20
     xsrc->lsi_map =3D bitmap_new(xsrc->nr_irqs);
     xsrc->lsi_map_size =3D xsrc->nr_irqs;
=20
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
+
     memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
                           &xive_source_esb_ops, xsrc, "xive.esb",
                           (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
--=20
2.13.6

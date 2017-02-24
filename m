Received: from eggs.gnu.org ([2001:4830:134:3::10]:32892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCza-0006qd-5I
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1chCzW-0000PQ-2O
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:50 -0500
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1chCzV-0000K6-Rm
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:20:45 -0500
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 49ED8DCAC8
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 11:20:42 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 24 Feb 2017 11:18:21 +0100
Message-Id: <1487931503-10607-23-git-send-email-clg@kaod.org>
In-Reply-To: <1487931503-10607-1-git-send-email-clg@kaod.org>
References: <1487931503-10607-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 22/24] ppc/xics: remove the 'xics' backlinks
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

These are not used anymore. Do the cleanups

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        | 28 ----------------------------
 hw/intc/xics_kvm.c    | 10 ----------
 hw/ppc/spapr.c        |  3 ---
 include/hw/ppc/xics.h |  3 ---
 4 files changed, 44 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 571063a67125..565b5ec0686a 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -360,23 +360,6 @@ static void icp_reset(DeviceState *dev)
     qemu_set_irq(icp->output, 0);
 }
=20
-static void icp_realize(DeviceState *dev, Error **errp)
-{
-    ICPState *icp =3D ICP(dev);
-    Object *obj;
-    Error *err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-
-    icp->xics =3D XICS_COMMON(obj);
-}
-
-
 static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -384,7 +367,6 @@ static void icp_class_init(ObjectClass *klass, void *=
data)
=20
     dc->reset =3D icp_reset;
     dc->vmsd =3D &vmstate_icp_server;
-    dc->realize =3D icp_realize;
     ic->print_info =3D icp_pic_print_info;
 }
=20
@@ -634,16 +616,6 @@ static void ics_simple_initfn(Object *obj)
 static void ics_simple_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS_SIMPLE(dev);
-    Object *obj;
-    Error *err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-    ics->xics =3D XICS_COMMON(obj);
=20
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 850777eab913..7c1809873c29 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -323,16 +323,6 @@ static void ics_kvm_reset(DeviceState *dev)
 static void ics_kvm_realize(DeviceState *dev, Error **errp)
 {
     ICSState *ics =3D ICS_SIMPLE(dev);
-    Object *obj;
-    Error *err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-    ics->xics =3D XICS_COMMON(obj);
=20
     if (!ics->nr_irqs) {
         error_setg(errp, "Number of interrupts needs to be greater 0");
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 032c8ab008d8..cfd0139dd418 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -115,8 +115,6 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
     qdev_set_parent_bus(DEVICE(spapr->ics), sysbus_get_default());
     object_property_add_child(OBJECT(spapr), "ics", OBJECT(spapr->ics), =
NULL);
     object_property_set_int(OBJECT(spapr->ics), nr_irqs, "nr-irqs", &err=
);
-    object_property_add_const_link(OBJECT(spapr->ics), "xics", OBJECT(xi=
cs),
-                                   NULL);
     object_property_set_bool(OBJECT(spapr->ics), true, "realized", &loca=
l_err);
     error_propagate(&err, local_err);
     if (err) {
@@ -132,7 +130,6 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
         object_initialize(icp, sizeof(*icp), type_icp);
         qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
         object_property_add_child(OBJECT(spapr), "icp[*]", OBJECT(icp), =
NULL);
-        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xics)=
, NULL);
         object_property_set_bool(OBJECT(icp), true, "realized", &err);
         if (err) {
             goto error;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1ea8d8139678..d1d110051c72 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -110,8 +110,6 @@ struct ICPState {
     uint8_t mfrr;
     qemu_irq output;
     bool cap_irq_xics_enabled;
-
-    XICSState *xics;
 };
=20
 #define TYPE_ICS_BASE "ics-base"
@@ -147,7 +145,6 @@ struct ICSState {
     uint32_t offset;
     qemu_irq *qirqs;
     ICSIRQState *irqs;
-    XICSState *xics;
 };
=20
 static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)
--=20
2.7.4

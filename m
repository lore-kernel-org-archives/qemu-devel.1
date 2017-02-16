Received: from eggs.gnu.org ([2001:4830:134:3::10]:40021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMS4-00039D-R2
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRz-0006Fj-VM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:28 -0500
Received: from mo173.mail-out.ovh.net ([178.32.228.173]:34155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMRz-0006Fa-Pa
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:50:23 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 9CD0D241B8
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:50:22 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:43 +0100
Message-Id: <1487252865-12064-21-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 20/22] ppc/xics: remove the 'xics' backlinks
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
index 78e08e23e3d6..eb1a9f12fd3a 100644
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
index 6b35b48f818a..059408a81b8a 100644
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
index f7f89c1d18d7..20c792fccfc3 100644
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

Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5977DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A03216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="EnWuoyn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A03216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Dq-0007E2-A7
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77H-0004Bg-T9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77D-0004bY-Rv
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:11 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs772-0004PP-Qz; Mon, 29 Jul 2019 10:58:57 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id A311D96F59;
 Mon, 29 Jul 2019 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxGn1CVCZ0DI+UxefdppQg1uDC8rnLqqzLKgyNbd95U=;
 b=EnWuoyn6PiWNMjrwMLvec93loNTSro61pVSsk/pHdEPRSvWq9ulcjbpoIws9Eu7+zhkJqs
 Xj29nVkqbjZiqLsp+05tiu1+QmvrPucS1gqQA+RYrmtnoTHHCLoI9rumR/Jky8xeImQumG
 CQADDhNmj2m1HoNQhkcnVnvlsFLgedc=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:25 +0200
Message-Id: <20190729145654.14644-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729145654.14644-1-damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxGn1CVCZ0DI+UxefdppQg1uDC8rnLqqzLKgyNbd95U=;
 b=YHkgyGAQulCF1XXnb8+AQB7dROmvHjBWLvYsj6VlvBCg4plVjF+LlD9HyM/hNt6Fy9UYj9
 TmgOUx5wsWG8WL8VCdjGlTuLrCZmM5ZXd3WvgBbjY7AHl2E54A+GDVYTmeTt+wDdayXChA
 +eTGHSSbEx3tFgQ3IL3ZsX35pGIZu0g=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412335; a=rsa-sha256; cv=none;
 b=l26Udfv/6iNz5ygpEeeY/wjm68EJ/xCx0jBg73FjM2fyOer7WkKI4UdOQq0yJ4U+u1jRkT
 zqqUmQBwx45UCbKY9gcSrDF9lB0GWWQDdSd0tDKuuY/RygkNsVYoh+kMikzFGpT8BvbMQI
 797d7V9jyKcZbJqrjlUW3b7XNaucUFY=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 04/33] make Device and Bus Resettable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This add Resettable interface implementation for both Bus and Device.

*resetting* counter and *reset_is_cold* flag are added in DeviceState
and BusState.

Compatibility with existing code base is ensured.
The legacy bus or device reset method is called in the new exit phase
and the other 2 phases are let empty. Using the exit phase guarantee that
legacy resets are called in the "post" order (ie: children then parent)
in hierarchical reset. That is the same order as legacy qdev_reset_all
or qbus_reset_all were using.

New *device_reset* and *bus_reset* function are proposed with an
additional boolean argument telling whether the reset is cold or warm.
Helper functions *device_reset_[warm|cold]* and *bus_reset_[warm|cold]*
are defined also as helpers.

Also add a [device|bus]_is_resetting and [device|bus]_is_reset_cold
functions telling respectively whether the object is currently under rese=
t and
if the current reset is cold or not.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/bus.c          | 85 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 82 ++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h | 84 ++++++++++++++++++++++++++++++++++++++---
 tests/Makefile.include |  1 +
 4 files changed, 247 insertions(+), 5 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 17bc1edcde..08a97addb6 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "hw/resettable.h"
=20
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp)
 {
@@ -68,6 +69,75 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
=20
+void bus_reset(BusState *bus, bool cold)
+{
+    resettable_reset(OBJECT(bus), cold);
+}
+
+bool bus_is_resetting(BusState *bus)
+{
+    return (bus->resetting !=3D 0);
+}
+
+bool bus_is_reset_cold(BusState *bus)
+{
+    return bus->reset_is_cold;
+}
+
+static uint32_t bus_get_reset_count(Object *obj)
+{
+    BusState *bus =3D BUS(obj);
+    return bus->resetting;
+}
+
+static uint32_t bus_increment_reset_count(Object *obj)
+{
+    BusState *bus =3D BUS(obj);
+    return ++bus->resetting;
+}
+
+static uint32_t bus_decrement_reset_count(Object *obj)
+{
+    BusState *bus =3D BUS(obj);
+    return --bus->resetting;
+}
+
+static bool bus_set_reset_cold(Object *obj, bool cold)
+{
+    BusState *bus =3D BUS(obj);
+    bool old =3D bus->reset_is_cold;
+    bus->reset_is_cold =3D cold;
+    return old;
+}
+
+static bool bus_set_hold_needed(Object *obj, bool hold_needed)
+{
+    BusState *bus =3D BUS(obj);
+    bool old =3D bus->reset_hold_needed;
+    bus->reset_hold_needed =3D hold_needed;
+    return old;
+}
+
+static void bus_foreach_reset_child(Object *obj, void (*func)(Object *))
+{
+    BusState *bus =3D BUS(obj);
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        func(OBJECT(kid->child));
+    }
+}
+
+static void bus_obj_legacy_reset(Object *obj)
+{
+    BusState *bus =3D BUS(obj);
+    BusClass *bc =3D BUS_GET_CLASS(obj);
+
+    if (bc->reset) {
+        bc->reset(bus);
+    }
+}
+
 static void qbus_realize(BusState *bus, DeviceState *parent, const char =
*name)
 {
     const char *typename =3D object_get_typename(OBJECT(bus));
@@ -192,6 +262,8 @@ static void qbus_initfn(Object *obj)
                              NULL);
     object_property_add_bool(obj, "realized",
                              bus_get_realized, bus_set_realized, NULL);
+
+    bus->resetting =3D 0;
 }
=20
 static char *default_bus_get_fw_dev_path(DeviceState *dev)
@@ -202,9 +274,18 @@ static char *default_bus_get_fw_dev_path(DeviceState=
 *dev)
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc =3D BUS_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D bus_unparent;
     bc->get_fw_dev_path =3D default_bus_get_fw_dev_path;
+
+    rc->phases.exit =3D bus_obj_legacy_reset;
+    rc->get_count =3D bus_get_reset_count;
+    rc->increment_count =3D bus_increment_reset_count;
+    rc->decrement_count =3D bus_decrement_reset_count;
+    rc->foreach_child =3D bus_foreach_reset_child;
+    rc->set_cold =3D bus_set_reset_cold;
+    rc->set_hold_needed =3D bus_set_hold_needed;
 }
=20
 static void qbus_finalize(Object *obj)
@@ -223,6 +304,10 @@ static const TypeInfo bus_info =3D {
     .instance_init =3D qbus_initfn,
     .instance_finalize =3D qbus_finalize,
     .class_init =3D bus_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_RESETTABLE },
+        { }
+    },
 };
=20
 static void bus_register_types(void)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 043e058396..559ced070d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -254,6 +254,64 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState=
 *dev)
     return hotplug_ctrl;
 }
=20
+void device_reset(DeviceState *dev, bool cold)
+{
+    resettable_reset(OBJECT(dev), cold);
+}
+
+bool device_is_resetting(DeviceState *dev)
+{
+    return (dev->resetting !=3D 0);
+}
+
+bool device_is_reset_cold(DeviceState *dev)
+{
+    return dev->reset_is_cold;
+}
+
+static uint32_t device_get_reset_count(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    return dev->resetting;
+}
+
+static uint32_t device_increment_reset_count(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    return ++dev->resetting;
+}
+
+static uint32_t device_decrement_reset_count(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    return --dev->resetting;
+}
+
+static bool device_set_reset_cold(Object *obj, bool cold)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    bool old =3D dev->reset_is_cold;
+    dev->reset_is_cold =3D cold;
+    return old;
+}
+
+static bool device_set_hold_needed(Object *obj, bool hold_needed)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    bool old =3D dev->reset_hold_needed;
+    dev->reset_hold_needed =3D hold_needed;
+    return old;
+}
+
+static void device_foreach_reset_child(Object *obj, void (*func)(Object =
*))
+{
+    DeviceState *dev =3D DEVICE(obj);
+    BusState *bus;
+    QLIST_FOREACH(bus, &dev->child_bus, sibling) {
+        func(OBJECT(bus));
+    }
+}
+
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
     device_legacy_reset(dev);
@@ -954,6 +1012,7 @@ static void device_initfn(Object *obj)
=20
     dev->instance_id_alias =3D -1;
     dev->realized =3D false;
+    dev->resetting =3D 0;
=20
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, N=
ULL);
@@ -1046,9 +1105,20 @@ static void device_unparent(Object *obj)
     }
 }
=20
+static void device_obj_legacy_reset(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
+
+    if (dc->reset) {
+        dc->reset(dev);
+    }
+}
+
 static void device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D device_unparent;
=20
@@ -1060,6 +1130,14 @@ static void device_class_init(ObjectClass *class, =
void *data)
      */
     dc->hotpluggable =3D true;
     dc->user_creatable =3D true;
+
+    rc->phases.exit =3D device_obj_legacy_reset;
+    rc->get_count =3D device_get_reset_count;
+    rc->increment_count =3D device_increment_reset_count;
+    rc->decrement_count =3D device_decrement_reset_count;
+    rc->foreach_child =3D device_foreach_reset_child;
+    rc->set_cold =3D device_set_reset_cold;
+    rc->set_hold_needed =3D device_set_hold_needed;
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
@@ -1117,6 +1195,10 @@ static const TypeInfo device_type_info =3D {
     .class_init =3D device_class_init,
     .abstract =3D true,
     .class_size =3D sizeof(DeviceClass),
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_RESETTABLE },
+        { }
+    },
 };
=20
 static void qdev_register_types(void)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 690ce72433..eeb75611c8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -7,6 +7,7 @@
 #include "hw/irq.h"
 #include "hw/hotplug.h"
 #include "sysemu/sysemu.h"
+#include "hw/resettable.h"
=20
 enum {
     DEV_NVECTORS_UNSPECIFIED =3D -1,
@@ -132,6 +133,10 @@ struct NamedGPIOList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ * @resetting: Indicates whether the device is under reset. Also
+ * used to count how many times reset has been initiated on the device.
+ * @reset_is_cold: If the device is under reset, indicates whether it is=
 cold
+ * or warm.
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
@@ -153,6 +158,9 @@ struct DeviceState {
     int num_child_bus;
     int instance_id_alias;
     int alias_required_for_version;
+    uint32_t resetting;
+    bool reset_is_cold;
+    bool reset_hold_needed;
 };
=20
 struct DeviceListener {
@@ -199,6 +207,10 @@ typedef struct BusChild {
 /**
  * BusState:
  * @hotplug_handler: link to a hotplug handler associated with bus.
+ * @resetting: Indicates whether the bus is under reset. Also
+ * used to count how many times reset has been initiated on the bus.
+ * @reset_is_cold: If the bus is under reset, indicates whether it is co=
ld
+ * or warm.
  */
 struct BusState {
     Object obj;
@@ -210,6 +222,9 @@ struct BusState {
     int num_children;
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
+    uint32_t resetting;
+    bool reset_is_cold;
+    bool reset_hold_needed;
 };
=20
 /**
@@ -376,6 +391,70 @@ int qdev_walk_children(DeviceState *dev,
                        qdev_walkerfn *post_devfn, qbus_walkerfn *post_bu=
sfn,
                        void *opaque);
=20
+/**
+ * device_reset:
+ * Resets the device @dev, @cold tell whether to do a cold or warm reset=
.
+ * Uses the ressetable interface.
+ * Base behavior is to reset the device and its qdev/qbus subtree.
+ */
+void device_reset(DeviceState *dev, bool cold);
+
+static inline void device_reset_warm(DeviceState *dev)
+{
+    device_reset(dev, false);
+}
+
+static inline void device_reset_cold(DeviceState *dev)
+{
+    device_reset(dev, true);
+}
+
+/**
+ * bus_reset:
+ * Resets the bus @bus, @cold tell whether to do a cold or warm reset.
+ * Uses the ressetable interface.
+ * Base behavior is to reset the bus and its qdev/qbus subtree.
+ */
+void bus_reset(BusState *bus, bool cold);
+
+static inline void bus_reset_warm(BusState *bus)
+{
+    bus_reset(bus, false);
+}
+
+static inline void bus_reset_cold(BusState *bus)
+{
+    bus_reset(bus, true);
+}
+
+/**
+ * device_is_resetting:
+ * Tell whether the device @dev is currently under reset.
+ */
+bool device_is_resetting(DeviceState *dev);
+
+/**
+ * device_is_reset_cold:
+ * Tell whether the device @dev is currently under reset cold or warm re=
set.
+ *
+ * Note: only valid when device_is_resetting returns true.
+ */
+bool device_is_reset_cold(DeviceState *dev);
+
+/**
+ * bus_is_resetting:
+ * Tell whether the bus @bus is currently under reset.
+ */
+bool bus_is_resetting(BusState *bus);
+
+/**
+ * bus_is_reset_cold:
+ * Tell whether the bus @bus is currently under reset cold or warm reset=
.
+ *
+ * Note: only valid when bus_is_resetting returns true.
+ */
+bool bus_is_reset_cold(BusState *bus);
+
 void qdev_reset_all(DeviceState *dev);
 void qdev_reset_all_fn(void *opaque);
=20
@@ -413,11 +492,6 @@ void qdev_machine_init(void);
  */
 void device_legacy_reset(DeviceState *dev);
=20
-static inline void device_reset(DeviceState *dev)
-{
-    device_legacy_reset(dev);
-}
-
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd7fdb8658..1c0a5345b9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -561,6 +561,7 @@ tests/fp/%:
=20
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
+	hw/core/resettable.o \
 	hw/core/bus.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
--=20
2.22.0



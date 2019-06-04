Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67885C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A25623CDC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="o9gGV7tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A25623CDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55227 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCR2-0001IN-Eq
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:37:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFz-0000c9-D9
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFx-0003dl-4u
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:51 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFr-0003UO-Rz; Tue, 04 Jun 2019 12:25:44 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 5E54F96F58;
	Tue,  4 Jun 2019 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=9FKgRGbSAx2vsIcSB6v4+/dH/c3qOu+6weH6IoadarA=;
	b=o9gGV7tHdf9G97XJEQXQfV+rBt4GOaWA2gCjQphv+xSVJtVgiQK7MDUNxehzcq6bt93o50
	1ONsmhiFbTMMDoBDVNKJPNIe1EMGdH6WaSIe7hkLIvHkawChopUyV6/vZtYkzBiDDSVRP7
	vVcUzZoE90mUfVHdJE9neV8R3zBUtoY=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:18 +0200
Message-Id: <20190604162526.10655-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190604162526.10655-1-damien.hedde@greensocs.com>
References: <20190604162526.10655-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=9FKgRGbSAx2vsIcSB6v4+/dH/c3qOu+6weH6IoadarA=;
	b=fPRa3FcahC35XR7I4Mpf9D5RXe6fXqDjORzJYQaDhVbMfslAt/TFYpaBx7coIeRFNBF6lK
	efOj6KM1ZFp1hFbLd7cwBGHRAYNSuYmdtlu11Wfk4ABjDcay9zyhOL2Hz7kdwE2VpemPgU
	OeANmN3sfLmSPp8fHJepZjdkx56PnZs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665543; a=rsa-sha256; cv=none;
	b=pnX1f5uo8vEI2LD5uDsujiHlFFWPV+MlxEkaLBlDWEqGr05gF6Gpdn58u9eNO0rC8Xn2FR
	g1WyIjankYev4qFMWPtuB2lspsaaD61l/ZnnnXy/555urfir79zvtwsLCihjYAKi8ACW0T
	0beYOA8b0sUCVgoz9x4r8Ey0WEZj5Fo=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 04/12] make Device and Bus Resettable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This add Resettable interface implementation for both Bus and Device.
The init phase default implementation is to call the legacy reset
handler.

qdev/bus_reset_all implementations are modified to use the new
device_reset / bus_reset function.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/core/bus.c          | 60 ++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 65 +++++++++++++++++++++++++++++++++++-------
 include/hw/qdev-core.h | 63 ++++++++++++++++++++++++++++++++++------
 tests/Makefile.include |  1 +
 4 files changed, 170 insertions(+), 19 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index e09843f6ab..c731e5cac7 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "hw/resettable.h"
=20
 void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **er=
rp)
 {
@@ -67,6 +68,54 @@ int qbus_walk_children(BusState *bus,
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
+static void bus_reset_init_phase(Object *obj, bool cold)
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
@@ -204,9 +253,16 @@ static char *default_bus_get_fw_dev_path(DeviceState=
 *dev)
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc =3D BUS_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D bus_unparent;
     bc->get_fw_dev_path =3D default_bus_get_fw_dev_path;
+
+    rc->phases.init =3D bus_reset_init_phase;
+    rc->get_count =3D bus_get_reset_count;
+    rc->increment_count =3D bus_increment_reset_count;
+    rc->decrement_count =3D bus_decrement_reset_count;
+    rc->foreach_child =3D bus_foreach_reset_child;
 }
=20
 static void qbus_finalize(Object *obj)
@@ -225,6 +281,10 @@ static const TypeInfo bus_info =3D {
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
index 90037ba70c..8c3911c2bd 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -254,25 +254,56 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceStat=
e *dev)
     return hotplug_ctrl;
 }
=20
-static int qdev_reset_one(DeviceState *dev, void *opaque)
+void device_reset(DeviceState *dev, bool cold)
 {
-    device_reset(dev);
+    resettable_reset(OBJECT(dev), cold);
+}
=20
-    return 0;
+bool device_is_resetting(DeviceState *dev)
+{
+    return (dev->resetting !=3D 0);
+}
+
+static uint32_t device_get_reset_count(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    return dev->resetting;
 }
=20
-static int qbus_reset_one(BusState *bus, void *opaque)
+static uint32_t device_increment_reset_count(Object *obj)
 {
-    BusClass *bc =3D BUS_GET_CLASS(bus);
-    if (bc->reset) {
-        bc->reset(bus);
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
+static void device_reset_init_phase(Object *obj, bool cold)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
+
+    if (dc->reset) {
+        dc->reset(dev);
     }
-    return 0;
 }
=20
 void qdev_reset_all(DeviceState *dev)
 {
-    qdev_walk_children(dev, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    device_reset(dev, false);
 }
=20
 void qdev_reset_all_fn(void *opaque)
@@ -282,7 +313,7 @@ void qdev_reset_all_fn(void *opaque)
=20
 void qbus_reset_all(BusState *bus)
 {
-    qbus_walk_children(bus, NULL, NULL, qdev_reset_one, qbus_reset_one, =
NULL);
+    bus_reset(bus, false);
 }
=20
 void qbus_reset_all_fn(void *opaque)
@@ -864,7 +895,7 @@ static void device_set_realized(Object *obj, bool val=
ue, Error **errp)
             }
         }
         if (dev->hotplugged) {
-            device_reset(dev);
+            device_reset(dev, true);
         }
         dev->pending_deleted_event =3D false;
=20
@@ -954,6 +985,7 @@ static void device_initfn(Object *obj)
=20
     dev->instance_id_alias =3D -1;
     dev->realized =3D false;
+    dev->resetting =3D 0;
=20
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, N=
ULL);
@@ -1049,6 +1081,7 @@ static void device_unparent(Object *obj)
 static void device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D device_unparent;
=20
@@ -1060,6 +1093,12 @@ static void device_class_init(ObjectClass *class, =
void *data)
      */
     dc->hotpluggable =3D true;
     dc->user_creatable =3D true;
+
+    rc->phases.init =3D device_reset_init_phase;
+    rc->get_count =3D device_get_reset_count;
+    rc->increment_count =3D device_increment_reset_count;
+    rc->decrement_count =3D device_decrement_reset_count;
+    rc->foreach_child =3D device_foreach_reset_child;
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
@@ -1117,6 +1156,10 @@ static const TypeInfo device_type_info =3D {
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
index 537dd0054d..658a419350 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -6,6 +6,7 @@
 #include "qom/object.h"
 #include "hw/irq.h"
 #include "hw/hotplug.h"
+#include "hw/resettable.h"
=20
 enum {
     DEV_NVECTORS_UNSPECIFIED =3D -1,
@@ -107,6 +108,11 @@ typedef struct DeviceClass {
     bool hotpluggable;
=20
     /* callbacks */
+    /*
+     * Reset method here is deprecated and replaced by methods in the
+     * resettable class interface to implement a multi-phase reset.
+     * TODO: remove once every reset callback is unused
+     */
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
@@ -131,6 +137,8 @@ struct NamedGPIOList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ * @resetting: Indicates whether the device is under reset. Also
+ * used to count how many times reset has been initiated on the device.
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
@@ -152,6 +160,7 @@ struct DeviceState {
     int num_child_bus;
     int instance_id_alias;
     int alias_required_for_version;
+    uint32_t resetting;
 };
=20
 struct DeviceListener {
@@ -198,6 +207,8 @@ typedef struct BusChild {
 /**
  * BusState:
  * @hotplug_handler: link to a hotplug handler associated with bus.
+ * @resetting: Indicates whether the device is under reset. Also
+ * used to count how many times reset has been initiated on the device.
  */
 struct BusState {
     Object obj;
@@ -209,6 +220,7 @@ struct BusState {
     int num_children;
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
+    uint32_t resetting;
 };
=20
 /**
@@ -375,11 +387,36 @@ int qdev_walk_children(DeviceState *dev,
                        qdev_walkerfn *post_devfn, qbus_walkerfn *post_bu=
sfn,
                        void *opaque);
=20
-void qdev_reset_all(DeviceState *dev);
-void qdev_reset_all_fn(void *opaque);
+/**
+ * device_reset:
+ * Resets the device @dev, @cold tell whether to do a cold or warm reset=
.
+ * Uses the ressetable interface.
+ * Base behavior is to reset the device and its qdev/qbus subtree.
+ */
+void device_reset(DeviceState *dev, bool cold);
=20
 /**
- * @qbus_reset_all:
+ * bus_reset:
+ * Resets the bus @bus, @cold tell whether to do a cold or warm reset.
+ * Uses the ressetable interface.
+ * Base behavior is to reset the bus and its qdev/qbus subtree.
+ */
+void bus_reset(BusState *bus, bool cold);
+
+/**
+ * device_is_resetting:
+ * Tell whether the device @dev is currently under reset.
+ */
+bool device_is_resetting(DeviceState *dev);
+
+/**
+ * bus_is_resetting:
+ * Tell whether the bus @bus is currently under reset.
+ */
+bool bus_is_resetting(BusState *bus);
+
+/**
+ * qbus/qdev_reset_all:
  * @bus: Bus to be reset.
  *
  * Reset @bus and perform a bus-level ("hard") reset of all devices conn=
ected
@@ -387,7 +424,13 @@ void qdev_reset_all_fn(void *opaque);
  * hard reset means that qbus_reset_all will reset all state of the devi=
ce.
  * For PCI devices, for example, this will include the base address regi=
sters
  * or configuration space.
+ *
+ * Theses functions are deprecated, please use device/bus_reset or
+ * resettable_reset_* instead
+ * TODO: remove them when all occurence are removed
  */
+void qdev_reset_all(DeviceState *dev);
+void qdev_reset_all_fn(void *opaque);
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
=20
@@ -409,17 +452,21 @@ void qdev_machine_init(void);
  * device_legacy_reset:
  *
  * Reset a single device (by calling the reset method).
+ *
+ * This function is deprecated, please use device_reset() instead.
+ * TODO: remove the function when all occurences are removed.
  */
 void device_legacy_reset(DeviceState *dev);
=20
-static inline void device_reset(DeviceState *dev)
-{
-    device_legacy_reset(dev);
-}
-
+/**
+ * device_class_set_parent_reset:
+ * TODO: remove the function when DeviceClass's reset method
+ * is not used anymore.
+ */
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
+
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize);
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 46a36c2c95..5b25905907 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -547,6 +547,7 @@ tests/fp/%:
=20
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
+	hw/core/resettable.o \
 	hw/core/bus.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
--=20
2.21.0



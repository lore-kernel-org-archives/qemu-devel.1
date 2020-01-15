Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EFC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F53B2467D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="FlZbhAOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F53B2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhxb-00040W-W9
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhui-0002Kp-4e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1irhuf-00033d-Qc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:36:48 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:53552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1irhuf-00031a-H5; Wed, 15 Jan 2020 07:36:45 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id D17D396F52;
 Wed, 15 Jan 2020 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579091804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpVex+Uqu2M2Y6rT+PJf0WZrf5N7fAcNZ3YVCKs6OI0=;
 b=FlZbhAOD6Fx6z3vm/jXN87Oo2AEmqJjthUapR+5hDSFLcN/QIj9/7b/TNd17JvW3Dnw/LC
 M38jgksnR50diaD7m6juiO9THidpTYC5QIdreyEZDD5MjZPvbXml7pjGMdOP93pZaevs/u
 KgNQc/91R5T/n38MlAM/nB5mVYU4uMg=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/11] hw/core: add Resettable support to BusClass and
 DeviceClass
Date: Wed, 15 Jan 2020 13:36:13 +0100
Message-Id: <20200115123620.250132-5-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115123620.250132-1-damien.hedde@greensocs.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579091804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpVex+Uqu2M2Y6rT+PJf0WZrf5N7fAcNZ3YVCKs6OI0=;
 b=jTf+ltcv2EN7S5l0Q6qHyuYJDIMdTEnj/LurDlv2krXSKZevB3uszKRYTnwcRa6Cg75zLM
 3kTS1yeS+49hhZwJQSXLuVGMLE3pbu80prgRVrpASjklzwzY5o6n3SKjbyc0GiU1jwLbHd
 73T9PsQikuU4BHWnEBG+tlXlGDGqz/s=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579091804; a=rsa-sha256; cv=none;
 b=BNezA3wj9On6JSc+ff+4PT1mbt9PWXTDc9UWsPYnXPWfI8/tK5w0n9RI/PQJ7u1OgqBx4h
 MVDGOGWl6xF7dhEEyluXEq07qJRPI3ds6Xq/mXH2EZpgFJezB6Mplpdj5r3ArcMia0xTno
 3lg3MYalMRXnFbn/28J7wUt6dqgdJdw=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds support of Resettable interface to buses and devices:
+ ResettableState structure is added in the Bus/Device state
+ Resettable methods are implemented.
+ device/bus_is_in_reset function defined

This commit allows to transition the objects to the new
multi-phase interface without changing the reset behavior at all.
Object single reset method can be split into the 3 different phases
but the 3 phases are still executed in a row for a given object.
From the qdev/qbus reset api point of view, nothing is changed.
qdev_reset_all() and qbus_reset_all() are not modified as well as
device_legacy_reset().

Transition of an object must be done from parent class to child class.
Care has been taken to allow the transition of a parent class
without requiring the child classes to be transitioned at the same
time. Note that SysBus and SysBusDevice class do not need any transition
because they do not override the legacy reset method.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-core.h | 27 ++++++++++++
 hw/core/bus.c          | 97 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 93 ++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |  1 +
 4 files changed, 218 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b8341b0fb0..1b4b420617 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -5,6 +5,7 @@
 #include "qemu/bitmap.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
+#include "hw/resettable.h"
=20
 enum {
     DEV_NVECTORS_UNSPECIFIED =3D -1,
@@ -117,6 +118,11 @@ typedef struct DeviceClass {
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
@@ -141,6 +147,7 @@ struct NamedGPIOList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ * @reset: ResettableState for the device; handled by Resettable interfa=
ce.
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
@@ -163,6 +170,7 @@ struct DeviceState {
     int num_child_bus;
     int instance_id_alias;
     int alias_required_for_version;
+    ResettableState reset;
 };
=20
 struct DeviceListener {
@@ -215,6 +223,7 @@ typedef struct BusChild {
 /**
  * BusState:
  * @hotplug_handler: link to a hotplug handler associated with bus.
+ * @reset: ResettableState for the bus; handled by Resettable interface.
  */
 struct BusState {
     Object obj;
@@ -226,6 +235,7 @@ struct BusState {
     int num_children;
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
+    ResettableState reset;
 };
=20
 /**
@@ -412,6 +422,18 @@ void qdev_reset_all_fn(void *opaque);
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
=20
+/**
+ * device_is_in_reset:
+ * Return true if the device @dev is currently being reset.
+ */
+bool device_is_in_reset(DeviceState *dev);
+
+/**
+ * bus_is_in_reset:
+ * Return true if the bus @bus is currently being reset.
+ */
+bool bus_is_in_reset(BusState *bus);
+
 /* This should go away once we get rid of the NULL bus hack */
 BusState *sysbus_get_default(void);
=20
@@ -433,6 +455,11 @@ void qdev_machine_init(void);
  */
 void device_legacy_reset(DeviceState *dev);
=20
+/**
+ * device_class_set_parent_reset:
+ * TODO: remove the function when DeviceClass's reset method
+ * is not used anymore.
+ */
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 7f3d2a3dbd..2698f715bd 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -68,6 +68,28 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
=20
+bool bus_is_in_reset(BusState *bus)
+{
+    return resettable_is_in_reset(OBJECT(bus));
+}
+
+static ResettableState *bus_get_reset_state(Object *obj)
+{
+    BusState *bus =3D BUS(obj);
+    return &bus->reset;
+}
+
+static void bus_reset_child_foreach(Object *obj, ResettableChildCallback=
 cb,
+                                    void *opaque, ResetType type)
+{
+    BusState *bus =3D BUS(obj);
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        cb(OBJECT(kid->child), opaque, type);
+    }
+}
+
 static void qbus_realize(BusState *bus, DeviceState *parent, const char =
*name)
 {
     const char *typename =3D object_get_typename(OBJECT(bus));
@@ -199,12 +221,83 @@ static char *default_bus_get_fw_dev_path(DeviceStat=
e *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
=20
+/**
+ * bus_phases_reset:
+ * Transition reset method for buses to allow moving
+ * smoothly from legacy reset method to multi-phases
+ */
+static void bus_phases_reset(BusState *bus)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(bus);
+
+    if (rc->phases.enter) {
+        rc->phases.enter(OBJECT(bus), RESET_TYPE_COLD);
+    }
+    if (rc->phases.hold) {
+        rc->phases.hold(OBJECT(bus));
+    }
+    if (rc->phases.exit) {
+        rc->phases.exit(OBJECT(bus));
+    }
+}
+
+static void bus_transitional_reset(Object *obj)
+{
+    BusClass *bc =3D BUS_GET_CLASS(obj);
+
+    /*
+     * This will call either @bus_phases_reset (for multi-phases transit=
ioned
+     * buses) or a bus's specific method for not-yet transitioned buses.
+     * In both case, it does not reset children.
+     */
+    if (bc->reset) {
+        bc->reset(BUS(obj));
+    }
+}
+
+/**
+ * bus_get_transitional_reset:
+ * check if the bus's class is ready for multi-phase
+ */
+static ResettableTrFunction bus_get_transitional_reset(Object *obj)
+{
+    BusClass *dc =3D BUS_GET_CLASS(obj);
+    if (dc->reset !=3D bus_phases_reset) {
+        /*
+         * dc->reset has been overridden by a subclass,
+         * the bus is not ready for multi phase yet.
+         */
+        return bus_transitional_reset;
+    }
+    return NULL;
+}
+
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc =3D BUS_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D bus_unparent;
     bc->get_fw_dev_path =3D default_bus_get_fw_dev_path;
+
+    rc->get_state =3D bus_get_reset_state;
+    rc->child_foreach =3D bus_reset_child_foreach;
+
+    /*
+     * @bus_phases_reset is put as the default reset method below, allow=
ing
+     * to do the multi-phase transition from base classes to leaf classe=
s. It
+     * allows a legacy-reset Bus class to extend a multi-phases-reset
+     * Bus class for the following reason:
+     * + If a base class B has been moved to multi-phase, then it does n=
ot
+     *   override this default reset method and may have defined phase m=
ethods.
+     * + A child class C (extending class B) which uses
+     *   bus_class_set_parent_reset() (or similar means) to override the
+     *   reset method will still work as expected. @bus_phases_reset fun=
ction
+     *   will be registered as the parent reset method and effectively c=
all
+     *   parent reset phases.
+     */
+    bc->reset =3D bus_phases_reset;
+    rc->get_transitional_function =3D bus_get_transitional_reset;
 }
=20
 static void qbus_finalize(Object *obj)
@@ -223,6 +316,10 @@ static const TypeInfo bus_info =3D {
     .instance_init =3D qbus_initfn,
     .instance_finalize =3D qbus_finalize,
     .class_init =3D bus_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_RESETTABLE_INTERFACE },
+        { }
+    },
 };
=20
 static void bus_register_types(void)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5cb03136b5..d431a020fc 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -355,6 +355,28 @@ void qbus_reset_all_fn(void *opaque)
     qbus_reset_all(bus);
 }
=20
+bool device_is_in_reset(DeviceState *dev)
+{
+    return resettable_is_in_reset(OBJECT(dev));
+}
+
+static ResettableState *device_get_reset_state(Object *obj)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    return &dev->reset;
+}
+
+static void device_reset_child_foreach(Object *obj, ResettableChildCallb=
ack cb,
+                                       void *opaque, ResetType type)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    BusState *bus;
+
+    QLIST_FOREACH(bus, &dev->child_bus, sibling) {
+        cb(OBJECT(bus), opaque, type);
+    }
+}
+
 /* can be used as ->unplug() callback for the simple cases */
 void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
                                   DeviceState *dev, Error **errp)
@@ -1107,10 +1129,62 @@ device_vmstate_if_get_id(VMStateIf *obj)
     return qdev_get_dev_path(dev);
 }
=20
+/**
+ * device_phases_reset:
+ * Transition reset method for devices to allow moving
+ * smoothly from legacy reset method to multi-phases
+ */
+static void device_phases_reset(DeviceState *dev)
+{
+    ResettableClass *rc =3D RESETTABLE_GET_CLASS(dev);
+
+    if (rc->phases.enter) {
+        rc->phases.enter(OBJECT(dev), RESET_TYPE_COLD);
+    }
+    if (rc->phases.hold) {
+        rc->phases.hold(OBJECT(dev));
+    }
+    if (rc->phases.exit) {
+        rc->phases.exit(OBJECT(dev));
+    }
+}
+
+static void device_transitional_reset(Object *obj)
+{
+    DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
+
+    /*
+     * This will call either @device_phases_reset (for multi-phases tran=
sitioned
+     * devices) or a device's specific method for not-yet transitioned d=
evices.
+     * In both case, it does not reset children.
+     */
+    if (dc->reset) {
+        dc->reset(DEVICE(obj));
+    }
+}
+
+/**
+ * device_get_transitional_reset:
+ * check if the device's class is ready for multi-phase
+ */
+static ResettableTrFunction device_get_transitional_reset(Object *obj)
+{
+    DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
+    if (dc->reset !=3D device_phases_reset) {
+        /*
+         * dc->reset has been overridden by a subclass,
+         * the device is not ready for multi phase yet.
+         */
+        return device_transitional_reset;
+    }
+    return NULL;
+}
+
 static void device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(class);
     VMStateIfClass *vc =3D VMSTATE_IF_CLASS(class);
+    ResettableClass *rc =3D RESETTABLE_CLASS(class);
=20
     class->unparent =3D device_unparent;
=20
@@ -1123,6 +1197,24 @@ static void device_class_init(ObjectClass *class, =
void *data)
     dc->hotpluggable =3D true;
     dc->user_creatable =3D true;
     vc->get_id =3D device_vmstate_if_get_id;
+    rc->get_state =3D device_get_reset_state;
+    rc->child_foreach =3D device_reset_child_foreach;
+
+    /*
+     * @device_phases_reset is put as the default reset method below, al=
lowing
+     * to do the multi-phase transition from base classes to leaf classe=
s. It
+     * allows a legacy-reset Device class to extend a multi-phases-reset
+     * Device class for the following reason:
+     * + If a base class B has been moved to multi-phase, then it does n=
ot
+     *   override this default reset method and may have defined phase m=
ethods.
+     * + A child class C (extending class B) which uses
+     *   device_class_set_parent_reset() (or similar means) to override =
the
+     *   reset method will still work as expected. @device_phases_reset =
function
+     *   will be registered as the parent reset method and effectively c=
all
+     *   parent reset phases.
+     */
+    dc->reset =3D device_phases_reset;
+    rc->get_transitional_function =3D device_get_transitional_reset;
 }
=20
 void device_class_set_parent_reset(DeviceClass *dc,
@@ -1183,6 +1275,7 @@ static const TypeInfo device_type_info =3D {
     .class_size =3D sizeof(DeviceClass),
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_VMSTATE_IF },
+        { TYPE_RESETTABLE_INTERFACE },
         { }
     }
 };
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1ae14a8b15..8ad07621b0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -427,6 +427,7 @@ tests/fp/%:
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
 	hw/core/bus.o \
+	hw/core/resettable.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
 	hw/core/reset.o \
--=20
2.24.1



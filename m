Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F1CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7D7206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kq3EcWc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7D7206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCZW-0006Cz-PX
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTx-0005f0-HB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTv-0002z1-9B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:53 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTv-0002xy-0v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id a9so4934987wmj.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9GY0agIDveLaCrKYi6SjCp332YnJXXqzF/7R2Nf/DpQ=;
 b=Kq3EcWc1lyPmVk8CDjVn8B3mL+cADKUVYLlx2+ThEdelwUJDHC3tSU5xY5GdYI3e6C
 XhJaE1H1ynVKDa0pNezWmdPF+645lfOAIZCEGIBdK1W69NUQbDHgo7uBRGd3QZ/Z/dRN
 Bu3sYWNrxOKyJLBWOOORa/039dEPsdPdMv8QTutUmyTEzKNtlHRIwcQMwB6FDmJOgHVn
 1eaM3kIsE7d1NL8uYKf9T+JbaioaY6nJvvczduwDtiZfz0hafiNPgkKSFp1nFbMxubGw
 OcJZwbUkQEipl1ygB3VteOUjcX+X4PwY/4yylV28sfaNGHXy2BszSZ7wWV4EeQ3zqMqa
 yO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9GY0agIDveLaCrKYi6SjCp332YnJXXqzF/7R2Nf/DpQ=;
 b=QNZSRyD0G8b/Y3MYer44tyK8AjnwJ4SKuToV/X/8xgq/5pM5SRkiiTYjKcAxDLfkuR
 6zCyQJPnjyq4B/Lxzh88mr+Dm/VMmeV1JJyjx8v1mmjBZqzTGGlaa5g+/CwqHmVGiOT0
 upHSMktcWcwaqH8rOVjAsEZAh/b9HRsBB0Kzvtq0VKB+logYe7VDKLzYKsN7VcXFeyk1
 eoEqM8owBE5Dv/L9+ZUD8nheBezv1bMg1x4mejYCm9pMgEkvWDA2PRJEM8fsI6hpfD/u
 H12MG7tIn94N1yB3yNlNZfYwPfb5TNQCLqrGpzzDQGOyi6U2Xb6ErWkpn2WZ0/SdPMAr
 pfzw==
X-Gm-Message-State: APjAAAXRx+XSo00Flkk/0ZXm++JDrtmeJnaIGu8OlcggMf4DZgdxln8J
 gAg2qfL7sj/mtH28WX1Qqk/LCIc1GBKv3Q==
X-Google-Smtp-Source: APXvYqyfRnGQY3K64XufGYhYAPRz5YtuGpHamkZaj8Pxzew7Kci3VefjsC67qar1cnwm0WdJQeVGGA==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr6108354wml.47.1580400949471; 
 Thu, 30 Jan 2020 08:15:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] hw/core: add Resettable support to BusClass and
 DeviceClass
Date: Thu, 30 Jan 2020 16:15:19 +0000
Message-Id: <20200130161533.8180-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-5-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/Makefile.include |  1 +
 include/hw/qdev-core.h | 27 ++++++++++++
 hw/core/bus.c          | 97 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 93 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 218 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c6827ce8c29..a1bff5dcce0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -429,6 +429,7 @@ tests/fp/%:
 tests/test-qdev-global-props$(EXESUF): tests/test-qdev-global-props.o \
 	hw/core/qdev.o hw/core/qdev-properties.o hw/core/hotplug.o\
 	hw/core/bus.o \
+	hw/core/resettable.o \
 	hw/core/irq.o \
 	hw/core/fw-path-provider.o \
 	hw/core/reset.o \
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 627d653dc16..09b7a441eb6 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -5,6 +5,7 @@
 #include "qemu/bitmap.h"
 #include "qom/object.h"
 #include "hw/hotplug.h"
+#include "hw/resettable.h"
 
 enum {
     DEV_NVECTORS_UNSPECIFIED = -1,
@@ -122,6 +123,11 @@ typedef struct DeviceClass {
     bool hotpluggable;
 
     /* callbacks */
+    /*
+     * Reset method here is deprecated and replaced by methods in the
+     * resettable class interface to implement a multi-phase reset.
+     * TODO: remove once every reset callback is unused
+     */
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
@@ -146,6 +152,7 @@ struct NamedGPIOList {
 /**
  * DeviceState:
  * @realized: Indicates whether the device has been fully constructed.
+ * @reset: ResettableState for the device; handled by Resettable interface.
  *
  * This structure should not be accessed directly.  We declare it here
  * so that it can be embedded in individual device state structures.
@@ -168,6 +175,7 @@ struct DeviceState {
     int num_child_bus;
     int instance_id_alias;
     int alias_required_for_version;
+    ResettableState reset;
 };
 
 struct DeviceListener {
@@ -220,6 +228,7 @@ typedef struct BusChild {
 /**
  * BusState:
  * @hotplug_handler: link to a hotplug handler associated with bus.
+ * @reset: ResettableState for the bus; handled by Resettable interface.
  */
 struct BusState {
     Object obj;
@@ -231,6 +240,7 @@ struct BusState {
     int num_children;
     QTAILQ_HEAD(, BusChild) children;
     QLIST_ENTRY(BusState) sibling;
+    ResettableState reset;
 };
 
 /**
@@ -417,6 +427,18 @@ void qdev_reset_all_fn(void *opaque);
 void qbus_reset_all(BusState *bus);
 void qbus_reset_all_fn(void *opaque);
 
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
 
@@ -440,6 +462,11 @@ void device_legacy_reset(DeviceState *dev);
 
 void device_class_set_props(DeviceClass *dc, Property *props);
 
+/**
+ * device_class_set_parent_reset:
+ * TODO: remove the function when DeviceClass's reset method
+ * is not used anymore.
+ */
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 7f3d2a3dbda..2698f715bd7 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -68,6 +68,28 @@ int qbus_walk_children(BusState *bus,
     return 0;
 }
 
+bool bus_is_in_reset(BusState *bus)
+{
+    return resettable_is_in_reset(OBJECT(bus));
+}
+
+static ResettableState *bus_get_reset_state(Object *obj)
+{
+    BusState *bus = BUS(obj);
+    return &bus->reset;
+}
+
+static void bus_reset_child_foreach(Object *obj, ResettableChildCallback cb,
+                                    void *opaque, ResetType type)
+{
+    BusState *bus = BUS(obj);
+    BusChild *kid;
+
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        cb(OBJECT(kid->child), opaque, type);
+    }
+}
+
 static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
 {
     const char *typename = object_get_typename(OBJECT(bus));
@@ -199,12 +221,83 @@ static char *default_bus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(object_get_typename(OBJECT(dev)));
 }
 
+/**
+ * bus_phases_reset:
+ * Transition reset method for buses to allow moving
+ * smoothly from legacy reset method to multi-phases
+ */
+static void bus_phases_reset(BusState *bus)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(bus);
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
+    BusClass *bc = BUS_GET_CLASS(obj);
+
+    /*
+     * This will call either @bus_phases_reset (for multi-phases transitioned
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
+    BusClass *dc = BUS_GET_CLASS(obj);
+    if (dc->reset != bus_phases_reset) {
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
     BusClass *bc = BUS_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
 
     class->unparent = bus_unparent;
     bc->get_fw_dev_path = default_bus_get_fw_dev_path;
+
+    rc->get_state = bus_get_reset_state;
+    rc->child_foreach = bus_reset_child_foreach;
+
+    /*
+     * @bus_phases_reset is put as the default reset method below, allowing
+     * to do the multi-phase transition from base classes to leaf classes. It
+     * allows a legacy-reset Bus class to extend a multi-phases-reset
+     * Bus class for the following reason:
+     * + If a base class B has been moved to multi-phase, then it does not
+     *   override this default reset method and may have defined phase methods.
+     * + A child class C (extending class B) which uses
+     *   bus_class_set_parent_reset() (or similar means) to override the
+     *   reset method will still work as expected. @bus_phases_reset function
+     *   will be registered as the parent reset method and effectively call
+     *   parent reset phases.
+     */
+    bc->reset = bus_phases_reset;
+    rc->get_transitional_function = bus_get_transitional_reset;
 }
 
 static void qbus_finalize(Object *obj)
@@ -223,6 +316,10 @@ static const TypeInfo bus_info = {
     .instance_init = qbus_initfn,
     .instance_finalize = qbus_finalize,
     .class_init = bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_RESETTABLE_INTERFACE },
+        { }
+    },
 };
 
 static void bus_register_types(void)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 29e8c6b8dfc..b2affd8f92b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -355,6 +355,28 @@ void qbus_reset_all_fn(void *opaque)
     qbus_reset_all(bus);
 }
 
+bool device_is_in_reset(DeviceState *dev)
+{
+    return resettable_is_in_reset(OBJECT(dev));
+}
+
+static ResettableState *device_get_reset_state(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+    return &dev->reset;
+}
+
+static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
+                                       void *opaque, ResetType type)
+{
+    DeviceState *dev = DEVICE(obj);
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
@@ -1057,10 +1079,62 @@ device_vmstate_if_get_id(VMStateIf *obj)
     return qdev_get_dev_path(dev);
 }
 
+/**
+ * device_phases_reset:
+ * Transition reset method for devices to allow moving
+ * smoothly from legacy reset method to multi-phases
+ */
+static void device_phases_reset(DeviceState *dev)
+{
+    ResettableClass *rc = RESETTABLE_GET_CLASS(dev);
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
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+
+    /*
+     * This will call either @device_phases_reset (for multi-phases transitioned
+     * devices) or a device's specific method for not-yet transitioned devices.
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
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+    if (dc->reset != device_phases_reset) {
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
     DeviceClass *dc = DEVICE_CLASS(class);
     VMStateIfClass *vc = VMSTATE_IF_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
 
     class->unparent = device_unparent;
 
@@ -1073,6 +1147,24 @@ static void device_class_init(ObjectClass *class, void *data)
     dc->hotpluggable = true;
     dc->user_creatable = true;
     vc->get_id = device_vmstate_if_get_id;
+    rc->get_state = device_get_reset_state;
+    rc->child_foreach = device_reset_child_foreach;
+
+    /*
+     * @device_phases_reset is put as the default reset method below, allowing
+     * to do the multi-phase transition from base classes to leaf classes. It
+     * allows a legacy-reset Device class to extend a multi-phases-reset
+     * Device class for the following reason:
+     * + If a base class B has been moved to multi-phase, then it does not
+     *   override this default reset method and may have defined phase methods.
+     * + A child class C (extending class B) which uses
+     *   device_class_set_parent_reset() (or similar means) to override the
+     *   reset method will still work as expected. @device_phases_reset function
+     *   will be registered as the parent reset method and effectively call
+     *   parent reset phases.
+     */
+    dc->reset = device_phases_reset;
+    rc->get_transitional_function = device_get_transitional_reset;
 
     object_class_property_add_bool(class, "realized",
                                    device_get_realized, device_set_realized,
@@ -1157,6 +1249,7 @@ static const TypeInfo device_type_info = {
     .class_size = sizeof(DeviceClass),
     .interfaces = (InterfaceInfo[]) {
         { TYPE_VMSTATE_IF },
+        { TYPE_RESETTABLE_INTERFACE },
         { }
     }
 };
-- 
2.20.1



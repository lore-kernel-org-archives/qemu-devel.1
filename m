Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E9EC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A84A206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A84A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJkbw-0000Dm-CP
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 16:04:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYW-0005lD-GF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJkYQ-0007Pd-RU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJkYQ-00062f-A3
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F1DD30882A5;
	Thu, 25 Apr 2019 20:00:58 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 56EF91A267;
	Thu, 25 Apr 2019 20:00:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 17:00:49 -0300
Message-Id: <20190425200051.19906-3-ehabkost@redhat.com>
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
References: <20190425200051.19906-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 25 Apr 2019 20:00:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] move qdev hotplug code to qdev-hotplug.c
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Like Xu <like.xu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425200049.rTYLFs2-KmJYcYs5VW1jyK2d2JdjlFD7SyCV7ii_G4g@z>

The qdev hotplug code is used only in softmmu mode, so move it to
a separate file so we can eventually avoid compiling it in
user-only mode.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/bus.c          | 11 -------
 hw/core/qdev-hotplug.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev.c         | 35 ---------------------
 hw/core/Makefile.objs  |  2 +-
 4 files changed, 70 insertions(+), 47 deletions(-)
 create mode 100644 hw/core/qdev-hotplug.c

diff --git a/hw/core/bus.c b/hw/core/bus.c
index e09843f6ab..35e042416c 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -22,17 +22,6 @@
 #include "hw/qdev.h"
 #include "qapi/error.h"
 
-void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp)
-{
-    object_property_set_link(OBJECT(bus), OBJECT(handler),
-                             QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
-}
-
-void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
-{
-    qbus_set_hotplug_handler(bus, OBJECT(bus), errp);
-}
-
 int qbus_walk_children(BusState *bus,
                        qdev_walkerfn *pre_devfn, qbus_walkerfn *pre_busfn,
                        qdev_walkerfn *post_devfn, qbus_walkerfn *post_busfn,
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
new file mode 100644
index 0000000000..8ab31043a7
--- /dev/null
+++ b/hw/core/qdev-hotplug.c
@@ -0,0 +1,69 @@
+/*
+ * qdev and qbus hotplug helpers
+ *
+ *  Copyright (c) 2009 CodeSourcery
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+
+void qbus_set_hotplug_handler(BusState *bus, Object *handler, Error **errp)
+{
+    object_property_set_link(OBJECT(bus), OBJECT(handler),
+                             QDEV_HOTPLUG_HANDLER_PROPERTY, errp);
+}
+
+void qbus_set_bus_hotplug_handler(BusState *bus, Error **errp)
+{
+    qbus_set_hotplug_handler(bus, OBJECT(bus), errp);
+}
+
+HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
+{
+    MachineState *machine;
+    MachineClass *mc;
+    Object *m_obj = qdev_get_machine();
+
+    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
+        machine = MACHINE(m_obj);
+        mc = MACHINE_GET_CLASS(machine);
+        if (mc->get_hotplug_handler) {
+            return mc->get_hotplug_handler(machine, dev);
+        }
+    }
+
+    return NULL;
+}
+
+HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
+{
+    if (dev->parent_bus) {
+        return dev->parent_bus->hotplug_handler;
+    }
+    return NULL;
+}
+
+HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
+{
+    HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
+
+    if (hotplug_ctrl == NULL && dev->parent_bus) {
+        hotplug_ctrl = qdev_get_bus_hotplug_handler(dev);
+    }
+    return hotplug_ctrl;
+}
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f73e7ded1a..3015da0ac9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -219,41 +219,6 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
     dev->alias_required_for_version = required_for_version;
 }
 
-HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
-{
-    MachineState *machine;
-    MachineClass *mc;
-    Object *m_obj = qdev_get_machine();
-
-    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
-        machine = MACHINE(m_obj);
-        mc = MACHINE_GET_CLASS(machine);
-        if (mc->get_hotplug_handler) {
-            return mc->get_hotplug_handler(machine, dev);
-        }
-    }
-
-    return NULL;
-}
-
-HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
-{
-    if (dev->parent_bus) {
-        return dev->parent_bus->hotplug_handler;
-    }
-    return NULL;
-}
-
-HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
-{
-    HotplugHandler *hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
-
-    if (hotplug_ctrl == NULL && dev->parent_bus) {
-        hotplug_ctrl = qdev_get_bus_hotplug_handler(dev);
-    }
-    return hotplug_ctrl;
-}
-
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
     device_reset(dev);
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6789154807..9c4f953716 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -1,6 +1,6 @@
 # core qdev-related obj files, also used by *-user:
 common-obj-y += qdev.o qdev-properties.o
-common-obj-y += bus.o reset.o
+common-obj-y += bus.o reset.o qdev-hotplug.o
 common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
 # irq.o needed for qdev GPIO handling:
-- 
2.18.0.rc1.1.g3f1ff2140



Received: from eggs.gnu.org ([2001:4830:134:3::10]:45994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD6-0003Vw-Rm
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XD3-0007tQ-IQ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XD3-0007t6-9D
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2701CC00B8DD
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:38 +0200
Message-Id: <20170421115646.15544-58-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 57/65] qdev: Move qdev_unplug() to qdev-monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

It is not used by linux-user, otherwise I need to to create one stub
for migration_is_idle() on following patch.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev.c | 34 ----------------------------------
 qdev-monitor.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c26cf84..0df0050 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -271,40 +271,6 @@ HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
     return hotplug_ctrl;
 }
 
-void qdev_unplug(DeviceState *dev, Error **errp)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-    HotplugHandler *hotplug_ctrl;
-    HotplugHandlerClass *hdc;
-
-    if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
-        return;
-    }
-
-    if (!dc->hotpluggable) {
-        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
-                   object_get_typename(OBJECT(dev)));
-        return;
-    }
-
-    qdev_hot_removed = true;
-
-    hotplug_ctrl = qdev_get_hotplug_handler(dev);
-    /* hotpluggable device MUST have HotplugHandler, if it doesn't
-     * then something is very wrong with it */
-    g_assert(hotplug_ctrl);
-
-    /* If device supports async unplug just request it to be done,
-     * otherwise just remove it synchronously */
-    hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_ctrl);
-    if (hdc->unplug_request) {
-        hotplug_handler_unplug_request(hotplug_ctrl, dev, errp);
-    } else {
-        hotplug_handler_unplug(hotplug_ctrl, dev, errp);
-    }
-}
-
 static int qdev_reset_one(DeviceState *dev, void *opaque)
 {
     device_reset(dev);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 5f2fcdf..bb3d8ba 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -836,6 +836,40 @@ static DeviceState *find_device_state(const char *id, Error **errp)
     return DEVICE(obj);
 }
 
+void qdev_unplug(DeviceState *dev, Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+    HotplugHandler *hotplug_ctrl;
+    HotplugHandlerClass *hdc;
+
+    if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
+        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
+        return;
+    }
+
+    if (!dc->hotpluggable) {
+        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
+                   object_get_typename(OBJECT(dev)));
+        return;
+    }
+
+    qdev_hot_removed = true;
+
+    hotplug_ctrl = qdev_get_hotplug_handler(dev);
+    /* hotpluggable device MUST have HotplugHandler, if it doesn't
+     * then something is very wrong with it */
+    g_assert(hotplug_ctrl);
+
+    /* If device supports async unplug just request it to be done,
+     * otherwise just remove it synchronously */
+    hdc = HOTPLUG_HANDLER_GET_CLASS(hotplug_ctrl);
+    if (hdc->unplug_request) {
+        hotplug_handler_unplug_request(hotplug_ctrl, dev, errp);
+    } else {
+        hotplug_handler_unplug(hotplug_ctrl, dev, errp);
+    }
+}
+
 void qmp_device_del(const char *id, Error **errp)
 {
     DeviceState *dev = find_device_state(id, errp);
-- 
2.9.3

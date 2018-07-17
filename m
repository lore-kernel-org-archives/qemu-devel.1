Received: from eggs.gnu.org ([2001:4830:134:3::10]:48490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZK-0005Bf-BK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZJ-0007HM-67
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44332 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZJ-0007H2-0F
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2861401EF0C
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 15:07:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:50 +0200
Message-Id: <1531840015-28804-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] qdev: add HotplugHandler->post_plug()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

From: Stefan Hajnoczi <stefanha@redhat.com>

The ->pre_plug() callback is invoked before the device is realized.  The
->plug() callback is invoked when the device is being realized but
before it is reset.

This patch adds a ->post_plug() callback which is invoked after the
device has been reset.  This callback is needed by HotplugHandlers that
need to wait until after ->reset().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20180716083732.3347-2-stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/hotplug.c    | 10 ++++++++++
 hw/core/qdev.c       |  4 ++++
 include/hw/hotplug.h | 11 +++++++++++
 3 files changed, 25 insertions(+)

diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 17ac986..2253072 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -35,6 +35,16 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
     }
 }
 
+void hotplug_handler_post_plug(HotplugHandler *plug_handler,
+                               DeviceState *plugged_dev)
+{
+    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+
+    if (hdc->post_plug) {
+        hdc->post_plug(plug_handler, plugged_dev);
+    }
+}
+
 void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cf0db4b..529b82d 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -867,6 +867,10 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             device_reset(dev);
         }
         dev->pending_deleted_event = false;
+
+        if (hotplug_ctrl) {
+            hotplug_handler_post_plug(hotplug_ctrl, dev);
+        }
     } else if (!value && dev->realized) {
         Error **local_errp = NULL;
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index 1a0516a..51541d6 100644
--- a/include/hw/hotplug.h
+++ b/include/hw/hotplug.h
@@ -47,6 +47,8 @@ typedef void (*hotplug_fn)(HotplugHandler *plug_handler,
  * @parent: Opaque parent interface.
  * @pre_plug: pre plug callback called at start of device.realize(true)
  * @plug: plug callback called at end of device.realize(true).
+ * @post_plug: post plug callback called after device.realize(true) and device
+ *             reset
  * @unplug_request: unplug request callback.
  *                  Used as a means to initiate device unplug for devices that
  *                  require asynchronous unplug handling.
@@ -61,6 +63,7 @@ typedef struct HotplugHandlerClass {
     /* <public> */
     hotplug_fn pre_plug;
     hotplug_fn plug;
+    void (*post_plug)(HotplugHandler *plug_handler, DeviceState *plugged_dev);
     hotplug_fn unplug_request;
     hotplug_fn unplug;
 } HotplugHandlerClass;
@@ -84,6 +87,14 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               Error **errp);
 
 /**
+ * hotplug_handler_post_plug:
+ *
+ * Call #HotplugHandlerClass.post_plug callback of @plug_handler.
+ */
+void hotplug_handler_post_plug(HotplugHandler *plug_handler,
+                               DeviceState *plugged_dev);
+
+/**
  * hotplug_handler_unplug_request:
  *
  * Calls #HotplugHandlerClass.unplug_request callback of @plug_handler.
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fez0o-0000sK-Gf
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fez0j-0004YZ-34
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:37:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fez0i-0004Y8-MM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:37:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jul 2018 09:37:31 +0100
Message-Id: <20180716083732.3347-2-stefanha@redhat.com>
In-Reply-To: <20180716083732.3347-1-stefanha@redhat.com>
References: <20180716083732.3347-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qdev: add HotplugHandler->post_plug()
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
Cc: l00284672 <lizhengui@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The ->pre_plug() callback is invoked before the device is realized.  The
->plug() callback is invoked when the device is being realized but
before it is reset.

This patch adds a ->post_plug() callback which is invoked after the
device has been reset.  This callback is needed by HotplugHandlers that
need to wait until after ->reset().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/hotplug.h | 11 +++++++++++
 hw/core/hotplug.c    | 10 ++++++++++
 hw/core/qdev.c       |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index 1a0516a479..51541d63e1 100644
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
@@ -83,6 +86,14 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp);
 
+/**
+ * hotplug_handler_post_plug:
+ *
+ * Call #HotplugHandlerClass.post_plug callback of @plug_handler.
+ */
+void hotplug_handler_post_plug(HotplugHandler *plug_handler,
+                               DeviceState *plugged_dev);
+
 /**
  * hotplug_handler_unplug_request:
  *
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 17ac986685..2253072d0e 100644
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
index cf0db4b6da..529b82de18 100644
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
-- 
2.17.1

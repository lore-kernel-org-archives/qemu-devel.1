Received: from eggs.gnu.org ([2001:4830:134:3::10]:46332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fcuuf-0002sr-CR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fcuud-0005o2-Np
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:50:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fcuud-0005l8-Hl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:50:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 10 Jul 2018 16:50:36 +0100
Message-Id: <20180710155037.16834-2-stefanha@redhat.com>
In-Reply-To: <20180710155037.16834-1-stefanha@redhat.com>
References: <20180710155037.16834-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qdev: add HotplugHandler->post_plug()
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
Cc: l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The ->pre_plug() callback is invoked before the device is realized.  The
->plug() callback is invoked when the device is being realized but
before it is reset.

This patch adds a ->post_plug() callback which is invoked after the
device has been reset.  This callback is needed by HotplugHandlers that
need to wait until after ->reset().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/hotplug.h | 12 ++++++++++++
 hw/core/hotplug.c    | 11 +++++++++++
 hw/core/qdev.c       |  7 +++++++
 3 files changed, 30 insertions(+)

diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
index 1a0516a479..1e8b1053b6 100644
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
+    hotplug_fn post_plug;
     hotplug_fn unplug_request;
     hotplug_fn unplug;
 } HotplugHandlerClass;
@@ -83,6 +86,15 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
                               DeviceState *plugged_dev,
                               Error **errp);
 
+/**
+ * hotplug_handler_post_plug:
+ *
+ * Call #HotplugHandlerClass.post_plug callback of @plug_handler.
+ */
+void hotplug_handler_post_plug(HotplugHandler *plug_handler,
+                               DeviceState *plugged_dev,
+                               Error **errp);
+
 /**
  * hotplug_handler_unplug_request:
  *
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 17ac986685..ab34c19461 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -35,6 +35,17 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
     }
 }
 
+void hotplug_handler_post_plug(HotplugHandler *plug_handler,
+                               DeviceState *plugged_dev,
+                               Error **errp)
+{
+    HotplugHandlerClass *hdc = HOTPLUG_HANDLER_GET_CLASS(plug_handler);
+
+    if (hdc->post_plug) {
+        hdc->post_plug(plug_handler, plugged_dev, errp);
+    }
+}
+
 void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
                                     DeviceState *plugged_dev,
                                     Error **errp)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index cf0db4b6da..78c0e031ff 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -865,6 +865,13 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         }
         if (dev->hotplugged) {
             device_reset(dev);
+
+            if (hotplug_ctrl) {
+                hotplug_handler_post_plug(hotplug_ctrl, dev, &local_err);
+                if (local_err != NULL) {
+                    goto child_realize_fail;
+                }
+            }
         }
         dev->pending_deleted_event = false;
     } else if (!value && dev->realized) {
-- 
2.17.1

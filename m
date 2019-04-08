Received: from eggs.gnu.org ([209.51.188.92]:40504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW17-0002n9-5D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9940f4835=Paul.Durrant@citrix.com>)
	id 1hDW11-0001N0-Dy
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:57 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 8 Apr 2019 16:16:15 +0100
Message-ID: <20190408151617.13025-2-paul.durrant@citrix.com>
In-Reply-To: <20190408151617.13025-1-paul.durrant@citrix.com>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] xen-bus: use a separate fd for each event
 channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

To better support use of IOThread-s it will be necessary to be able to set
the AioContext for each XenEventChannel and hence it is necessary to open a
separate handle to libxenevtchan for each channel.

This patch stops using NotifierList for event channel callbacks, replacing
that construct by a list of complete XenEventChannel structures. Each of
these now has a xenevtchn_handle pointer in place of the single pointer
previously held in the XenDevice structure. The individual handles are
opened/closed in xen_device_bind/unbind_event_channel(), replacing the
single open/close in xen_device_realize/unrealize().

NOTE: This patch does not add an AioContext parameter to
      xen_device_bind_event_channel(). That will be done in a subsequent
      patch.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c         | 79 ++++++++++++++++++++--------------------
 include/hw/xen/xen-bus.h |  6 +--
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 49a725e8c7..9e391492ac 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -923,19 +923,22 @@ done:
 }
 
 struct XenEventChannel {
+    QLIST_ENTRY(XenEventChannel) list;
+    xenevtchn_handle *xeh;
     evtchn_port_t local_port;
     XenEventHandler handler;
     void *opaque;
-    Notifier notifier;
 };
 
-static void event_notify(Notifier *n, void *data)
+static void xen_device_event(void *opaque)
 {
-    XenEventChannel *channel = container_of(n, XenEventChannel, notifier);
-    unsigned long port = (unsigned long)data;
+    XenEventChannel *channel = opaque;
+    unsigned long port = xenevtchn_pending(channel->xeh);
 
     if (port == channel->local_port) {
         channel->handler(channel->opaque);
+
+        xenevtchn_unmask(channel->xeh, port);
     }
 }
 
@@ -947,24 +950,39 @@ XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
     XenEventChannel *channel = g_new0(XenEventChannel, 1);
     xenevtchn_port_or_error_t local_port;
 
-    local_port = xenevtchn_bind_interdomain(xendev->xeh,
+    channel->xeh = xenevtchn_open(NULL, 0);
+    if (!channel->xeh) {
+        error_setg_errno(errp, errno, "failed xenevtchn_open");
+        goto fail;
+    }
+
+    local_port = xenevtchn_bind_interdomain(channel->xeh,
                                             xendev->frontend_id,
                                             port);
     if (local_port < 0) {
         error_setg_errno(errp, errno, "xenevtchn_bind_interdomain failed");
-
-        g_free(channel);
-        return NULL;
+        goto fail;
     }
 
     channel->local_port = local_port;
     channel->handler = handler;
     channel->opaque = opaque;
-    channel->notifier.notify = event_notify;
 
-    notifier_list_add(&xendev->event_notifiers, &channel->notifier);
+    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event, NULL,
+                        channel);
+
+    QLIST_INSERT_HEAD(&xendev->event_channels, channel, list);
 
     return channel;
+
+fail:
+    if (channel->xeh) {
+        xenevtchn_close(channel->xeh);
+    }
+
+    g_free(channel);
+
+    return NULL;
 }
 
 void xen_device_notify_event_channel(XenDevice *xendev,
@@ -976,7 +994,7 @@ void xen_device_notify_event_channel(XenDevice *xendev,
         return;
     }
 
-    if (xenevtchn_notify(xendev->xeh, channel->local_port) < 0) {
+    if (xenevtchn_notify(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_notify failed");
     }
 }
@@ -990,12 +1008,15 @@ void xen_device_unbind_event_channel(XenDevice *xendev,
         return;
     }
 
-    notifier_remove(&channel->notifier);
+    QLIST_REMOVE(channel, list);
 
-    if (xenevtchn_unbind(xendev->xeh, channel->local_port) < 0) {
+    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), NULL, NULL, NULL);
+
+    if (xenevtchn_unbind(channel->xeh, channel->local_port) < 0) {
         error_setg_errno(errp, errno, "xenevtchn_unbind failed");
     }
 
+    xenevtchn_close(channel->xeh);
     g_free(channel);
 }
 
@@ -1004,6 +1025,7 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     XenDevice *xendev = XEN_DEVICE(dev);
     XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
     const char *type = object_get_typename(OBJECT(xendev));
+    XenEventChannel *channel, *next;
 
     if (!xendev->name) {
         return;
@@ -1020,15 +1042,14 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
         xendev_class->unrealize(xendev, errp);
     }
 
+    /* Make sure all event channels are cleaned up */
+    QLIST_FOREACH_SAFE(channel, &xendev->event_channels, list, next) {
+        xen_device_unbind_event_channel(xendev, channel, NULL);
+    }
+
     xen_device_frontend_destroy(xendev);
     xen_device_backend_destroy(xendev);
 
-    if (xendev->xeh) {
-        qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), NULL, NULL, NULL);
-        xenevtchn_close(xendev->xeh);
-        xendev->xeh = NULL;
-    }
-
     if (xendev->xgth) {
         xengnttab_close(xendev->xgth);
         xendev->xgth = NULL;
@@ -1045,16 +1066,6 @@ static void xen_device_exit(Notifier *n, void *data)
     xen_device_unrealize(DEVICE(xendev), &error_abort);
 }
 
-static void xen_device_event(void *opaque)
-{
-    XenDevice *xendev = opaque;
-    unsigned long port = xenevtchn_pending(xendev->xeh);
-
-    notifier_list_notify(&xendev->event_notifiers, (void *)port);
-
-    xenevtchn_unmask(xendev->xeh, port);
-}
-
 static void xen_device_realize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -1095,16 +1106,6 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xendev->feature_grant_copy =
         (xengnttab_grant_copy(xendev->xgth, 0, NULL) == 0);
 
-    xendev->xeh = xenevtchn_open(NULL, 0);
-    if (!xendev->xeh) {
-        error_setg_errno(errp, errno, "failed xenevtchn_open");
-        goto unrealize;
-    }
-
-    notifier_list_init(&xendev->event_notifiers);
-    qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), xen_device_event, NULL,
-                        xendev);
-
     xen_device_backend_create(xendev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 3183f10e3c..3315f0de20 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -15,6 +15,7 @@
 typedef void (*XenWatchHandler)(void *opaque);
 
 typedef struct XenWatch XenWatch;
+typedef struct XenEventChannel XenEventChannel;
 
 typedef struct XenDevice {
     DeviceState qdev;
@@ -28,8 +29,7 @@ typedef struct XenDevice {
     XenWatch *backend_online_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
-    xenevtchn_handle *xeh;
-    NotifierList event_notifiers;
+    QLIST_HEAD(, XenEventChannel) event_channels;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -119,8 +119,6 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
                                 XenDeviceGrantCopySegment segs[],
                                 unsigned int nr_segs, Error **errp);
 
-typedef struct XenEventChannel XenEventChannel;
-
 typedef void (*XenEventHandler)(void *opaque);
 
 XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
-- 
2.20.1.2.gb21ebb6

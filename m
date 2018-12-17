Received: from eggs.gnu.org ([2001:4830:134:3::10]:52842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYrGc-00048r-QX
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 06:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8828e3297=Paul.Durrant@citrix.com>)
	id 1gYrGa-0006ZT-3x
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 06:40:58 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Mon, 17 Dec 2018 11:40:37 +0000
Message-ID: <1545046848-14891-8-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1545046848-14891-1-git-send-email-paul.durrant@citrix.com>
References: <1545046848-14891-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 07/18] xen: add event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

The legacy PV backend infrastructure provides functions to bind, unbind
and send notifications to event channnels. Similar functionality will be
required by XenDevice implementations so this patch adds the necessary
support.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - Added error pointers to notify and unbind
---
 hw/xen/xen-bus.c         | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-bus.h |  18 +++++++++
 2 files changed, 119 insertions(+)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index faa9fd3..9443f27 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -617,6 +617,81 @@ done:
     g_free(xengnttab_segs);
 }
 
+struct XenEventChannel {
+    unsigned int local_port;
+    XenEventHandler handler;
+    void *opaque;
+    Notifier notifier;
+};
+
+static void event_notify(Notifier *n, void *data)
+{
+    XenEventChannel *channel = container_of(n, XenEventChannel, notifier);
+    unsigned long port = (unsigned long)data;
+
+    if (port == channel->local_port) {
+        channel->handler(channel->opaque);
+    }
+}
+
+XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
+                                               unsigned int port,
+                                               XenEventHandler handler,
+                                               void *opaque, Error **errp)
+{
+    XenEventChannel *channel = g_new0(XenEventChannel, 1);
+
+    channel->local_port = xenevtchn_bind_interdomain(xendev->xeh,
+                                                     xendev->frontend_id,
+                                                     port);
+    if (xendev->local_port < 0) {
+        error_setg_errno(errp, errno, "xenevtchn_bind_interdomain failed");
+
+        g_free(channel);
+        return NULL;
+    }
+
+    channel->handler = handler;
+    channel->opaque = opaque;
+    channel->notifier.notify = event_notify;
+
+    notifier_list_add(&xendev->event_notifiers, &channel->notifier);
+
+    return channel;
+}
+
+void xen_device_notify_event_channel(XenDevice *xendev,
+                                     XenEventChannel *channel,
+                                     Error **errp)
+{
+    if (!channel) {
+        error_setg(errp, "bad channel");
+        return;
+    }
+
+    if (xenevtchn_notify(xendev->xeh, channel->local_port) < 0) {
+        error_setg_errno(errp, errno, "xenevtchn_notify failed");
+    }
+}
+
+void xen_device_unbind_event_channel(XenDevice *xendev,
+                                     XenEventChannel *channel,
+                                     Error **errp)
+{
+    if (!channel) {
+        error_setg(errp, "bad channel");
+        return;
+    }
+
+    notifier_remove(&channel->notifier);
+
+    if (xenevtchn_unbind(xendev->xeh, channel->local_port) < 0) {
+        error_setg_errno(errp, errno, "xenevtchn_unbind failed");
+    }
+
+    g_free(channel);
+}
+
 static void xen_device_unrealize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -641,6 +716,12 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     xen_device_frontend_destroy(xendev);
     xen_device_backend_destroy(xendev);
 
+    if (xendev->xeh) {
+        qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), NULL, NULL, NULL);
+        xenevtchn_close(xendev->xeh);
+        xendev->xeh = NULL;
+    }
+
     if (xendev->xgth) {
         xengnttab_close(xendev->xgth);
         xendev->xgth = NULL;
@@ -657,6 +738,16 @@ static void xen_device_exit(Notifier *n, void *data)
     xen_device_unrealize(DEVICE(xendev), &error_abort);
 }
 
+static void xen_device_event(void *opaque)
+{
+    XenDevice *xendev = opaque;
+    unsigned long port = xenevtchn_pending(xendev->xeh);
+
+    notifier_list_notify(&xendev->event_notifiers, (void *)port);
+
+    xenevtchn_unmask(xendev->xeh, port);
+}
+
 static void xen_device_realize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -697,6 +788,16 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xendev->feature_grant_copy =
         (xengnttab_grant_copy(xendev->xgth, 0, NULL) == 0);
 
+    xendev->xeh = xenevtchn_open(NULL, 0);
+    if (!xendev->xeh) {
+        error_setg_errno(errp, errno, "failed xenevtchn_open");
+        goto unrealize;
+    }
+
+    notifier_list_init(&xendev->event_notifiers);
+    qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), xen_device_event, NULL,
+                        xendev);
+
     xen_device_backend_create(xendev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 63a09b6..f83a95c 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -26,6 +26,9 @@ typedef struct XenDevice {
     XenWatch *frontend_state_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
+    xenevtchn_handle *xeh;
+    xenevtchn_port_or_error_t local_port;
+    NotifierList event_notifiers;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -104,4 +107,19 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
                                 XenDeviceGrantCopySegment segs[],
                                 unsigned int nr_segs, Error **errp);
 
+typedef struct XenEventChannel XenEventChannel;
+
+typedef void (*XenEventHandler)(void *opaque);
+
+XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
+                                               unsigned int port,
+                                               XenEventHandler handler,
+                                               void *opaque, Error **errp);
+void xen_device_notify_event_channel(XenDevice *xendev,
+                                     XenEventChannel *channel,
+                                     Error **errp);
+void xen_device_unbind_event_channel(XenDevice *xendev,
+                                     XenEventChannel *channel,
+                                     Error **errp);
+
 #endif /* HW_XEN_BUS_H */
-- 
2.1.4

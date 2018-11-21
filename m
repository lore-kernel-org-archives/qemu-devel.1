Received: from eggs.gnu.org ([2001:4830:134:3::10]:46104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB3-0005Ss-CK
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=856356900=Paul.Durrant@citrix.com>)
	id 1gPUB1-0003fO-VM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 10:12:29 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Wed, 21 Nov 2018 15:12:00 +0000
Message-ID: <20181121151211.15997-8-paul.durrant@citrix.com>
In-Reply-To: <20181121151211.15997-1-paul.durrant@citrix.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 07/18] xen: add event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

The legacy PV backend infrastructure provides functions to bind, unbind
and send notifications to event channnels. Similar functionality will be
required by XenDevice implementations so this patch adds the necessary
support.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/xen/xen-bus.c         | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-bus.h | 16 +++++++++
 2 files changed, 100 insertions(+)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 7a152d2a2f..64c8af54b0 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -579,6 +579,65 @@ done:
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
+                                     XenEventChannel *channel)
+{
+    xenevtchn_notify(xendev->xeh, channel->local_port);
+}
+
+void xen_device_unbind_event_channel(XenDevice *xendev,
+                                     XenEventChannel *channel)
+{
+    notifier_remove(&channel->notifier);
+
+    xenevtchn_unbind(xendev->xeh, channel->local_port);
+
+    g_free(channel);
+}
+
 static void xen_device_unrealize(DeviceState *dev, Error **errp)
 {
     XenDevice *xendev = XEN_DEVICE(dev);
@@ -602,6 +661,11 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
     xen_device_frontend_destroy(xendev);
     xen_device_backend_destroy(xendev);
 
+    if (xendev->xeh) {
+        qemu_set_fd_handler(xenevtchn_fd(xendev->xeh), NULL, NULL, NULL);
+        xenevtchn_close(xendev->xeh);
+    }
+
     if (xendev->xgth) {
         xengnttab_close(xendev->xgth);
     }
@@ -616,6 +680,16 @@ static void xen_device_exit(Notifier *n, void *data)
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
@@ -656,6 +730,16 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
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
index db14d49027..386f6bfc93 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -24,6 +24,9 @@ typedef struct XenDevice {
     XenWatch *frontend_state_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
+    xenevtchn_handle *xeh;
+    xenevtchn_port_or_error_t local_port;
+    NotifierList event_notifiers;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -102,4 +105,17 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
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
+                                     XenEventChannel *channel);
+void xen_device_unbind_event_channel(XenDevice *xendev,
+                                     XenEventChannel *channel);
+
 #endif /* HW_XEN_BUS_H */
-- 
2.11.0

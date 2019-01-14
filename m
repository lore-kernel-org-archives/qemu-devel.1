Received: from eggs.gnu.org ([209.51.188.92]:45938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2in-0004hh-DB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2fY-0002eS-7W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:52:49 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:65464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=9106bec1f=anthony.perard@citrix.com>)
	id 1gj2fX-0002cK-Sl
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:52:48 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Mon, 14 Jan 2019 13:51:38 +0000
Message-ID: <20190114135154.16826-10-anthony.perard@citrix.com>
In-Reply-To: <20190114135154.16826-1-anthony.perard@citrix.com>
References: <20190114135154.16826-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 09/25] xen: add event channel interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

The legacy PV backend infrastructure provides functions to bind, unbind
and send notifications to event channnels. Similar functionality will be
required by XenDevice implementations so this patch adds the necessary
support.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Patch squashed with:

Patch "xen: add event channel interface for XenDevice-s" makes use of
the type xenevtchn_port_or_error_t, but this isn't avaiable before Xen
4.7. Also the function xen_device_bind_event_channel assign the return
value of xenevtchn_bind_interdomain to channel->local_port but check the
result for error with xendev->local_port.

Fix by:
- removing local_port from struct XenDevice as it isn't use anywere.
- adding a compatibility typedef for xenevtchn_port_or_error_t for Xen
  4.6 and earlier.

As extra, replace the type of XenEventChannel->local_port by
evtchn_port_t.

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul.durrant@citrix.com>
---
 hw/xen/xen-bus.c            | 103 ++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen-bus.h    |  17 ++++++
 include/hw/xen/xen_common.h |   1 +
 3 files changed, 121 insertions(+)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index faa9fd3577..14881126ff 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -617,6 +617,83 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
     g_free(xengnttab_segs);
 }
 
+struct XenEventChannel {
+    evtchn_port_t local_port;
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
+    xenevtchn_port_or_error_t local_port;
+
+    local_port = xenevtchn_bind_interdomain(xendev->xeh,
+                                            xendev->frontend_id,
+                                            port);
+    if (local_port < 0) {
+        error_setg_errno(errp, errno, "xenevtchn_bind_interdomain failed");
+
+        g_free(channel);
+        return NULL;
+    }
+
+    channel->local_port = local_port;
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
@@ -641,6 +718,12 @@ static void xen_device_unrealize(DeviceState *dev, Error **errp)
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
@@ -657,6 +740,16 @@ static void xen_device_exit(Notifier *n, void *data)
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
@@ -697,6 +790,16 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
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
index 63a09b67ee..b554559e5b 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -26,6 +26,8 @@ typedef struct XenDevice {
     XenWatch *frontend_state_watch;
     xengnttab_handle *xgth;
     bool feature_grant_copy;
+    xenevtchn_handle *xeh;
+    NotifierList event_notifiers;
 } XenDevice;
 
 typedef char *(*XenDeviceGetName)(XenDevice *xendev, Error **errp);
@@ -104,4 +106,19 @@ void xen_device_copy_grant_refs(XenDevice *xendev, bool to_domain,
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
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 93f631e5bf..9c3ac07d78 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -32,6 +32,7 @@ extern xc_interface *xen_xc;
 typedef xc_interface xenforeignmemory_handle;
 typedef xc_evtchn xenevtchn_handle;
 typedef xc_gnttab xengnttab_handle;
+typedef evtchn_port_or_error_t xenevtchn_port_or_error_t;
 
 #define xenevtchn_open(l, f) xc_evtchn_open(l, f);
 #define xenevtchn_close(h) xc_evtchn_close(h)
-- 
Anthony PERARD

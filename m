Received: from eggs.gnu.org ([2001:4830:134:3::10]:40564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDw-0004pQ-R7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQIDv-0008GU-Oe
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQIDv-0008GF-H8
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:01:59 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Jun 2017 20:00:31 +0100
Message-Id: <20170628190047.26159-14-dgilbert@redhat.com>
In-Reply-To: <20170628190047.26159-1-dgilbert@redhat.com>
References: <20170628190047.26159-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC 13/29] vhost+postcopy: Transmit 'listen' to client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Notify the vhost-user client on reception of the 'postcopy-listen'
event from the source.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 16 ++++++++++++++++
 contrib/libvhost-user/libvhost-user.h |  2 ++
 hw/virtio/trace-events                |  3 +++
 hw/virtio/vhost-user.c                | 23 +++++++++++++++++++++++
 migration/postcopy-ram.h              |  1 +
 migration/savevm.c                    |  7 +++++++
 6 files changed, 52 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 62e97f6b84..6de339fb7a 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -15,7 +15,9 @@
 
 #include <qemu/osdep.h>
 #include <sys/eventfd.h>
+#include <sys/ioctl.h>
 #include <sys/syscall.h>
+#include <linux/userfaultfd.h>
 #include <linux/vhost.h>
 
 #include "qemu/atomic.h"
@@ -65,6 +67,7 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_SEND_RARP),
         REQ(VHOST_USER_INPUT_GET_CONFIG),
         REQ(VHOST_USER_POSTCOPY_ADVISE),
+        REQ(VHOST_USER_POSTCOPY_LISTEN),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -801,6 +804,17 @@ vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
+vu_set_postcopy_listen(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (dev->nregions) {
+        vu_panic(dev, "Regions already registered at postcopy-listen");
+        return false;
+    }
+    dev->postcopy_listening = true;
+
+    return false;
+}
+static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
     int do_reply = 0;
@@ -865,6 +879,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_vring_enable_exec(dev, vmsg);
     case VHOST_USER_POSTCOPY_ADVISE:
         return vu_set_postcopy_advise(dev, vmsg);
+    case VHOST_USER_POSTCOPY_LISTEN:
+        return vu_set_postcopy_listen(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 3e65a962da..86e1934ddb 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -64,6 +64,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SEND_RARP = 19,
     VHOST_USER_INPUT_GET_CONFIG = 20,
     VHOST_USER_POSTCOPY_ADVISE  = 23,
+    VHOST_USER_POSTCOPY_LISTEN  = 24,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -234,6 +235,7 @@ struct VuDev {
 
     /* Postcopy data */
     int postcopy_ufd;
+    bool postcopy_listening;
 };
 
 typedef struct VuVirtqElement {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e24d8fa997..1076dbbb1d 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,5 +1,8 @@
 # See docs/tracing.txt for syntax documentation.
 
+# hw/virtio/vhost-user.c
+vhost_user_postcopy_listen(void) ""
+
 # hw/virtio/virtio.c
 virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
 virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "vq %p elem %p len %u idx %u"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b98fbe4834..1f70f5760f 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -67,6 +67,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_POSTCOPY_ADVISE  = 23,
+    VHOST_USER_POSTCOPY_LISTEN  = 24,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -771,6 +772,25 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+/*
+ * Called at the switch to postcopy on reception of the 'listen' command.
+ */
+static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **errp)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_POSTCOPY_LISTEN,
+        .flags = VHOST_USER_VERSION,
+    };
+
+    trace_vhost_user_postcopy_listen();
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_setg(errp, "Failed to send postcopy_listen to vhost");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
                                         void *opaque)
 {
@@ -793,6 +813,9 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     case POSTCOPY_NOTIFY_INBOUND_ADVISE:
         return vhost_user_postcopy_advise(dev, pnd->errp);
 
+    case POSTCOPY_NOTIFY_INBOUND_LISTEN:
+        return vhost_user_postcopy_listen(dev, pnd->errp);
+
     default:
         /* We ignore notifications we don't know */
         break;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 28c216cc7a..873c147b68 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -129,6 +129,7 @@ void postcopy_infrastructure_init(void);
 enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE = 0,
     POSTCOPY_NOTIFY_INBOUND_ADVISE,
+    POSTCOPY_NOTIFY_INBOUND_LISTEN,
 };
 
 struct PostcopyNotifyData {
diff --git a/migration/savevm.c b/migration/savevm.c
index 4977baf9b7..4b6294b7d4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1579,6 +1579,8 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
     trace_loadvm_postcopy_handle_listen();
+    Error *local_err = NULL;
+
     if (ps != POSTCOPY_INCOMING_ADVISE && ps != POSTCOPY_INCOMING_DISCARD) {
         error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
         return -1;
@@ -1600,6 +1602,11 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
     if (mis->have_listen_thread) {
         error_report("CMD_POSTCOPY_RAM_LISTEN already has a listen thread");
         return -1;
-- 
2.13.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxnk-0002FN-0e
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxng-0004YJ-Rx
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxng-0004Xl-J1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:28:20 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:07 +0100
Message-Id: <20170824192730.8440-10-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 09/32] vhost-user: Add
 'VHOST_USER_POSTCOPY_ADVISE' message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wire up a notifier to send a VHOST_USER_POSTCOPY_ADVISE
message on an incoming advise.

Later patches will fill in the behaviour/contents of the
message.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 21 ++++++++++++---
 contrib/libvhost-user/libvhost-user.h |  6 ++++-
 docs/interop/vhost-user.txt           |  9 +++++++
 hw/virtio/vhost-user.c                | 48 +++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.h              |  1 +
 migration/savevm.c                    |  6 +++++
 6 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 201b9846e9..8bbdf5fb40 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -42,9 +42,6 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_NONE),
         REQ(VHOST_USER_GET_FEATURES),
         REQ(VHOST_USER_SET_FEATURES),
-        REQ(VHOST_USER_NONE),
-        REQ(VHOST_USER_GET_FEATURES),
-        REQ(VHOST_USER_SET_FEATURES),
         REQ(VHOST_USER_SET_OWNER),
         REQ(VHOST_USER_RESET_OWNER),
         REQ(VHOST_USER_SET_MEM_TABLE),
@@ -62,7 +59,10 @@ vu_request_to_string(int req)
         REQ(VHOST_USER_GET_QUEUE_NUM),
         REQ(VHOST_USER_SET_VRING_ENABLE),
         REQ(VHOST_USER_SEND_RARP),
-        REQ(VHOST_USER_INPUT_GET_CONFIG),
+        REQ(VHOST_USER_SET_SLAVE_REQ_FD),
+        REQ(VHOST_USER_IOTLB_MSG),
+        REQ(VHOST_USER_SET_VRING_ENDIAN),
+        REQ(VHOST_USER_POSTCOPY_ADVISE),
         REQ(VHOST_USER_MAX),
     };
 #undef REQ
@@ -744,6 +744,17 @@ vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
+vu_set_postcopy_advise(VuDev *dev, VhostUserMsg *vmsg)
+{
+    /* TODO: Open ufd, pass it back in the request
+     * TODO: Add addresses 
+     */
+    vmsg->payload.u64 = 0xcafe;
+    vmsg->size = sizeof(vmsg->payload.u64);
+    return true; /* = send a reply */
+}
+
+static bool
 vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
 {
     int do_reply = 0;
@@ -808,6 +819,8 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
         return vu_set_vring_enable_exec(dev, vmsg);
     case VHOST_USER_NONE:
         break;
+    case VHOST_USER_POSTCOPY_ADVISE:
+        return vu_set_postcopy_advise(dev, vmsg);
     default:
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Unhandled request: %d", vmsg->request);
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 95d0d34a28..3987ce643d 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -62,7 +62,11 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_QUEUE_NUM = 17,
     VHOST_USER_SET_VRING_ENABLE = 18,
     VHOST_USER_SEND_RARP = 19,
-    VHOST_USER_INPUT_GET_CONFIG = 20,
+    VHOST_USER_NET_SET_MTU      = 20,
+    VHOST_USER_SET_SLAVE_REQ_FD = 21,
+    VHOST_USER_IOTLB_MSG        = 22,
+    VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_POSTCOPY_ADVISE  = 24,
     VHOST_USER_MAX
 } VhostUserRequest;
 
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index a279560eb0..dad2a1b343 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -606,6 +606,15 @@ Master message types
       and expect this message once (per VQ) during device configuration
       (ie. before the master starts the VQ).
 
+ * VHOST_USER_POSTCOPY_ADVISE
+      Id: 24
+      Master payload: N/A
+      Slave payload: userfault fd + u64
+
+      Master advises slave that a migration with postcopy enabled is underway,
+      the slave must open a userfaultfd for later use.
+      Note that at this stage the migration is still in precopy mode.
+
 Slave message types
 -------------------
 
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c51bbd1296..7063e4df61 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -67,6 +67,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_SET_SLAVE_REQ_FD = 21,
     VHOST_USER_IOTLB_MSG = 22,
     VHOST_USER_SET_VRING_ENDIAN = 23,
+    VHOST_USER_POSTCOPY_ADVISE  = 24,
     VHOST_USER_MAX
 } VhostUserRequest;
 
@@ -724,6 +725,50 @@ out:
     return ret;
 }
 
+/*
+ * Called at the start of an inbound postcopy on reception of the
+ * 'advise' command.
+ */
+static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
+{
+    struct vhost_user *u = dev->opaque;
+    CharBackend *chr = u->chr;
+    int ufd;
+    VhostUserMsg msg = {
+        .request = VHOST_USER_POSTCOPY_ADVISE,
+        .flags = VHOST_USER_VERSION,
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_setg(errp, "Failed to send postcopy_advise to vhost");
+        return -1;
+    }
+
+    if (vhost_user_read(dev, &msg) < 0) {
+        error_setg(errp, "Failed to get postcopy_advise reply from vhost");
+        return -1;
+    }
+
+    if (msg.request != VHOST_USER_POSTCOPY_ADVISE) {
+        error_setg(errp, "Unexpected msg type. Expected %d received %d",
+                     VHOST_USER_POSTCOPY_ADVISE, msg.request);
+        return -1;
+    }
+
+    if (msg.size != sizeof(msg.payload.u64)) {
+        error_setg(errp, "Received bad msg size.");
+        return -1;
+    }
+    ufd = qemu_chr_fe_get_msgfd(chr);
+    if (ufd < 0) {
+        error_setg(errp, "%s: Failed to get ufd", __func__);
+        return -1;
+    }
+
+    /* TODO: register ufd with userfault thread */
+    return 0;
+}
+
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
                                         void *opaque)
 {
@@ -743,6 +788,9 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
         }
         break;
 
+    case POSTCOPY_NOTIFY_INBOUND_ADVISE:
+        return vhost_user_postcopy_advise(dev, pnd->errp);
+
     default:
         /* We ignore notifications we don't know */
         break;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index d688411674..70d4b09659 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -128,6 +128,7 @@ void postcopy_infrastructure_init(void);
  */
 enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE = 0,
+    POSTCOPY_NOTIFY_INBOUND_ADVISE,
 };
 
 struct PostcopyNotifyData {
diff --git a/migration/savevm.c b/migration/savevm.c
index fdd15fa0a7..d35911731d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1343,6 +1343,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
+    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_advise();
     if (ps != POSTCOPY_INCOMING_NONE) {
@@ -1390,6 +1391,11 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+
     if (ram_postcopy_incoming_init(mis)) {
         return -1;
     }
-- 
2.13.5

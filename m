Received: from eggs.gnu.org ([2001:4830:134:3::10]:52885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxp3-0003Uh-4Z
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkxp1-0005Xu-4o
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkxp0-0005XM-SX
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:29:43 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 24 Aug 2017 20:27:25 +0100
Message-Id: <20170824192730.8440-28-dgilbert@redhat.com>
In-Reply-To: <20170824192730.8440-1-dgilbert@redhat.com>
References: <20170824192730.8440-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [RFC v2 27/32] vhost+postcopy: Wire up POSTCOPY_END
 notify
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

Wire up a call to VHOST_USER_POSTCOPY_END message to the vhost clients
right before we ask the listener thread to shutdown.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events   |  2 ++
 hw/virtio/vhost-user.c   | 30 ++++++++++++++++++++++++++++++
 migration/postcopy-ram.c |  5 +++++
 migration/postcopy-ram.h |  1 +
 4 files changed, 38 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 065822c70a..5b599617a1 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,8 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/virtio/vhost-user.c
+vhost_user_postcopy_end_entry(void) ""
+vhost_user_postcopy_end_exit(void) ""
 vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int nregions) "%s: @0x%"PRIx64" nregions:%d"
 vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
 vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c2e55be0fd..d4461459fe 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -965,6 +965,33 @@ static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+/*
+ * Called at the end of postcopy
+ */
+static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
+{
+    VhostUserMsg msg = {
+        .request = VHOST_USER_POSTCOPY_END,
+        .flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+    };
+    int ret;
+
+    trace_vhost_user_postcopy_end_entry();
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        error_setg(errp, "Failed to send postcopy_end to vhost");
+        return -1;
+    }
+
+    ret = process_message_reply(dev, &msg);
+    if (ret) {
+        error_setg(errp, "Failed to receive reply to postcopy_end");
+        return ret;
+    }
+    trace_vhost_user_postcopy_end_exit();
+
+    return 0;
+}
+
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
                                         void *opaque)
 {
@@ -990,6 +1017,9 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     case POSTCOPY_NOTIFY_INBOUND_LISTEN:
         return vhost_user_postcopy_listen(dev, pnd->errp);
 
+    case POSTCOPY_NOTIFY_INBOUND_END:
+        return vhost_user_postcopy_end(dev, pnd->errp);
+
     default:
         /* We ignore notifications we don't know */
         break;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7d0786ff04..28791cf1f1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -337,7 +337,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
 
     if (mis->have_fault_thread) {
         uint64_t tmp64;
+        Error *local_err = NULL;
 
+        if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
         if (qemu_ram_foreach_block(cleanup_range, mis)) {
             return -1;
         }
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ecf731c689..d0dc838001 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -130,6 +130,7 @@ enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE = 0,
     POSTCOPY_NOTIFY_INBOUND_ADVISE,
     POSTCOPY_NOTIFY_INBOUND_LISTEN,
+    POSTCOPY_NOTIFY_INBOUND_END,
 };
 
 struct PostcopyNotifyData {
-- 
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gi-0003a3-6F
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eu1gh-0006QM-5q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41484 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eu1gg-0006PY-VZ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:58:51 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 666098182D24
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 19:58:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  8 Mar 2018 19:58:07 +0000
Message-Id: <20180308195811.24894-26-dgilbert@redhat.com>
In-Reply-To: <20180308195811.24894-1-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 25/29] vhost+postcopy: Wire up POSTCOPY_END
 notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wire up a call to VHOST_USER_POSTCOPY_END message to the vhost clients
right before we ask the listener thread to shutdown.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/trace-events   |  2 ++
 hw/virtio/vhost-user.c   | 34 ++++++++++++++++++++++++++++++++++
 migration/postcopy-ram.c |  7 +++++++
 migration/postcopy-ram.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index fe5e0ff856..857c495e65 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -7,6 +7,8 @@ vhost_region_add_section_abut(const char *name, uint64_t new_size) "%s: 0x%"PRIx
 vhost_section(const char *name, int r) "%s:%d"
 
 # hw/virtio/vhost-user.c
+vhost_user_postcopy_end_entry(void) ""
+vhost_user_postcopy_end_exit(void) ""
 vhost_user_postcopy_fault_handler(const char *name, uint64_t fault_address, int nregions) "%s: @0x%"PRIx64" nregions:%d"
 vhost_user_postcopy_fault_handler_loop(int i, uint64_t client_base, uint64_t size) "%d: client 0x%"PRIx64" +0x%"PRIx64
 vhost_user_postcopy_fault_handler_found(int i, uint64_t region_offset, uint64_t rb_offset) "%d: region_offset: 0x%"PRIx64" rb_offset:0x%"PRIx64
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 45de6d8a53..eb7d753b1a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1114,6 +1114,37 @@ static int vhost_user_postcopy_listen(struct vhost_dev *dev, Error **errp)
     return 0;
 }
 
+/*
+ * Called at the end of postcopy
+ */
+static int vhost_user_postcopy_end(struct vhost_dev *dev, Error **errp)
+{
+    VhostUserMsg msg = {
+        .hdr.request = VHOST_USER_POSTCOPY_END,
+        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
+    };
+    int ret;
+    struct vhost_user *u = dev->opaque;
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
+    postcopy_unregister_shared_ufd(&u->postcopy_fd);
+    u->postcopy_fd.handler = NULL;
+
+    trace_vhost_user_postcopy_end_exit();
+
+    return 0;
+}
+
 static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
                                         void *opaque)
 {
@@ -1139,6 +1170,9 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     case POSTCOPY_NOTIFY_INBOUND_LISTEN:
         return vhost_user_postcopy_listen(dev, pnd->errp);
 
+    case POSTCOPY_NOTIFY_INBOUND_END:
+        return vhost_user_postcopy_end(dev, pnd->errp);
+
     default:
         /* We ignore notifications we don't know */
         break;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 36db900e8f..1379923cfc 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -413,6 +413,13 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     trace_postcopy_ram_incoming_cleanup_entry();
 
     if (mis->have_fault_thread) {
+        Error *local_err = NULL;
+
+        if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
+
         if (qemu_ram_foreach_block(cleanup_range, mis)) {
             return -1;
         }
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index fef7448e4b..1d11276c94 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -132,6 +132,7 @@ enum PostcopyNotifyReason {
     POSTCOPY_NOTIFY_PROBE = 0,
     POSTCOPY_NOTIFY_INBOUND_ADVISE,
     POSTCOPY_NOTIFY_INBOUND_LISTEN,
+    POSTCOPY_NOTIFY_INBOUND_END,
 };
 
 struct PostcopyNotifyData {
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DD-0007OR-Gi
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DB-000799-3b
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DA-000791-U8
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 257531E57
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:16 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xM027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:15 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:44 +0100
Message-Id: <20161222152300.32395-10-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/25] virtio-scsi: introduce
 virtio_scsi_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

These will be used more as soon as the acquire/release is pushed down to
the ioeventfd handlers.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 10fd687..34bba35 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -420,6 +420,20 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
     }
 }
 
+static inline void virtio_scsi_acquire(VirtIOSCSI *s)
+{
+    if (s->ctx) {
+        aio_context_acquire(s->ctx);
+    }
+}
+
+static inline void virtio_scsi_release(VirtIOSCSI *s)
+{
+    if (s->ctx) {
+        aio_context_release(s->ctx);
+    }
+}
+
 void virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
@@ -691,10 +705,7 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
         return;
     }
 
-    if (s->dataplane_started) {
-        assert(s->ctx);
-        aio_context_acquire(s->ctx);
-    }
+    virtio_scsi_acquire(s);
 
     req = virtio_scsi_pop_req(s, vs->event_vq);
     if (!req) {
@@ -730,9 +741,7 @@ void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
     }
     virtio_scsi_complete_req(req);
 out:
-    if (s->dataplane_started) {
-        aio_context_release(s->ctx);
-    }
+    virtio_scsi_release(s);
 }
 
 void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
@@ -778,9 +787,9 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         if (blk_op_is_blocked(sd->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
             return;
         }
-        aio_context_acquire(s->ctx);
+        virtio_scsi_acquire(s);
         blk_set_aio_context(sd->conf.blk, s->ctx);
-        aio_context_release(s->ctx);
+        virtio_scsi_release(s);
 
     }
 
-- 
2.9.3

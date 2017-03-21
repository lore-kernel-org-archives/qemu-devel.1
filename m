Received: from eggs.gnu.org ([2001:4830:134:3::10]:40715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAKR-0003Bh-SR
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAKO-0001Kb-P1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:19:23 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:30 +0800
Message-Id: <20170321031635.22123-12-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 11/16] virtio-blk: Request
 BLK_PERM_AIO_CONTEXT_CHANGE for dataplane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

blk_set_aio_context is audited by perm API, so follow the protocol and
request for permission first.

Previously the return code in error path is hardcoded as -EPERM, but
returning 'r' is more meaningful here both for the new error and
existing errors.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e..8f2ff2df 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -168,6 +168,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     unsigned i;
     unsigned nvqs = s->conf->num_queues;
     int r;
+    Error *local_err = NULL;
 
     if (vblk->dataplane_started || s->starting) {
         return 0;
@@ -175,12 +176,18 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
 
     s->starting = true;
 
+    r = blk_request_perm(s->conf->conf.blk, BLK_PERM_AIO_CONTEXT_CHANGE,
+                         &local_err);
+    if (r) {
+        error_report_err(local_err);
+        goto fail;
+    }
     /* Set up guest notifier (irq) */
     r = k->set_guest_notifiers(qbus->parent, nvqs, true);
     if (r != 0) {
         fprintf(stderr, "virtio-blk failed to set guest notifier (%d), "
                 "ensure -enable-kvm is set\n", r);
-        goto fail_guest_notifiers;
+        goto fail;
     }
 
     /* Set up virtqueue notify */
@@ -191,7 +198,7 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
             while (i--) {
                 virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
             }
-            goto fail_guest_notifiers;
+            goto fail;
         }
     }
 
@@ -219,11 +226,11 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     aio_context_release(s->ctx);
     return 0;
 
-  fail_guest_notifiers:
+fail:
     vblk->dataplane_disabled = true;
     s->starting = false;
     vblk->dataplane_started = true;
-    return -ENOSYS;
+    return r;
 }
 
 /* Context: QEMU global mutex held */
-- 
2.9.3

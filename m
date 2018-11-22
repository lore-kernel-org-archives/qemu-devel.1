Received: from eggs.gnu.org ([2001:4830:134:3::10]:36944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPph2-00079r-9q
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPph0-0000fO-6S
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:10:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPpgz-0000bM-WC
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:10:54 -0500
From: wexu@redhat.com
Date: Thu, 22 Nov 2018 09:06:17 -0500
Message-Id: <1542895581-10721-13-git-send-email-wexu@redhat.com>
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v1 12/16] virtio: add userspace migration of
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 240c4e3..64d5c04 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2558,6 +2558,12 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
          */
         qemu_put_be64(f, vdev->vq[i].vring.desc);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
+        qemu_put_8s(f, (const uint8_t *)&vdev->vq[i].avail_wrap_counter);
+        qemu_put_8s(f, (const uint8_t *)&vdev->vq[i].event_wrap_counter);
+        qemu_put_8s(f, (const uint8_t *)&vdev->vq[i].used_wrap_counter);
+        qemu_put_be16s(f, &vdev->vq[i].used_idx);
+        qemu_put_be16s(f, &vdev->vq[i].shadow_avail_idx);
+        qemu_put_be32s(f, &vdev->vq[i].inuse);
         if (k->save_queue) {
             k->save_queue(qbus->parent, i, f);
         }
@@ -2705,6 +2711,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         }
         vdev->vq[i].vring.desc = qemu_get_be64(f);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
+
+        qemu_get_8s(f, (uint8_t *)&vdev->vq[i].avail_wrap_counter);
+        qemu_get_8s(f, (uint8_t *)&vdev->vq[i].event_wrap_counter);
+        qemu_get_8s(f, (uint8_t *)&vdev->vq[i].used_wrap_counter);
+        qemu_get_be16s(f, &vdev->vq[i].used_idx);
+        qemu_get_be16s(f, &vdev->vq[i].shadow_avail_idx);
+        qemu_get_be32s(f, &vdev->vq[i].inuse);
+
         vdev->vq[i].signalled_used_valid = false;
         vdev->vq[i].notification = true;
 
@@ -2786,6 +2800,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
                 virtio_queue_update_rings(vdev, i);
             }
 
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+                continue;
+            }
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgZvD-0002zL-46
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgZvC-000550-8V
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgZvB-00054n-Vq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 11:37:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 22 Feb 2017 16:37:34 +0000
Message-Id: <20170222163734.13104-3-stefanha@redhat.com>
In-Reply-To: <20170222163734.13104-1-stefanha@redhat.com>
References: <20170222163734.13104-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio: add missing region cache init
 in virtio_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Commit 97cd965c070152bc626c7507df9fb356bbe1cd81 ("virtio: use
VRingMemoryRegionCaches for avail and used rings") switched to a memory
region cache to avoid repeated map/unmap operations.

The virtio_load() process is a little tricky because vring addresses are
serialized in two separate places.  VIRTIO 1.0 devices serialize desc
and then a subsection with used and avail.  Legacy devices only
serialize desc.

Live migration of VIRTIO 1.0 devices fails on the destination host with:

  VQ 0 size 0x80 < last_avail_idx 0x12f8 - used_idx 0x0
  Failed to load virtio-blk:virtio
  error while loading state for instance 0x0 of device '0000:00:04.0/virtio-blk'

This happens because the memory region cache is only initialized after
desc is loaded and not after the used and avail subsection is loaded.
If the guest chose memory addresses that don't match the legacy ring
layout then the wrong guest memory location is accessed.

Wait until all ring addresses are known before trying to initialize the
region cache.  Also clarify the incomplete comment about VIRTIO-1 ring
address subsection.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index da5c6fe..f3bbf38 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1853,7 +1853,10 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         if (k->has_variable_vring_alignment) {
             qemu_put_be32(f, vdev->vq[i].vring.align);
         }
-        /* XXX virtio-1 devices */
+        /*
+         * Save desc now, the rest of the ring addresses are saved in
+         * subsections for VIRTIO-1 devices.
+         */
         qemu_put_be64(f, vdev->vq[i].vring.desc);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
         if (k->save_queue) {
@@ -1994,14 +1997,11 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->vq[i].signalled_used_valid = false;
         vdev->vq[i].notification = true;
 
-        if (vdev->vq[i].vring.desc) {
-            /* XXX virtio-1 devices */
-            virtio_queue_update_rings(vdev, i);
-        } else if (vdev->vq[i].last_avail_idx) {
+        if (!vdev->vq[i].vring.desc && vdev->vq[i].last_avail_idx) {
             error_report("VQ %d address 0x0 "
                          "inconsistent with Host index 0x%x",
                          i, vdev->vq[i].last_avail_idx);
-                return -1;
+            return -1;
         }
         if (k->load_queue) {
             ret = k->load_queue(qbus->parent, i, f);
@@ -2062,6 +2062,19 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
+
+            /*
+             * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
+             * only the region cache needs to be set up.  Legacy devices need
+             * to calculate used and avail ring addresses based on the desc
+             * address.
+             */
+            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+                virtio_init_region_cache(vdev, i);
+            } else {
+                virtio_queue_update_rings(vdev, i);
+            }
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
-- 
2.9.3

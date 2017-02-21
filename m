Received: from eggs.gnu.org ([2001:4830:134:3::10]:38151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgFeb-0002dr-Be
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cgFea-0007Ut-C4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cgFea-0007Ue-36
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:59:12 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 335FE4E02E
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:59:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 18:59:01 +0000
Message-Id: <20170221185901.3256-3-stefanha@redhat.com>
In-Reply-To: <20170221185901.3256-1-stefanha@redhat.com>
References: <20170221185901.3256-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio: add missing region cache init in
 virtio_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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

Clarify comments about VIRTIO 1.0 and force memory region cache
initialization at the point where all ring addresses are known.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index da5c6fe..5bbc34b 100644
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
@@ -1995,7 +1998,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->vq[i].notification = true;
 
         if (vdev->vq[i].vring.desc) {
-            /* XXX virtio-1 devices */
+            /*
+             * VIRTIO-1 devices may not have final ring addresses here.  The
+             * used and avail ring addresses are loaded in subsections later.
+             */
             virtio_queue_update_rings(vdev, i);
         } else if (vdev->vq[i].last_avail_idx) {
             error_report("VQ %d address 0x0 "
@@ -2062,6 +2068,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     for (i = 0; i < num; i++) {
         if (vdev->vq[i].vring.desc) {
             uint16_t nheads;
+
+            /* All ring addresses have been loaded now... */
+            virtio_init_region_cache(vdev, i);
+
             nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
             /* Check it isn't doing strange things with descriptor numbers. */
             if (nheads > vdev->vq[i].vring.num) {
-- 
2.9.3

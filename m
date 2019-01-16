Received: from eggs.gnu.org ([209.51.188.92]:45941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpUS-0000G7-Bs
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gjpUR-00070L-0q
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:00:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gjpUQ-0006tO-Lz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:00:34 -0500
Date: Thu, 17 Jan 2019 01:48:07 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190116174807.GB28579@wei-ubt>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
	<1542895581-10721-14-git-send-email-wexu@redhat.com>
	<5b06d5dd-9aa4-ac2d-1be4-47aed98b5dfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b06d5dd-9aa4-ac2d-1be4-47aed98b5dfd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 13/16] virtio: add vhost-net migration
 of packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, jfreimann@redhat.com, tiwei.bie@intel.com

On Wed, Nov 28, 2018 at 11:34:46AM +0100, Maxime Coquelin wrote:
> 
> 
> On 11/22/18 3:06 PM, wexu@redhat.com wrote:
> >From: Wei Xu <wexu@redhat.com>
> >
> >tweaked vhost-net code to test migration.
> >
> >@@ -1414,64 +1430,20 @@ long vhost_vring_ioctl(struct vhost_dev
> >             r = -EFAULT;
> >             break;
> >         }
> >+               vq->last_avail_idx = s.num & 0x7FFF;
> >+               /* Forget the cached index value. */
> >+               vq->avail_idx = vq->last_avail_idx;
> >+               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> >+                       vq->last_avail_wrap_counter = !!(s.num & 0x8000);
> >+                       vq->avail_wrap_counter = vq->last_avail_wrap_counter;
> >+
> >+                       vq->last_used_idx = (s.num & 0x7fFF0000) >> 16;
> >+                       vq->last_used_wrap_counter = !!(s.num & 0x80000000);
> >+               }
> >+               break;
> >+       case VHOST_GET_VRING_BASE:
> >+               s.index = idx;
> >+                s.num = vq->last_avail_idx;
> >+               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
> >+                       s.num |= vq->last_avail_wrap_counter << 15;
> >+                       s.num |= vq->last_used_idx << 16;
> >+                       s.num |= vq->last_used_wrap_counter << 31;
> >+               }
> >+               if (copy_to_user(argp, &s, sizeof(s)))
> >+                       r = -EFAULT;
> >+               break;
> >
> >Signed-off-by: Wei Xu <wexu@redhat.com>
> >---
> >  hw/virtio/virtio.c         | 35 ++++++++++++++++++++++++++++++-----
> >  include/hw/virtio/virtio.h |  4 ++--
> >  2 files changed, 32 insertions(+), 7 deletions(-)
> >
> >diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >index 64d5c04..7487d3d 100644
> >--- a/hw/virtio/virtio.c
> >+++ b/hw/virtio/virtio.c
> >@@ -2963,19 +2963,40 @@ hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
> >      }
> >  }
> >-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> >+int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> >-    return vdev->vq[n].last_avail_idx;
> >+    int idx;
> >+
> >+    if (virtio_host_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> 
> Also, I think you want to use virtio_vdev_has_feature() here instead,
> else it will set wrap counter in the case ring_packed=on in the QEMU
> command line but the feature has not been negotiated.
> 
> 
> For example, with ring_packed=on and with stock Fedora 28 kernel, which
> does not support packed ring, I get this warning with DPDK vhost user
> backend:
> 
> VHOST_CONFIG: last_used_idx (32768) and vq->used->idx (0) mismatches;
> some packets maybe resent for Tx and dropped for Rx

Thanks, will fix it.

Wei

> 
> >+        idx = vdev->vq[n].last_avail_idx;
> >+        idx |= ((int)vdev->vq[n].avail_wrap_counter) << 15;
> >+        idx |= (vdev->vq[n].used_idx) << 16;
> >+        idx |= ((int)vdev->vq[n].used_wrap_counter) << 31;
> >+    } else {
> >+        idx = (int)vdev->vq[n].last_avail_idx;
> >+    }
> >+    return idx;
> >  }
> >-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
> >+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, int idx)
> >  {
> >-    vdev->vq[n].last_avail_idx = idx;
> >-    vdev->vq[n].shadow_avail_idx = idx;
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        vdev->vq[n].last_avail_idx = idx & 0x7fff;
> >+        vdev->vq[n].avail_wrap_counter = !!(idx & 0x8000);
> >+        vdev->vq[n].used_idx = (idx & 0x7fff0000) >> 16;
> >+        vdev->vq[n].used_wrap_counter = !!(idx & 0x80000000);
> >+    } else {
> >+        vdev->vq[n].last_avail_idx = idx;
> >+        vdev->vq[n].shadow_avail_idx = idx;
> >+    }
> >  }
> >  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return;
> >+    }
> >+
> >      rcu_read_lock();
> >      if (vdev->vq[n].vring.desc) {
> >          vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
> >@@ -2986,6 +3007,10 @@ void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
> >  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
> >  {
> >+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> >+        return;
> >+    }
> >+
> >      rcu_read_lock();
> >      if (vdev->vq[n].vring.desc) {
> >          vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
> >diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >index 9c1fa07..a6fdf3f 100644
> >--- a/include/hw/virtio/virtio.h
> >+++ b/include/hw/virtio/virtio.h
> >@@ -272,8 +272,8 @@ hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
> >  hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
> >  hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
> >  hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
> >-uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
> >-void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
> >+int virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
> >+void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, int idx);
> >  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
> >  void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
> >  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
> >

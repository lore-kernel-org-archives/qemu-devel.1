Received: from eggs.gnu.org ([2001:4830:134:3::10]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJW-0001wi-4I
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJU-0002x4-Rv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJU-0002vn-Kz
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:12 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:07:55 -0400
Message-Id: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 0/8] packed ring virtio-net userspace backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com

From: Wei Xu <wexu@redhat.com>

Todo:
- address Rx slow performance
- event index interrupt suppression test

v1->v2
- sync to tiwei's v5
- reuse memory cache function with 1.0
- dropped detach patch and notification helper(04 & 05 in v1)
- guest virtio-net driver unload/reload support
- event suppression support(not tested)
- addressed feedback from v1

About guest virtio-net load/unload:
Since last_avail, avail_wrap_count, used_idx and used_wrap_count are
all 16 or bool type variables, so I turned to merge them to
'vhost_vring_state.num' in stead of introducing a new case
in handling ioctl, test has been done with a tweak in kernel side like:

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1439,10 +1439,16 @@ long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
            r = -EFAULT;
            break;
        }
-               if (s.num > 0xffff) {
-                       r = -EINVAL;
-                       break;
-               }
+               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+                       vq->avail_wrap_counter = (bool)(uint16_t)(s.num >> 16);
+                       vq->last_used_idx = (uint16_t)(s.num >> 32);
+                       vq->used_wrap_counter = (bool)(uint16_t)(s.num >> 48);
+                } else {
+                    if (s.num > 0xffff) {
+                            r = -EINVAL;
+                            break;
+                    }
+                }
        vq->last_avail_idx = s.num;
        /* Forget the cached index value. */
        vq->avail_idx = vq->last_avail_idx;
@@ -1450,8 +1456,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp)
    case VHOST_GET_VRING_BASE:
        s.index = idx;
        s.num = vq->last_avail_idx;
+               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
+                       s.num |= vq->avail_wrap_counter << 16;
+                       s.num |= vq->last_used_idx << 32;
+                       s.num |= vq->used_wrap_counter << 48;
+                }
        if (copy_to_user(argp, &s, sizeof s))
            r = -EFAULT;
+               if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
+                       s.num |= vq->avail_wrap_counter << 31;
        break;
    case VHOST_SET_VRING_ADDR:
        if (copy_from_user(&a, argp, sizeof a)) {

Wei Xu (8):
  virtio: feature bit, data structure, init for packed ring
  virtio: memory cache for packed ring
  virtio: empty check and desc read for packed ring
  virtio: get avail bytes check for packed ring
  virtio: queue pop support for packed ring
  virtio: flush/push support for packed ring
  virtio: event suppression support for packed ring
  virtio: support guest driver reload for vhost-net

 hw/net/vhost_net.c                             |   2 +
 hw/virtio/virtio.c                             | 677 +++++++++++++++++++++++--
 include/hw/virtio/virtio.h                     |   4 +-
 include/standard-headers/linux/virtio_config.h |  15 +
 4 files changed, 649 insertions(+), 49 deletions(-)

-- 
1.8.3.1

Received: from eggs.gnu.org ([209.51.188.92]:43056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1gjLeh-0001wz-NW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1gjLeg-0001uC-U6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:09:11 -0500
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:56881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1gjLeg-0001iz-8A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 05:09:10 -0500
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Tue, 15 Jan 2019 13:08:47 +0300
Message-Id: <1547546927-18006-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v1] virtio: add checks for the size of the
 indirect table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, dimastep@yandex-team.ru

The virtqueue_pop() and virtqueue_get_avail_bytes() routines can use the
INDIRECT table to get the data. It is possible to create a packet which
will lead to the assert message like:
  include/exec/memory.h:1995: void
  address_space_read_cached(MemoryRegionCache *, hwaddr, void *, int):
  Assertion `addr < cache->len && len <= cache->len - addr' failed.
  Aborted
To do it the first descriptor should have a link to the INDIRECT table
and set the size of it to 0. It doesn't look good that the guest should
be able to trigger the assert in qemu. Add additional check for the size
of the INDIRECT table, which should not be 0.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 22bd1ac..a1ff647 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -646,7 +646,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
         vring_desc_read(vdev, &desc, desc_cache, i);
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -902,7 +902,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
     desc_cache = &caches->desc;
     vring_desc_read(vdev, &desc, desc_cache, i);
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
2.7.4

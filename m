Received: from eggs.gnu.org ([2001:4830:134:3::10]:41223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTw3x-00084c-13
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTw3s-0000Fo-42
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:38:29 -0500
Date: Wed, 18 Jan 2017 21:38:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484768294-23336-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] virtio: fix up max size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Coverity reports that ARRAY_SIZE(elem->out_sg) (and all the others too)
is wrong because elem->out_sg is a pointer.

However, the check is not in the right place and the max_size argument
of virtqueue_map_iovec can be removed.  The check on in_num/out_num
should be moved to qemu_get_virtqueue_element instead, before the call
to virtqueue_alloc_element.

Cc: qemu-stable@nongnu.org
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 3724650db07057333879484c8bc7d900b5c1bf8e ("virtio: introduce virtqueue_alloc_element")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 34065c7..b15a133 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -599,23 +599,11 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
 
 static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
                                 hwaddr *addr, unsigned int *num_sg,
-                                unsigned int max_size, int is_write)
+                                int is_write)
 {
     unsigned int i;
     hwaddr len;
 
-    /* Note: this function MUST validate input, some callers
-     * are passing in num_sg values received over the network.
-     */
-    /* TODO: teach all callers that this can fail, and return failure instead
-     * of asserting here.
-     * When we do, we might be able to re-enable NDEBUG below.
-     */
-#ifdef NDEBUG
-#error building with NDEBUG is not supported
-#endif
-    assert(*num_sg <= max_size);
-
     for (i = 0; i < *num_sg; i++) {
         len = sg[i].iov_len;
         sg[i].iov_base = dma_memory_map(vdev->dma_as,
@@ -636,7 +624,6 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
 void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
 {
     virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, &elem->in_num,
-                        MIN(ARRAY_SIZE(elem->in_sg), ARRAY_SIZE(elem->in_addr)),
                         1);
     virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, &elem->out_num,
                         MIN(ARRAY_SIZE(elem->out_sg),
@@ -840,6 +827,16 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
 
     qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
 
+    /* TODO: teach all callers that this can fail, and return failure instead
+     * of asserting here.
+     * When we do, we might be able to re-enable NDEBUG below.
+     */
+#ifdef NDEBUG
+#error building with NDEBUG is not supported
+#endif
+    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
+    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
+
     elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
     elem->index = data.index;
 
-- 
MST

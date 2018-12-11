Received: from eggs.gnu.org ([2001:4830:134:3::10]:42785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOq-0007wh-Hi
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOj-0007Gv-3z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:24 +0100
Message-Id: <20181211180352.19644-3-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/30] virtio: pass argument by value for
 virtqueue_map_iovec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Dongli Zhang <dongli.zhang@oracle.com>

From: Dongli Zhang <dongli.zhang@oracle.com>

Pass num_sg by value instead of by pointer, as num_sg is never modified in
virtqueue_map_iovec().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1541139396-4727-1-git-send-email-dongli.zhang@oracle.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/virtio/virtio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5828ed14df..22bd1ac34e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -796,13 +796,13 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
 }
 
 static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
-                                hwaddr *addr, unsigned int *num_sg,
+                                hwaddr *addr, unsigned int num_sg,
                                 int is_write)
 {
     unsigned int i;
     hwaddr len;
 
-    for (i = 0; i < *num_sg; i++) {
+    for (i = 0; i < num_sg; i++) {
         len = sg[i].iov_len;
         sg[i].iov_base = dma_memory_map(vdev->dma_as,
                                         addr[i], &len, is_write ?
@@ -821,8 +821,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
 
 void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
 {
-    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, &elem->in_num, 1);
-    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, &elem->out_num, 0);
+    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, 1);
+    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num, 0);
 }
 
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
-- 
2.19.2

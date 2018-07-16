Received: from eggs.gnu.org ([2001:4830:134:3::10]:34246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7Rb-0007TE-VN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ff7RX-0003AV-FE
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ff7RX-0003AF-AU
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:37:51 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 16 Jul 2018 18:37:43 +0100
Message-Id: <20180716173743.133393-5-dgilbert@redhat.com>
In-Reply-To: <20180716173743.133393-1-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH for 3.1 4/4] virtio: qemu_get_virtqueue_element
 fail rather than assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Make it return NULL rather than assert.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/virtio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98b59..aedd390240 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1037,13 +1037,12 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
 
     qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
 
-    /* TODO: teach all callers that this can fail, and return failure instead
-     * of asserting here.
-     * This is just one thing (there are probably more) that must be
-     * fixed before we can allow NDEBUG compilation.
-     */
-    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
-    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
+    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
+        data.out_num > ARRAY_SIZE(data.out_addr)) {
+        error_report("%s: Bad index: in=%d out=%d",
+                    __func__, data.in_num, data.out_num);
+        return NULL;
+    }
 
     elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
     elem->index = data.index;
-- 
2.17.1

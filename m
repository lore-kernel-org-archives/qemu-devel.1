Received: from eggs.gnu.org ([2001:4830:134:3::10]:41294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qr-0001qT-IZ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qm-00054p-IV
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45262
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qm-00054T-AL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8pVa008175
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:39 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a87k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:39 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:39 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:17 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-54-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/81] virtio: fix up max size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

From: "Michael S. Tsirkin" <mst@redhat.com>

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
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
(cherry picked from commit 6bdc21c050a2a7b92cbbd0b2a1f8934e9b5f896f)
* dropped context dep on 8607f5c30
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e37641a..6dfc92f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -592,24 +592,12 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
 }
 
 static void virtqueue_map_iovec(struct iovec *sg, hwaddr *addr,
-                                unsigned int *num_sg, unsigned int max_size,
+                                unsigned int *num_sg,
                                 int is_write)
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
         sg[i].iov_base = cpu_physical_memory_map(addr[i], &len, is_write);
@@ -626,10 +614,8 @@ static void virtqueue_map_iovec(struct iovec *sg, hwaddr *addr,
 
 void virtqueue_map(VirtQueueElement *elem)
 {
-    virtqueue_map_iovec(elem->in_sg, elem->in_addr, &elem->in_num,
-                        VIRTQUEUE_MAX_SIZE, 1);
-    virtqueue_map_iovec(elem->out_sg, elem->out_addr, &elem->out_num,
-                        VIRTQUEUE_MAX_SIZE, 0);
+    virtqueue_map_iovec(elem->in_sg, elem->in_addr, &elem->in_num, 1);
+    virtqueue_map_iovec(elem->out_sg, elem->out_addr, &elem->out_num, 0);
 }
 
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
@@ -790,6 +776,16 @@ void *qemu_get_virtqueue_element(QEMUFile *f, size_t sz)
 
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
2.7.4

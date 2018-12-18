Received: from eggs.gnu.org ([2001:4830:134:3::10]:53203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBJ-0007Xn-H9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZCBF-0001hg-HG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:53 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZCBF-0001hN-9a
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:00:49 -0500
Received: by mail-pf1-x444.google.com with SMTP id c123so7912760pfb.0
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 02:00:49 -0800 (PST)
From: elohimes@gmail.com
Date: Tue, 18 Dec 2018 17:59:58 +0800
Message-Id: <20181218100002.11219-4-xieyongji@baidu.com>
In-Reply-To: <20181218100002.11219-1-xieyongji@baidu.com>
References: <20181218100002.11219-1-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for-4.0 3/7] libvhost-user: Introduce
 vu_queue_map_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, yury-kotov@yandex-team.ru, maxime.coquelin@redhat.com
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

From: Xie Yongji <xieyongji@baidu.com>

Introduce vu_queue_map_desc() which should be
independent with vu_queue_pop();

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 88 ++++++++++++++++-----------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index a6b46cdc03..23bd52264c 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -1853,49 +1853,20 @@ virtqueue_alloc_element(size_t sz,
     return elem;
 }
 
-void *
-vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
+static void *
+vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsigned int idx, size_t sz)
 {
-    unsigned int i, head, max, desc_len;
+    struct vring_desc *desc = vq->vring.desc;
     uint64_t desc_addr, read_len;
+    unsigned int desc_len;
+    unsigned int max = vq->vring.num;
+    unsigned int i = idx;
     VuVirtqElement *elem;
-    unsigned out_num, in_num;
+    unsigned int out_num = 0, in_num = 0;
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
     struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
-    struct vring_desc *desc;
     int rc;
 
-    if (unlikely(dev->broken) ||
-        unlikely(!vq->vring.avail)) {
-        return NULL;
-    }
-
-    if (vu_queue_empty(dev, vq)) {
-        return NULL;
-    }
-    /* Needed after virtio_queue_empty(), see comment in
-     * virtqueue_num_heads(). */
-    smp_rmb();
-
-    /* When we start there are none of either input nor output. */
-    out_num = in_num = 0;
-
-    max = vq->vring.num;
-    if (vq->inuse >= vq->vring.num) {
-        vu_panic(dev, "Virtqueue size exceeded");
-        return NULL;
-    }
-
-    if (!virtqueue_get_head(dev, vq, vq->last_avail_idx++, &head)) {
-        return NULL;
-    }
-
-    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
-        vring_set_avail_event(vq, vq->last_avail_idx);
-    }
-
-    i = head;
-    desc = vq->vring.desc;
     if (desc[i].flags & VRING_DESC_F_INDIRECT) {
         if (desc[i].len % sizeof(struct vring_desc)) {
             vu_panic(dev, "Invalid size for indirect buffer table");
@@ -1947,12 +1918,13 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
     } while (rc == VIRTQUEUE_READ_DESC_MORE);
 
     if (rc == VIRTQUEUE_READ_DESC_ERROR) {
+        vu_panic(dev, "read descriptor error");
         return NULL;
     }
 
     /* Now copy what we have collected and mapped */
     elem = virtqueue_alloc_element(sz, out_num, in_num);
-    elem->index = head;
+    elem->index = idx;
     for (i = 0; i < out_num; i++) {
         elem->out_sg[i] = iov[i];
     }
@@ -1960,6 +1932,48 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
         elem->in_sg[i] = iov[out_num + i];
     }
 
+    return elem;
+}
+
+void *
+vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
+{
+    unsigned int head;
+    VuVirtqElement *elem;
+
+    if (unlikely(dev->broken) ||
+        unlikely(!vq->vring.avail)) {
+        return NULL;
+    }
+
+    if (vu_queue_empty(dev, vq)) {
+        return NULL;
+    }
+    /*
+     * Needed after virtio_queue_empty(), see comment in
+     * virtqueue_num_heads().
+     */
+    smp_rmb();
+
+    if (vq->inuse >= vq->vring.num) {
+        vu_panic(dev, "Virtqueue size exceeded");
+        return NULL;
+    }
+
+    if (!virtqueue_get_head(dev, vq, vq->last_avail_idx++, &head)) {
+        return NULL;
+    }
+
+    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        vring_set_avail_event(vq, vq->last_avail_idx);
+    }
+
+    elem = vu_queue_map_desc(dev, vq, head, sz);
+
+    if (!elem) {
+        return NULL;
+    }
+
     vq->inuse++;
 
     return elem;
-- 
2.17.1

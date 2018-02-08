Received: from eggs.gnu.org ([2001:4830:134:3::10]:54273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZQ-0006Lg-GC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZN-0008QT-S5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejrZN-0008Q6-Md
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:17 -0500
Date: Thu, 8 Feb 2018 21:09:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-22-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 21/26] libvhost-user: Support
 across-memory-boundary access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yongji Xie <elohimes@gmail.com>, Yongji Xie <xieyongji@baidu.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Yongji Xie <elohimes@gmail.com>

The sg list/indirect descriptor table may be contigious
in GPA but not in HVA address space. But libvhost-user
wasn't aware of that. This would cause out-of-bounds
access. Even a malicious guest could use it to get
information from the vhost-user backend.

Introduce a plen parameter in vu_gpa_to_va() so we can
handle this case, returning the actual mapped length.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |   3 +-
 contrib/libvhost-user/libvhost-user.c | 133 ++++++++++++++++++++++++++++++----
 2 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index f8a730b..18f95f6 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -327,11 +327,12 @@ bool vu_dispatch(VuDev *dev);
 /**
  * vu_gpa_to_va:
  * @dev: a VuDev context
+ * @plen: guest memory size
  * @guest_addr: guest address
  *
  * Translate a guest address to a pointer. Returns NULL on failure.
  */
-void *vu_gpa_to_va(VuDev *dev, uint64_t guest_addr);
+void *vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr);
 
 /**
  * vu_get_queue:
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 54dbc93..2e358b5 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -118,15 +118,22 @@ vu_panic(VuDev *dev, const char *msg, ...)
 
 /* Translate guest physical address to our virtual address.  */
 void *
-vu_gpa_to_va(VuDev *dev, uint64_t guest_addr)
+vu_gpa_to_va(VuDev *dev, uint64_t *plen, uint64_t guest_addr)
 {
     int i;
 
+    if (*plen == 0) {
+        return NULL;
+    }
+
     /* Find matching memory region.  */
     for (i = 0; i < dev->nregions; i++) {
         VuDevRegion *r = &dev->regions[i];
 
         if ((guest_addr >= r->gpa) && (guest_addr < (r->gpa + r->size))) {
+            if ((guest_addr + *plen) > (r->gpa + r->size)) {
+                *plen = r->gpa + r->size - guest_addr;
+            }
             return (void *)(uintptr_t)
                 guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
         }
@@ -1116,6 +1123,37 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
     return true;
 }
 
+static int
+virtqueue_read_indirect_desc(VuDev *dev, struct vring_desc *desc,
+                             uint64_t addr, size_t len)
+{
+    struct vring_desc *ori_desc;
+    uint64_t read_len;
+
+    if (len > (VIRTQUEUE_MAX_SIZE * sizeof(struct vring_desc))) {
+        return -1;
+    }
+
+    if (len == 0) {
+        return -1;
+    }
+
+    while (len) {
+        read_len = len;
+        ori_desc = vu_gpa_to_va(dev, &read_len, addr);
+        if (!ori_desc) {
+            return -1;
+        }
+
+        memcpy(desc, ori_desc, read_len);
+        len -= read_len;
+        addr += read_len;
+        desc += read_len;
+    }
+
+    return 0;
+}
+
 enum {
     VIRTQUEUE_READ_DESC_ERROR = -1,
     VIRTQUEUE_READ_DESC_DONE = 0,   /* end of chain */
@@ -1162,8 +1200,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
     }
 
     while ((rc = virtqueue_num_heads(dev, vq, idx)) > 0) {
-        unsigned int max, num_bufs, indirect = 0;
+        unsigned int max, desc_len, num_bufs, indirect = 0;
+        uint64_t desc_addr, read_len;
         struct vring_desc *desc;
+        struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
         unsigned int i;
 
         max = vq->vring.num;
@@ -1187,8 +1227,24 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
 
             /* loop over the indirect descriptor table */
             indirect = 1;
-            max = desc[i].len / sizeof(struct vring_desc);
-            desc = vu_gpa_to_va(dev, desc[i].addr);
+            desc_addr = desc[i].addr;
+            desc_len = desc[i].len;
+            max = desc_len / sizeof(struct vring_desc);
+            read_len = desc_len;
+            desc = vu_gpa_to_va(dev, &read_len, desc_addr);
+            if (unlikely(desc && read_len != desc_len)) {
+                /* Failed to use zero copy */
+                desc = NULL;
+                if (!virtqueue_read_indirect_desc(dev, desc_buf,
+                                                  desc_addr,
+                                                  desc_len)) {
+                    desc = desc_buf;
+                }
+            }
+            if (!desc) {
+                vu_panic(dev, "Invalid indirect buffer table");
+                goto err;
+            }
             num_bufs = i = 0;
         }
 
@@ -1386,9 +1442,24 @@ virtqueue_map_desc(VuDev *dev,
         return;
     }
 
-    iov[num_sg].iov_base = vu_gpa_to_va(dev, pa);
-    iov[num_sg].iov_len = sz;
-    num_sg++;
+    while (sz) {
+        uint64_t len = sz;
+
+        if (num_sg == max_num_sg) {
+            vu_panic(dev, "virtio: too many descriptors in indirect table");
+            return;
+        }
+
+        iov[num_sg].iov_base = vu_gpa_to_va(dev, &len, pa);
+        if (iov[num_sg].iov_base == NULL) {
+            vu_panic(dev, "virtio: invalid address for buffers");
+            return;
+        }
+        iov[num_sg].iov_len = len;
+        num_sg++;
+        sz -= len;
+        pa += len;
+    }
 
     *p_num_sg = num_sg;
 }
@@ -1420,10 +1491,12 @@ virtqueue_alloc_element(size_t sz,
 void *
 vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
 {
-    unsigned int i, head, max;
+    unsigned int i, head, max, desc_len;
+    uint64_t desc_addr, read_len;
     VuVirtqElement *elem;
     unsigned out_num, in_num;
     struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
     struct vring_desc *desc;
     int rc;
 
@@ -1464,8 +1537,24 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
         }
 
         /* loop over the indirect descriptor table */
-        max = desc[i].len / sizeof(struct vring_desc);
-        desc = vu_gpa_to_va(dev, desc[i].addr);
+        desc_addr = desc[i].addr;
+        desc_len = desc[i].len;
+        max = desc_len / sizeof(struct vring_desc);
+        read_len = desc_len;
+        desc = vu_gpa_to_va(dev, &read_len, desc_addr);
+        if (unlikely(desc && read_len != desc_len)) {
+            /* Failed to use zero copy */
+            desc = NULL;
+            if (!virtqueue_read_indirect_desc(dev, desc_buf,
+                                              desc_addr,
+                                              desc_len)) {
+                desc = desc_buf;
+            }
+        }
+        if (!desc) {
+            vu_panic(dev, "Invalid indirect buffer table");
+            return NULL;
+        }
         i = 0;
     }
 
@@ -1541,7 +1630,9 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
                   unsigned int len)
 {
     struct vring_desc *desc = vq->vring.desc;
-    unsigned int i, max, min;
+    unsigned int i, max, min, desc_len;
+    uint64_t desc_addr, read_len;
+    struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
     unsigned num_bufs = 0;
 
     max = vq->vring.num;
@@ -1553,8 +1644,24 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
         }
 
         /* loop over the indirect descriptor table */
-        max = desc[i].len / sizeof(struct vring_desc);
-        desc = vu_gpa_to_va(dev, desc[i].addr);
+        desc_addr = desc[i].addr;
+        desc_len = desc[i].len;
+        max = desc_len / sizeof(struct vring_desc);
+        read_len = desc_len;
+        desc = vu_gpa_to_va(dev, &read_len, desc_addr);
+        if (unlikely(desc && read_len != desc_len)) {
+            /* Failed to use zero copy */
+            desc = NULL;
+            if (!virtqueue_read_indirect_desc(dev, desc_buf,
+                                              desc_addr,
+                                              desc_len)) {
+                desc = desc_buf;
+            }
+        }
+        if (!desc) {
+            vu_panic(dev, "Invalid indirect buffer table");
+            return;
+        }
         i = 0;
     }
 
-- 
MST

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ecCgn-0002Zm-O9
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ecCgi-0004WR-Oy
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:05:17 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:41079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ecCgi-0004VV-Gg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:05:12 -0500
Received: by mail-pg0-x244.google.com with SMTP id 136so14046725pgd.8
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:05:12 -0800 (PST)
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 19 Jan 2018 00:04:05 +0800
Message-Id: <1516291445-4572-1-git-send-email-xieyongji@baidu.com>
Subject: [Qemu-devel] [PATCH] libvhost-user: Support across-memory-boundary
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@redhat.com
Cc: dgilbert@redhat.com, maxime.coquelin@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org

The sg list/indirect descriptor table may be contigious
in GPA but not in HVA address space. But libvhost-user
wasn't aware of that. This would cause out-of-bounds
access. Even a malicious guest could use it to get
information from the vhost-user backend.

Introduce a plen parameter in vu_gpa_to_va() so we can
handle this case, returning the actual mapped length.

Signed-off-by: Yongji Xie <xieyongji@baidu.com>
---
 contrib/libvhost-user/libvhost-user.c |  133 +++++++++++++++++++++++++++++----
 contrib/libvhost-user/libvhost-user.h |    3 +-
 2 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index cadced7..6ec31c6 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -116,15 +116,22 @@ vu_panic(VuDev *dev, const char *msg, ...)
 
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
@@ -1074,6 +1081,37 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
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
@@ -1120,8 +1158,10 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
     }
 
     while ((rc = virtqueue_num_heads(dev, vq, idx)) > 0) {
-        unsigned int max, num_bufs, indirect = 0;
+        unsigned int max, desc_len, num_bufs, indirect = 0;
+        uint64_t desc_addr, read_len;
         struct vring_desc *desc;
+        struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
         unsigned int i;
 
         max = vq->vring.num;
@@ -1145,8 +1185,24 @@ vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes,
 
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
 
@@ -1344,9 +1400,24 @@ virtqueue_map_desc(VuDev *dev,
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
@@ -1378,10 +1449,12 @@ virtqueue_alloc_element(size_t sz,
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
 
@@ -1422,8 +1495,24 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
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
 
@@ -1499,7 +1588,9 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
                   unsigned int len)
 {
     struct vring_desc *desc = vq->vring.desc;
-    unsigned int i, max, min;
+    unsigned int i, max, min, desc_len;
+    uint64_t desc_addr, read_len;
+    struct vring_desc desc_buf[VIRTQUEUE_MAX_SIZE];
     unsigned num_bufs = 0;
 
     max = vq->vring.num;
@@ -1511,8 +1602,24 @@ vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
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
 
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 2f5864b..4e7ecd8 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -294,11 +294,12 @@ bool vu_dispatch(VuDev *dev);
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
-- 
1.7.9.5

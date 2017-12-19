Received: from eggs.gnu.org ([2001:4830:134:3::10]:40427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMNy-0007ee-9r
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMNx-0005BY-1g
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:13:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:27617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eRMNw-0005AW-Q3
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:13:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A5807E427
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 18:13:00 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 19 Dec 2017 19:11:28 +0100
Message-Id: <20171219181129.24189-3-maxime.coquelin@redhat.com>
In-Reply-To: <20171219181129.24189-1-maxime.coquelin@redhat.com>
References: <20171219181129.24189-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] vhost: introduce backend's user address
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Cc: mlureau@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

User backends don't need to know about QEMU virtual addresses.
It is possible to use guest physical addresses as user addresses
without user backends changes.

This patch introduces a new enum in VhostOps to specify whether the
backend expects the user addresses to be host virtual or guest
physical.

This patch makes possible for the backend driver to select whether
it wants to use host virtual or guest physical addresses as user
addresses.

No behavioral changes in this patch for the backensds, as both
backend types still use host virtual addresses.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-backend.c         |  1 +
 hw/virtio/vhost-user.c            |  1 +
 hw/virtio/vhost.c                 | 16 ++++++++++++----
 include/hw/virtio/vhost-backend.h |  6 ++++++
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efab8b..dc53f91d59 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -235,6 +235,7 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
 
 static const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
+        .uaddr_type = VHOST_UADDR_TYPE_HVA,
         .vhost_backend_init = vhost_kernel_init,
         .vhost_backend_cleanup = vhost_kernel_cleanup,
         .vhost_backend_memslots_limit = vhost_kernel_memslots_limit,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 43b342a65b..5ebeb8401b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -924,6 +924,7 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
 
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
+        .uaddr_type = VHOST_UADDR_TYPE_HVA,
         .vhost_backend_init = vhost_user_init,
         .vhost_backend_cleanup = vhost_user_cleanup,
         .vhost_backend_memslots_limit = vhost_user_memslots_limit,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce93d..300e307284 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -433,7 +433,8 @@ static int vhost_dev_has_iommu(struct vhost_dev *dev)
 static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr *plen, int is_write)
 {
-    if (!vhost_dev_has_iommu(dev)) {
+    if (dev->vhost_ops->uaddr_type == VHOST_UADDR_TYPE_HVA &&
+            !vhost_dev_has_iommu(dev)) {
         return cpu_physical_memory_map(addr, plen, is_write);
     } else {
         return (void *)(uintptr_t)addr;
@@ -444,7 +445,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                hwaddr len, int is_write,
                                hwaddr access_len)
 {
-    if (!vhost_dev_has_iommu(dev)) {
+    if (dev->vhost_ops->uaddr_type == VHOST_UADDR_TYPE_HVA &&
+            !vhost_dev_has_iommu(dev)) {
         cpu_physical_memory_unmap(buffer, len, is_write, access_len);
     }
 }
@@ -975,7 +977,7 @@ static int vhost_memory_region_lookup(struct vhost_dev *hdev,
 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
 {
     IOMMUTLBEntry iotlb;
-    uint64_t uaddr, len;
+    uint64_t userspace_addr, uaddr, len;
     int ret = -EFAULT;
 
     rcu_read_lock();
@@ -984,7 +986,7 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
                                           iova, write);
     if (iotlb.target_as != NULL) {
         ret = vhost_memory_region_lookup(dev, iotlb.translated_addr,
-                                         &uaddr, &len);
+                                         &userspace_addr, &len);
         if (ret) {
             error_report("Fail to lookup the translated address "
                          "%"PRIx64, iotlb.translated_addr);
@@ -994,6 +996,12 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         len = MIN(iotlb.addr_mask + 1, len);
         iova = iova & ~iotlb.addr_mask;
 
+        if (dev->vhost_ops->uaddr_type == VHOST_UADDR_TYPE_GPA) {
+            uaddr = iotlb.translated_addr;
+        } else {
+            uaddr = userspace_addr;
+        }
+
         ret = vhost_backend_update_device_iotlb(dev, iova, uaddr,
                                                 len, iotlb.perm);
         if (ret) {
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a7a5f22bc6..51c1c08c7a 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -20,6 +20,11 @@ typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_MAX = 3,
 } VhostBackendType;
 
+typedef enum VhostUaddrType {
+    VHOST_UADDR_TYPE_HVA = 0,
+    VHOST_UADDR_TYPE_GPA = 1,
+} VhostUaddrType;
+
 struct vhost_dev;
 struct vhost_log;
 struct vhost_memory;
@@ -87,6 +92,7 @@ typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
+    VhostUaddrType uaddr_type;
     vhost_backend_init vhost_backend_init;
     vhost_backend_cleanup vhost_backend_cleanup;
     vhost_backend_memslots_limit vhost_backend_memslots_limit;
-- 
2.14.3

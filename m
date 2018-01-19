Received: from eggs.gnu.org ([2001:4830:134:3::10]:46328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecY5Z-0000w6-Bw
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecY5Y-0002qd-7N
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:56:17 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 19 Jan 2018 14:49:00 +0000
Message-Id: <1516373355-305-8-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
References: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 07/22] virtio-iommu: Decode the command payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This patch adds the command payload decoding and
introduces the functions that will do the actual
command handling. Those functions are not yet implemented.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v4 -> v5:
- adopt new v0.5 terminology

v3 -> v4:
- no flags field anymore in struct virtio_iommu_req_unmap
- test reserved on attach/detach, change trace proto
- rebase on v2.10.0.
---
 hw/virtio/trace-events   |   6 ++-
 hw/virtio/virtio-iommu.c | 104 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 98cf9a1..f570699 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -31,4 +31,8 @@ virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0
 virtio_iommu_set_features(uint64_t features) "features accepted by the driver =0x%"PRIx64
 virtio_iommu_device_reset(void) "reset!"
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
-virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint8_t ioasid_bits, uint32_t probe_size) "page_size_mask=0x%"PRIx64" start=0x%"PRIx64" end=0x%"PRIx64" ioasid_bits=%d probe_size=0x%x"
+virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint8_t domain_bits, uint32_t probe_size) "page_size_mask=0x%"PRIx64" start=0x%"PRIx64" end=0x%"PRIx64" domain_bits=%d probe_size=0x%x"
+virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
+virtio_iommu_detach(uint32_t ep_id) "endpoint=%d"
+virtio_iommu_map(uint32_t domain_id, uint64_t phys_addr, uint64_t virt_addr, uint64_t size, uint32_t flags) "domain=%d phys_addr=0x%"PRIx64" virt_addr=0x%"PRIx64" size=0x%"PRIx64" flags=%d"
+virtio_iommu_unmap(uint32_t domain_id, uint64_t virt_addr, uint64_t size) "domain=%d virt_addr=0x%"PRIx64" size=0x%"PRIx64
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 52430dc..247e6c8 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -35,29 +35,125 @@
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 
+static int virtio_iommu_attach(VirtIOIOMMU *s,
+                               struct virtio_iommu_req_attach *req)
+{
+    uint32_t domain_id = le32_to_cpu(req->domain);
+    uint32_t ep_id = le32_to_cpu(req->endpoint);
+    uint32_t reserved = le32_to_cpu(req->reserved);
+
+    trace_virtio_iommu_attach(domain_id, ep_id);
+
+    if (reserved) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+
+static int virtio_iommu_detach(VirtIOIOMMU *s,
+                               struct virtio_iommu_req_detach *req)
+{
+    uint32_t ep_id = le32_to_cpu(req->endpoint);
+    uint32_t reserved = le32_to_cpu(req->reserved);
+
+    trace_virtio_iommu_detach(ep_id);
+
+    if (reserved) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+
+static int virtio_iommu_map(VirtIOIOMMU *s,
+                            struct virtio_iommu_req_map *req)
+{
+    uint32_t domain_id = le32_to_cpu(req->domain);
+    uint64_t phys_addr = le64_to_cpu(req->phys_addr);
+    uint64_t virt_addr = le64_to_cpu(req->virt_addr);
+    uint64_t size = le64_to_cpu(req->size);
+    uint32_t flags = le32_to_cpu(req->flags);
+
+    trace_virtio_iommu_map(domain_id, phys_addr, virt_addr, size, flags);
+
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+
+static int virtio_iommu_unmap(VirtIOIOMMU *s,
+                              struct virtio_iommu_req_unmap *req)
+{
+    uint32_t domain_id = le32_to_cpu(req->domain);
+    uint64_t virt_addr = le64_to_cpu(req->virt_addr);
+    uint64_t size = le64_to_cpu(req->size);
+
+    trace_virtio_iommu_unmap(domain_id, virt_addr, size);
+
+    return VIRTIO_IOMMU_S_UNSUPP;
+}
+
+#define get_payload_size(req) (\
+sizeof((req)) - sizeof(struct virtio_iommu_req_tail))
+
 static int virtio_iommu_handle_attach(VirtIOIOMMU *s,
                                       struct iovec *iov,
                                       unsigned int iov_cnt)
 {
-    return -ENOENT;
+    struct virtio_iommu_req_attach req;
+    size_t sz, payload_sz;
+
+    payload_sz = get_payload_size(req);
+
+    sz = iov_to_buf(iov, iov_cnt, 0, &req, payload_sz);
+    if (sz != payload_sz) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+    return virtio_iommu_attach(s, &req);
 }
 static int virtio_iommu_handle_detach(VirtIOIOMMU *s,
                                       struct iovec *iov,
                                       unsigned int iov_cnt)
 {
-    return -ENOENT;
+    struct virtio_iommu_req_detach req;
+    size_t sz, payload_sz;
+
+    payload_sz = get_payload_size(req);
+
+    sz = iov_to_buf(iov, iov_cnt, 0, &req, payload_sz);
+    if (sz != payload_sz) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+    return virtio_iommu_detach(s, &req);
 }
 static int virtio_iommu_handle_map(VirtIOIOMMU *s,
                                    struct iovec *iov,
                                    unsigned int iov_cnt)
 {
-    return -ENOENT;
+    struct virtio_iommu_req_map req;
+    size_t sz, payload_sz;
+
+    payload_sz = get_payload_size(req);
+
+    sz = iov_to_buf(iov, iov_cnt, 0, &req, payload_sz);
+    if (sz != payload_sz) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+    return virtio_iommu_map(s, &req);
 }
 static int virtio_iommu_handle_unmap(VirtIOIOMMU *s,
                                      struct iovec *iov,
                                      unsigned int iov_cnt)
 {
-    return -ENOENT;
+    struct virtio_iommu_req_unmap req;
+    size_t sz, payload_sz;
+
+    payload_sz = get_payload_size(req);
+
+    sz = iov_to_buf(iov, iov_cnt, 0, &req, payload_sz);
+    if (sz != payload_sz) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+    return virtio_iommu_unmap(s, &req);
 }
 
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
-- 
1.9.1

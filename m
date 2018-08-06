Received: from eggs.gnu.org ([2001:4830:134:3::10]:58517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlud-0006VB-9z
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fmlub-0006wS-HY
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 16:15:31 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  6 Aug 2018 22:14:37 +0200
Message-Id: <1533586484-5737-10-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
References: <1533586484-5737-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v7 09/16] virtio-iommu: Implement probe request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

This patch implements the PROBE request. At the moment,
no reserved regions are returned as none are registered
per device. Only a NONE property is returned.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- adapt to the change in virtio_iommu_probe_resv_mem fields
- use get_endpoint() instead of directly checking the EP
  was registered.

v4 -> v5:
- initialize bufstate.error to false
- add cpu_to_le64(size)
---
 hw/virtio/trace-events   |   2 +
 hw/virtio/virtio-iommu.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 4041af6..69aba56 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -67,3 +67,5 @@ virtio_iommu_unmap_left_interval(uint64_t low, uint64_t high, uint64_t next_low,
 virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"], new interval=[0x%"PRIx64",0x%"PRIx64"]"
 virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc [0x%"PRIx64",0x%"PRIx64"]"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
+virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end, uint32_t flags, size_t filled) "dev= %d, subtype=%d start=0x%"PRIx64" end=0x%"PRIx64" flags=%d filled=0x%lx"
+virtio_iommu_fill_none_property(uint32_t devid) "devid=%d"
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 6f44d15..0291a04 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -40,6 +40,11 @@
 
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
+#define VIOMMU_PROBE_SIZE 512
+
+#define SUPPORTED_PROBE_PROPERTIES (\
+    VIRTIO_IOMMU_PROBE_T_NONE | \
+    VIRTIO_IOMMU_PROBE_T_RESV_MEM)
 
 typedef struct viommu_domain {
     uint32_t id;
@@ -52,6 +57,7 @@ typedef struct viommu_endpoint {
     viommu_domain *domain;
     QLIST_ENTRY(viommu_endpoint) next;
     VirtIOIOMMU *viommu;
+    GTree *reserved_regions;
 } viommu_endpoint;
 
 typedef struct viommu_interval {
@@ -66,6 +72,13 @@ typedef struct viommu_mapping {
     uint32_t flags;
 } viommu_mapping;
 
+typedef struct viommu_property_buffer {
+    viommu_endpoint *endpoint;
+    size_t filled;
+    uint8_t *start;
+    bool error;
+} viommu_property_buffer;
+
 static inline uint16_t virtio_iommu_get_sid(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -105,6 +118,9 @@ static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
     ep->viommu = s;
     trace_virtio_iommu_get_endpoint(ep_id);
     g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
+    ep->reserved_regions = g_tree_new_full((GCompareDataFunc)interval_cmp,
+                                            NULL, (GDestroyNotify)g_free,
+                                            (GDestroyNotify)g_free);
     return ep;
 }
 
@@ -118,6 +134,7 @@ static void virtio_iommu_put_endpoint(gpointer data)
     }
 
     trace_virtio_iommu_put_endpoint(ep->id);
+    g_tree_destroy(ep->reserved_regions);
     g_free(ep);
 }
 
@@ -361,6 +378,136 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     return VIRTIO_IOMMU_S_INVAL;
 }
 
+/**
+ * virtio_iommu_fill_resv_mem_prop - Add a RESV_MEM probe
+ * property into the probe request buffer
+ *
+ * @key: interval handle
+ * @value: handle to the reserved memory region
+ * @data: handle to the probe request buffer state
+ */
+static gboolean virtio_iommu_fill_resv_mem_prop(gpointer key,
+                                                gpointer value,
+                                                gpointer data)
+{
+    struct virtio_iommu_probe_resv_mem *resv =
+        (struct virtio_iommu_probe_resv_mem *)value;
+    struct virtio_iommu_probe_property *prop;
+    struct virtio_iommu_probe_resv_mem *current;
+    viommu_property_buffer *bufstate = (viommu_property_buffer *)data;
+    size_t size = sizeof(*resv), total_size;
+
+    total_size = size + sizeof(*prop);
+
+    if (bufstate->filled + total_size >= VIOMMU_PROBE_SIZE) {
+        bufstate->error = true;
+        /* get the traversal stopped by returning true */
+        return true;
+    }
+    prop = (struct virtio_iommu_probe_property *)
+                (bufstate->start + bufstate->filled);
+    prop->type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_RESV_MEM) &
+                    VIRTIO_IOMMU_PROBE_T_MASK;
+    prop->length = cpu_to_le16(size);
+
+    current = (struct virtio_iommu_probe_resv_mem *)prop->value;
+    *current = *resv;
+    bufstate->filled += total_size;
+    trace_virtio_iommu_fill_resv_property(bufstate->endpoint->id,
+                                          resv->subtype, resv->start,
+                                          resv->end, resv->subtype,
+                                          bufstate->filled);
+    return false;
+}
+
+static int virtio_iommu_fill_none_prop(viommu_property_buffer *bufstate)
+{
+    struct virtio_iommu_probe_property *prop;
+
+    prop = (struct virtio_iommu_probe_property *)
+                (bufstate->start + bufstate->filled);
+    prop->type = cpu_to_le16(VIRTIO_IOMMU_PROBE_T_NONE)
+                    & VIRTIO_IOMMU_PROBE_T_MASK;
+    prop->length = 0;
+    bufstate->filled += sizeof(*prop);
+    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
+    return 0;
+}
+
+static int virtio_iommu_fill_property(int type,
+                                      viommu_property_buffer *bufstate)
+{
+    int ret = -ENOSPC;
+
+    if (bufstate->filled + 4 >= VIOMMU_PROBE_SIZE) {
+        /* Even the property header cannot be filled */
+        bufstate->error = true;
+        goto out;
+    }
+
+    switch (type) {
+    case VIRTIO_IOMMU_PROBE_T_NONE:
+        ret = virtio_iommu_fill_none_prop(bufstate);
+        break;
+    case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
+    {
+        viommu_endpoint *ep = bufstate->endpoint;
+
+        g_tree_foreach(ep->reserved_regions,
+                       virtio_iommu_fill_resv_mem_prop,
+                       bufstate);
+        if (!bufstate->error) {
+            ret = 0;
+        }
+        break;
+    }
+    default:
+        ret = -ENOENT;
+        break;
+    }
+out:
+    if (ret) {
+        error_report("%s property of type=%d could not be filled (%d),"
+                     " remaining size = 0x%lx",
+                     __func__, type, ret, bufstate->filled);
+    }
+    return ret;
+}
+
+/**
+ * virtio_iommu_probe - Fill the probe request buffer with all
+ * the properties the device is able to return and add a NONE
+ * property at the end.
+ */
+static int virtio_iommu_probe(VirtIOIOMMU *s,
+                              struct virtio_iommu_req_probe *req,
+                              uint8_t *buf)
+{
+    uint32_t ep_id = le32_to_cpu(req->endpoint);
+    int16_t prop_types = SUPPORTED_PROBE_PROPERTIES, type;
+    viommu_property_buffer bufstate;
+    viommu_endpoint *ep;
+    int ret;
+
+    ep = virtio_iommu_get_endpoint(s, ep_id);
+
+    bufstate.start = buf;
+    bufstate.filled = 0;
+    bufstate.error = false;
+    bufstate.endpoint = ep;
+
+    while ((type = ctz32(prop_types)) != 32) {
+        ret = virtio_iommu_fill_property(1 << type, &bufstate);
+        if (ret) {
+            break;
+        }
+        prop_types &= ~(1 << type);
+    }
+    virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufstate);
+
+    return VIRTIO_IOMMU_S_OK;
+}
+
 #define get_payload_size(req) (\
 sizeof((req)) - sizeof(struct virtio_iommu_req_tail))
 
@@ -425,6 +572,24 @@ static int virtio_iommu_handle_unmap(VirtIOIOMMU *s,
     return virtio_iommu_unmap(s, &req);
 }
 
+static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
+                                     struct iovec *iov,
+                                     unsigned int iov_cnt,
+                                     uint8_t *buf)
+{
+    struct virtio_iommu_req_probe req;
+    size_t sz, payload_sz;
+
+    payload_sz = sizeof(req);
+
+    sz = iov_to_buf(iov, iov_cnt, 0, &req, payload_sz);
+    if (sz != payload_sz) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    return virtio_iommu_probe(s, &req, buf);
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
@@ -469,16 +634,32 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
         case VIRTIO_IOMMU_T_UNMAP:
             tail.status = virtio_iommu_handle_unmap(s, iov, iov_cnt);
             break;
+        case VIRTIO_IOMMU_T_PROBE:
+        {
+            struct virtio_iommu_req_tail *ptail;
+            uint8_t *buf = g_malloc0(s->config.probe_size + sizeof(tail));
+
+            ptail = (struct virtio_iommu_req_tail *)
+                        (buf + s->config.probe_size);
+            ptail->status = virtio_iommu_handle_probe(s, iov, iov_cnt, buf);
+
+            sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
+                              buf, s->config.probe_size + sizeof(tail));
+            g_free(buf);
+            assert(sz == s->config.probe_size + sizeof(tail));
+            goto push;
+        }
         default:
             tail.status = VIRTIO_IOMMU_S_UNSUPP;
         }
-        qemu_mutex_unlock(&s->mutex);
 
         sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                           &tail, sizeof(tail));
         assert(sz == sizeof(tail));
 
-        virtqueue_push(vq, elem, sizeof(tail));
+push:
+        qemu_mutex_unlock(&s->mutex);
+        virtqueue_push(vq, elem, sz);
         virtio_notify(vdev, vq);
         g_free(elem);
     }
@@ -575,6 +756,7 @@ static uint64_t virtio_iommu_get_features(VirtIODevice *vdev, uint64_t f,
     virtio_add_feature(&f, VIRTIO_RING_F_INDIRECT_DESC);
     virtio_add_feature(&f, VIRTIO_IOMMU_F_INPUT_RANGE);
     virtio_add_feature(&f, VIRTIO_IOMMU_F_MAP_UNMAP);
+    virtio_add_feature(&f, VIRTIO_IOMMU_F_PROBE);
     return f;
 }
 
@@ -619,6 +801,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 
     s->config.page_size_mask = TARGET_PAGE_MASK;
     s->config.input_range.end = -1UL;
+    s->config.probe_size = VIOMMU_PROBE_SIZE;
 
     qemu_mutex_init(&s->mutex);
 
-- 
2.5.5

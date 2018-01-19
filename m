Received: from eggs.gnu.org ([2001:4830:134:3::10]:48418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecYBS-0006CJ-E3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ecYBP-0006p0-86
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:02:22 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 19 Jan 2018 14:49:03 +0000
Message-Id: <1516373355-305-11-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
References: <1516373355-305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v5 10/22] virtio-iommu: Implement attach/detach
 command
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

This patch implements the endpoint attach/detach to/from
a domain.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index cca2614..b30d761 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -113,8 +113,8 @@ static void virtio_iommu_put_endpoint(gpointer data)
     g_free(ep);
 }
 
-viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id);
-viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s, uint32_t domain_id)
+static viommu_domain *virtio_iommu_get_domain(VirtIOIOMMU *s,
+                                              uint32_t domain_id)
 {
     viommu_domain *domain;
 
@@ -193,6 +193,8 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
     uint32_t domain_id = le32_to_cpu(req->domain);
     uint32_t ep_id = le32_to_cpu(req->endpoint);
     uint32_t reserved = le32_to_cpu(req->reserved);
+    viommu_domain *domain;
+    viommu_endpoint *ep;
 
     trace_virtio_iommu_attach(domain_id, ep_id);
 
@@ -200,7 +202,22 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
         return VIRTIO_IOMMU_S_INVAL;
     }
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep = virtio_iommu_get_endpoint(s, ep_id);
+    if (ep->domain) {
+        /*
+         * the device is already attached to a domain,
+         * detach it first
+         */
+        virtio_iommu_detach_endpoint_from_domain(ep);
+    }
+
+    domain = virtio_iommu_get_domain(s, domain_id);
+    QLIST_INSERT_HEAD(&domain->endpoint_list, ep, next);
+
+    ep->domain = domain;
+    g_tree_ref(domain->mappings);
+
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_detach(VirtIOIOMMU *s,
@@ -208,14 +225,24 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
 {
     uint32_t ep_id = le32_to_cpu(req->endpoint);
     uint32_t reserved = le32_to_cpu(req->reserved);
-
-    trace_virtio_iommu_detach(ep_id);
+    viommu_endpoint *ep;
 
     if (reserved) {
         return VIRTIO_IOMMU_S_INVAL;
     }
 
-    return VIRTIO_IOMMU_S_UNSUPP;
+    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
+    if (!ep) {
+        return VIRTIO_IOMMU_S_NOENT;
+    }
+
+    if (!ep->domain) {
+        return VIRTIO_IOMMU_S_INVAL;
+    }
+
+    virtio_iommu_detach_endpoint_from_domain(ep);
+    trace_virtio_iommu_detach(ep_id);
+    return VIRTIO_IOMMU_S_OK;
 }
 
 static int virtio_iommu_map(VirtIOIOMMU *s,
-- 
1.9.1

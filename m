Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CEC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A0520663
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 08:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="R0mN9ycV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A0520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGIpt-0000YX-Jb
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 04:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIjw-0000LZ-IM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIju-0003J6-C1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:47:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64092
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2351ca747f=bbhushan2@marvell.com>)
 id 1jGIju-0003Iq-2G; Mon, 23 Mar 2020 04:47:18 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02N8debD010645; Mon, 23 Mar 2020 01:47:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=2gCNoHyGjv63XzmeUOxsBCZMChV7RLhevIlNw3CI/5Q=;
 b=R0mN9ycVVvxMcHi6wn0JiHwR/sPn1dzzi6pbPNlLf42UCSAuaFG107axT9vSqBQb/uRl
 7zGLxr132vakEwfejHpAhZVzTfkO3xfFo+USWCKklSYmF+MwCCksgAPX7QM8C2F5qSlV
 LjiuOVmwzhI3feOdOyIMTrldv791DrJha1RtrXupCTfDPWlWHh7h9nsRiUk7vLjLqCtJ
 YdI3GNY24gDFXlSWoLywzIhXUZImjUdEFW7WG7jOFGkI6OWS6fr9nWH5WQ/fPCC6TjS/
 pg1//FTeRg4Fa3H/AtXy8ZSvQvYMRad4WCGEcNsQHnFFhOaQiZD5kh/F3p34463tmIY1 SA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 2ywg9ndrxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2020 01:47:15 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 23 Mar 2020 01:47:14 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 23 Mar 2020 01:47:13 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Mar 2020 01:47:08 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <bharatb.linux@gmail.com>, <jean-philippe@linaro.org>,
 <yang.zhong@intel.com>
Subject: [PATCH v9 8/9] virtio-iommu: Implement probe request
Date: Mon, 23 Mar 2020 14:16:16 +0530
Message-ID: <20200323084617.1782-9-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323084617.1782-1-bbhushan2@marvell.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-23_02:2020-03-21,
 2020-03-23 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.148.174
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eric Auger <eric.auger@redhat.com>, Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements the PROBE request. Currently supported
page size mask per endpoint is returned. Also append a NONE
property in the end.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/standard-headers/linux/virtio_iommu.h |   6 +
 hw/virtio/virtio-iommu.c                      | 161 +++++++++++++++++-
 hw/virtio/trace-events                        |   2 +
 3 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/include/standard-headers/linux/virtio_iommu.h b/include/standard-headers/linux/virtio_iommu.h
index b9443b83a1..8a0d47b907 100644
--- a/include/standard-headers/linux/virtio_iommu.h
+++ b/include/standard-headers/linux/virtio_iommu.h
@@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
 
 #define VIRTIO_IOMMU_PROBE_T_NONE		0
 #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
 
 #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
 
@@ -130,6 +131,11 @@ struct virtio_iommu_probe_resv_mem {
 	uint64_t					end;
 };
 
+struct virtio_iommu_probe_pgsize_mask {
+	struct virtio_iommu_probe_property      head;
+	uint64_t				pgsize_bitmap;
+};
+
 struct virtio_iommu_req_probe {
 	struct virtio_iommu_req_head		head;
 	uint32_t					endpoint;
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 747e3cf1da..63fbacdcdc 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -38,6 +38,10 @@
 
 /* Max size */
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
+#define VIOMMU_PROBE_SIZE 512
+
+#define SUPPORTED_PROBE_PROPERTIES (\
+    1 << VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK)
 
 typedef struct VirtIOIOMMUDomain {
     uint32_t id;
@@ -62,6 +66,13 @@ typedef struct VirtIOIOMMUMapping {
     uint32_t flags;
 } VirtIOIOMMUMapping;
 
+typedef struct VirtIOIOMMUPropBuffer {
+    VirtIOIOMMUEndpoint *endpoint;
+    size_t filled;
+    uint8_t *start;
+    bool error;
+} VirtIOIOMMUPropBuffer;
+
 static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
 {
     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
@@ -490,6 +501,114 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     return ret;
 }
 
+static int virtio_iommu_fill_none_prop(VirtIOIOMMUPropBuffer *bufstate)
+{
+    struct virtio_iommu_probe_property *prop;
+
+    prop = (struct virtio_iommu_probe_property *)
+                (bufstate->start + bufstate->filled);
+    prop->type = 0;
+    prop->length = 0;
+    bufstate->filled += sizeof(*prop);
+    trace_virtio_iommu_fill_none_property(bufstate->endpoint->id);
+    return 0;
+}
+
+static int virtio_iommu_fill_page_size_mask(VirtIOIOMMUPropBuffer *bufstate)
+{
+    struct virtio_iommu_probe_pgsize_mask *page_size_mask;
+    size_t prop_size = sizeof(*page_size_mask);
+    VirtIOIOMMUEndpoint *ep = bufstate->endpoint;
+    VirtIOIOMMU *s = ep->viommu;
+    IOMMUDevice *sdev;
+
+    if (bufstate->filled + prop_size >= VIOMMU_PROBE_SIZE) {
+        bufstate->error = true;
+        /* get the traversal stopped by returning true */
+        return true;
+    }
+
+    page_size_mask = (struct virtio_iommu_probe_pgsize_mask *)
+                     (bufstate->start + bufstate->filled);
+
+    page_size_mask->head.type = VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK;
+    page_size_mask->head.length = prop_size;
+    QLIST_FOREACH(sdev, &s->notifiers_list, next) {
+        if (ep->id == sdev->devfn) {
+            page_size_mask->pgsize_bitmap = sdev->page_size_mask;
+	}
+    }
+    bufstate->filled += sizeof(*page_size_mask);
+    trace_virtio_iommu_fill_pgsize_mask_property(bufstate->endpoint->id,
+                                                 page_size_mask->pgsize_bitmap,
+                                                 bufstate->filled);
+    return false;
+}
+
+/* Fill the properties[] buffer with properties of type @type */
+static int virtio_iommu_fill_property(int type,
+                                      VirtIOIOMMUPropBuffer *bufstate)
+{
+    int ret = -ENOSPC;
+
+    if (bufstate->filled + sizeof(struct virtio_iommu_probe_property)
+            >= VIOMMU_PROBE_SIZE) {
+        /* no space left for the header */
+        bufstate->error = true;
+        goto out;
+    }
+
+    switch (type) {
+    case VIRTIO_IOMMU_PROBE_T_NONE:
+        ret = virtio_iommu_fill_none_prop(bufstate);
+        break;
+    case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
+    {
+        ret = virtio_iommu_fill_page_size_mask(bufstate);
+	break;
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
+ * property at the end. @buf points to properties[].
+ */
+static int virtio_iommu_probe(VirtIOIOMMU *s,
+                              struct virtio_iommu_req_probe *req,
+                              uint8_t *buf)
+{
+    uint32_t ep_id = le32_to_cpu(req->endpoint);
+    VirtIOIOMMUEndpoint *ep = virtio_iommu_get_endpoint(s, ep_id);
+    int16_t prop_types = SUPPORTED_PROBE_PROPERTIES, type;
+    VirtIOIOMMUPropBuffer bufstate = {.start = buf, .filled = 0,
+                                       .error = false, .endpoint = ep};
+
+    while ((type = ctz32(prop_types)) != 32) {
+        if (virtio_iommu_fill_property(type, &bufstate)) {
+            goto failure;
+        }
+        prop_types &= ~(1 << type);
+    }
+    if (virtio_iommu_fill_property(VIRTIO_IOMMU_PROBE_T_NONE, &bufstate)) {
+        goto failure;
+    }
+    return VIRTIO_IOMMU_S_OK;
+failure:
+    return VIRTIO_IOMMU_S_INVAL;
+}
+
 static int virtio_iommu_iov_to_req(struct iovec *iov,
                                    unsigned int iov_cnt,
                                    void *req, size_t req_sz)
@@ -519,6 +638,17 @@ virtio_iommu_handle_req(detach)
 virtio_iommu_handle_req(map)
 virtio_iommu_handle_req(unmap)
 
+static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
+                                     struct iovec *iov,
+                                     unsigned int iov_cnt,
+                                     uint8_t *buf)
+{
+    struct virtio_iommu_req_probe req;
+    int ret = virtio_iommu_iov_to_req(iov, iov_cnt, &req, sizeof(req));
+
+    return ret ? ret : virtio_iommu_probe(s, &req, buf);
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
@@ -564,17 +694,33 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
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
 
 out:
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
@@ -634,16 +780,23 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     VirtIOIOMMUEndpoint *ep;
     uint32_t sid, flags;
     bool bypass_allowed;
+    hwaddr addr_mask;
     bool found;
 
     interval.low = addr;
     interval.high = addr + 1;
 
+    if (sdev->page_size_mask) {
+        addr_mask = (1 << ctz32(sdev->page_size_mask)) - 1;
+    } else {
+        addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1;
+    }
+
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
         .iova = addr,
         .translated_addr = addr,
-        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
+        .addr_mask = addr_mask,
         .perm = IOMMU_NONE,
     };
 
@@ -831,6 +984,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->config.page_size_mask = TARGET_PAGE_MASK;
     s->config.input_range.end = -1UL;
     s->config.domain_range.end = 32;
+    s->config.probe_size = VIOMMU_PROBE_SIZE;
 
     virtio_add_feature(&s->features, VIRTIO_RING_F_EVENT_IDX);
     virtio_add_feature(&s->features, VIRTIO_RING_F_INDIRECT_DESC);
@@ -840,6 +994,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MAP_UNMAP);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_BYPASS);
     virtio_add_feature(&s->features, VIRTIO_IOMMU_F_MMIO);
+    virtio_add_feature(&s->features, VIRTIO_IOMMU_F_PROBE);
 
     qemu_mutex_init(&s->mutex);
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8bae651191..b0a6e4bda3 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -76,3 +76,5 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uin
 virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64
 virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64
 virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
+virtio_iommu_fill_none_property(uint32_t devid) "devid=%d"
+virtio_iommu_fill_pgsize_mask_property(uint32_t devid, uint64_t pgsize_mask, size_t filled) "dev= %d, pgsize_mask=0x%"PRIx64" filled=0x%lx"
-- 
2.17.1



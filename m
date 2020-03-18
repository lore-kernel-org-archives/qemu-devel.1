Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F660C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5672076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RMqK6DZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5672076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVkB-00086B-3t
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgz-0002wn-PX
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgy-0005Cy-AK
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:12:53 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEVgy-0005AF-4k; Wed, 18 Mar 2020 06:12:52 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IACGVT031196; Wed, 18 Mar 2020 03:12:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=H70ira2xI4tp3d4NOT3PQrNRuE9cpJhM0WachNeWQc4=;
 b=RMqK6DZROWHvl415vE9qM1Y3H+cAuz51UAMzxajdb3zmL3iA5DLt6h7B2zzruLgio+Ka
 Tb8/SF2BUf3ZN+uKta38tThj+LXPz2VMpe9lO0Vgyts3+u5gBGW/E0aXy1cAHoMrNEmS
 HsTggBaKXxZT4CuIISSLyMcErku15DTadEUyA6FCmCgc06bUKLYd7nHaK2DSxH05odHY
 3XuD9Uc0V8ga+JLawhBWI67iXbAa+CNxsfKn8j28VsL/lAfh5fS4B9M9UAsPsOh9Td6q
 Yl6rFWsVtMmAbX2Q1MSWs2sDGjnQajT4ajCiZSroteArRaIRxBg1wNHJQ44nrrs0z1Jw KA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2yu9rp9tw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2020 03:12:49 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 18 Mar
 2020 03:12:47 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Mar 2020 03:12:42 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>,
 <bharatb.linux@gmail.com>, <jean-philippe@linaro.org>,
 <yang.zhong@intel.com>
Subject: [PATCH v8 7/8] virtio-iommu: add iommu replay
Date: Wed, 18 Mar 2020 15:41:58 +0530
Message-ID: <20200318101159.8767-8-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318101159.8767-1-bbhushan2@marvell.com>
References: <20200318101159.8767-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_04:2020-03-18,
 2020-03-18 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.156.173
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
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Default replay does not work with virtio-iommu,
so this patch provide virtio-iommu replay functionality.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 hw/virtio/virtio-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  1 +
 2 files changed, 45 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4d522a636a..b68644f7c3 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -771,6 +771,49 @@ static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     s->config.page_size_mask = page_size_mask;
 }
 
+static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
+{
+    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    trace_virtio_iommu_remap(interval->low, mapping->phys_addr,
+                             interval->high - interval->low + 1);
+    /* unmap previous entry and map again */
+    virtio_iommu_notify_unmap(mr, interval->low,
+                              interval->high - interval->low + 1);
+
+    virtio_iommu_notify_map(mr, interval->low, mapping->phys_addr,
+                            interval->high - interval->low + 1);
+    return false;
+}
+
+static void virtio_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint32_t sid;
+    VirtIOIOMMUEndpoint *ep;
+
+    sid = virtio_iommu_get_bdf(sdev);
+
+    qemu_mutex_lock(&s->mutex);
+
+    if (!s->endpoints) {
+        goto unlock;
+    }
+
+    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
+    if (!ep || !ep->domain) {
+        goto unlock;
+    }
+
+    g_tree_foreach(ep->domain->mappings, virtio_iommu_remap, mr);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -989,6 +1032,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
 
     imrc->translate = virtio_iommu_translate;
     imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
+    imrc->replay = virtio_iommu_replay;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index d94a1cd8a3..8bae651191 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -75,3 +75,4 @@ virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid)
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
 virtio_iommu_notify_map(const char *name, uint64_t iova, uint64_t paddr, uint64_t map_size) "mr=%s iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64
 virtio_iommu_notify_unmap(const char *name, uint64_t iova, uint64_t map_size) "mr=%s iova=0x%"PRIx64" size=0x%"PRIx64
+virtio_iommu_remap(uint64_t iova, uint64_t pa, uint64_t size) "iova=0x%"PRIx64" pa=0x%" PRIx64" size=0x%"PRIx64""
-- 
2.17.1



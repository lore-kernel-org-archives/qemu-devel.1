Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0EDC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B727A206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Trz1gCIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727A206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGwj-0002fC-Mb
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1ihGpg-0002ah-0B
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1ihGpa-0001g3-8X
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:40:26 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1ihGpa-0001fH-2T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:40:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df912fb0000>; Tue, 17 Dec 2019 09:40:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 17 Dec 2019 09:40:20 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 09:40:20 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 17:40:20 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 17:40:13 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v11 Kernel 6/6] vfio: Selective dirty page tracking if IOMMU
 backed device pins pages
Date: Tue, 17 Dec 2019 22:40:51 +0530
Message-ID: <1576602651-15430-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
References: <1576602651-15430-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576604411; bh=2oOKZISnlK+HtkceRMjiNJPC+PXUu6lxNvUL0/CXFX4=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=Trz1gCIL6LRVRcRFOVHvf9tto/vx0LXLrJwXmj6tyNt6tZ4QKCLW8Qprg1IGcoljP
 M8w93i70jhV+HUgKiFWm6P07fwxqz202YsraDB8KwN3cTQouAxAkiV/vG8BaCLHEXr
 iXTUgq3Lprm10u9mFLLrGy3b9LPJs9DLeLDVIl/Kn8DFmrQwOjSFHxGjc+r4MLYbmD
 P2kjstfqPEzKRQ8yhd5W9SfpGs7+qaV5/635oXi8J6K++3DXbaXmx1pv/hoU+VkF8z
 0QxA5c3bs/G7lRMb3q47rPeJCEBhuxanGKHJgCMQcvyeWRI3i/KhHLSBAo5510hGHx
 P1jS7K0f6jODg==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.64
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Track dirty pages reporting capability for each vfio_device by setting the
capability flag on calling vfio_pin_pages() for that device.

In vfio_iommu_type1 module, while creating dirty pages bitmap, check if
IOMMU backed device is present in the container. If IOMMU backed device is
present in container then check dirty pages reporting capability for each
vfio device in the container. If all vfio devices are capable of reporing
dirty pages tracking by pinning pages through external API, then report
create bitmap of pinned pages only. If IOMMU backed device is present in
the container and any one device is not able to report dirty pages, then
marked all pages as dirty.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio.c             | 33 +++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c | 44 +++++++++++++++++++++++++++++++++++++++--
 include/linux/vfio.h            |  3 ++-
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index c8482624ca34..9d2fbe09768a 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -96,6 +96,8 @@ struct vfio_device {
 	struct vfio_group		*group;
 	struct list_head		group_next;
 	void				*device_data;
+	/* dirty pages reporting capable */
+	bool				dirty_pages_cap;
 };
 
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -1866,6 +1868,29 @@ int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr, int num_irqs,
 }
 EXPORT_SYMBOL(vfio_set_irqs_validate_and_prepare);
 
+int vfio_device_is_dirty_reporting_capable(struct device *dev, bool *cap)
+{
+	struct vfio_device *device;
+	struct vfio_group *group;
+
+	if (!dev || !cap)
+		return -EINVAL;
+
+	group = vfio_group_get_from_dev(dev);
+	if (!group)
+		return -ENODEV;
+
+	device = vfio_group_get_device(group, dev);
+	if (!device)
+		return -ENODEV;
+
+	*cap = device->dirty_pages_cap;
+	vfio_device_put(device);
+	vfio_group_put(group);
+	return 0;
+}
+EXPORT_SYMBOL(vfio_device_is_dirty_reporting_capable);
+
 /*
  * Pin a set of guest PFNs and return their associated host PFNs for local
  * domain only.
@@ -1907,6 +1932,14 @@ int vfio_pin_pages(struct device *dev, unsigned long *user_pfn, int npage,
 	else
 		ret = -ENOTTY;
 
+	if (ret > 0) {
+		struct vfio_device *device = vfio_group_get_device(group, dev);
+
+		if (device) {
+			device->dirty_pages_cap = true;
+			vfio_device_put(device);
+		}
+	}
 	vfio_group_try_dissolve_container(group);
 
 err_pin_pages:
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 68d8ed3b2665..ef56f31f4e73 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -891,6 +891,39 @@ static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
 	return bitmap;
 }
 
+static int vfio_is_dirty_pages_reporting_capable(struct device *dev, void *data)
+{
+	bool new;
+	int ret;
+
+	ret = vfio_device_is_dirty_reporting_capable(dev, &new);
+	if (ret)
+		return ret;
+
+	*(bool *)data = *(bool *)data && new;
+
+	return 0;
+}
+
+static bool vfio_dirty_pages_reporting_capable(struct vfio_iommu *iommu)
+{
+	struct vfio_domain *d;
+	struct vfio_group *g;
+	bool capable = true;
+	int ret;
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		list_for_each_entry(g, &d->group_list, next) {
+			ret = iommu_group_for_each_dev(g->iommu_group, &capable,
+					vfio_is_dirty_pages_reporting_capable);
+			if (ret)
+				return false;
+		}
+	}
+
+	return capable;
+}
+
 /*
  * start_iova is the reference from where bitmaping started. This is called
  * from DMA_UNMAP where start_iova can be different than iova
@@ -903,10 +936,17 @@ static void vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
 	struct vfio_dma *dma;
 	dma_addr_t i = iova;
 	unsigned long pgshift = __ffs(pgsize);
+	bool dirty_report_cap = true;
+
+	if (IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
+		dirty_report_cap = vfio_dirty_pages_reporting_capable(iommu);
 
 	while ((dma = vfio_find_dma(iommu, i, pgsize))) {
-		/* mark all pages dirty if all pages are pinned and mapped. */
-		if (dma->iommu_mapped) {
+		/*
+		 * mark all pages dirty if any IOMMU capable device is not able
+		 * to report dirty pages and all pages are pinned and mapped.
+		 */
+		if (!dirty_report_cap && dma->iommu_mapped) {
 			dma_addr_t iova_limit;
 
 			iova_limit = (dma->iova + dma->size) < (iova + size) ?
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e42a711a2800..ed3832ea10a1 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -148,7 +148,8 @@ extern int vfio_info_add_capability(struct vfio_info_cap *caps,
 extern int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
 					      int num_irqs, int max_irq_type,
 					      size_t *data_size);
-
+extern int vfio_device_is_dirty_reporting_capable(struct device *dev,
+						  bool *cap);
 struct pci_dev;
 #if IS_ENABLED(CONFIG_VFIO_SPAPR_EEH)
 extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
-- 
2.7.0



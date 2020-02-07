Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4329C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722CC20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QeWIUtuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722CC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0A7l-0004th-LZ
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1j0A3p-0006t2-Md
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1j0A3o-0007og-3I
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:17:09 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11755)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1j0A3n-0007kh-Ss
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:17:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e3dc5b40000>; Fri, 07 Feb 2020 12:16:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 07 Feb 2020 12:17:06 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 07 Feb 2020 12:17:06 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 20:17:06 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Feb 2020 20:16:59 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v12 Kernel 7/7] vfio: Selective dirty page tracking if IOMMU
 backed device pins pages
Date: Sat, 8 Feb 2020 01:12:34 +0530
Message-ID: <1581104554-10704-8-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1581106612; bh=YVAtaLtfgsC2YtbtiscRi9VO5xbl0xoPRNsPdWoiJ9g=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=QeWIUtuqVsrjKktkTpL8vA+7kHT7G81M2g8WYxEcNLpP3ygKEofIYGQq4Z1D9SwmM
 9sTWxJWcKIGAehXqc/Hvg0Go8Bc2ugEZm8AenMEdMzfp0OlY7hhsnr9Wyex3y8Wy3e
 Symeq5adh1WLE/s83Zp5PDUNRgNnOhnk1fnFOp9JM3rWx6PUms9eNFia1kLHBEVrOx
 Opmx52E5Q0cI0gCRpwKaDCM8UA0zVnFSbrZUe94ne+DANzHZI67rkgtPAIjEZoUIZj
 ICpBLLntzvgGZomE+ZRExhY2i/oWD9Eg0eKFOAmDu5YC+scCoJlTwA9Qm2UQTmTeqe
 ujZ6dmAV/d10Q==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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

Added a check such that only singleton IOMMU groups can pin pages.
From the point when vendor driver pins any pages, consider IOMMU group
dirty page scope to be limited to pinned pages.

To optimize to avoid walking list often, added flag
pinned_page_dirty_scope to indicate if all of the vfio_groups for each
vfio_domain in the domain_list dirty page scope is limited to pinned
pages. This flag is updated on first pinned pages request for that IOMMU
group and on attaching/detaching group.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 drivers/vfio/vfio.c             | 13 +++++++-
 drivers/vfio/vfio_iommu_type1.c | 72 +++++++++++++++++++++++++++++++++++++++--
 include/linux/vfio.h            |  4 ++-
 3 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index c8482624ca34..a941c860b440 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -87,6 +87,7 @@ struct vfio_group {
 	bool				noiommu;
 	struct kvm			*kvm;
 	struct blocking_notifier_head	notifier;
+	bool				is_singleton;
 };
 
 struct vfio_device {
@@ -838,6 +839,12 @@ int vfio_add_group_dev(struct device *dev,
 		return PTR_ERR(device);
 	}
 
+	mutex_lock(&group->device_lock);
+	group->is_singleton = false;
+	if (list_is_singular(&group->device_list))
+		group->is_singleton = true;
+	mutex_unlock(&group->device_lock);
+
 	/*
 	 * Drop all but the vfio_device reference.  The vfio_device holds
 	 * a reference to the vfio_group, which holds a reference to the
@@ -1895,6 +1902,9 @@ int vfio_pin_pages(struct device *dev, unsigned long *user_pfn, int npage,
 	if (!group)
 		return -ENODEV;
 
+	if (!group->is_singleton)
+		return -EINVAL;
+
 	ret = vfio_group_add_container_user(group);
 	if (ret)
 		goto err_pin_pages;
@@ -1902,7 +1912,8 @@ int vfio_pin_pages(struct device *dev, unsigned long *user_pfn, int npage,
 	container = group->container;
 	driver = container->iommu_driver;
 	if (likely(driver && driver->ops->pin_pages))
-		ret = driver->ops->pin_pages(container->iommu_data, user_pfn,
+		ret = driver->ops->pin_pages(container->iommu_data,
+					     group->iommu_group, user_pfn,
 					     npage, prot, phys_pfn);
 	else
 		ret = -ENOTTY;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f748a3dbe9f9..a787a2bcd757 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -71,6 +71,7 @@ struct vfio_iommu {
 	bool			v2;
 	bool			nesting;
 	bool			dirty_page_tracking;
+	bool			pinned_page_dirty_scope;
 };
 
 struct vfio_domain {
@@ -98,6 +99,7 @@ struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
 	bool			mdev_group;	/* An mdev group */
+	bool			has_pinned_pages;
 };
 
 struct vfio_iova {
@@ -129,6 +131,10 @@ struct vfio_regions {
 static int put_pfn(unsigned long pfn, int prot);
 static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
 
+static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
+					       struct iommu_group *iommu_group);
+
+static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu);
 /*
  * This code handles mapping and unmapping of user data buffers
  * into DMA'ble space using the IOMMU
@@ -580,11 +586,13 @@ static int vfio_unpin_page_external(struct vfio_iommu *iommu,
 }
 
 static int vfio_iommu_type1_pin_pages(void *iommu_data,
+				      struct iommu_group *iommu_group,
 				      unsigned long *user_pfn,
 				      int npage, int prot,
 				      unsigned long *phys_pfn)
 {
 	struct vfio_iommu *iommu = iommu_data;
+	struct vfio_group *group;
 	int i, j, ret;
 	unsigned long remote_vaddr;
 	struct vfio_dma *dma;
@@ -661,8 +669,14 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 			}
 		}
 	}
-
 	ret = i;
+
+	group = vfio_iommu_find_iommu_group(iommu, iommu_group);
+	if (!group->has_pinned_pages) {
+		group->has_pinned_pages = true;
+		update_pinned_page_dirty_scope(iommu);
+	}
+
 	goto pin_done;
 
 pin_unwind:
@@ -938,8 +952,11 @@ static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
 		unsigned int npages = 0, shift = 0;
 		unsigned char temp = 0;
 
-		/* mark all pages dirty if all pages are pinned and mapped. */
-		if (dma->iommu_mapped) {
+		/*
+		 * mark all pages dirty if any IOMMU capable device is not able
+		 * to report dirty pages and all pages are pinned and mapped.
+		 */
+		if (!iommu->pinned_page_dirty_scope && dma->iommu_mapped) {
 			iova_limit = min(dma->iova + dma->size, iova + size);
 			npages = iova_limit/pgsize;
 			bitmap_set(dma->bitmap, 0, npages);
@@ -1479,6 +1496,51 @@ static struct vfio_group *find_iommu_group(struct vfio_domain *domain,
 	return NULL;
 }
 
+static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
+					       struct iommu_group *iommu_group)
+{
+	struct vfio_domain *domain;
+	struct vfio_group *group = NULL;
+
+	list_for_each_entry(domain, &iommu->domain_list, next) {
+		group = find_iommu_group(domain, iommu_group);
+		if (group)
+			return group;
+	}
+
+	if (iommu->external_domain)
+		group = find_iommu_group(iommu->external_domain, iommu_group);
+
+	return group;
+}
+
+static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu)
+{
+	struct vfio_domain *domain;
+	struct vfio_group *group;
+
+	list_for_each_entry(domain, &iommu->domain_list, next) {
+		list_for_each_entry(group, &domain->group_list, next) {
+			if (!group->has_pinned_pages) {
+				iommu->pinned_page_dirty_scope = false;
+				return;
+			}
+		}
+	}
+
+	if (iommu->external_domain) {
+		domain = iommu->external_domain;
+		list_for_each_entry(group, &domain->group_list, next) {
+			if (!group->has_pinned_pages) {
+				iommu->pinned_page_dirty_scope = false;
+				return;
+			}
+		}
+	}
+
+	iommu->pinned_page_dirty_scope = true;
+}
+
 static bool vfio_iommu_has_sw_msi(struct list_head *group_resv_regions,
 				  phys_addr_t *base)
 {
@@ -1885,6 +1947,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 
 			list_add(&group->next,
 				 &iommu->external_domain->group_list);
+			update_pinned_page_dirty_scope(iommu);
 			mutex_unlock(&iommu->lock);
 
 			return 0;
@@ -2007,6 +2070,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 done:
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
+	update_pinned_page_dirty_scope(iommu);
 	mutex_unlock(&iommu->lock);
 	vfio_iommu_resv_free(&group_resv_regions);
 
@@ -2021,6 +2085,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 out_free:
 	kfree(domain);
 	kfree(group);
+	update_pinned_page_dirty_scope(iommu);
 	mutex_unlock(&iommu->lock);
 	return ret;
 }
@@ -2225,6 +2290,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		vfio_iommu_iova_free(&iova_copy);
 
 detach_group_done:
+	update_pinned_page_dirty_scope(iommu);
 	mutex_unlock(&iommu->lock);
 }
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e42a711a2800..da29802d6276 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -72,7 +72,9 @@ struct vfio_iommu_driver_ops {
 					struct iommu_group *group);
 	void		(*detach_group)(void *iommu_data,
 					struct iommu_group *group);
-	int		(*pin_pages)(void *iommu_data, unsigned long *user_pfn,
+	int		(*pin_pages)(void *iommu_data,
+				     struct iommu_group *group,
+				     unsigned long *user_pfn,
 				     int npage, int prot,
 				     unsigned long *phys_pfn);
 	int		(*unpin_pages)(void *iommu_data,
-- 
2.7.0



Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB49C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D4D20752
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LrsaFscE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D4D20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEf9I-00024Y-4O
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jEf6G-0006RY-8J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jEf6E-0008O9-F7
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:15:36 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jEf6E-0008LM-87
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:15:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7281580000>; Wed, 18 Mar 2020 13:15:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Wed, 18 Mar 2020 13:15:33 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Wed, 18 Mar 2020 13:15:33 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Mar
 2020 20:15:32 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Mar 2020 20:15:26 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v14 Kernel 7/7] vfio: Selective dirty page tracking if IOMMU
 backed device pins pages
Date: Thu, 19 Mar 2020 01:11:14 +0530
Message-ID: <1584560474-19946-8-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584562520; bh=8VlsLIVPHZAq5ZJWXywAGXpd7HfPucReDuvSFacF2X8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=LrsaFscEVvEj3ViKAwGaPzK90kIJTizNhlPoo+3oANEgt4Jiir2EAFXSY+oqvcQhx
 wXMBTB6qaEcj0XvIIp6Jn8B+IiaI8qLzyknJ/BbRAry8g1lnWybW5Yk1TLtwRstN1i
 +rq1cRIgOwWTwoC9P5QwS6gnj2LeLE6nFLaOQpXybiHgDY6ApjCJ/Vs9sc4i7vNU3D
 u8uBdoGbq8360Bj9k5FQNnk8fCPysKRsMGBLh6UA/hRxVtx7SpPtUpbOtZxaLAhRej
 LKmfoOpM7hwtwtUPLdndk7L6DITyjHhTCIf6Dz9P+RZy9pk1Aombphf5mPDFVnrKq5
 EZ0bvMuHQ9xvA==
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
 drivers/vfio/vfio.c             | 13 +++++--
 drivers/vfio/vfio_iommu_type1.c | 77 +++++++++++++++++++++++++++++++++++++++--
 include/linux/vfio.h            |  4 ++-
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 210fcf426643..311b5e4e111e 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -85,6 +85,7 @@ struct vfio_group {
 	atomic_t			opened;
 	wait_queue_head_t		container_q;
 	bool				noiommu;
+	unsigned int			dev_counter;
 	struct kvm			*kvm;
 	struct blocking_notifier_head	notifier;
 };
@@ -555,6 +556,7 @@ struct vfio_device *vfio_group_create_device(struct vfio_group *group,
 
 	mutex_lock(&group->device_lock);
 	list_add(&device->group_next, &group->device_list);
+	group->dev_counter++;
 	mutex_unlock(&group->device_lock);
 
 	return device;
@@ -567,6 +569,7 @@ static void vfio_device_release(struct kref *kref)
 	struct vfio_group *group = device->group;
 
 	list_del(&device->group_next);
+	group->dev_counter--;
 	mutex_unlock(&group->device_lock);
 
 	dev_set_drvdata(device->dev, NULL);
@@ -1933,6 +1936,9 @@ int vfio_pin_pages(struct device *dev, unsigned long *user_pfn, int npage,
 	if (!group)
 		return -ENODEV;
 
+	if (group->dev_counter > 1)
+		return -EINVAL;
+
 	ret = vfio_group_add_container_user(group);
 	if (ret)
 		goto err_pin_pages;
@@ -1940,7 +1946,8 @@ int vfio_pin_pages(struct device *dev, unsigned long *user_pfn, int npage,
 	container = group->container;
 	driver = container->iommu_driver;
 	if (likely(driver && driver->ops->pin_pages))
-		ret = driver->ops->pin_pages(container->iommu_data, user_pfn,
+		ret = driver->ops->pin_pages(container->iommu_data,
+					     group->iommu_group, user_pfn,
 					     npage, prot, phys_pfn);
 	else
 		ret = -ENOTTY;
@@ -2038,8 +2045,8 @@ int vfio_group_pin_pages(struct vfio_group *group,
 	driver = container->iommu_driver;
 	if (likely(driver && driver->ops->pin_pages))
 		ret = driver->ops->pin_pages(container->iommu_data,
-					     user_iova_pfn, npage,
-					     prot, phys_pfn);
+					     group->iommu_group, user_iova_pfn,
+					     npage, prot, phys_pfn);
 	else
 		ret = -ENOTTY;
 
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 912629320719..deec09f4b0f6 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -72,6 +72,7 @@ struct vfio_iommu {
 	bool			v2;
 	bool			nesting;
 	bool			dirty_page_tracking;
+	bool			pinned_page_dirty_scope;
 };
 
 struct vfio_domain {
@@ -99,6 +100,7 @@ struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
 	bool			mdev_group;	/* An mdev group */
+	bool			pinned_page_dirty_scope;
 };
 
 struct vfio_iova {
@@ -132,6 +134,10 @@ struct vfio_regions {
 static int put_pfn(unsigned long pfn, int prot);
 static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu);
 
+static struct vfio_group *vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
+					       struct iommu_group *iommu_group);
+
+static void update_pinned_page_dirty_scope(struct vfio_iommu *iommu);
 /*
  * This code handles mapping and unmapping of user data buffers
  * into DMA'ble space using the IOMMU
@@ -556,11 +562,13 @@ static int vfio_unpin_page_external(struct vfio_dma *dma, dma_addr_t iova,
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
@@ -630,8 +638,14 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 				   (vpfn->iova - dma->iova) >> pgshift, 1);
 		}
 	}
-
 	ret = i;
+
+	group = vfio_iommu_find_iommu_group(iommu, iommu_group);
+	if (!group->pinned_page_dirty_scope) {
+		group->pinned_page_dirty_scope = true;
+		update_pinned_page_dirty_scope(iommu);
+	}
+
 	goto pin_done;
 
 pin_unwind:
@@ -913,8 +927,11 @@ static int vfio_iova_dirty_bitmap(struct vfio_iommu *iommu, dma_addr_t iova,
 	npages = dma->size >> pgshift;
 	bitmap_size = DIRTY_BITMAP_BYTES(npages);
 
-	/* mark all pages dirty if all pages are pinned and mapped. */
-	if (dma->iommu_mapped)
+	/*
+	 * mark all pages dirty if any IOMMU capable device is not able
+	 * to report dirty pages and all pages are pinned and mapped.
+	 */
+	if (!iommu->pinned_page_dirty_scope && dma->iommu_mapped)
 		bitmap_set(dma->bitmap, 0, npages);
 
 	if (copy_to_user((void __user *)bitmap, dma->bitmap, bitmap_size))
@@ -1393,6 +1410,51 @@ static struct vfio_group *find_iommu_group(struct vfio_domain *domain,
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
+			if (!group->pinned_page_dirty_scope) {
+				iommu->pinned_page_dirty_scope = false;
+				return;
+			}
+		}
+	}
+
+	if (iommu->external_domain) {
+		domain = iommu->external_domain;
+		list_for_each_entry(group, &domain->group_list, next) {
+			if (!group->pinned_page_dirty_scope) {
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
@@ -1799,6 +1861,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 
 			list_add(&group->next,
 				 &iommu->external_domain->group_list);
+			group->pinned_page_dirty_scope = true;
+			if (!iommu->pinned_page_dirty_scope)
+				update_pinned_page_dirty_scope(iommu);
 			mutex_unlock(&iommu->lock);
 
 			return 0;
@@ -1921,6 +1986,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 done:
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
+	iommu->pinned_page_dirty_scope = false;
 	mutex_unlock(&iommu->lock);
 	vfio_iommu_resv_free(&group_resv_regions);
 
@@ -2073,6 +2139,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_domain *domain;
 	struct vfio_group *group;
+	bool update_dirty_scope = false;
 	LIST_HEAD(iova_copy);
 
 	mutex_lock(&iommu->lock);
@@ -2080,6 +2147,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	if (iommu->external_domain) {
 		group = find_iommu_group(iommu->external_domain, iommu_group);
 		if (group) {
+			update_dirty_scope = !group->pinned_page_dirty_scope;
 			list_del(&group->next);
 			kfree(group);
 
@@ -2109,6 +2177,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 			continue;
 
 		vfio_iommu_detach_group(domain, group);
+		update_dirty_scope = !group->pinned_page_dirty_scope;
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -2139,6 +2208,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		vfio_iommu_iova_free(&iova_copy);
 
 detach_group_done:
+	if (update_dirty_scope)
+		update_pinned_page_dirty_scope(iommu);
 	mutex_unlock(&iommu->lock);
 }
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index be2bd358b952..702e1d7b6e8b 100644
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



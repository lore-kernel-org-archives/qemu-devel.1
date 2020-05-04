Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B34C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA38C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hpPDYMTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA38C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVfqL-0004PY-6I
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVfog-0001M3-LI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:27:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVfof-0004OY-9J
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:27:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb05e200000>; Mon, 04 May 2020 11:25:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 11:27:43 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 04 May 2020 11:27:43 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 18:27:43 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 May 2020 18:27:36 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v1 1/2] Sample mtty: Add sysfs interface to pin pages
Date: Mon, 4 May 2020 23:24:19 +0530
Message-ID: <1588614860-16330-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588614860-16330-1-git-send-email-kwankhede@nvidia.com>
References: <1588614860-16330-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588616736; bh=LM7O/QtPrNroYPHMAw1tDGhJJm1iWHCvYUgOsUsGJ7U=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=hpPDYMTIWyA3RSFu+DgJWyk3YbCP/vjKSL74Gb5ZdospGbspIf2/V1Feypa9UgNrU
 aePDwyyivOy/Ul61M29DEr6mv+M0TWUs7YlRQKLdAZVcQ1ROs5FV/ciu60/Ht/P1a9
 a9+p2Z6J2cG6zY0CSzOiqV73QCUFztxnN5KFzO2ymaDrnfIGGE7T4lzRcUcrH9dM7H
 yRAHOBcevjE9pUCPVU7GBlH87wfVnKxpP7+27dRC1J/xOrPVlkKA/IjIsS4ZzUap6y
 xreQplhyETU3I/mkFFnVKzWVkOkZ9M/cSc0NXReD93bmy8LkO9HDoi5V6mtoDp6QMi
 d9m1JVpb8j5QA==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:32:29
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Added sysfs interface to pin pages which will be used to test migration
when vendor driver pins pages.

Read on pin_pages shows number of pages pinned:
 $ cat /sys/bus/mdev/devices/<mdev UUID>/vendor/pin_pages
Pinned 0x0 pages

Write gpfn to pin_pages to pin that page. One page pinned on write
 $ echo 0x20 > /sys/bus/mdev/devices/<mdev UUID>/vendor/pin_pages

Limitation: Buffer for 2GB system memory is created to track pinned
pages.

This is for testing purpose only.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
---
 samples/vfio-mdev/mtty.c | 176 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 175 insertions(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index ce84a300a4da..bf666cce5bb7 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -64,6 +64,10 @@
 				(((u64)(1) << MTTY_VFIO_PCI_OFFSET_SHIFT) - 1)
 #define MAX_MTTYS	24
 
+/* Maximum pages of 4K for upto 2G RAM can be pinned */
+#define MAX_GPFN_COUNT	(512 * 1024)
+#define PFN_NULL	(~0UL)
+
 /*
  * Global Structures
  */
@@ -141,6 +145,10 @@ struct mdev_state {
 	struct mutex rxtx_lock;
 	struct vfio_device_info dev_info;
 	int nr_ports;
+
+	/* List of pinned gpfns, gpfn as index and content is translated hpfn */
+	unsigned long *gpfn_to_hpfn;
+	struct notifier_block nb;
 };
 
 static struct mutex mdev_list_lock;
@@ -745,6 +753,17 @@ static int mtty_create(struct kobject *kobj, struct mdev_device *mdev)
 		return -ENOMEM;
 	}
 
+	mdev_state->gpfn_to_hpfn =
+		 kzalloc(sizeof(unsigned long) * MAX_GPFN_COUNT, GFP_KERNEL);
+	if (mdev_state->gpfn_to_hpfn == NULL) {
+		kfree(mdev_state->vconfig);
+		kfree(mdev_state);
+		return -ENOMEM;
+	}
+
+	memset(mdev_state->gpfn_to_hpfn, ~0,
+	       sizeof(unsigned long) * MAX_GPFN_COUNT);
+
 	mutex_init(&mdev_state->ops_lock);
 	mdev_state->mdev = mdev;
 	mdev_set_drvdata(mdev, mdev_state);
@@ -769,6 +788,7 @@ static int mtty_remove(struct mdev_device *mdev)
 		if (mdev_state == mds) {
 			list_del(&mdev_state->next);
 			mdev_set_drvdata(mdev, NULL);
+			kfree(mdev_state->gpfn_to_hpfn);
 			kfree(mdev_state->vconfig);
 			kfree(mdev_state);
 			ret = 0;
@@ -1246,15 +1266,95 @@ static long mtty_ioctl(struct mdev_device *mdev, unsigned int cmd,
 	return -ENOTTY;
 }
 
+static void unpin_pages_all(struct mdev_state *mdev_state)
+{
+	struct mdev_device *mdev = mdev_state->mdev;
+	unsigned long i;
+
+	mutex_lock(&mdev_state->ops_lock);
+	for (i = 0; i < MAX_GPFN_COUNT; i++) {
+		if (mdev_state->gpfn_to_hpfn[i] != PFN_NULL) {
+			int ret;
+
+			ret = vfio_unpin_pages(mdev_dev(mdev), &i, 1);
+			if (ret <= 0) {
+				pr_err("%s: 0x%lx unpin error %d\n",
+					 __func__, i, ret);
+				continue;
+			}
+			mdev_state->gpfn_to_hpfn[i] = PFN_NULL;
+		}
+	}
+	mutex_unlock(&mdev_state->ops_lock);
+}
+
+static int unmap_notifier(struct notifier_block *nb, unsigned long action,
+			  void *data)
+{
+	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
+		struct mdev_state *mdev_state = container_of(nb,
+							 struct mdev_state, nb);
+		struct mdev_device *mdev = mdev_state->mdev;
+		struct vfio_iommu_type1_dma_unmap *unmap = data;
+		unsigned long start = unmap->iova >> PAGE_SHIFT;
+		unsigned long end = (unmap->iova + unmap->size) >> PAGE_SHIFT;
+		unsigned long i;
+
+		mutex_lock(&mdev_state->ops_lock);
+		for (i = start; i < end; i++) {
+			if (mdev_state->gpfn_to_hpfn[i] != PFN_NULL) {
+				int ret;
+
+				ret = vfio_unpin_pages(mdev_dev(mdev), &i, 1);
+				if (ret <= 0) {
+					pr_err("%s: 0x%lx unpin error %d\n",
+							__func__, i, ret);
+					continue;
+				}
+				mdev_state->gpfn_to_hpfn[i] = PFN_NULL;
+			}
+		}
+		mutex_unlock(&mdev_state->ops_lock);
+
+	}
+	return 0;
+}
+
 static int mtty_open(struct mdev_device *mdev)
 {
+	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	struct mdev_state *mdev_state;
+	int ret;
+
 	pr_info("%s\n", __func__);
-	return 0;
+
+	if (!mdev)
+		return -EINVAL;
+
+	mdev_state = mdev_get_drvdata(mdev);
+	if (!mdev_state)
+		return -ENODEV;
+
+	mdev_state->nb.notifier_call = unmap_notifier;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY, &events,
+				     &mdev_state->nb);
+	return ret;
 }
 
 static void mtty_close(struct mdev_device *mdev)
 {
+	struct mdev_state *mdev_state;
+
 	pr_info("%s\n", __func__);
+
+	mdev_state = mdev_get_drvdata(mdev);
+	if (!mdev_state)
+		return;
+
+	unpin_pages_all(mdev_state);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &mdev_state->nb);
 }
 
 static ssize_t
@@ -1293,8 +1393,82 @@ sample_mdev_dev_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(sample_mdev_dev);
 
+static ssize_t
+pin_pages_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct mdev_state *mdev_state;
+	int i, count = 0;
+
+	if (!mdev)
+		return -EINVAL;
+
+	mdev_state = mdev_get_drvdata(mdev);
+	if (!mdev_state)
+		return -EINVAL;
+
+	mutex_lock(&mdev_state->ops_lock);
+	for (i = 0; i < MAX_GPFN_COUNT; i++) {
+		if (mdev_state->gpfn_to_hpfn[i] != PFN_NULL)
+			count++;
+	}
+	mutex_unlock(&mdev_state->ops_lock);
+	return sprintf(buf, "Pinned 0x%x pages\n", count);
+}
+
+static ssize_t
+pin_pages_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct mdev_device *mdev = mdev_from_dev(dev);
+	struct mdev_state *mdev_state;
+	unsigned long gpfn, hpfn;
+	int ret;
+
+	if (!mdev)
+		return -EINVAL;
+
+	mdev_state = mdev_get_drvdata(mdev);
+	if (!mdev_state)
+		return -EINVAL;
+
+	ret = kstrtoul(buf, 0, &gpfn);
+	if (ret)
+		return ret;
+
+	if (gpfn >= MAX_GPFN_COUNT) {
+		pr_err("Error 0x%lx > 0x%lx\n",
+		       gpfn, (unsigned long)MAX_GPFN_COUNT);
+		return -EINVAL;
+	}
+
+	mutex_lock(&mdev_state->ops_lock);
+
+	if (mdev_state->gpfn_to_hpfn[gpfn] != PFN_NULL) {
+		ret = -EEXIST;
+		goto out;
+	}
+
+	ret = vfio_pin_pages(mdev_dev(mdev), &gpfn, 1,
+			     IOMMU_READ | IOMMU_WRITE, &hpfn);
+
+	if (ret <= 0) {
+		pr_err("Failed to pin, ret %d\n", ret);
+		goto out;
+	}
+
+	mdev_state->gpfn_to_hpfn[gpfn] = hpfn;
+	ret = count;
+out:
+	mutex_unlock(&mdev_state->ops_lock);
+	return ret;
+}
+
+static DEVICE_ATTR_RW(pin_pages);
+
 static struct attribute *mdev_dev_attrs[] = {
 	&dev_attr_sample_mdev_dev.attr,
+	&dev_attr_pin_pages.attr,
 	NULL,
 };
 
-- 
2.7.0



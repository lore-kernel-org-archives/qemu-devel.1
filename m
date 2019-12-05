Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674EAC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA966206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA966206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ichyu-00072i-B2
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichu0-0000dO-Li
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichtx-00005H-Kl
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:34:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:37478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ichtx-0008TT-7o
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:34:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="243094895"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2019 19:33:56 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 1/9] vfio/pci: introduce mediate ops to intercept vfio-pci
 ops
Date: Wed,  4 Dec 2019 22:25:36 -0500
Message-Id: <20191205032536.29653-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205032419.29606-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 zhenyuw@linux.intel.com, qemu-devel@nongnu.org, shaopeng.he@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

when vfio-pci is bound to a physical device, almost all the hardware
resources are passthroughed.
Sometimes, vendor driver of this physcial device may want to mediate some
hardware resource access for a short period of time, e.g. dirty page
tracking during live migration.

Here we introduce mediate ops in vfio-pci for this purpose.

Vendor driver can register a mediate ops to vfio-pci.
But rather than directly bind to the passthroughed device, the
vendor driver is now either a module that does not bind to any device or
a module binds to other device.
E.g. when passing through a VF device that is bound to vfio-pci modules,
PF driver that binds to PF device can register to vfio-pci to mediate
VF's regions, hence supporting VF live migration.

The sequence goes like this:
1. Vendor driver register its vfio_pci_mediate_ops to vfio-pci driver

2. vfio-pci maintains a list of those registered vfio_pci_mediate_ops

3. Whenever vfio-pci opens a device, it searches the list and call
vfio_pci_mediate_ops->open() to check whether a vendor driver supports
mediating this device.
Upon a success return value of from vfio_pci_mediate_ops->open(),
vfio-pci will stop list searching and store a mediate handle to
represent this open into vendor driver.
(so if multiple vendor drivers support mediating a device through
vfio_pci_mediate_ops, only one will win, depending on their registering
sequence)

4. Whenever a VFIO_DEVICE_GET_REGION_INFO ioctl is received in vfio-pci
ops, it will chain into vfio_pci_mediate_ops->get_region_info(), so that
vendor driver is able to override a region's default flags and caps,
e.g. adding a sparse mmap cap to passthrough only sub-regions of a whole
region.

5. vfio_pci_rw()/vfio_pci_mmap() first calls into
vfio_pci_mediate_ops->rw()/vfio_pci_mediate_ops->mmaps().
if pt=true is rteturned, vfio_pci_rw()/vfio_pci_mmap() will further
passthrough this read/write/mmap to physical device, otherwise it just
returns without touch physical device.

6. When vfio-pci closes a device, vfio_pci_release() chains into
vfio_pci_mediate_ops->release() to close the reference in vendor driver.

7. Vendor driver unregister its vfio_pci_mediate_ops when driver exits

Cc: Kevin Tian <kevin.tian@intel.com>

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/vfio/pci/vfio_pci.c         | 146 ++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |   2 +
 include/linux/vfio.h                |  16 +++
 3 files changed, 164 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 02206162eaa9..55080ff29495 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -54,6 +54,14 @@ module_param(disable_idle_d3, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(disable_idle_d3,
 		 "Disable using the PCI D3 low power state for idle, unused devices");
 
+static LIST_HEAD(mediate_ops_list);
+static DEFINE_MUTEX(mediate_ops_list_lock);
+struct vfio_pci_mediate_ops_list_entry {
+	struct vfio_pci_mediate_ops	*ops;
+	int				refcnt;
+	struct list_head		next;
+};
+
 static inline bool vfio_vga_disabled(void)
 {
 #ifdef CONFIG_VFIO_PCI_VGA
@@ -472,6 +480,10 @@ static void vfio_pci_release(void *device_data)
 	if (!(--vdev->refcnt)) {
 		vfio_spapr_pci_eeh_release(vdev->pdev);
 		vfio_pci_disable(vdev);
+		if (vdev->mediate_ops && vdev->mediate_ops->release) {
+			vdev->mediate_ops->release(vdev->mediate_handle);
+			vdev->mediate_ops = NULL;
+		}
 	}
 
 	mutex_unlock(&vdev->reflck->lock);
@@ -483,6 +495,7 @@ static int vfio_pci_open(void *device_data)
 {
 	struct vfio_pci_device *vdev = device_data;
 	int ret = 0;
+	struct vfio_pci_mediate_ops_list_entry *mentry;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENODEV;
@@ -495,6 +508,30 @@ static int vfio_pci_open(void *device_data)
 			goto error;
 
 		vfio_spapr_pci_eeh_open(vdev->pdev);
+		mutex_lock(&mediate_ops_list_lock);
+		list_for_each_entry(mentry, &mediate_ops_list, next) {
+			u64 caps;
+			u32 handle;
+
+			memset(&caps, 0, sizeof(caps));
+			ret = mentry->ops->open(vdev->pdev, &caps, &handle);
+			if (!ret)  {
+				vdev->mediate_ops = mentry->ops;
+				vdev->mediate_handle = handle;
+
+				pr_info("vfio pci found mediate_ops %s, caps=%llx, handle=%x for %x:%x\n",
+						vdev->mediate_ops->name, caps,
+						handle, vdev->pdev->vendor,
+						vdev->pdev->device);
+				/*
+				 * only find the first matching mediate_ops,
+				 * and add its refcnt
+				 */
+				mentry->refcnt++;
+				break;
+			}
+		}
+		mutex_unlock(&mediate_ops_list_lock);
 	}
 	vdev->refcnt++;
 error:
@@ -736,6 +773,14 @@ static long vfio_pci_ioctl(void *device_data,
 			info.size = pdev->cfg_size;
 			info.flags = VFIO_REGION_INFO_FLAG_READ |
 				     VFIO_REGION_INFO_FLAG_WRITE;
+
+			if (vdev->mediate_ops &&
+					vdev->mediate_ops->get_region_info) {
+				vdev->mediate_ops->get_region_info(
+						vdev->mediate_handle,
+						&info, &caps, NULL);
+			}
+
 			break;
 		case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
 			info.offset = VFIO_PCI_INDEX_TO_OFFSET(info.index);
@@ -756,6 +801,13 @@ static long vfio_pci_ioctl(void *device_data,
 				}
 			}
 
+			if (vdev->mediate_ops &&
+					vdev->mediate_ops->get_region_info) {
+				vdev->mediate_ops->get_region_info(
+						vdev->mediate_handle,
+						&info, &caps, NULL);
+			}
+
 			break;
 		case VFIO_PCI_ROM_REGION_INDEX:
 		{
@@ -794,6 +846,14 @@ static long vfio_pci_ioctl(void *device_data,
 			}
 
 			pci_write_config_word(pdev, PCI_COMMAND, orig_cmd);
+
+			if (vdev->mediate_ops &&
+					vdev->mediate_ops->get_region_info) {
+				vdev->mediate_ops->get_region_info(
+						vdev->mediate_handle,
+						&info, &caps, NULL);
+			}
+
 			break;
 		}
 		case VFIO_PCI_VGA_REGION_INDEX:
@@ -805,6 +865,13 @@ static long vfio_pci_ioctl(void *device_data,
 			info.flags = VFIO_REGION_INFO_FLAG_READ |
 				     VFIO_REGION_INFO_FLAG_WRITE;
 
+			if (vdev->mediate_ops &&
+					vdev->mediate_ops->get_region_info) {
+				vdev->mediate_ops->get_region_info(
+						vdev->mediate_handle,
+						&info, &caps, NULL);
+			}
+
 			break;
 		default:
 		{
@@ -839,6 +906,13 @@ static long vfio_pci_ioctl(void *device_data,
 				if (ret)
 					return ret;
 			}
+
+			if (vdev->mediate_ops &&
+					vdev->mediate_ops->get_region_info) {
+				vdev->mediate_ops->get_region_info(
+						vdev->mediate_handle,
+						&info, &caps, &cap_type);
+			}
 		}
 		}
 
@@ -1151,6 +1225,16 @@ static ssize_t vfio_pci_rw(void *device_data, char __user *buf,
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 		return -EINVAL;
 
+	if (vdev->mediate_ops && vdev->mediate_ops->rw) {
+		int ret;
+		bool pt = true;
+
+		ret = vdev->mediate_ops->rw(vdev->mediate_handle,
+				buf, count, ppos, iswrite, &pt);
+		if (!pt)
+			return ret;
+	}
+
 	switch (index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		return vfio_pci_config_rw(vdev, buf, count, ppos, iswrite);
@@ -1200,6 +1284,15 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
 	u64 phys_len, req_len, pgoff, req_start;
 	int ret;
 
+	if (vdev->mediate_ops && vdev->mediate_ops->mmap) {
+		int ret;
+		bool pt = true;
+
+		ret = vdev->mediate_ops->mmap(vdev->mediate_handle, vma, &pt);
+		if (!pt)
+			return ret;
+	}
+
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
 	if (vma->vm_end < vma->vm_start)
@@ -1629,8 +1722,17 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
 
 static void __exit vfio_pci_cleanup(void)
 {
+	struct vfio_pci_mediate_ops_list_entry *mentry, *n;
+
 	pci_unregister_driver(&vfio_pci_driver);
 	vfio_pci_uninit_perm_bits();
+
+	mutex_lock(&mediate_ops_list_lock);
+	list_for_each_entry_safe(mentry, n,  &mediate_ops_list, next) {
+		list_del(&mentry->next);
+		kfree(mentry);
+	}
+	mutex_unlock(&mediate_ops_list_lock);
 }
 
 static void __init vfio_pci_fill_ids(void)
@@ -1697,6 +1799,50 @@ static int __init vfio_pci_init(void)
 	return ret;
 }
 
+int vfio_pci_register_mediate_ops(struct vfio_pci_mediate_ops *ops)
+{
+	struct vfio_pci_mediate_ops_list_entry *mentry;
+
+	mutex_lock(&mediate_ops_list_lock);
+	mentry = kzalloc(sizeof(*mentry), GFP_KERNEL);
+	if (!mentry) {
+		mutex_unlock(&mediate_ops_list_lock);
+		return -ENOMEM;
+	}
+
+	mentry->ops = ops;
+	mentry->refcnt = 0;
+	list_add(&mentry->next, &mediate_ops_list);
+
+	pr_info("registered dm ops %s\n", ops->name);
+	mutex_unlock(&mediate_ops_list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(vfio_pci_register_mediate_ops);
+
+void vfio_pci_unregister_mediate_ops(struct vfio_pci_mediate_ops *ops)
+{
+	struct vfio_pci_mediate_ops_list_entry *mentry, *n;
+
+	mutex_lock(&mediate_ops_list_lock);
+	list_for_each_entry_safe(mentry, n,  &mediate_ops_list, next) {
+		if (mentry->ops != ops)
+			continue;
+
+		mentry->refcnt--;
+		if (!mentry->refcnt) {
+			list_del(&mentry->next);
+			kfree(mentry);
+		} else
+			pr_err("vfio_pci unregister mediate ops %s error\n",
+					mentry->ops->name);
+	}
+	mutex_unlock(&mediate_ops_list_lock);
+
+}
+EXPORT_SYMBOL(vfio_pci_unregister_mediate_ops);
+
 module_init(vfio_pci_init);
 module_exit(vfio_pci_cleanup);
 
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index ee6ee91718a4..bad4a254360e 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -122,6 +122,8 @@ struct vfio_pci_device {
 	struct list_head	dummy_resources_list;
 	struct mutex		ioeventfds_lock;
 	struct list_head	ioeventfds_list;
+	struct vfio_pci_mediate_ops *mediate_ops;
+	u32			 mediate_handle;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e42a711a2800..0265e779acd1 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -195,4 +195,20 @@ extern int vfio_virqfd_enable(void *opaque,
 			      void *data, struct virqfd **pvirqfd, int fd);
 extern void vfio_virqfd_disable(struct virqfd **pvirqfd);
 
+struct vfio_pci_mediate_ops {
+	char	*name;
+	int	(*open)(struct pci_dev *pdev, u64 *caps, u32 *handle);
+	void	(*release)(int handle);
+	void	(*get_region_info)(int handle,
+			struct vfio_region_info *info,
+			struct vfio_info_cap *caps,
+			struct vfio_region_info_cap_type *cap_type);
+	ssize_t	(*rw)(int handle, char __user *buf,
+			   size_t count, loff_t *ppos, bool iswrite, bool *pt);
+	int	(*mmap)(int handle, struct vm_area_struct *vma, bool *pt);
+
+};
+extern int vfio_pci_register_mediate_ops(struct vfio_pci_mediate_ops *ops);
+extern void vfio_pci_unregister_mediate_ops(struct vfio_pci_mediate_ops *ops);
+
 #endif /* VFIO_H */
-- 
2.17.1



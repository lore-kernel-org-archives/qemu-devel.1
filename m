Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5656C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A259206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A259206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ici91-0000cx-As
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichvU-0002UC-Me
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichvS-0003DS-Kq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:35:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:19462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ichvS-0003B8-69
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:35:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:35:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="243095235"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2019 19:35:30 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 6/9] sample/vfio-pci/igd_dt: dynamically trap/untrap
 subregion of IGD bar0
Date: Wed,  4 Dec 2019 22:27:20 -0500
Message-Id: <20191205032720.29888-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205032419.29606-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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

This sample code first returns device
cap |= VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR, so that vfio-pci driver
would create for it a dynamic-trap-bar-info region
(of type VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO and
subtype VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO)

Then in igd_dt_get_region_info(), this sample driver will customize the
size of dynamic-trap-bar-info region.
Also, this sample driver customizes BAR 0 region to be sparse mmaped
(only passthrough subregion from BAR0_DYNAMIC_TRAP_OFFSET of size
BAR0_DYNAMIC_TRAP_SIZE) and set this sparse mmaped subregion as disablable.

Then when QEMU detects the dynamic trap bar info region, it will create
an eventfd and write its fd into 'dt_fd' field of this region.

When BAR0's registers below BAR0_DYNAMIC_TRAP_OFFSET is trapped, it will
signal the eventfd to notify QEMU to read 'trap' field of dynamic trap bar
info region  and put previously passthroughed subregion to be trapped.
After registers within BAR0_DYNAMIC_TRAP_OFFSET and
BAR0_DYNAMIC_TRAP_SIZE are trapped, this sample driver notifies QEMU via
eventfd to passthrough this subregion again.

Cc: Kevin Tian <kevin.tian@intel.com>

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 samples/vfio-pci/igd_dt.c | 176 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/samples/vfio-pci/igd_dt.c b/samples/vfio-pci/igd_dt.c
index 857e8d01b0d1..58ef110917f1 100644
--- a/samples/vfio-pci/igd_dt.c
+++ b/samples/vfio-pci/igd_dt.c
@@ -29,6 +29,9 @@
 /* This driver supports to open max 256 device devices */
 #define MAX_OPEN_DEVICE 256
 
+#define BAR0_DYNAMIC_TRAP_OFFSET (32*1024)
+#define BAR0_DYNAMIC_TRAP_SIZE (32*1024)
+
 /*
  * below are pciids of two IGD devices supported in this driver
  * It is only for demo purpose.
@@ -47,10 +50,30 @@ struct igd_dt_device {
 	__u32 vendor;
 	__u32 device;
 	__u32 handle;
+
+	__u64 dt_region_index;
+	struct eventfd_ctx *dt_trigger;
+	bool is_highend_trapped;
+	bool is_trap_triggered;
 };
 
 static struct igd_dt_device *igd_device_array[MAX_OPEN_DEVICE];
 
+static bool is_handle_valid(int handle)
+{
+	mutex_lock(&device_bit_lock);
+
+	if (handle >= MAX_OPEN_DEVICE || !igd_device_array[handle] ||
+			!test_bit(handle, igd_device_bits)) {
+		pr_err("%s: handle mismatch, please check interaction with vfio-pci module\n",
+				__func__);
+		mutex_unlock(&device_bit_lock);
+		return false;
+	}
+	mutex_unlock(&device_bit_lock);
+	return true;
+}
+
 int igd_dt_open(struct pci_dev *pdev, u64 *caps, u32 *mediate_handle)
 {
 	int supported_dev_cnt = sizeof(pciidlist)/sizeof(struct pci_device_id);
@@ -88,6 +111,7 @@ int igd_dt_open(struct pci_dev *pdev, u64 *caps, u32 *mediate_handle)
 	igd_device->vendor = pdev->vendor;
 	igd_device->device = pdev->device;
 	igd_device->handle = handle;
+	igd_device->dt_region_index = -1;
 	igd_device_array[handle] = igd_device;
 	set_bit(handle, igd_device_bits);
 
@@ -95,6 +119,7 @@ int igd_dt_open(struct pci_dev *pdev, u64 *caps, u32 *mediate_handle)
 			pdev->vendor, pdev->device, handle);
 
 	*mediate_handle = handle;
+	*caps |= VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR;
 
 error:
 	mutex_unlock(&device_bit_lock);
@@ -135,14 +160,165 @@ static void igd_dt_get_region_info(int handle,
 		struct vfio_info_cap *caps,
 		struct vfio_region_info_cap_type *cap_type)
 {
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	size_t size;
+	int nr_areas, ret;
+
+	if (!is_handle_valid(handle))
+		return;
+
+	switch (info->index) {
+	case VFIO_PCI_BAR0_REGION_INDEX:
+		info->flags |= VFIO_REGION_INFO_FLAG_MMAP;
+		nr_areas = 1;
+
+		size = sizeof(*sparse) + (nr_areas * sizeof(*sparse->areas));
+
+		sparse = kzalloc(size, GFP_KERNEL);
+		if (!sparse)
+			return;
+
+		sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+		sparse->header.version = 1;
+		sparse->nr_areas = nr_areas;
+
+		sparse->areas[0].offset = BAR0_DYNAMIC_TRAP_OFFSET;
+		sparse->areas[0].size = BAR0_DYNAMIC_TRAP_SIZE;
+		sparse->areas[0].disablable = 1;//able to get disabled
+
+		ret = vfio_info_add_capability(caps, &sparse->header,
+				size);
+		kfree(sparse);
+		break;
+	case VFIO_PCI_BAR1_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
+	case VFIO_PCI_CONFIG_REGION_INDEX:
+	case VFIO_PCI_ROM_REGION_INDEX:
+	case VFIO_PCI_VGA_REGION_INDEX:
+		break;
+	default:
+		if ((cap_type->type ==
+			VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO) &&
+			(cap_type->subtype ==
+			 VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO)){
+			struct igd_dt_device *igd_device;
+
+			igd_device = igd_device_array[handle];
+			igd_device->dt_region_index = info->index;
+			info->size =
+				sizeof(struct vfio_device_dt_bar_info_region);
+		}
+	}
+}
+
+static
+void igd_dt_set_bar_mmap_enabled(struct igd_dt_device *igd_device,
+							bool enabled)
+{
+	bool disable_bar = !enabled;
+
+	if (igd_device->is_highend_trapped == disable_bar)
+		return;
+
+	igd_device->is_highend_trapped = disable_bar;
+
+	if (igd_device->dt_trigger)
+		eventfd_signal(igd_device->dt_trigger, 1);
+}
+
+static ssize_t igd_dt_dt_region_rw(struct igd_dt_device *igd_device,
+				char __user *buf, size_t count,
+				loff_t *ppos, bool iswrite, bool *pt)
+{
+#define DT_REGION_OFFSET(x) offsetof(struct vfio_device_dt_bar_info_region, x)
+	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
+
+	*pt = false;
+	switch (pos) {
+	case DT_REGION_OFFSET(dt_fd):
+		if (iswrite) {
+			u32 dt_fd;
+			struct eventfd_ctx *trigger;
+
+			if (copy_from_user(&dt_fd, buf,
+						sizeof(dt_fd)))
+				return -EFAULT;
+
+			trigger = eventfd_ctx_fdget(dt_fd);
+			pr_info("igd_dt_rw, dt trigger fd %d\n",
+					dt_fd);
+			if (IS_ERR(trigger)) {
+				pr_err("igd_dt_rw, dt trigger fd set error\n");
+				return -EINVAL;
+			}
+			igd_device->dt_trigger = trigger;
+			return sizeof(dt_fd);
+		} else
+			return -EFAULT;
+	case DT_REGION_OFFSET(trap):
+		if (iswrite)
+			return -EFAULT;
+		else
+			return copy_to_user(buf,
+					&igd_device->is_highend_trapped,
+					sizeof(u32)) ?
+				-EFAULT : count;
+		break;
+	default:
+		return -EFAULT;
+	}
 }
 
 static ssize_t igd_dt_rw(int handle, char __user *buf,
 			   size_t count, loff_t *ppos,
 			   bool iswrite, bool *pt)
 {
+	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
+	struct igd_dt_device *igd_device;
+	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
+
 	*pt = true;
 
+	if (!is_handle_valid(handle))
+		return -EFAULT;
+
+	igd_device = igd_device_array[handle];
+
+	switch (index) {
+	case VFIO_PCI_BAR0_REGION_INDEX:
+		/*
+		 * disable passthroughed subregion
+		 * on lower end write trapped
+		 */
+		if (pos < BAR0_DYNAMIC_TRAP_OFFSET &&
+				!igd_device->is_trap_triggered) {
+			pr_info("igd_dt bar 0 lowend rw trapped, trap highend\n");
+			igd_device->is_trap_triggered = true;
+			igd_dt_set_bar_mmap_enabled(igd_device, false);
+		}
+
+		/*
+		 * re-enable passthroughed subregion
+		 * on high end write trapped
+		 */
+		if (pos >= BAR0_DYNAMIC_TRAP_OFFSET &&
+				pos <= (BAR0_DYNAMIC_TRAP_OFFSET +
+					BAR0_DYNAMIC_TRAP_SIZE)) {
+			pr_info("igd_dt bar 0 higher end rw trapped, pt higher end\n");
+			igd_dt_set_bar_mmap_enabled(igd_device, true);
+		}
+
+		break;
+	case VFIO_PCI_BAR1_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
+	case VFIO_PCI_CONFIG_REGION_INDEX:
+	case VFIO_PCI_ROM_REGION_INDEX:
+	case VFIO_PCI_VGA_REGION_INDEX:
+		break;
+	default:
+		if (index == igd_device->dt_region_index)
+			return igd_dt_dt_region_rw(igd_device, buf,
+					count, ppos, iswrite, pt);
+	}
+
 	return 0;
 }
 
-- 
2.17.1



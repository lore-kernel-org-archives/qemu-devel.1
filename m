Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C9C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FD8206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FD8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ichxk-0005Ol-7P
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichvy-0003D3-1q
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichvw-0004bv-3F
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:36:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:43900)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ichvv-0004YW-PK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:36:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:36:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="243095319"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2019 19:36:00 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 9/9] i40e/vf_migration: support dynamic trap of bar0
Date: Wed,  4 Dec 2019 22:27:49 -0500
Message-Id: <20191205032749.30030-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205032419.29606-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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

mediate dynamic_trap_info region to dynamically trap bar0.

bar0 is sparsely mmaped into 5 sub-regions, of which only two need to be
dynamically trapped.
By mediating dynamic_trap_info region and telling QEMU this information,
the two sub-regions of bar0 can be trapped when migration starts and put
to passthrough again when migration fails

Cc: Shaopeng He <shaopeng.he@intel.com>

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 .../ethernet/intel/i40e/i40e_vf_migration.c   | 140 +++++++++++++++++-
 .../ethernet/intel/i40e/i40e_vf_migration.h   |  12 ++
 2 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_vf_migration.c b/drivers/net/ethernet/intel/i40e/i40e_vf_migration.c
index 5bb509fed66e..0b9d5be85049 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_vf_migration.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_vf_migration.c
@@ -29,6 +29,21 @@ static bool is_handle_valid(int handle)
 	return true;
 }
 
+static
+void i40e_vf_migration_dynamic_trap_bar(struct i40e_vf_migration *i40e_vf_dev)
+{
+	if (i40e_vf_dev->dt_trigger)
+		eventfd_signal(i40e_vf_dev->dt_trigger, 1);
+}
+
+static void i40e_vf_trap_bar0(struct i40e_vf_migration *i40e_vf_dev, bool trap)
+{
+	if (i40e_vf_dev->trap_bar0 != trap) {
+		i40e_vf_dev->trap_bar0 = trap;
+		i40e_vf_migration_dynamic_trap_bar(i40e_vf_dev);
+	}
+}
+
 static size_t set_device_state(struct i40e_vf_migration *i40e_vf_dev, u32 state)
 {
 	int ret = 0;
@@ -39,8 +54,10 @@ static size_t set_device_state(struct i40e_vf_migration *i40e_vf_dev, u32 state)
 
 	switch (state) {
 	case VFIO_DEVICE_STATE_RUNNING:
+		i40e_vf_trap_bar0(i40e_vf_dev, false);
 		break;
 	case VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING:
+		i40e_vf_trap_bar0(i40e_vf_dev, true);
 		// alloc dirty page tracking resources and
 		// do the first round dirty page scanning
 		break;
@@ -137,16 +154,22 @@ int i40e_vf_migration_open(struct pci_dev *pdev, u64 *caps, u32 *dm_handle)
 		MIGRATION_DIRTY_BITMAP_SIZE;
 	i40e_vf_dev->migration_region_index = -1;
 
+	i40e_vf_dev->dt_region_index = -1;
+	i40e_vf_dev->trap_bar0 = false;
+
 	vf = &pf->vf[vf_id];
 
 	i40e_vf_dev_array[handle] = i40e_vf_dev;
 	set_bit(handle, open_device_bits);
+
 	*dm_handle = handle;
 
 	*caps |= VFIO_PCI_DEVICE_CAP_MIGRATION;
+	*caps |= VFIO_PCI_DEVICE_CAP_DYNAMIC_TRAP_BAR;
 
 	pr_info("%s: device %x %x, vf id %d, handle=%x\n",
 		__func__, pdev->vendor, pdev->device, vf_id, handle);
+
 error:
 	mutex_unlock(&device_bit_lock);
 
@@ -188,6 +211,10 @@ void i40e_vf_migration_release(int handle)
 
 	kfree(i40e_vf_dev->mig_ctl);
 	vfree(i40e_vf_dev->dirty_bitmap);
+
+	if (i40e_vf_dev->dt_trigger)
+		eventfd_ctx_put(i40e_vf_dev->dt_trigger);
+
 	kfree(i40e_vf_dev);
 
 	module_put(THIS_MODULE);
@@ -216,6 +243,47 @@ static void migration_region_sparse_mmap_cap(struct vfio_info_cap *caps)
 	kfree(sparse);
 }
 
+static void bar0_sparse_mmap_cap(struct vfio_region_info *info,
+				 struct vfio_info_cap *caps)
+{
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	size_t size;
+	int nr_areas = 5;
+
+	size = sizeof(*sparse) + (nr_areas * sizeof(*sparse->areas));
+
+	sparse = kzalloc(size, GFP_KERNEL);
+	if (!sparse)
+		return;
+
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas = nr_areas;
+
+	sparse->areas[0].offset = 0;
+	sparse->areas[0].size = IAVF_VF_TAIL_START;
+	sparse->areas[0].disablable = 0;//able to get toggled
+
+	sparse->areas[1].offset = IAVF_VF_TAIL_START;
+	sparse->areas[1].size = PAGE_SIZE;
+	sparse->areas[1].disablable = 1;//able to get toggled
+
+	sparse->areas[2].offset = IAVF_VF_TAIL_START + PAGE_SIZE;
+	sparse->areas[2].size = IAVF_VF_ARQH1 - sparse->areas[2].offset;
+	sparse->areas[2].disablable = 0;//able to get toggled
+
+	sparse->areas[3].offset = IAVF_VF_ARQT1;
+	sparse->areas[3].size = PAGE_SIZE;
+	sparse->areas[3].disablable = 1;//able to get toggled
+
+	sparse->areas[4].offset = IAVF_VF_ARQT1 + PAGE_SIZE;
+	sparse->areas[4].size = info->size - sparse->areas[4].offset;
+	sparse->areas[4].disablable = 0;//able to get toggled
+
+	vfio_info_add_capability(caps, &sparse->header,	size);
+	kfree(sparse);
+}
+
 static void
 i40e_vf_migration_get_region_info(int handle,
 				  struct vfio_region_info *info,
@@ -227,9 +295,8 @@ i40e_vf_migration_get_region_info(int handle,
 
 	switch (info->index) {
 	case VFIO_PCI_BAR0_REGION_INDEX:
-		info->flags = VFIO_REGION_INFO_FLAG_READ |
-			VFIO_REGION_INFO_FLAG_WRITE;
-
+		info->flags |= VFIO_REGION_INFO_FLAG_MMAP;
+		bar0_sparse_mmap_cap(info, caps);
 		break;
 	case VFIO_PCI_BAR1_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
 	case VFIO_PCI_CONFIG_REGION_INDEX:
@@ -237,7 +304,20 @@ i40e_vf_migration_get_region_info(int handle,
 	case VFIO_PCI_VGA_REGION_INDEX:
 		break;
 	default:
-		if (cap_type->type == VFIO_REGION_TYPE_MIGRATION &&
+		if (cap_type->type ==
+		    VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO &&
+		    cap_type->subtype ==
+		    VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO) {
+			struct i40e_vf_migration *i40e_vf_dev;
+
+			i40e_vf_dev = i40e_vf_dev_array[handle];
+			i40e_vf_dev->dt_region_index = info->index;
+			info->size =
+				sizeof(struct vfio_device_dt_bar_info_region);
+		} else if ((cap_type->type == VFIO_REGION_TYPE_MIGRATION) &&
+				(cap_type->subtype ==
+				 VFIO_REGION_SUBTYPE_MIGRATION)) {
+		} else if (cap_type->type == VFIO_REGION_TYPE_MIGRATION &&
 		    cap_type->subtype == VFIO_REGION_SUBTYPE_MIGRATION) {
 			struct i40e_vf_migration *i40e_vf_dev;
 
@@ -254,6 +334,53 @@ i40e_vf_migration_get_region_info(int handle,
 	}
 }
 
+static ssize_t i40e_vf_dt_region_rw(struct i40e_vf_migration *i40e_vf_dev,
+				    char __user *buf, size_t count,
+				    loff_t *ppos, bool iswrite, bool *pt)
+{
+#define DT_REGION_OFFSET(x) offsetof(struct vfio_device_dt_bar_info_region, x)
+	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	ssize_t ret = 0;
+
+	*pt = false;
+	switch (pos) {
+	case DT_REGION_OFFSET(dt_fd):
+		if (iswrite) {
+			u32 dt_fd;
+			struct eventfd_ctx *trigger;
+
+			if (copy_from_user(&dt_fd, buf,	sizeof(dt_fd)))
+				return -EFAULT;
+
+			trigger = eventfd_ctx_fdget(dt_fd);
+			if (IS_ERR(trigger)) {
+				pr_err("i40e_vf_migration_rw, dt trigger fd set error\n");
+				return -EINVAL;
+			}
+			i40e_vf_dev->dt_trigger = trigger;
+			ret = sizeof(dt_fd);
+		} else {
+			ret = -EFAULT;
+		}
+		break;
+
+	case DT_REGION_OFFSET(trap):
+		if (iswrite)
+			ret = copy_from_user(&i40e_vf_dev->trap_bar0,
+					     buf, count) ? -EFAULT : count;
+		else
+			ret = copy_to_user(buf,
+					   &i40e_vf_dev->trap_bar0,
+					   sizeof(u32)) ?
+					   -EFAULT : sizeof(u32);
+		break;
+	default:
+		ret = -EFAULT;
+		break;
+	}
+	return ret;
+}
+
 static
 ssize_t i40e_vf_migration_region_rw(struct i40e_vf_migration *i40e_vf_dev,
 				    char __user *buf, size_t count,
@@ -420,7 +547,10 @@ static ssize_t i40e_vf_migration_rw(int handle, char __user *buf,
 	case VFIO_PCI_VGA_REGION_INDEX:
 		break;
 	default:
-		if (index == i40e_vf_dev->migration_region_index) {
+		if (index == i40e_vf_dev->dt_region_index) {
+			return i40e_vf_dt_region_rw(i40e_vf_dev, buf, count,
+					ppos, iswrite, pt);
+		} else if (index == i40e_vf_dev->migration_region_index) {
 			return i40e_vf_migration_region_rw(i40e_vf_dev, buf,
 					count, ppos, iswrite, pt);
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_vf_migration.h b/drivers/net/ethernet/intel/i40e/i40e_vf_migration.h
index b31b500b3cd6..dfad4cc7e46f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_vf_migration.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_vf_migration.h
@@ -21,6 +21,14 @@
 		PAGE_ALIGN(sizeof(struct vfio_device_migration_info))
 #define MIGRATION_DIRTY_BITMAP_SIZE (64 * 1024UL)
 
+#define IAVF_VF_ARQBAH1 0x00006000 /* Reset: EMPR */
+#define IAVF_VF_ARQBAL1 0x00006C00 /* Reset: EMPR */
+#define IAVF_VF_ARQH1 0x00007400 /* Reset: EMPR */
+#define IAVF_VF_ARQT1 0x00007000 /* Reset: EMPR */
+#define IAVF_VF_ARQLEN1 0x00008000 /* Reset: EMPR */
+#define IAVF_VF_TAIL_START 0x00002000 /* Start of tail register region */
+#define IAVF_VF_TAIL_END 0x00002400 /* End of tail register region */
+
 /* Single Root I/O Virtualization */
 struct pci_sriov {
 	int		pos;		/* Capability position */
@@ -56,6 +64,10 @@ struct i40e_vf_migration {
 	struct pci_dev *vf_dev;
 	int vf_id;
 
+	__u64 dt_region_index;
+	struct eventfd_ctx *dt_trigger;
+	bool trap_bar0;
+
 	__u64 migration_region_index;
 	__u64 migration_region_size;
 
-- 
2.17.1



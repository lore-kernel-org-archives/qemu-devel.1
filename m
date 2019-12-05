Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA16C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC4820707
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC4820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iciFi-0007Np-6K
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1iciDO-0005OY-6H
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1iciDL-0001Q5-4a
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:54:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:23251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1iciDK-0001NE-Qi
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:54:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="205633364"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by orsmga008.jf.intel.com with ESMTP; 04 Dec 2019 19:53:59 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 2/2] hw/vfio/pci: init dynamic-trap-bar-info region
Date: Wed,  4 Dec 2019 22:45:47 -0500
Message-Id: <20191205034547.30276-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205034451.30181-1-yan.y.zhao@intel.com>
References: <20191205034451.30181-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, zhenyuw@linux.intel.com, shaopeng.he@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

for devices that support device region of type
VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO and subtype
VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO, probe and init a
dynamic-trap-bar-info region which holds info of
(1) fd of eventfd,
(2) to trap/untrap of sparse mmaped pci bars.

Vendor driver first should specify device pci bars to be sparse mmapped,
which means those bars are sparsely passthroughed.
And if it wants certain sub-regions to be dynamically trapped, it should
also set 'disablable' flag for those sub-regions.

When vendor driver signals the eventfd, QEMU reads 'trap' field of this
dynamic trap bar info region, then disable/enable disablable subregions
of pci bar regions.

Cc: Kevin Tian <kevin.tian@intel.com>

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 hw/vfio/pci.c              | 117 +++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h              |   5 ++
 hw/vfio/trace-events       |   1 +
 linux-headers/linux/vfio.h |  11 ++++
 4 files changed, 134 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c04f4bcfb8..3837f77185 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2638,6 +2638,120 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
+static void vfio_dt_notifier_handler(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    int i;
+    __u32 dt_state;
+
+    if (!event_notifier_test_and_clear(&vdev->dt_notifier)) {
+        return;
+    }
+
+    if (vdev->dt_offset < 0) {
+        return;
+    }
+
+    if (pread(vdev->vbasedev.fd, &dt_state,
+                sizeof(dt_state),
+                vdev->dt_offset +
+                offsetof(struct vfio_device_dt_bar_info_region, trap))
+            != sizeof(dt_state)) {
+        error_report("vfio failed to read from dt region");
+        return;
+    }
+
+    if (dt_state == vdev->dt_state) {
+        return;
+    }
+
+    for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
+        vfio_region_disablable_mmaps_set_enabled(&vdev->bars[i].region,
+                                                 !dt_state);
+    }
+
+    vdev->dt_state = dt_state;
+
+}
+
+static void vfio_register_dt_notifier(VFIOPCIDevice *vdev)
+{
+    if (vdev->enable_dt) {
+        return;
+    }
+
+    if (event_notifier_init(&vdev->dt_notifier, 0)) {
+        error_report("vfio: unable to init event notifier for dynamic trap");
+        return;
+    }
+
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->dt_notifier),
+            vfio_dt_notifier_handler, NULL, vdev);
+}
+
+static void vfio_unregister_dt_notifier(VFIOPCIDevice *vdev)
+{
+    if (!vdev->enable_dt) {
+        return;
+    }
+
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->dt_notifier),
+            NULL, NULL, vdev);
+    event_notifier_cleanup(&vdev->dt_notifier);
+    vdev->enable_dt = false;
+    vdev->dt_offset = -1;
+    vdev->dt_state = false;
+}
+
+/**
+ * init a dynamic trap bar info region
+ * this region is used for qemu to communicate to vendor driver
+ *
+ * if this device region is queried from vendor driver, qemu will
+ * create an eventfd and write fd of this eventfd to dt_fd field of
+ * this region.
+ *
+ * when vendor driver notifys this dt_fd, qemu first read trap field
+ * of this region to get trap/untrap info. Then qemu will disable/enable
+ * mmaped subregions of pci bar regions according to this info.
+ *
+ */
+static void init_dt_region(VFIOPCIDevice *vdev)
+{
+    struct vfio_region_info *reg_info;
+    int ret;
+    uint32_t dt_fd;
+    vdev->dt_state = false;
+
+    ret = vfio_get_dev_region_info(&vdev->vbasedev,
+            VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO,
+            VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO,
+            &reg_info);
+    if (ret || reg_info->size < sizeof(dt_fd)) {
+        goto out;
+    }
+
+    vdev->dt_offset = reg_info->offset;
+
+    vfio_register_dt_notifier(vdev);
+    dt_fd = event_notifier_get_fd(&vdev->dt_notifier);
+
+    trace_vfio_init_dt_region(vdev->vbasedev.name, vdev->vendor_id,
+                              vdev->device_id, reg_info->offset,
+                              reg_info->offset + reg_info->size - 1, dt_fd);
+
+    if (pwrite(vdev->vbasedev.fd, &dt_fd,
+                sizeof(dt_fd),
+                vdev->dt_offset) != sizeof(dt_fd)) {
+        error_report("vfio failed to write to dt region");
+        vfio_unregister_dt_notifier(vdev);
+    }
+    vdev->enable_dt = true;
+out:
+    g_free(reg_info);
+}
+
+
 static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3173,6 +3287,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                          vdev->vbasedev.name);
     }
 
+    init_dt_region(vdev);
+
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -3214,6 +3330,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
+    vfio_unregister_dt_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 834a90d646..981d81b516 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -168,6 +168,11 @@ typedef struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     VFIODisplay *dpy;
+    EventNotifier dt_notifier;
+    bool enable_dt; /*is dynamically trap enabled*/
+    bool dt_state; /* trap or untrap. default state is untrap */
+    off_t dt_offset; /* Offset of dt region within device fd */
+
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 7b2d07529e..b445887d85 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -162,3 +162,4 @@ vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
 vfio_get_dirty_page_list(char *name, uint64_t start, uint64_t pfn_count, uint64_t page_size) " (%s) start 0x%"PRIx64" pfn_count 0x%"PRIx64 " page size 0x%"PRIx64
 vfio_region_disablable_mmaps_set_enabled(const char *name, unsigned long offset, unsigned long end, bool enabled) "Region %s mmaps [0x%lx - 0x%lx] set to %d"
+vfio_init_dt_region(char *name, uint32_t vendor_id, uint32_t device_id, unsigned long offset, unsigned long size, uint32_t dt_fd) "(%s %x %x) init dt region [0x%lx - 0x%lx] dt_fd=%d"
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index f9f0ea8eda..1743ce68e5 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -378,6 +378,7 @@ struct vfio_region_gfx_edid {
 #define VFIO_REGION_TYPE_MIGRATION	        (3)
 #define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
 
+
 /**
  * Structure vfio_device_migration_info is placed at 0th offset of
  * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
@@ -522,6 +523,16 @@ struct vfio_device_migration_info {
 #define VFIO_DEVICE_DIRTY_PFNS_ALL      (~0ULL)
 } __attribute__((packed));
 
+
+/* Region type and sub-type to hold info to dynamically trap bars */
+#define VFIO_REGION_TYPE_DYNAMIC_TRAP_BAR_INFO          (4)
+#define VFIO_REGION_SUBTYPE_DYNAMIC_TRAP_BAR_INFO       (1)
+
+struct vfio_device_dt_bar_info_region {
+	__u32 dt_fd; /* fd of eventfd to notify qemu trap/untrap bars */
+	__u32 trap;   /* trap/untrap bar regions */
+};
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.17.1



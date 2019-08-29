Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9109C215EA
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 08:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9109C215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3GH6-00012E-Nv
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 04:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.gao@intel.com>) id 1i3GGH-0000aL-8d
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chao.gao@intel.com>) id 1i3GGE-0006ld-SW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:58:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:11741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1i3GGE-0006k0-JD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 04:58:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 01:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="381572329"
Received: from gao-cwp.sh.intel.com ([10.239.159.26])
 by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2019 01:58:24 -0700
From: Chao Gao <chao.gao@intel.com>
To: xen-devel@lists.xenproject.org,
	qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 17:02:27 +0800
Message-Id: <1567069347-22841-1-git-send-email-chao.gao@intel.com>
X-Mailer: git-send-email 1.9.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: [Qemu-devel] [RFC Patch] xen/pt: Emulate FLR capability
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul.durrant@citrix.com>, Jan Beulich <jbeulich@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>, Chao Gao <chao.gao@intel.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, for a HVM on Xen, no reset method is virtualized. So in a VM's
perspective, assigned devices cannot be reset. But some devices rely on PCI
reset to recover from hardware hangs. When being assigned to a VM, those
devices cannot be reset and won't work any longer if a hardware hang occurs.
We have to reboot VM to trigger PCI reset on host to recover the device.

This patch exposes FLR capability to VMs if the assigned device can be reset on
host. When VM initiates an FLR to a device, qemu cleans up the device state,
(including disabling of intx and/or MSI and unmapping BARs from guest, deleting
emulated registers), then initiate PCI reset through 'reset' knob under the
device's sysfs, finally initialize the device again.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
Do we need to introduce an attribute, like "permissive" to explicitly
enable FLR capability emulation? During PCI reset, interrupts and BARs are
unmapped from the guest. It seems that guest cannot interact with the device
directly except access to device's configuration space which is emulated by
qemu. If proper method can be used to prevent qemu accessing the physical
device there is no new security hole caused by the FLR emulation.

VM's FLR may be backed by any reset function on host to the physical device,
for example: FLR, D3softreset, secondary bus reset. Not sure it is fine to mix
them. Given Linux kernel just uses an unified API to reset device and caller
cannot choose a specific one, it might be OK.
---
 hw/xen/xen-host-pci-device.c | 30 ++++++++++++++++++++++++++++++
 hw/xen/xen-host-pci-device.h |  3 +++
 hw/xen/xen_pt.c              |  9 +++++++++
 hw/xen/xen_pt.h              |  1 +
 hw/xen/xen_pt_config_init.c  | 30 +++++++++++++++++++++++++++---
 5 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 1b44dcafaf..d549656f42 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -198,6 +198,35 @@ static bool xen_host_pci_dev_is_virtfn(XenHostPCIDevice *d)
     return !stat(path, &buf);
 }
 
+static bool xen_host_pci_resetable(XenHostPCIDevice *d)
+{
+    char path[PATH_MAX];
+
+    xen_host_pci_sysfs_path(d, "reset", path, sizeof(path));
+
+    return !access(path, W_OK);
+}
+
+void xen_host_pci_reset(XenHostPCIDevice *d)
+{
+    char path[PATH_MAX];
+    int fd;
+
+    xen_host_pci_sysfs_path(d, "reset", path, sizeof(path));
+
+    fd = open(path, O_WRONLY);
+    if (fd == -1) {
+        XEN_HOST_PCI_LOG("Xen host pci reset: open error\n");
+        return;
+    }
+
+    if (write(fd, "1", 1) != 1) {
+        XEN_HOST_PCI_LOG("Xen host pci reset: write error\n");
+    }
+
+    return;
+}
+
 static void xen_host_pci_config_open(XenHostPCIDevice *d, Error **errp)
 {
     char path[PATH_MAX];
@@ -377,6 +406,7 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     d->class_code = v;
 
     d->is_virtfn = xen_host_pci_dev_is_virtfn(d);
+    d->is_resetable = xen_host_pci_resetable(d);
 
     return;
 
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 4d8d34ecb0..cacf9b3df8 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -32,6 +32,7 @@ typedef struct XenHostPCIDevice {
     XenHostPCIIORegion rom;
 
     bool is_virtfn;
+    bool is_resetable;
 
     int config_fd;
 } XenHostPCIDevice;
@@ -55,4 +56,6 @@ int xen_host_pci_set_block(XenHostPCIDevice *d, int pos, uint8_t *buf,
 
 int xen_host_pci_find_ext_cap_offset(XenHostPCIDevice *s, uint32_t cap);
 
+void xen_host_pci_reset(XenHostPCIDevice *d);
+
 #endif /* XEN_HOST_PCI_DEVICE_H */
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 8fbaf2eae9..d750367c0a 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -938,6 +938,15 @@ static void xen_pt_unregister_device(PCIDevice *d)
     xen_pt_destroy(d);
 }
 
+void xen_pt_reset(XenPCIPassthroughState *s)
+{
+    PCIDevice *d = PCI_DEVICE(s);
+
+    xen_pt_unregister_device(d);
+    xen_host_pci_reset(&s->real_device);
+    xen_pt_realize(d, NULL);
+}
+
 static Property xen_pci_passthrough_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("hostaddr", XenPCIPassthroughState, hostaddr),
     DEFINE_PROP_BOOL("permissive", XenPCIPassthroughState, permissive, false),
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 9167bbaf6d..ed05bc0d39 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -332,4 +332,5 @@ int xen_pt_register_vga_regions(XenHostPCIDevice *dev);
 int xen_pt_unregister_vga_regions(XenHostPCIDevice *dev);
 void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
                      Error **errp);
+void xen_pt_reset(XenPCIPassthroughState *s);
 #endif /* XEN_PT_H */
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 31ec5add1d..435abd7286 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -852,6 +852,30 @@ static inline uint8_t get_device_type(XenPCIPassthroughState *s,
     return (flag & PCI_EXP_FLAGS_TYPE) >> 4;
 }
 
+/* Initialize Device Capability register */
+static int xen_pt_devcap_reg_init(XenPCIPassthroughState *s,
+                                  XenPTRegInfo *reg, uint32_t real_offset,
+                                  uint32_t *data)
+{
+    *data = reg->init_val;
+
+    if (s->real_device.is_resetable) {
+        *data |= PCI_EXP_DEVCAP_FLR;
+    }
+
+    return 0;
+}
+
+static int xen_pt_devctl_reg_write(XenPCIPassthroughState *s,
+                                   XenPTReg *cfg_entry, uint16_t *val,
+                                   uint16_t dev_value, uint16_t valid_mask)
+{
+    if (s->real_device.is_resetable && (*val & PCI_EXP_DEVCTL_BCR_FLR)) {
+        xen_pt_reset(s);
+    }
+    return xen_pt_word_reg_write(s, cfg_entry, val, dev_value, valid_mask);
+}
+
 /* initialize Link Control register */
 static int xen_pt_linkctrl_reg_init(XenPCIPassthroughState *s,
                                     XenPTRegInfo *reg, uint32_t real_offset,
@@ -933,7 +957,7 @@ static XenPTRegInfo xen_pt_emu_reg_pcie[] = {
         .init_val   = 0x00000000,
         .ro_mask    = 0xFFFFFFFF,
         .emu_mask   = 0x10000000,
-        .init       = xen_pt_common_reg_init,
+        .init       = xen_pt_devcap_reg_init,
         .u.dw.read  = xen_pt_long_reg_read,
         .u.dw.write = xen_pt_long_reg_write,
     },
@@ -946,7 +970,7 @@ static XenPTRegInfo xen_pt_emu_reg_pcie[] = {
         .emu_mask   = 0xFFFF,
         .init       = xen_pt_common_reg_init,
         .u.w.read   = xen_pt_word_reg_read,
-        .u.w.write  = xen_pt_word_reg_write,
+        .u.w.write  = xen_pt_devctl_reg_write,
     },
     /* Device Status reg */
     {
@@ -1969,7 +1993,7 @@ static void xen_pt_config_reg_init(XenPCIPassthroughState *s,
             /* Mask out host (including past size). */
             new_val = val & host_mask;
             /* Merge emulated ones (excluding the non-emulated ones). */
-            new_val |= data & host_mask;
+            new_val |= data & ~host_mask;
             /* Leave intact host and emulated values past the size - even though
              * we do not care as we write per reg->size granularity, but for the
              * logging below lets have the proper value. */
-- 
2.17.1



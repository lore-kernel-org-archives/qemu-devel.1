Received: from eggs.gnu.org ([2001:4830:134:3::10]:44669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIX-0008EB-6e
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIV-0005R1-J4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:49 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIV-0005Qd-BE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:47 -0400
Received: by mail-pl0-x241.google.com with SMTP id m22-v6so9835858pls.5
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:47 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:04 +1000
Message-Id: <836d7504943af1390458dc2bc8341a654eee234a.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 19/30] xen/pt: avoid reading PCIe device
 type and cap version multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Alexey Gerasimenko <x1917x@gmail.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

xen_pt_config_init.c reads Device/Port Type and Capability version fields
in many places. Two functions are used for this purpose:
get_capability_version and get_device_type. These functions perform PCI
conf space reading every time they're called. Another bad thing is that
these functions know nothing about where PCI Expess Capability is located,
so its offset must be provided explicitly in function arguments. Their
typical usage is like this:
    uint8_t cap_ver = get_capability_version(s, real_offset - reg->offset);
    uint8_t dev_type = get_device_type(s, real_offset - reg->offset);

To avoid this, the PCI Express Capability register now being read only
once and stored in  XenHostPCIDevice structure (pcie_flags field). The
capabiliy offset parameter is no longer needed, simplifying functions
usage. Also, get_device_type and get_capability_version were renamed
to more descriptive get_pcie_device_type and get_pcie_capability_version.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen-host-pci-device.c | 15 +++++++++++++++
 hw/xen/xen-host-pci-device.h |  1 +
 hw/xen/xen_pt_config_init.c  | 34 ++++++++++++++--------------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 9d76b199af..11e9e26d31 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -402,6 +402,7 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
 {
     unsigned int v;
     Error *err = NULL;
+    int pcie_cap_pos;
 
     d->config_fd = -1;
     d->domain = domain;
@@ -446,6 +447,20 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     d->is_virtfn         = xen_host_pci_dev_is_virtfn(d);
     d->has_pcie_ext_caps = xen_host_pci_dev_has_pcie_ext_caps(d);
 
+    /* read and store PCIe Capabilities field for later use */
+    pcie_cap_pos = xen_host_pci_find_next_cap(d, 0, PCI_CAP_ID_EXP);
+
+    if (pcie_cap_pos) {
+        if (xen_host_pci_get_word(d, pcie_cap_pos + PCI_EXP_FLAGS,
+                                  &d->pcie_flags)) {
+            error_setg(&err, "Unable to read from PCI Express capability "
+                       "structure at 0x%x", pcie_cap_pos);
+            goto error;
+        }
+    } else {
+        d->pcie_flags = 0xFFFF;
+    }
+
     return;
 
 error:
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 37c5614a24..2884c4b4b9 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -27,6 +27,7 @@ typedef struct XenHostPCIDevice {
     uint16_t device_id;
     uint32_t class_code;
     int irq;
+    uint16_t pcie_flags;
 
     XenHostPCIIORegion io_regions[PCI_NUM_REGIONS - 1];
     XenHostPCIIORegion rom;
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index a3ce33e78b..02e8c97f3c 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -828,24 +828,18 @@ static XenPTRegInfo xen_pt_emu_reg_vendor[] = {
  * PCI Express Capability
  */
 
-static inline uint8_t get_capability_version(XenPCIPassthroughState *s,
-                                             uint32_t offset)
+static inline uint8_t get_pcie_capability_version(XenPCIPassthroughState *s)
 {
-    uint8_t flag;
-    if (xen_host_pci_get_byte(&s->real_device, offset + PCI_EXP_FLAGS, &flag)) {
-        return 0;
-    }
-    return flag & PCI_EXP_FLAGS_VERS;
+    assert(s->real_device.pcie_flags != 0xFFFF);
+
+    return (uint8_t) (s->real_device.pcie_flags & PCI_EXP_FLAGS_VERS);
 }
 
-static inline uint8_t get_device_type(XenPCIPassthroughState *s,
-                                      uint32_t offset)
+static inline uint8_t get_pcie_device_type(XenPCIPassthroughState *s)
 {
-    uint8_t flag;
-    if (xen_host_pci_get_byte(&s->real_device, offset + PCI_EXP_FLAGS, &flag)) {
-        return 0;
-    }
-    return (flag & PCI_EXP_FLAGS_TYPE) >> 4;
+    assert(s->real_device.pcie_flags != 0xFFFF);
+
+    return (uint8_t) ((s->real_device.pcie_flags & PCI_EXP_FLAGS_TYPE) >> 4);
 }
 
 /* initialize Link Control register */
@@ -853,8 +847,8 @@ static int xen_pt_linkctrl_reg_init(XenPCIPassthroughState *s,
                                     XenPTRegInfo *reg, uint32_t real_offset,
                                     uint32_t *data)
 {
-    uint8_t cap_ver = get_capability_version(s, real_offset - reg->offset);
-    uint8_t dev_type = get_device_type(s, real_offset - reg->offset);
+    uint8_t cap_ver  = get_pcie_capability_version(s);
+    uint8_t dev_type = get_pcie_device_type(s);
 
     /* no need to initialize in case of Root Complex Integrated Endpoint
      * with cap_ver 1.x
@@ -871,7 +865,7 @@ static int xen_pt_devctrl2_reg_init(XenPCIPassthroughState *s,
                                     XenPTRegInfo *reg, uint32_t real_offset,
                                     uint32_t *data)
 {
-    uint8_t cap_ver = get_capability_version(s, real_offset - reg->offset);
+    uint8_t cap_ver = get_pcie_capability_version(s);
 
     /* no need to initialize in case of cap_ver 1.x */
     if (cap_ver == 1) {
@@ -886,7 +880,7 @@ static int xen_pt_linkctrl2_reg_init(XenPCIPassthroughState *s,
                                      XenPTRegInfo *reg, uint32_t real_offset,
                                      uint32_t *data)
 {
-    uint8_t cap_ver = get_capability_version(s, real_offset - reg->offset);
+    uint8_t cap_ver = get_pcie_capability_version(s);
     uint32_t reg_field = 0;
 
     /* no need to initialize in case of cap_ver 1.x */
@@ -1586,8 +1580,8 @@ static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
                                  uint32_t base_offset, uint8_t *size)
 {
     PCIDevice *d = &s->dev;
-    uint8_t version = get_capability_version(s, base_offset);
-    uint8_t type = get_device_type(s, base_offset);
+    uint8_t version = get_pcie_capability_version(s);
+    uint8_t type = get_pcie_device_type(s);
     uint8_t pcie_size = 0;
 
 
-- 
2.11.0

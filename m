Received: from eggs.gnu.org ([2001:4830:134:3::10]:44742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIi-0008Pt-Qa
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIh-0005YU-5K
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:00 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:45690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIg-0005YD-Se
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:35:59 -0400
Received: by mail-pl0-x22b.google.com with SMTP id v9-v6so9810258plp.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:35:58 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:07 +1000
Message-Id: <4918ab0dbd7e53ef3a83ff68a546e6cea9d8c7fa.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 22/30] xen/pt: add support for PCIe
 Extended Capabilities and larger config space
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

This patch provides basic facilities for PCIe Extended Capabilities and
support for controlled (via s->pcie_enabled_dev flag) access to PCIe
config space (>256).

PCIe Extended Capabilities make use of 16-bit capability ID. Also,
a capability size might exceed 8-bit width. So as the very first step
we need to increase type size for grp_id, grp_size, etc -- they were
limited to 8-bit.

The only troublesome issue with PCIe Extended Capability IDs is that their
value range is actually same as for basic PCI capabilities.
Eg. capability ID 3 means VPD Capability for PCI and at the same time
Device Serial Number Capability for PCIe Extended caps. This adds a bit of
inconvenience.

In order to distinguish between two sets of same capability IDs, the patch
introduces a set of macros to mark a capability ID as PCIe Extended one
(or check if it is basic/extended + get a raw ID value):
- PCIE_EXT_CAP_ID(cap_id)
- IS_PCIE_EXT_CAP_ID(grp_id)
- GET_PCIE_EXT_CAP_ID(grp_id)

Here is how it's used:
    /* Intel IGD Opregion group */
    {
        .grp_id      = XEN_PCI_INTEL_OPREGION,  /* no change */
        .grp_type    = XEN_PT_GRP_TYPE_EMU,
        .grp_size    = 0x4,
        .size_init   = xen_pt_reg_grp_size_init,
        .emu_regs    = xen_pt_emu_reg_igd_opregion,
    },
    /* Vendor-specific Extended Capability reg group */
    {
        .grp_id      = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_VNDR),
        .grp_type    = XEN_PT_GRP_TYPE_EMU,
        .grp_size    = 0xFF,
        .size_init   = xen_pt_ext_cap_vendor_size_init,
        .emu_regs    = xen_pt_ext_cap_emu_reg_vendor,
    },
By using the PCIE_EXT_CAP_ID() macro it is possible to reuse existing
header files with already defined PCIe Extended Capability ID values.

find_cap_offset() receive capabily ID and checks if it's an Extended one
by using IS_PCIE_EXT_CAP_ID(cap) macro, passing the real capabiliy
ID value to either xen_host_pci_find_next_ext_cap
or xen_host_pci_find_next_cap.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt.c             |  14 +++++-
 hw/xen/xen_pt.h             |  13 +++--
 hw/xen/xen_pt_config_init.c | 113 +++++++++++++++++++++-----------------------
 3 files changed, 74 insertions(+), 66 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index a902a9b685..bf098c26b3 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -82,10 +82,20 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...)
 
 /* Config Space */
 
-static int xen_pt_pci_config_access_check(PCIDevice *d, uint32_t addr, int len)
+static int xen_pt_pci_config_access_check(PCIDevice *d,
+                                          uint32_t addr, int len)
 {
+    XenPCIPassthroughState *s = XEN_PT_DEVICE(d);
+
     /* check offset range */
-    if (addr > 0xFF) {
+    if (s->pcie_enabled_dev) {
+        if (addr >= PCIE_CONFIG_SPACE_SIZE) {
+            XEN_PT_ERR(d, "Failed to access register with offset "
+                          "exceeding 0xFFF. (addr: 0x%02x, len: %d)\n",
+                          addr, len);
+            return -1;
+        }
+    } else if (addr >= PCI_CONFIG_SPACE_SIZE) {
         XEN_PT_ERR(d, "Failed to access register with offset exceeding 0xFF. "
                    "(addr: 0x%02x, len: %d)\n", addr, len);
         return -1;
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 1204acbdce..5531347ab2 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -31,6 +31,11 @@ void xen_pt_log(const PCIDevice *d, const char *f, ...) GCC_FMT_ATTR(2, 3);
 /* Helper */
 #define XEN_PFN(x) ((x) >> XC_PAGE_SHIFT)
 
+/* Macro's for PCIe Extended Capabilities */
+#define PCIE_EXT_CAP_ID(cap_id)     ((cap_id) | (1U << 16))
+#define IS_PCIE_EXT_CAP_ID(grp_id)  ((grp_id) & (1U << 16))
+#define GET_PCIE_EXT_CAP_ID(grp_id) ((grp_id) & 0xFFFF)
+
 typedef const struct XenPTRegInfo XenPTRegInfo;
 typedef struct XenPTReg XenPTReg;
 
@@ -152,13 +157,13 @@ typedef const struct XenPTRegGroupInfo XenPTRegGroupInfo;
 /* emul reg group size initialize method */
 typedef int (*xen_pt_reg_size_init_fn)
     (XenPCIPassthroughState *, XenPTRegGroupInfo *,
-     uint32_t base_offset, uint8_t *size);
+     uint32_t base_offset, uint32_t *size);
 
 /* emulated register group information */
 struct XenPTRegGroupInfo {
-    uint8_t grp_id;
+    uint32_t grp_id;
     XenPTRegisterGroupType grp_type;
-    uint8_t grp_size;
+    uint32_t grp_size;
     xen_pt_reg_size_init_fn size_init;
     XenPTRegInfo *emu_regs;
 };
@@ -168,7 +173,7 @@ typedef struct XenPTRegGroup {
     QLIST_ENTRY(XenPTRegGroup) entries;
     XenPTRegGroupInfo *reg_grp;
     uint32_t base_offset;
-    uint8_t size;
+    uint32_t size;
     QLIST_HEAD(, XenPTReg) reg_tbl_list;
 } XenPTRegGroup;
 
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 91de215407..9c041fa288 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -32,29 +32,42 @@ static int xen_pt_ptr_reg_init(XenPCIPassthroughState *s, XenPTRegInfo *reg,
 /* helper */
 
 /* A return value of 1 means the capability should NOT be exposed to guest. */
-static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint8_t grp_id)
+static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint32_t grp_id)
 {
-    switch (grp_id) {
-    case PCI_CAP_ID_EXP:
-        /* The PCI Express Capability Structure of the VF of Intel 82599 10GbE
-         * Controller looks trivial, e.g., the PCI Express Capabilities
-         * Register is 0. We should not try to expose it to guest.
-         *
-         * The datasheet is available at
-         * http://download.intel.com/design/network/datashts/82599_datasheet.pdf
-         *
-         * See 'Table 9.7. VF PCIe Configuration Space' of the datasheet, the
-         * PCI Express Capability Structure of the VF of Intel 82599 10GbE
-         * Controller looks trivial, e.g., the PCI Express Capabilities
-         * Register is 0, so the Capability Version is 0 and
-         * xen_pt_pcie_size_init() would fail.
-         */
-        if (d->vendor_id == PCI_VENDOR_ID_INTEL &&
-            d->device_id == PCI_DEVICE_ID_INTEL_82599_SFP_VF) {
-            return 1;
+    if (IS_PCIE_EXT_CAP_ID(grp_id)) {
+        switch (GET_PCIE_EXT_CAP_ID(grp_id)) {
+            /* Here can be added device-specific filtering
+             * for PCIe Extended capabilities (those with offset >= 0x100).
+             * This is simply a placeholder as no filtering needed for now.
+             */
+        default:
+            break;
+        }
+    } else {
+        /* basic PCI capability */
+        switch (grp_id) {
+        case PCI_CAP_ID_EXP:
+            /* The PCI Express Capability Structure of the VF of Intel 82599 10GbE
+             * Controller looks trivial, e.g., the PCI Express Capabilities
+             * Register is 0. We should not try to expose it to guest.
+             *
+             * The datasheet is available at
+             * http://download.intel.com/design/network/datashts/82599_datasheet.pdf
+             *
+             * See 'Table 9.7. VF PCIe Configuration Space' of the datasheet, the
+             * PCI Express Capability Structure of the VF of Intel 82599 10GbE
+             * Controller looks trivial, e.g., the PCI Express Capabilities
+             * Register is 0, so the Capability Version is 0 and
+             * xen_pt_pcie_size_init() would fail.
+             */
+            if (d->vendor_id == PCI_VENDOR_ID_INTEL &&
+                d->device_id == PCI_DEVICE_ID_INTEL_82599_SFP_VF) {
+                return 1;
+            }
+            break;
         }
-        break;
     }
+
     return 0;
 }
 
@@ -1622,7 +1635,7 @@ static XenPTRegInfo xen_pt_emu_reg_igd_opregion[] = {
 
 static int xen_pt_reg_grp_size_init(XenPCIPassthroughState *s,
                                     const XenPTRegGroupInfo *grp_reg,
-                                    uint32_t base_offset, uint8_t *size)
+                                    uint32_t base_offset, uint32_t *size)
 {
     *size = grp_reg->grp_size;
     return 0;
@@ -1630,14 +1643,18 @@ static int xen_pt_reg_grp_size_init(XenPCIPassthroughState *s,
 /* get Vendor Specific Capability Structure register group size */
 static int xen_pt_vendor_size_init(XenPCIPassthroughState *s,
                                    const XenPTRegGroupInfo *grp_reg,
-                                   uint32_t base_offset, uint8_t *size)
+                                   uint32_t base_offset, uint32_t *size)
 {
-    return xen_host_pci_get_byte(&s->real_device, base_offset + 0x02, size);
+    uint8_t sz = 0;
+    int ret = xen_host_pci_get_byte(&s->real_device, base_offset + 0x02, &sz);
+
+    *size = sz;
+    return ret;
 }
 /* get PCI Express Capability Structure register group size */
 static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
-                                 uint32_t base_offset, uint8_t *size)
+                                 uint32_t base_offset, uint32_t *size)
 {
     PCIDevice *d = &s->dev;
     uint8_t version = get_pcie_capability_version(s);
@@ -1709,7 +1726,7 @@ static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
 /* get MSI Capability Structure register group size */
 static int xen_pt_msi_size_init(XenPCIPassthroughState *s,
                                 const XenPTRegGroupInfo *grp_reg,
-                                uint32_t base_offset, uint8_t *size)
+                                uint32_t base_offset, uint32_t *size)
 {
     uint16_t msg_ctrl = 0;
     uint8_t msi_size = 0xa;
@@ -1737,7 +1754,7 @@ static int xen_pt_msi_size_init(XenPCIPassthroughState *s,
 /* get MSI-X Capability Structure register group size */
 static int xen_pt_msix_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
-                                 uint32_t base_offset, uint8_t *size)
+                                 uint32_t base_offset, uint32_t *size)
 {
     int rc = 0;
 
@@ -1920,44 +1937,20 @@ out:
  * Main
  */
 
-static uint8_t find_cap_offset(XenPCIPassthroughState *s, uint8_t cap)
+static uint32_t find_cap_offset(XenPCIPassthroughState *s, uint32_t cap)
 {
-    uint8_t id;
-    unsigned max_cap = XEN_PCI_CAP_MAX;
-    uint8_t pos = PCI_CAPABILITY_LIST;
-    uint8_t status = 0;
+    uint32_t retval = 0;
 
-    if (xen_host_pci_get_byte(&s->real_device, PCI_STATUS, &status)) {
-        return 0;
-    }
-    if ((status & PCI_STATUS_CAP_LIST) == 0) {
-        return 0;
-    }
-
-    while (max_cap--) {
-        if (xen_host_pci_get_byte(&s->real_device, pos, &pos)) {
-            break;
-        }
-        if (pos < PCI_CONFIG_HEADER_SIZE) {
-            break;
+    if (IS_PCIE_EXT_CAP_ID(cap)) {
+        if (s->pcie_enabled_dev) {
+            retval = xen_host_pci_find_next_ext_cap(&s->real_device, 0,
+                                                    GET_PCIE_EXT_CAP_ID(cap));
         }
-
-        pos &= ~3;
-        if (xen_host_pci_get_byte(&s->real_device,
-                                  pos + PCI_CAP_LIST_ID, &id)) {
-            break;
-        }
-
-        if (id == 0xff) {
-            break;
-        }
-        if (id == cap) {
-            return pos;
-        }
-
-        pos += PCI_CAP_LIST_NEXT;
+    } else {
+        retval = xen_host_pci_find_next_cap(&s->real_device, 0, cap);
     }
-    return 0;
+
+    return retval;
 }
 
 static void xen_pt_config_reg_init(XenPCIPassthroughState *s,
-- 
2.11.0

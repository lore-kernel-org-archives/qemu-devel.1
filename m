Received: from eggs.gnu.org ([2001:4830:134:3::10]:44821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIv-000096-EG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIs-0005e2-BG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:13 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIs-0005dj-2d
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:10 -0400
Received: by mail-pl0-x241.google.com with SMTP id s13-v6so9820984plq.6
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:09 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:10 +1000
Message-Id: <ad509c654592b7ffbcfce69bdf641eec45ad3742.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 25/30] xen/pt: add Vendor-specific PCIe
 Extended Capability descriptor and sizing
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

The patch provides Vendor-specific PCIe Extended Capability description
structure and corresponding sizing function. In this particular case the
size of the Vendor capability is available in the VSEC Length field.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 77 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 10f3b67d35..6e99b9ebd7 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -129,6 +129,18 @@ static uint32_t get_throughable_mask(const XenPCIPassthroughState *s,
     return throughable_mask & valid_mask;
 }
 
+static void log_pcie_extended_cap(XenPCIPassthroughState *s,
+                                  const char *cap_name,
+                                  uint32_t base_offset, uint32_t size)
+{
+    if (size) {
+        XEN_PT_LOG(&s->dev, "Found PCIe Extended Capability: %s at 0x%04x, "
+                            "size 0x%x bytes\n", cap_name,
+                            (uint16_t) base_offset, size);
+    }
+}
+
+
 /****************
  * general register functions
  */
@@ -1684,6 +1696,44 @@ static int xen_pt_ext_cap_capid_reg_init(XenPCIPassthroughState *s,
 }
 
 
+/* Vendor-specific Ext Capability Structure reg static information table */
+static XenPTRegInfo xen_pt_ext_cap_emu_reg_vendor[] = {
+    {
+        .offset     = XEN_PCIE_CAP_ID,
+        .size       = 2,
+        .init_val   = 0x0000,
+        .ro_mask    = 0xFFFF,
+        .emu_mask   = 0xFFFF,
+        .init       = xen_pt_ext_cap_capid_reg_init,
+        .u.w.read   = xen_pt_word_reg_read,
+        .u.w.write  = xen_pt_word_reg_write,
+    },
+    {
+        .offset     = XEN_PCIE_CAP_LIST_NEXT,
+        .size       = 2,
+        .init_val   = 0x0000,
+        .ro_mask    = 0xFFFF,
+        .emu_mask   = 0xFFFF,
+        .init       = xen_pt_ext_cap_ptr_reg_init,
+        .u.w.read   = xen_pt_word_reg_read,
+        .u.w.write  = xen_pt_word_reg_write,
+    },
+    {
+        .offset     = PCI_VNDR_HEADER,
+        .size       = 4,
+        .init_val   = 0x00000000,
+        .ro_mask    = 0xFFFFFFFF,
+        .emu_mask   = 0x00000000,
+        .init       = xen_pt_common_reg_init,
+        .u.dw.read  = xen_pt_long_reg_read,
+        .u.dw.write = xen_pt_long_reg_write,
+    },
+    {
+        .size = 0,
+    },
+};
+
+
 /****************************
  * Capabilities
  */
@@ -1708,6 +1758,23 @@ static int xen_pt_vendor_size_init(XenPCIPassthroughState *s,
     *size = sz;
     return ret;
 }
+
+static int xen_pt_ext_cap_vendor_size_init(XenPCIPassthroughState *s,
+                                           const XenPTRegGroupInfo *grp_reg,
+                                           uint32_t base_offset,
+                                           uint32_t *size)
+{
+    uint32_t vsec_hdr = 0;
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_VNDR_HEADER,
+                                    &vsec_hdr);
+
+    *size = PCI_VNDR_HEADER_LEN(vsec_hdr);
+
+    log_pcie_extended_cap(s, "Vendor-specific", base_offset, *size);
+
+    return ret;
+}
 /* get PCI Express Capability Structure register group size */
 static int xen_pt_pcie_size_init(XenPCIPassthroughState *s,
                                  const XenPTRegGroupInfo *grp_reg,
@@ -1934,6 +2001,14 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init   = xen_pt_reg_grp_size_init,
         .emu_regs    = xen_pt_emu_reg_igd_opregion,
     },
+    /* Vendor-specific Extended Capability reg group */
+    {
+        .grp_id      = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_VNDR),
+        .grp_type    = XEN_PT_GRP_TYPE_EMU,
+        .grp_size    = 0xFF,
+        .size_init   = xen_pt_ext_cap_vendor_size_init,
+        .emu_regs    = xen_pt_ext_cap_emu_reg_vendor,
+    },
     {
         .grp_size = 0,
     },
@@ -2054,8 +2129,6 @@ out:
     return 0;
 }
 
-
-
 /*************
  * Main
  */
-- 
2.11.0

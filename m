Received: from eggs.gnu.org ([2001:4830:134:3::10]:44898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSJ0-0000FY-Os
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIz-0005hg-Op
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:18 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIz-0005hL-JX
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:17 -0400
Received: by mail-pf0-x244.google.com with SMTP id h19so4724566pfd.12
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:17 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:12 +1000
Message-Id: <43e8c571a05afdd8b44ad43d7f178672399660d5.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 27/30] xen/pt: add AER PCIe Extended
 Capability descriptor and sizing
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

The patch provides Advanced Error Reporting PCIe Extended Capability
description structure and corresponding capability sizing function.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 42296c08cc..98aae3daca 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1924,6 +1924,70 @@ static int xen_pt_msix_size_init(XenPCIPassthroughState *s,
     return 0;
 }
 
+/* get Advanced Error Reporting Extended Capability register group size */
+#define PCI_ERR_CAP_TLP_PREFIX_LOG      (1U << 11)
+#define PCI_DEVCAP2_END_END_TLP_PREFIX  (1U << 21)
+static int xen_pt_ext_cap_aer_size_init(XenPCIPassthroughState *s,
+                                        const XenPTRegGroupInfo *grp_reg,
+                                        uint32_t base_offset,
+                                        uint32_t *size)
+{
+    uint8_t dev_type = get_pcie_device_type(s);
+    uint32_t aer_caps = 0;
+    uint32_t sz = 0;
+    int pcie_cap_pos;
+    uint32_t devcaps2;
+    int ret = 0;
+
+    pcie_cap_pos = xen_host_pci_find_next_cap(&s->real_device, 0,
+                                              PCI_CAP_ID_EXP);
+    if (!pcie_cap_pos) {
+        XEN_PT_ERR(&s->dev,
+                   "Cannot find a required PCI Express Capability\n");
+        return -1;
+    }
+
+    if (get_pcie_capability_version(s) > 1) {
+        ret = xen_host_pci_get_long(&s->real_device,
+                                    pcie_cap_pos + PCI_EXP_DEVCAP2,
+                                    &devcaps2);
+        if (ret) {
+            XEN_PT_ERR(&s->dev, "Error while reading Device "
+                       "Capabilities 2 Register \n");
+            return -1;
+        }
+    }
+
+    if (devcaps2 & PCI_DEVCAP2_END_END_TLP_PREFIX) {
+        ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_ERR_CAP,
+                                    &aer_caps);
+        if (ret) {
+            XEN_PT_ERR(&s->dev,
+                       "Error while reading AER Extended Capability\n");
+            return -1;
+        }
+
+        if (aer_caps & PCI_ERR_CAP_TLP_PREFIX_LOG) {
+            sz = 0x48;
+        }
+    }
+
+    if (!sz) {
+        if (dev_type == PCI_EXP_TYPE_ROOT_PORT ||
+            dev_type == PCI_EXP_TYPE_RC_EC) {
+            sz = 0x38;
+        } else {
+            sz = 0x2C;
+        }
+    }
+
+    *size = sz;
+
+    log_pcie_extended_cap(s, "AER", base_offset, *size);
+    return ret;
+}
+
 
 static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
     /* Header Type0 reg group */
@@ -2192,6 +2256,14 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init  = xen_pt_reg_grp_size_init,
         .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
     },
+    /* Advanced Error Reporting Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ERR),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_aer_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
     {
         .grp_size = 0,
     },
-- 
2.11.0

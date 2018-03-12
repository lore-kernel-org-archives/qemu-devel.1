Received: from eggs.gnu.org ([2001:4830:134:3::10]:44851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIx-0000BQ-Dq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIw-0005fh-6L
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:15 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:42272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIv-0005fL-US
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:14 -0400
Received: by mail-pg0-x242.google.com with SMTP id x2so2730340pgo.9
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:13 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:11 +1000
Message-Id: <1251abd57b81696c15e5d8effe224f7497f59418.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 26/30] xen/pt: add fixed-size PCIe Extended
 Capabilities descriptors
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

This adds description structures for all fixed-size PCIe Extended
Capabilities.

For every capability register group, only 2 registers are emulated
currently: Capability ID (16 bit) and Next Capability Offset/Version (16
bit). Both needed to implement selective capability hiding. All other
registers are passed through at the moment (unless they belong to
a "hardwired" capability which is hidden)

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 6e99b9ebd7..42296c08cc 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1734,6 +1734,37 @@ static XenPTRegInfo xen_pt_ext_cap_emu_reg_vendor[] = {
 };
 
 
+/* Common reg static information table for all passthru-type
+ * PCIe Extended Capabilities. Only Extended Cap ID and
+ * Next pointer are handled (to support capability hiding).
+ */
+static XenPTRegInfo xen_pt_ext_cap_emu_reg_dummy[] = {
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
+        .size = 0,
+    },
+};
+
+
 /****************************
  * Capabilities
  */
@@ -2009,6 +2040,158 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init   = xen_pt_ext_cap_vendor_size_init,
         .emu_regs    = xen_pt_ext_cap_emu_reg_vendor,
     },
+    /* Device Serial Number Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_DSN),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_DSN_SIZEOF,       /*0x0C*/
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Power Budgeting Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PWR),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_PWR_SIZEOF,       /*0x10*/
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Root Complex Internal Link Control Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCILC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x0C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Root Complex Event Collector Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCEC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x08,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Root Complex Register Block Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCRB),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x14,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Configuration Access Correlation Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_CAC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x08,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Alternate Routing ID Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ARI),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_ARI_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Address Translation Services Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ATS),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_ATS_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Single Root I/O Virtualization Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_SRIOV),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_SRIOV_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Page Request Interface Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PRI),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_PRI_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Latency Tolerance Reporting Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_LTR),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_LTR_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Secondary PCIe Capability Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_SECPCI),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x10,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Process Address Space ID Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PASID),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = PCI_EXT_CAP_PASID_SIZEOF,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* L1 PM Substates Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_L1SS),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x10,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Precision Time Measurement Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PTM),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x0C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* M-PCIe Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x20),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x1C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* LN Requester (LNR) Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x1C),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x08,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Function Readiness Status (FRS) Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x21),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x10,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Readiness Time Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(0x22),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0x0C,
+        .size_init  = xen_pt_reg_grp_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
     {
         .grp_size = 0,
     },
-- 
2.11.0

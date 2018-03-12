Received: from eggs.gnu.org ([2001:4830:134:3::10]:44916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSJ6-0000Lg-Sq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSJ3-0005jC-N8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:24 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSJ3-0005it-EG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:21 -0400
Received: by mail-pf0-x244.google.com with SMTP id h11so4724741pfn.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:21 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:13 +1000
Message-Id: <1253d9d553ef8d73af6f5c659f6756402ca28b06.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 28/30] xen/pt: add descriptors and size
 calculation for RCLD/ACS/PMUX/DPA/MCAST/TPH/DPC PCIe Extended Capabilities
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

Add few more PCIe Extended Capabilities entries to the
xen_pt_emu_reg_grps[] array along with their corresponding *_size_init()
functions.

All these capabilities have non-fixed size but their size calculation
is very simple, hence adding them in a single batch.

For every capability register group, only 2 registers are emulated
currently: Capability ID (16 bit) and Next Capability Offset/Version (16
bit). Both needed to implement the selective capability hiding. All other
registers are passed through at the moment (unless they belong to
a capability marked as "hardwired" which is hidden)

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 224 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 98aae3daca..326f5671ff 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1988,6 +1988,174 @@ static int xen_pt_ext_cap_aer_size_init(XenPCIPassthroughState *s,
     return ret;
 }
 
+/* get Root Complex Link Declaration Extended Capability register group size */
+#define RCLD_GET_NUM_ENTRIES(x)     (((x) >> 8) & 0xFF)
+static int xen_pt_ext_cap_rcld_size_init(XenPCIPassthroughState *s,
+                                         const XenPTRegGroupInfo *grp_reg,
+                                         uint32_t base_offset,
+                                         uint32_t *size)
+{
+    uint32_t elem_self_descr = 0;
+
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + 4,
+                                    &elem_self_descr);
+
+    *size = 0x10 + RCLD_GET_NUM_ENTRIES(elem_self_descr) * 0x10;
+
+    log_pcie_extended_cap(s, "Root Complex Link Declaration",
+                          base_offset, *size);
+    return ret;
+}
+
+/* get Access Control Services Extended Capability register group size */
+#define ACS_VECTOR_SIZE_BITS(x)    ((((x) >> 8) & 0xFF) ?: 256)
+static int xen_pt_ext_cap_acs_size_init(XenPCIPassthroughState *s,
+                                        const XenPTRegGroupInfo *grp_reg,
+                                        uint32_t base_offset,
+                                        uint32_t *size)
+{
+    uint16_t acs_caps = 0;
+
+    int ret = xen_host_pci_get_word(&s->real_device,
+                                    base_offset + PCI_ACS_CAP,
+                                    &acs_caps);
+
+    if (acs_caps & PCI_ACS_EC) {
+        uint32_t vector_sz = ACS_VECTOR_SIZE_BITS(acs_caps);
+
+        *size = PCI_ACS_EGRESS_CTL_V + ((vector_sz + 7) & ~7) / 8;
+    } else {
+        *size = PCI_ACS_EGRESS_CTL_V;
+    }
+
+    log_pcie_extended_cap(s, "ACS", base_offset, *size);
+    return ret;
+}
+
+/* get Multicast Extended Capability register group size */
+static int xen_pt_ext_cap_multicast_size_init(XenPCIPassthroughState *s,
+                                              const XenPTRegGroupInfo *grp_reg,
+                                              uint32_t base_offset,
+                                              uint32_t *size)
+{
+    uint8_t dev_type = get_pcie_device_type(s);
+
+    switch (dev_type) {
+    case PCI_EXP_TYPE_ENDPOINT:
+    case PCI_EXP_TYPE_LEG_END:
+    case PCI_EXP_TYPE_RC_END:
+    case PCI_EXP_TYPE_RC_EC:
+    default:
+        *size = PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF;
+        break;
+
+    case PCI_EXP_TYPE_ROOT_PORT:
+    case PCI_EXP_TYPE_UPSTREAM:
+    case PCI_EXP_TYPE_DOWNSTREAM:
+        *size = 0x30;
+        break;
+    }
+
+    log_pcie_extended_cap(s, "Multicast", base_offset, *size);
+    return 0;
+}
+
+/* get Dynamic Power Allocation Extended Capability register group size */
+static int xen_pt_ext_cap_dpa_size_init(XenPCIPassthroughState *s,
+                                        const XenPTRegGroupInfo *grp_reg,
+                                        uint32_t base_offset,
+                                        uint32_t *size)
+{
+    uint32_t dpa_caps = 0;
+    uint32_t num_entries;
+
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_DPA_CAP,
+                                    &dpa_caps);
+
+    num_entries = (dpa_caps & PCI_DPA_CAP_SUBSTATE_MASK) + 1;
+
+    *size = PCI_DPA_BASE_SIZEOF + num_entries /*byte-size registers*/;
+
+    log_pcie_extended_cap(s, "Dynamic Power Allocation", base_offset, *size);
+    return ret;
+}
+
+/* get TPH Requester Extended Capability register group size */
+static int xen_pt_ext_cap_tph_size_init(XenPCIPassthroughState *s,
+                                        const XenPTRegGroupInfo *grp_reg,
+                                        uint32_t base_offset,
+                                        uint32_t *size)
+{
+    uint32_t tph_caps = 0;
+    uint32_t num_entries;
+
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_TPH_CAP,
+                                    &tph_caps);
+
+    switch(tph_caps & PCI_TPH_CAP_LOC_MASK) {
+    case PCI_TPH_LOC_CAP:
+        num_entries = (tph_caps & PCI_TPH_CAP_ST_MASK) >> PCI_TPH_CAP_ST_SHIFT;
+        num_entries++;
+        break;
+
+    case PCI_TPH_LOC_NONE:
+    case PCI_TPH_LOC_MSIX:
+    default:
+        /* not in the capability */
+        num_entries = 0;
+    }
+
+    *size = PCI_TPH_BASE_SIZEOF + num_entries * 2;
+
+    log_pcie_extended_cap(s, "TPH Requester", base_offset, *size);
+    return ret;
+}
+
+/* get Downstream Port Containment Extended Capability register group size */
+static int xen_pt_ext_cap_dpc_size_init(XenPCIPassthroughState *s,
+                                        const XenPTRegGroupInfo *grp_reg,
+                                        uint32_t base_offset,
+                                        uint32_t *size)
+{
+    uint16_t dpc_caps = 0;
+
+    int ret = xen_host_pci_get_word(&s->real_device,
+                                    base_offset + PCI_EXP_DPC_CAP,
+                                    &dpc_caps);
+
+    if (dpc_caps & PCI_EXP_DPC_CAP_RP_EXT) {
+        *size = 0x20 + ((dpc_caps & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8) * 4;
+    } else {
+        *size = 0xC;
+    }
+
+    log_pcie_extended_cap(s, "Downstream Port Containment",
+                          base_offset, *size);
+    return ret;
+}
+
+/* get Protocol Multiplexing Extended Capability register group size */
+#define PMUX_GET_NUM_ENTRIES(x)     ((x) & 0x3F)
+static int xen_pt_ext_cap_pmux_size_init(XenPCIPassthroughState *s,
+                                         const XenPTRegGroupInfo *grp_reg,
+                                         uint32_t base_offset,
+                                         uint32_t *size)
+{
+    uint32_t pmux_caps = 0;
+
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + 4,
+                                    &pmux_caps);
+
+    *size = 0x10 + PMUX_GET_NUM_ENTRIES(pmux_caps) * 4;
+
+    log_pcie_extended_cap(s, "PMUX", base_offset, *size);
+    return ret;
+}
+
 
 static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
     /* Header Type0 reg group */
@@ -2264,6 +2432,62 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init  = xen_pt_ext_cap_aer_size_init,
         .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
     },
+    /* Root Complex Link Declaration Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_RCLD),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_rcld_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Access Control Services Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_ACS),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_acs_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Multicast Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_MCAST),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_multicast_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Dynamic Power Allocation Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_DPA),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_dpa_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* TPH Requester Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_TPH),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_tph_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Protocol Multiplexing Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_PMUX),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_pmux_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
+    /* Downstream Port Containment Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_DPC),
+        .grp_type   = XEN_PT_GRP_TYPE_EMU,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_dpc_size_init,
+        .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
+    },
     {
         .grp_size = 0,
     },
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSJ8-0000N6-Dm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSJ7-0005kK-C2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:26 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSJ7-0005k3-6Z
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:25 -0400
Received: by mail-pf0-x242.google.com with SMTP id x1so4728740pfh.7
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:25 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:14 +1000
Message-Id: <303852531690715bd3b5abfe884bd072523d0072.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 29/30] xen/pt: add Resizable BAR PCIe
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

Unlike other PCIe Extended Capabilities, we currently cannot allow attempts
to use Resizable BAR Capability. Without specifically handling BAR resizing
we're likely end up with corrupted MMIO hole layout if guest OS will
attempt to use this feature. Actually, recent Windows versions started
to understand and use the Resizable BAR Capability (see [1]).

For now, we need to hide the Resizable BAR Capability from guest OS until
BAR resizing emulation support will be implemented in Xen. This support
is a pretty much mandatory todo-feature as the effect of writing
to Resizable BAR control registers can be considered similar
to reprogramming normal BAR registers -- i.e. this needs to be handled
explicitly, resulting in corresponding MMIO BAR range(s) remapping.
Until then, we mark the Resizable BAR Capability as
XEN_PT_GRP_TYPE_HARDWIRED.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/display/resizable-bar-support

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 326f5671ff..b03b071b22 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -2156,6 +2156,26 @@ static int xen_pt_ext_cap_pmux_size_init(XenPCIPassthroughState *s,
     return ret;
 }
 
+/* get Resizable BAR Extended Capability register group size */
+static int xen_pt_ext_cap_rebar_size_init(XenPCIPassthroughState *s,
+                                          const XenPTRegGroupInfo *grp_reg,
+                                          uint32_t base_offset,
+                                          uint32_t *size)
+{
+    uint32_t rebar_ctl = 0;
+    uint32_t num_entries;
+
+    int ret = xen_host_pci_get_long(&s->real_device,
+                                    base_offset + PCI_REBAR_CTRL,
+                                    &rebar_ctl);
+    num_entries =
+        (rebar_ctl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+
+    *size = num_entries*8 + 4;
+
+    log_pcie_extended_cap(s, "Resizable BAR", base_offset, *size);
+    return ret;
+}
 
 static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
     /* Header Type0 reg group */
@@ -2488,6 +2508,13 @@ static const XenPTRegGroupInfo xen_pt_emu_reg_grps[] = {
         .size_init  = xen_pt_ext_cap_dpc_size_init,
         .emu_regs   = xen_pt_ext_cap_emu_reg_dummy,
     },
+    /* Resizable BAR Extended Capability reg group */
+    {
+        .grp_id     = PCIE_EXT_CAP_ID(PCI_EXT_CAP_ID_REBAR),
+        .grp_type   = XEN_PT_GRP_TYPE_HARDWIRED,
+        .grp_size   = 0xFF,
+        .size_init  = xen_pt_ext_cap_rebar_size_init,
+    },
     {
         .grp_size = 0,
     },
-- 
2.11.0

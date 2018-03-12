Received: from eggs.gnu.org ([2001:4830:134:3::10]:44784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIp-000050-Io
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIo-0005cg-Jo
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:07 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:33700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIo-0005c9-Ak
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:06 -0400
Received: by mail-pl0-x242.google.com with SMTP id c11-v6so9833118plo.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:06 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:09 +1000
Message-Id: <2bb9523a189c03a8a4da12af11cbc07f597dff57.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 24/30] xen/pt: allow to hide PCIe Extended
 Capabilities
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

We need to hide some unwanted PCI/PCIe capabilities for passed through
devices.
Normally we do this by marking the capability register group
as XEN_PT_GRP_TYPE_HARDWIRED which exclude this capability from the
capability list and returns zeroes on attempts to read capability body.
Skipping the capability in the linked list of capabilities can be done
by changing Next Capability register to skip one or many unwanted
capabilities.

One difference between PCI and PCIe Extended capabilities is that we don't
have the list head field anymore. PCIe Extended capabilities always start
at offset 0x100 if they're present. Unfortunately, there are typically
only few PCIe extended capabilities present which means there is a chance
that some capability we want to hide will reside at offset 0x100 in PCIe
config space.

The simplest way to hide such capabilities from guest OS or drivers
is faking their capability ID value.

This patch adds the Capability ID register handler which checks
- if the capability to which this register belong starts at offset 0x100
  in PCIe config space
- if this capability is marked as XEN_PT_GRP_TYPE_HARDWIRED

If it is the case, then a fake Capability ID value is returned.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt.c             | 11 +++++++-
 hw/xen/xen_pt.h             |  5 ++++
 hw/xen/xen_pt_config_init.c | 62 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index bf098c26b3..e6a18afa83 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -154,7 +154,16 @@ static uint32_t xen_pt_pci_read_config(PCIDevice *d, uint32_t addr, int len)
     reg_grp_entry = xen_pt_find_reg_grp(s, addr);
     if (reg_grp_entry) {
         /* check 0-Hardwired register group */
-        if (reg_grp_entry->reg_grp->grp_type == XEN_PT_GRP_TYPE_HARDWIRED) {
+        if (reg_grp_entry->reg_grp->grp_type == XEN_PT_GRP_TYPE_HARDWIRED &&
+            /*
+             * For PCIe Extended Capabilities we need to emulate
+             * CapabilityID and NextCapability/Version registers for a
+             * hardwired reg group located at the offset 0x100 in PCIe
+             * config space. This allows us to hide the first extended
+             * capability as well.
+             */
+            !(reg_grp_entry->base_offset == PCI_CONFIG_SPACE_SIZE &&
+            ranges_overlap(addr, len, 0x100, 4))) {
             /* no need to emulate, just return 0 */
             val = 0;
             goto exit;
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 5531347ab2..ac45261679 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -78,6 +78,11 @@ typedef int (*xen_pt_conf_byte_read)
 
 #define XEN_PCI_INTEL_OPREGION 0xfc
 
+#define XEN_PCIE_CAP_ID             0
+#define XEN_PCIE_CAP_LIST_NEXT      2
+
+#define XEN_PCIE_FAKE_CAP_ID_BASE   0xFE00
+
 typedef enum {
     XEN_PT_GRP_TYPE_HARDWIRED = 0,  /* 0 Hardwired reg group */
     XEN_PT_GRP_TYPE_EMU,            /* emul reg group */
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 0ce2a033f9..10f3b67d35 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -31,6 +31,10 @@ static int xen_pt_ext_cap_ptr_reg_init(XenPCIPassthroughState *s,
                                        XenPTRegInfo *reg,
                                        uint32_t real_offset,
                                        uint32_t *data);
+static int xen_pt_ext_cap_capid_reg_init(XenPCIPassthroughState *s,
+                                         XenPTRegInfo *reg,
+                                         uint32_t real_offset,
+                                         uint32_t *data);
 
 /* helper */
 
@@ -1630,6 +1634,56 @@ static XenPTRegInfo xen_pt_emu_reg_igd_opregion[] = {
     },
 };
 
+
+/****************************
+ * Emulated registers for
+ * PCIe Extended Capabilities
+ */
+
+static uint16_t fake_cap_id = XEN_PCIE_FAKE_CAP_ID_BASE;
+
+/* PCIe Extended Capability ID reg */
+static int xen_pt_ext_cap_capid_reg_init(XenPCIPassthroughState *s,
+                                         XenPTRegInfo *reg,
+                                         uint32_t real_offset,
+                                         uint32_t *data)
+{
+    uint16_t reg_field;
+    int rc;
+    XenPTRegGroup *reg_grp_entry = NULL;
+
+    /* use real device register's value as initial value */
+    rc = xen_host_pci_get_word(&s->real_device, real_offset, &reg_field);
+    if (rc) {
+        return rc;
+    }
+
+    reg_grp_entry = xen_pt_find_reg_grp(s, real_offset);
+
+    if (reg_grp_entry) {
+        if (reg_grp_entry->reg_grp->grp_type == XEN_PT_GRP_TYPE_HARDWIRED &&
+            reg_grp_entry->base_offset == PCI_CONFIG_SPACE_SIZE) {
+            /*
+             * This is the situation when we were asked to hide (aka
+             * "hardwire to 0") some PCIe ext capability, but it was located
+             * at offset 0x100 in PCIe config space. In this case we can't
+             * simply exclude it from the linked list of capabilities
+             * (as it is the first entry in the list), so we must fake its
+             * Capability ID in PCIe Extended Capability header, leaving
+             * the Next Ptr field intact while returning zeroes on attempts
+             * to read capability body (writes are ignored).
+             */
+            reg_field = fake_cap_id;
+            /* increment the value in order to have unique Capability IDs */
+            fake_cap_id++;
+        }
+    }
+
+    *data = reg_field;
+    return 0;
+}
+
+
 /****************************
  * Capabilities
  */
@@ -2173,7 +2227,13 @@ void xen_pt_config_init(XenPCIPassthroughState *s, Error **errp)
             }
         }
 
-        if (xen_pt_emu_reg_grps[i].grp_type == XEN_PT_GRP_TYPE_EMU) {
+        if (xen_pt_emu_reg_grps[i].grp_type == XEN_PT_GRP_TYPE_EMU ||
+            /*
+             * We need to always emulate the PCIe Extended Capability
+             * header for a hidden capability which starts at offset 0x100
+             */
+            (xen_pt_emu_reg_grps[i].grp_type == XEN_PT_GRP_TYPE_HARDWIRED &&
+            reg_grp_offset == 0x100)) {
             if (xen_pt_emu_reg_grps[i].emu_regs) {
                 int j = 0;
                 XenPTRegInfo *regs = xen_pt_emu_reg_grps[i].emu_regs;
-- 
2.11.0

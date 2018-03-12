Received: from eggs.gnu.org ([2001:4830:134:3::10]:44758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIm-0008Sm-5V
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1evSIk-0005aw-ML
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:04 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1evSIk-0005ag-Fd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:02 -0400
Received: by mail-pl0-x241.google.com with SMTP id 9-v6so9823668ple.11
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 11:36:02 -0700 (PDT)
From: Alexey Gerasimenko <x1917x@gmail.com>
Date: Tue, 13 Mar 2018 04:34:08 +1000
Message-Id: <56325a135d2acf2bfdbb95369186bfc763845c31.1520867956.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
In-Reply-To: <cover.1520867740.git.x1917x@gmail.com>
References: <cover.1520867740.git.x1917x@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 23/30] xen/pt: handle PCIe Extended
 Capabilities Next register
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

The patch adds new xen_pt_ext_cap_ptr_reg_init function which is used
to initialize the emulated next pcie extended capability pointer.

Primary mission of this function is to have a method to selectively hide
some extended capabilities from the capability linked list, skipping them
by altering the Next capability pointer value.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
---
 hw/xen/xen_pt_config_init.c | 73 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 9c041fa288..0ce2a033f9 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -23,11 +23,14 @@
 
 #define XEN_PT_INVALID_REG          0xFFFFFFFF      /* invalid register value */
 
-/* prototype */
+/* prototypes */
 
 static int xen_pt_ptr_reg_init(XenPCIPassthroughState *s, XenPTRegInfo *reg,
                                uint32_t real_offset, uint32_t *data);
-
+static int xen_pt_ext_cap_ptr_reg_init(XenPCIPassthroughState *s,
+                                       XenPTRegInfo *reg,
+                                       uint32_t real_offset,
+                                       uint32_t *data);
 
 /* helper */
 
@@ -1932,6 +1935,72 @@ out:
     return 0;
 }
 
+#define PCIE_EXT_CAP_NEXT_SHIFT 4
+#define PCIE_EXT_CAP_VER_MASK   0xF
+
+static int xen_pt_ext_cap_ptr_reg_init(XenPCIPassthroughState *s,
+                                       XenPTRegInfo *reg,
+                                       uint32_t real_offset,
+                                       uint32_t *data)
+{
+    int i, rc;
+    XenHostPCIDevice *d = &s->real_device;
+    uint16_t reg_field;
+    uint16_t cur_offset, version, cap_id;
+    uint32_t header;
+
+    if (real_offset < PCI_CONFIG_SPACE_SIZE) {
+        XEN_PT_ERR(&s->dev, "Incorrect PCIe extended capability offset"
+                   "encountered: 0x%04x\n", real_offset);
+        return -EINVAL;
+    }
+
+    rc = xen_host_pci_get_word(d, real_offset, &reg_field);
+    if (rc)
+        return rc;
+
+    /* preserve version field */
+    version    = reg_field & PCIE_EXT_CAP_VER_MASK;
+    cur_offset = reg_field >> PCIE_EXT_CAP_NEXT_SHIFT;
+
+    while (cur_offset && cur_offset != 0xFFF) {
+        rc = xen_host_pci_get_long(d, cur_offset, &header);
+        if (rc) {
+            XEN_PT_ERR(&s->dev, "Failed to read PCIe extended capability "
+                       "@0x%x (rc:%d)\n", cur_offset, rc);
+            return rc;
+        }
+
+        cap_id = PCI_EXT_CAP_ID(header);
+
+        for (i = 0; xen_pt_emu_reg_grps[i].grp_size != 0; i++) {
+            uint32_t cur_grp_id = xen_pt_emu_reg_grps[i].grp_id;
+
+            if (!IS_PCIE_EXT_CAP_ID(cur_grp_id))
+                continue;
+
+            if (xen_pt_hide_dev_cap(d, cur_grp_id))
+                continue;
+
+            if (GET_PCIE_EXT_CAP_ID(cur_grp_id) == cap_id) {
+                if (xen_pt_emu_reg_grps[i].grp_type == XEN_PT_GRP_TYPE_EMU)
+                    goto out;
+
+                /* skip TYPE_HARDWIRED capability, move the ptr to next one */
+                break;
+            }
+        }
+
+        /* next capability */
+        cur_offset = PCI_EXT_CAP_NEXT(header);
+    }
+
+out:
+    *data = (cur_offset << PCIE_EXT_CAP_NEXT_SHIFT) | version;
+    return 0;
+}
+
+
 
 /*************
  * Main
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkr78-0001JC-Ex
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkr72-0002Ts-0n
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:19:58 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:9295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkr71-0002TH-Nj
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:19:51 -0400
From: Roger Pau Monne <roger.pau@citrix.com>
Date: Thu, 24 Aug 2017 13:19:19 +0100
Message-ID: <20170824121919.78678-3-roger.pau@citrix.com>
In-Reply-To: <20170824121919.78678-1-roger.pau@citrix.com>
References: <20170824121919.78678-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH QEMU v2] xen/pt: allow QEMU to request MSI
 unmasking at bind time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org
Cc: Roger Pau Monne <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Jan Beulich <JBeulich@suse.com>, qemu-devel@nongnu.org

When a MSI interrupt is bound to a guest using
xc_domain_update_msi_irq (XEN_DOMCTL_bind_pt_irq) the interrupt is
left masked by default.

This causes problems with guests that first configure interrupts and
clean the per-entry MSIX table mask bit and afterwards enable MSIX
globally. In such scenario the Xen internal msixtbl handlers would not
detect the unmasking of MSIX entries because vectors are not yet
registered since MSIX is not enabled, and vectors would be left
masked.

Introduce a new flag in the gflags field to signal Xen whether a MSI
interrupt should be unmasked after being bound.

This also requires to track the mask register for MSI interrupts, so
QEMU can also notify to Xen whether the MSI interrupt should be bound
masked or unmasked

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reported-by: Andreas Kinzler <hfp@posteo.de>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: qemu-devel@nongnu.org
---
Changes since v1:
 - Track MSI mask bits.
 - Notify Xen of whether MSI interrupts should be unmasked after
   binding, instead of hardcoding it.
---
 hw/xen/xen_pt.h             |  1 +
 hw/xen/xen_pt_config_init.c | 19 +++++++++++++++++--
 hw/xen/xen_pt_msi.c         | 13 ++++++++++---
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index 191d9caea1..aa39a9aa5f 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -180,6 +180,7 @@ typedef struct XenPTMSI {
     uint32_t addr_hi;  /* guest message upper address */
     uint16_t data;     /* guest message data */
     uint32_t ctrl_offset; /* saved control offset */
+    uint32_t mask;     /* guest mask bits */
     int pirq;          /* guest pirq corresponding */
     bool initialized;  /* when guest MSI is initialized */
     bool mapped;       /* when pirq is mapped */
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 1f04ec5eec..9c724eeb62 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -1315,6 +1315,21 @@ static int xen_pt_msgdata_reg_write(XenPCIPassthroughState *s,
     return 0;
 }
 
+static int xen_pt_mask_reg_write(XenPCIPassthroughState *s, XenPTReg *cfg_entry,
+                                 uint32_t *val, uint32_t dev_value,
+                                 uint32_t valid_mask)
+{
+    int rc;
+
+    rc = xen_pt_long_reg_write(s, cfg_entry, val, dev_value, valid_mask);
+    if (rc)
+        return rc;
+
+    s->msi->mask = *val;
+
+    return 0;
+}
+
 /* MSI Capability Structure reg static information table */
 static XenPTRegInfo xen_pt_emu_reg_msi[] = {
     /* Next Pointer reg */
@@ -1393,7 +1408,7 @@ static XenPTRegInfo xen_pt_emu_reg_msi[] = {
         .emu_mask   = 0xFFFFFFFF,
         .init       = xen_pt_mask_reg_init,
         .u.dw.read  = xen_pt_long_reg_read,
-        .u.dw.write = xen_pt_long_reg_write,
+        .u.dw.write = xen_pt_mask_reg_write,
     },
     /* Mask reg (if PCI_MSI_FLAGS_MASKBIT set, for 64-bit devices) */
     {
@@ -1404,7 +1419,7 @@ static XenPTRegInfo xen_pt_emu_reg_msi[] = {
         .emu_mask   = 0xFFFFFFFF,
         .init       = xen_pt_mask_reg_init,
         .u.dw.read  = xen_pt_long_reg_read,
-        .u.dw.write = xen_pt_long_reg_write,
+        .u.dw.write = xen_pt_mask_reg_write,
     },
     /* Pending reg (if PCI_MSI_FLAGS_MASKBIT set, for 32-bit devices) */
     {
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index ff9a79f5d2..6d1e3bdeb4 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -24,6 +24,7 @@
 #define XEN_PT_GFLAGS_SHIFT_DM             9
 #define XEN_PT_GFLAGSSHIFT_DELIV_MODE     12
 #define XEN_PT_GFLAGSSHIFT_TRG_MODE       15
+#define XEN_PT_GFLAGSSHIFT_UNMASKED       16
 
 #define latch(fld) latch[PCI_MSIX_ENTRY_##fld / sizeof(uint32_t)]
 
@@ -155,7 +156,8 @@ static int msi_msix_update(XenPCIPassthroughState *s,
                            int pirq,
                            bool is_msix,
                            int msix_entry,
-                           int *old_pirq)
+                           int *old_pirq,
+                           bool masked)
 {
     PCIDevice *d = &s->dev;
     uint8_t gvec = msi_vector(data);
@@ -171,6 +173,8 @@ static int msi_msix_update(XenPCIPassthroughState *s,
         table_addr = s->msix->mmio_base_addr;
     }
 
+    gflags |= masked ? 0 : (1u << XEN_PT_GFLAGSSHIFT_UNMASKED);
+
     rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
                                   pirq, gflags, table_addr);
 
@@ -273,8 +277,10 @@ int xen_pt_msi_setup(XenPCIPassthroughState *s)
 int xen_pt_msi_update(XenPCIPassthroughState *s)
 {
     XenPTMSI *msi = s->msi;
+
+    /* Current MSI emulation in QEMU only supports 1 vector */
     return msi_msix_update(s, msi_addr64(msi), msi->data, msi->pirq,
-                           false, 0, &msi->pirq);
+                           false, 0, &msi->pirq, msi->mask & 1);
 }
 
 void xen_pt_msi_disable(XenPCIPassthroughState *s)
@@ -355,7 +361,8 @@ static int xen_pt_msix_update_one(XenPCIPassthroughState *s, int entry_nr,
     }
 
     rc = msi_msix_update(s, entry->addr, entry->data, pirq, true,
-                         entry_nr, &entry->pirq);
+                         entry_nr, &entry->pirq,
+                         vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
     if (!rc) {
         entry->updated = false;
-- 
2.11.0 (Apple Git-81)

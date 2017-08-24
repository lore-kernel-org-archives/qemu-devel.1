Received: from eggs.gnu.org ([2001:4830:134:3::10]:56353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpDd-0000hi-6H
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpDa-0006fE-1J
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:18:33 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:1520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=402c228e5=roger.pau@citrix.com>)
	id 1dkpDZ-0006es-RM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:18:29 -0400
From: Roger Pau Monne <roger.pau@citrix.com>
Date: Thu, 24 Aug 2017 10:47:53 +0100
Message-ID: <20170824094753.77795-3-roger.pau@citrix.com>
In-Reply-To: <20170824094753.77795-1-roger.pau@citrix.com>
References: <20170824094753.77795-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH QEMU] xen/pt: allow QEMU to request MSI
 unmasking at bind time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, hfp@posteo.de
Cc: Roger Pau Monne <roger.pau@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Jan Beulich <JBeulich@suse.com>, qemu-devel@nongnu.org

When a MSIX interrupt is bound to a guest using
xc_domain_update_msi_irq (XEN_DOMCTL_bind_pt_irq) the interrupt is
left masked by default.

This causes problems with guests that first configure interrupts and
clean the per-entry MSIX table mask bit and afterwards enable MSIX
globally. In such scenario the Xen internal msixtbl handlers would not
detect the unmasking of MSIX entries because vectors are not yet
registered since MSIX is not enabled, and vectors would be left
masked.

Introduce a new flag in the gflags field to signal Xen whether a MSIX
interrupt should be unmasked after being bound.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reported-by: Andreas Kinzler <hfp@posteo.de>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: qemu-devel@nongnu.org
---
 hw/xen/xen_pt_msi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index ff9a79f5d2..c00ac2fd7d 100644
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
 
@@ -274,7 +278,7 @@ int xen_pt_msi_update(XenPCIPassthroughState *s)
 {
     XenPTMSI *msi = s->msi;
     return msi_msix_update(s, msi_addr64(msi), msi->data, msi->pirq,
-                           false, 0, &msi->pirq);
+                           false, 0, &msi->pirq, false);
 }
 
 void xen_pt_msi_disable(XenPCIPassthroughState *s)
@@ -355,7 +359,8 @@ static int xen_pt_msix_update_one(XenPCIPassthroughState *s, int entry_nr,
     }
 
     rc = msi_msix_update(s, entry->addr, entry->data, pirq, true,
-                         entry_nr, &entry->pirq);
+                         entry_nr, &entry->pirq,
+                         vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
     if (!rc) {
         entry->updated = false;
-- 
2.11.0 (Apple Git-81)

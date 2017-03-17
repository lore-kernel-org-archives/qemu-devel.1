Received: from eggs.gnu.org ([2001:4830:134:3::10]:56974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBy-0003uM-Sh
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1coqBt-0007GD-W9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:17799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1coqBt-0007E2-Jy
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:37:05 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Fri, 17 Mar 2017 19:29:17 +0800
Message-Id: <1489750157-17401-5-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [RFC PATCH 4/4] msi: taking interrupt format into
 consideration during judging a pirq is binded with a event channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xensource.com
Cc: chao.gao@intel.com, kevin.tian@intel.com, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, anthony.perard@citrix.com, Lan Tianyu <tianyu.lan@intel.com>

From: Chao Gao <chao.gao@intel.com>

As remapping format interrupt has been introduced, the vector in msi remapping
format can also be 0, same as a interrupt is binded with a event channel.
So we can't just use whether vector is 0 or not to judge a msi is binded
to a event channel or not.

This patch takes the msi interrupt format into consideration.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/pci/msi.c         | 5 +++--
 hw/pci/msix.c        | 4 +++-
 hw/xen/xen_pt_msi.c  | 2 +-
 include/hw/xen/xen.h | 2 +-
 xen-hvm-stub.c       | 2 +-
 xen-hvm.c            | 7 ++++++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index a87b227..8d1ac9e 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -289,7 +289,7 @@ void msi_reset(PCIDevice *dev)
 static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
 {
     uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
-    uint32_t mask, data;
+    uint32_t mask, data, addr_lo;
     bool msi64bit = flags & PCI_MSI_FLAGS_64BIT;
     assert(vector < PCI_MSI_VECTORS_MAX);
 
@@ -298,7 +298,8 @@ static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
     }
 
     data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
-    if (xen_is_pirq_msi(data)) {
+    addr_lo = pci_get_word(dev->config + msi_address_lo_off(dev));
+    if (xen_is_pirq_msi(data, addr_lo)) {
         return false;
     }
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 0ec1cb1..6b8045a 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -81,9 +81,11 @@ static bool msix_vector_masked(PCIDevice *dev, unsigned int vector, bool fmask)
 {
     unsigned offset = vector * PCI_MSIX_ENTRY_SIZE;
     uint8_t *data = &dev->msix_table[offset + PCI_MSIX_ENTRY_DATA];
+    uint8_t *addr_lo = &dev->msix_table[offset + PCI_MSIX_ENTRY_LOWER_ADDR];
     /* MSIs on Xen can be remapped into pirqs. In those cases, masking
      * and unmasking go through the PV evtchn path. */
-    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data))) {
+    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data),
+                                         pci_get_long(addr_lo))) {
         return false;
     }
     return fmask || dev->msix_table[offset + PCI_MSIX_ENTRY_VECTOR_CTRL] &
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index 8b0d7fc..f799fed 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -114,7 +114,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
 
     assert((!is_msix && msix_entry == 0) || is_msix);
 
-    if (xen_is_pirq_msi(data)) {
+    if (xen_is_pirq_msi(data, (uint32_t)(addr & 0xffffffff))) {
         *ppirq = msi_ext_dest_id(addr >> 32) | msi_dest_id(addr);
         if (!*ppirq) {
             /* this probably identifies an misconfiguration of the guest,
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index a8f3afb..c15beb5 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -33,7 +33,7 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 void xen_piix3_set_irq(void *opaque, int irq_num, int level);
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
-int xen_is_pirq_msi(uint32_t msi_data);
+int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo);
 
 qemu_irq *xen_interrupt_controller_init(void);
 
diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
index c500325..dae421c 100644
--- a/xen-hvm-stub.c
+++ b/xen-hvm-stub.c
@@ -31,7 +31,7 @@ void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
 {
 }
 
-int xen_is_pirq_msi(uint32_t msi_data)
+int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
 {
     return 0;
 }
diff --git a/xen-hvm.c b/xen-hvm.c
index 2f348ed..9e78b23 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -146,8 +146,13 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
     }
 }
 
-int xen_is_pirq_msi(uint32_t msi_data)
+int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
 {
+    /* If msi address is configurate to remapping format, the msi will not
+     * remapped into a pirq.
+     */
+    if ( msi_addr_lo & 0x10 )
+        return 0;
     /* If vector is 0, the msi is remapped into a pirq, passed as
      * dest_id.
      */
-- 
1.8.3.1

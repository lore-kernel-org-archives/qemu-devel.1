Received: from eggs.gnu.org ([2001:4830:134:3::10]:57277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eFa6c-0001AY-EH
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eFa6b-0001Iq-9V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:62640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1eFa6a-0000tS-TO
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 01:26:25 -0500
From: Chao Gao <chao.gao@intel.com>
Date: Fri, 17 Nov 2017 14:24:25 +0800
Message-Id: <1510899865-40323-4-git-send-email-chao.gao@intel.com>
In-Reply-To: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
References: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/3] msi: Handle remappable format interrupt
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chao Gao <chao.gao@intel.com>, xen-devel@lists.xenproject.org, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>

According to VT-d spec Interrupt Remapping and Interrupt Posting ->
Interrupt Remapping -> Interrupt Request Formats On Intel 64
Platforms, fields of MSI data register have changed. This patch
avoids wrongly regarding a remappable format interrupt request as
an interrupt binded with a pirq.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
v3:
 - clarify the interrupt format bit is Intel-specific, then it is
 improper to define MSI_ADDR_IF_MASK in a common header.
---
 hw/i386/xen/xen-hvm.c | 10 +++++++++-
 hw/pci/msi.c          |  5 +++--
 hw/pci/msix.c         |  4 +++-
 hw/xen/xen_pt_msi.c   |  2 +-
 include/hw/xen/xen.h  |  2 +-
 stubs/xen-hvm.c       |  2 +-
 6 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 8028bed..52dc8af 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -145,8 +145,16 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
     }
 }
 
-int xen_is_pirq_msi(uint32_t msi_data)
+int xen_is_pirq_msi(uint32_t msi_addr_lo, uint32_t msi_data)
 {
+    /* If the MSI address is configured in remapping format, the MSI will not
+     * be remapped into a pirq. This 'if' test excludes Intel-specific
+     * remappable msi.
+     */
+#define MSI_ADDR_IF_MASK 0x00000010
+    if (msi_addr_lo & MSI_ADDR_IF_MASK) {
+        return 0;
+    }
     /* If vector is 0, the msi is remapped into a pirq, passed as
      * dest_id.
      */
diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index 5e05ce5..d05c876 100644
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
+    addr_lo = pci_get_long(dev->config + msi_address_lo_off(dev));
+    if (xen_is_pirq_msi(addr_lo, data)) {
         return false;
     }
 
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index c944c02..4cb01db 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -83,9 +83,11 @@ static bool msix_vector_masked(PCIDevice *dev, unsigned int vector, bool fmask)
 {
     unsigned offset = vector * PCI_MSIX_ENTRY_SIZE;
     uint8_t *data = &dev->msix_table[offset + PCI_MSIX_ENTRY_DATA];
+    uint8_t *addr_lo = &dev->msix_table[offset + PCI_MSIX_ENTRY_LOWER_ADDR];
     /* MSIs on Xen can be remapped into pirqs. In those cases, masking
      * and unmasking go through the PV evtchn path. */
-    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data))) {
+    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(addr_lo),
+                                         pci_get_long(data))) {
         return false;
     }
     return fmask || dev->msix_table[offset + PCI_MSIX_ENTRY_VECTOR_CTRL] &
diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
index f7d6e76..0e5bf83 100644
--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -96,7 +96,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
 
     assert((!is_msix && msix_entry == 0) || is_msix);
 
-    if (xen_is_pirq_msi(data)) {
+    if (xen_is_pirq_msi(addr, data)) {
         *ppirq = msi_ext_dest_id(addr >> 32) | msi_dest_id(addr);
         if (!*ppirq) {
             /* this probably identifies an misconfiguration of the guest,
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 7efcdaa..0d6c83e 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -34,7 +34,7 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 void xen_piix3_set_irq(void *opaque, int irq_num, int level);
 void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
 void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
-int xen_is_pirq_msi(uint32_t msi_data);
+int xen_is_pirq_msi(uint32_t msi_addr_lo, uint32_t msi_data);
 
 qemu_irq *xen_interrupt_controller_init(void);
 
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 3ca6c51..aeb1592 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -31,7 +31,7 @@ void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
 {
 }
 
-int xen_is_pirq_msi(uint32_t msi_data)
+int xen_is_pirq_msi(uint32_t msi_addr_lo, uint32_t msi_data)
 {
     return 0;
 }
-- 
1.8.3.1

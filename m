Received: from eggs.gnu.org ([2001:4830:134:3::10]:35454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePp-0002YN-IE
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePn-0007x6-Bc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:44873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwePn-0007w8-3P
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:43 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Fri,  7 Apr 2017 17:45:33 -0700
Message-Id: <1491612336-31066-2-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 1/4] pam:refactor PAM related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, Anthony Xu <anthony.xu@intel.com>

split PAM SMRAM functions in piix.c
create mch_init_pam in q35.c

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 hw/pci-host/piix.c | 58 ++++++++++++++++++++++++++++++++++++++----------------
 hw/pci-host/q35.c  | 23 +++++++++++++---------
 2 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index f9218aa..ff4e8b5 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -138,16 +138,11 @@ static int pci_slot_get_pirq(PCIDevice *pci_dev, int pci_intx)
     return (pci_intx + slot_addend) & 3;
 }
 
-static void i440fx_update_memory_mappings(PCII440FXState *d)
+static void i440fx_update_smram(PCII440FXState *d)
 {
-    int i;
     PCIDevice *pd = PCI_DEVICE(d);
 
     memory_region_transaction_begin();
-    for (i = 0; i < 13; i++) {
-        pam_update(&d->pam_regions[i], i,
-                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
-    }
     memory_region_set_enabled(&d->smram_region,
                               !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
     memory_region_set_enabled(&d->smram,
@@ -155,6 +150,39 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
     memory_region_transaction_commit();
 }
 
+static void i440fx_update_pam(PCII440FXState *d)
+{
+    int i;
+    PCIDevice *pd = PCI_DEVICE(d);
+    memory_region_transaction_begin();
+    pam_update(&d->pam_regions[0], 0,
+               pd->config[I440FX_PAM]);
+    for (i = 1; i < 13; i++) {
+        pam_update(&d->pam_regions[i], i,
+                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
+    }
+    memory_region_transaction_commit();
+}
+
+static void i440fx_update_memory_mappings(PCII440FXState *d)
+{
+    i440fx_update_pam(d);
+    i440fx_update_smram(d);
+}
+
+
+static void i440fx_init_pam(PCII440FXState *d)
+{
+    int i;
+    init_pam(DEVICE(d), d->ram_memory, d->system_memory,
+             d->pci_address_space, &d->pam_regions[0],
+             PAM_BIOS_BASE,  PAM_BIOS_SIZE);
+    for (i = 0; i < 12; ++i) {
+        init_pam(DEVICE(d), d->ram_memory, d->system_memory,
+                 d->pci_address_space, &d->pam_regions[i + 1],
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+    }
+}
 
 static void i440fx_write_config(PCIDevice *dev,
                                 uint32_t address, uint32_t val, int len)
@@ -163,9 +191,12 @@ static void i440fx_write_config(PCIDevice *dev,
 
     /* XXX: implement SMRAM.D_LOCK */
     pci_default_write_config(dev, address, val, len);
-    if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||
-        range_covers_byte(address, len, I440FX_SMRAM)) {
-        i440fx_update_memory_mappings(d);
+    if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE)) {
+        i440fx_update_pam(d);
+    }
+
+    if (range_covers_byte(address, len, I440FX_SMRAM)) {
+        i440fx_update_smram(d);
     }
 }
 
@@ -335,7 +366,6 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     PCIHostState *s;
     PIIX3State *piix3;
     PCII440FXState *f;
-    unsigned i;
     I440FXState *i440fx;
 
     dev = qdev_create(NULL, host_type);
@@ -378,13 +408,7 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&f->smram), &error_abort);
 
-    init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
-             &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < 12; ++i) {
-        init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
-                 &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE,
-                 PAM_EXPAN_SIZE);
-    }
+    i440fx_init_pam(f);
 
     /* Xen supports additional interrupt routes from the PCI devices to
      * the IOAPIC: the four pins of each PCI device on the bus are also
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 344f77b..8866357 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -460,9 +460,21 @@ static void mch_reset(DeviceState *qdev)
     mch_update(mch);
 }
 
-static void mch_realize(PCIDevice *d, Error **errp)
+static void mch_init_pam(MCHPCIState *mch)
 {
     int i;
+    init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
+             mch->pci_address_space, &mch->pam_regions[0],
+             PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    for (i = 0; i < 12; ++i) {
+        init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
+                 mch->pci_address_space, &mch->pam_regions[i + 1],
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+    }
+}
+
+static void mch_realize(PCIDevice *d, Error **errp)
+{
     MCHPCIState *mch = MCH_PCI_DEVICE(d);
 
     /* setup pci memory mapping */
@@ -510,14 +522,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
     object_property_add_const_link(qdev_get_machine(), "smram",
                                    OBJECT(&mch->smram), &error_abort);
 
-    init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
-             mch->pci_address_space, &mch->pam_regions[0],
-             PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < 12; ++i) {
-        init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
-                 mch->pci_address_space, &mch->pam_regions[i+1],
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
-    }
+    mch_init_pam(mch);
 }
 
 uint64_t mch_mcfg_base(void)
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePp-0002YM-I5
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cwePn-0007xG-My
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:37867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cwePn-0007wz-B6
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:39:43 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Fri,  7 Apr 2017 17:45:34 -0700
Message-Id: <1491612336-31066-3-git-send-email-anthony.xu@intel.com>
In-Reply-To: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
References: <1491612336-31066-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH 2/4] pam: Make PAM configurable
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

by default PAM is enabled. when PAM is disabled,
*_init_pam and *_update_pam are dummy functions

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 hw/i386/pc.c         | 18 ++++++++++++++++++
 hw/pci-host/piix.c   | 36 ++++++++++++++++++++----------------
 hw/pci-host/q35.c    | 34 +++++++++++++++++++---------------
 include/hw/i386/pc.h |  2 ++
 4 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e..9d154c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2210,6 +2210,20 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
     pcms->pit = value;
 }
 
+static bool pc_machine_get_pam(Object *obj, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    return pcms->pam;
+}
+
+static void pc_machine_set_pam(Object *obj, bool value, Error **errp)
+{
+    PCMachineState *pcms = PC_MACHINE(obj);
+
+    pcms->pam = value;
+}
+
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -2224,6 +2238,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->smbus = true;
     pcms->sata = true;
     pcms->pit = true;
+    pcms->pam = true;
 }
 
 static void pc_machine_reset(void)
@@ -2372,6 +2387,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
 
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
         pc_machine_get_pit, pc_machine_set_pit, &error_abort);
+
+    object_class_property_add_bool(oc, PC_MACHINE_PAM,
+        pc_machine_get_pam, pc_machine_set_pam, &error_abort);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index ff4e8b5..7497516 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -152,16 +152,18 @@ static void i440fx_update_smram(PCII440FXState *d)
 
 static void i440fx_update_pam(PCII440FXState *d)
 {
-    int i;
-    PCIDevice *pd = PCI_DEVICE(d);
-    memory_region_transaction_begin();
-    pam_update(&d->pam_regions[0], 0,
-               pd->config[I440FX_PAM]);
-    for (i = 1; i < 13; i++) {
-        pam_update(&d->pam_regions[i], i,
-                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
+    if (PC_MACHINE(current_machine)->pam) {
+        int i;
+        PCIDevice *pd = PCI_DEVICE(d);
+        memory_region_transaction_begin();
+        pam_update(&d->pam_regions[0], 0,
+                   pd->config[I440FX_PAM]);
+        for (i = 1; i < 13; i++) {
+            pam_update(&d->pam_regions[i], i,
+                       pd->config[I440FX_PAM + ((i + 1) / 2)]);
+        }
+        memory_region_transaction_commit();
     }
-    memory_region_transaction_commit();
 }
 
 static void i440fx_update_memory_mappings(PCII440FXState *d)
@@ -173,14 +175,16 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
 
 static void i440fx_init_pam(PCII440FXState *d)
 {
-    int i;
-    init_pam(DEVICE(d), d->ram_memory, d->system_memory,
-             d->pci_address_space, &d->pam_regions[0],
-             PAM_BIOS_BASE,  PAM_BIOS_SIZE);
-    for (i = 0; i < 12; ++i) {
+    if (PC_MACHINE(current_machine)->pam) {
+        int i;
         init_pam(DEVICE(d), d->ram_memory, d->system_memory,
-                 d->pci_address_space, &d->pam_regions[i + 1],
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+                 d->pci_address_space, &d->pam_regions[0],
+                 PAM_BIOS_BASE,  PAM_BIOS_SIZE);
+        for (i = 0; i < 12; ++i) {
+            init_pam(DEVICE(d), d->ram_memory, d->system_memory,
+                     d->pci_address_space, &d->pam_regions[i + 1],
+                     PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+        }
     }
 }
 
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 8866357..e63b057 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -310,15 +310,17 @@ static void mch_update_pciexbar(MCHPCIState *mch)
 /* PAM */
 static void mch_update_pam(MCHPCIState *mch)
 {
-    PCIDevice *pd = PCI_DEVICE(mch);
-    int i;
-
-    memory_region_transaction_begin();
-    for (i = 0; i < 13; i++) {
-        pam_update(&mch->pam_regions[i], i,
-                   pd->config[MCH_HOST_BRIDGE_PAM0 + ((i + 1) / 2)]);
+    if (PC_MACHINE(current_machine)->pam) {
+        PCIDevice *pd = PCI_DEVICE(mch);
+        int i;
+
+        memory_region_transaction_begin();
+        for (i = 0; i < 13; i++) {
+            pam_update(&mch->pam_regions[i], i,
+                       pd->config[MCH_HOST_BRIDGE_PAM0 + ((i + 1) / 2)]);
+        }
+        memory_region_transaction_commit();
     }
-    memory_region_transaction_commit();
 }
 
 /* SMRAM */
@@ -462,14 +464,16 @@ static void mch_reset(DeviceState *qdev)
 
 static void mch_init_pam(MCHPCIState *mch)
 {
-    int i;
-    init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
-             mch->pci_address_space, &mch->pam_regions[0],
-             PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < 12; ++i) {
+    if (PC_MACHINE(current_machine)->pam) {
+        int i;
         init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
-                 mch->pci_address_space, &mch->pam_regions[i + 1],
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+                 mch->pci_address_space, &mch->pam_regions[0],
+                 PAM_BIOS_BASE, PAM_BIOS_SIZE);
+        for (i = 0; i < 12; ++i) {
+            init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
+                     mch->pci_address_space, &mch->pam_regions[i + 1],
+                     PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+        }
     }
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f278b3a..05f4df5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -66,6 +66,7 @@ struct PCMachineState {
     bool smbus;
     bool sata;
     bool pit;
+    bool pam;
 
     /* RAM information (sizes, addresses, configuration): */
     ram_addr_t below_4g_mem_size, above_4g_mem_size;
@@ -93,6 +94,7 @@ struct PCMachineState {
 #define PC_MACHINE_SMBUS            "smbus"
 #define PC_MACHINE_SATA             "sata"
 #define PC_MACHINE_PIT              "pit"
+#define PC_MACHINE_PAM              "pam"
 
 /**
  * PCMachineClass:
-- 
1.8.3.1

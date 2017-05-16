Received: from eggs.gnu.org ([2001:4830:134:3::10]:36643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAR5R-0001vU-CP
	for qemu-devel@nongnu.org; Mon, 15 May 2017 21:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAR5O-0006gh-4e
	for qemu-devel@nongnu.org; Mon, 15 May 2017 21:15:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:40296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dAR5N-0006gQ-Pk
	for qemu-devel@nongnu.org; Mon, 15 May 2017 21:15:38 -0400
From: Anthony Xu <anthony.xu@intel.com>
Date: Mon, 15 May 2017 18:21:23 -0700
Message-Id: <1494897683-16395-1-git-send-email-anthony.xu@intel.com>
Subject: [Qemu-devel] [PATCH] SMM: disable smram region if smm is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Anthony Xu <anthony.xu@intel.com>

when smm is disabled, smram is not used, so disable it

Signed-off-by: Anthony Xu <anthony.xu@intel.com>
---
 hw/pci-host/piix.c | 45 +++++++++++++++--------------
 hw/pci-host/q35.c  | 83 +++++++++++++++++++++++++++++-------------------------
 kvm-all.c          |  3 +-
 target/i386/kvm.c  |  2 +-
 4 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index bf4221d..ce43f87 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -142,10 +142,12 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
         pam_update(&d->pam_regions[i], i,
                    pd->config[I440FX_PAM + ((i + 1) / 2)]);
     }
-    memory_region_set_enabled(&d->smram_region,
-                              !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
-    memory_region_set_enabled(&d->smram,
-                              pd->config[I440FX_SMRAM] & SMRAM_G_SMRAME);
+    if (pc_machine_is_smm_enabled(PC_MACHINE(current_machine))) {
+        memory_region_set_enabled(&d->smram_region,
+                !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
+        memory_region_set_enabled(&d->smram,
+                pd->config[I440FX_SMRAM] & SMRAM_G_SMRAME);
+    }
     memory_region_transaction_commit();
 }
 
@@ -355,23 +357,24 @@ PCIBus *i440fx_init(const char *host_type, const char *pci_type,
     pc_pci_as_mapping_init(OBJECT(f), f->system_memory,
                            f->pci_address_space);
 
-    /* if *disabled* show SMRAM to all CPUs */
-    memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
-                             f->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
-                                        &f->smram_region, 1);
-    memory_region_set_enabled(&f->smram_region, true);
-
-    /* smram, as seen by SMM CPUs */
-    memory_region_init(&f->smram, OBJECT(d), "smram", 1ull << 32);
-    memory_region_set_enabled(&f->smram, true);
-    memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
-                             f->ram_memory, 0xa0000, 0x20000);
-    memory_region_set_enabled(&f->low_smram, true);
-    memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
-    object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&f->smram), &error_abort);
-
+    if (pc_machine_is_smm_enabled(PC_MACHINE(current_machine))) {
+        /* if *disabled* show SMRAM to all CPUs */
+        memory_region_init_alias(&f->smram_region, OBJECT(d), "smram-region",
+                f->pci_address_space, 0xa0000, 0x20000);
+        memory_region_add_subregion_overlap(f->system_memory, 0xa0000,
+                &f->smram_region, 1);
+        memory_region_set_enabled(&f->smram_region, true);
+
+        /* smram, as seen by SMM CPUs */
+        memory_region_init(&f->smram, OBJECT(d), "smram", 1ull << 32);
+        memory_region_set_enabled(&f->smram, true);
+        memory_region_init_alias(&f->low_smram, OBJECT(d), "smram-low",
+                f->ram_memory, 0xa0000, 0x20000);
+        memory_region_set_enabled(&f->low_smram, true);
+        memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
+        object_property_add_const_link(qdev_get_machine(), "smram",
+                OBJECT(&f->smram), &error_abort);
+    }
     init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
              &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
     for (i = 0; i < 12; ++i) {
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 344f77b..a10d79e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -324,6 +324,9 @@ static void mch_update_pam(MCHPCIState *mch)
 /* SMRAM */
 static void mch_update_smram(MCHPCIState *mch)
 {
+    if (!pc_machine_is_smm_enabled(PC_MACHINE(current_machine))) {
+        return;
+    }
     PCIDevice *pd = PCI_DEVICE(mch);
     bool h_smrame = (pd->config[MCH_HOST_BRIDGE_ESMRAMC] & MCH_HOST_BRIDGE_ESMRAMC_H_SMRAME);
     uint32_t tseg_size;
@@ -469,46 +472,48 @@ static void mch_realize(PCIDevice *d, Error **errp)
     pc_pci_as_mapping_init(OBJECT(mch), mch->system_memory,
                            mch->pci_address_space);
 
-    /* if *disabled* show SMRAM to all CPUs */
-    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
-                             mch->pci_address_space, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(mch->system_memory, 0xa0000,
-                                        &mch->smram_region, 1);
-    memory_region_set_enabled(&mch->smram_region, true);
-
-    memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
-                             mch->ram_memory, 0xa0000, 0x20000);
-    memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
-                                        &mch->open_high_smram, 1);
-    memory_region_set_enabled(&mch->open_high_smram, false);
-
-    /* smram, as seen by SMM CPUs */
-    memory_region_init(&mch->smram, OBJECT(mch), "smram", 1ull << 32);
-    memory_region_set_enabled(&mch->smram, true);
-    memory_region_init_alias(&mch->low_smram, OBJECT(mch), "smram-low",
-                             mch->ram_memory, 0xa0000, 0x20000);
-    memory_region_set_enabled(&mch->low_smram, true);
-    memory_region_add_subregion(&mch->smram, 0xa0000, &mch->low_smram);
-    memory_region_init_alias(&mch->high_smram, OBJECT(mch), "smram-high",
-                             mch->ram_memory, 0xa0000, 0x20000);
-    memory_region_set_enabled(&mch->high_smram, true);
-    memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
-
-    memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
-                          &tseg_blackhole_ops, NULL,
-                          "tseg-blackhole", 0);
-    memory_region_set_enabled(&mch->tseg_blackhole, false);
-    memory_region_add_subregion_overlap(mch->system_memory,
-                                        mch->below_4g_mem_size,
-                                        &mch->tseg_blackhole, 1);
+    if (pc_machine_is_smm_enabled(PC_MACHINE(current_machine))) {
+        /* if *disabled* show SMRAM to all CPUs */
+        memory_region_init_alias(&mch->smram_region, OBJECT(mch),
+               "smram-region", mch->pci_address_space, 0xa0000, 0x20000);
+        memory_region_add_subregion_overlap(mch->system_memory, 0xa0000,
+                &mch->smram_region, 1);
+        memory_region_set_enabled(&mch->smram_region, true);
 
-    memory_region_init_alias(&mch->tseg_window, OBJECT(mch), "tseg-window",
-                             mch->ram_memory, mch->below_4g_mem_size, 0);
-    memory_region_set_enabled(&mch->tseg_window, false);
-    memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
-                                &mch->tseg_window);
-    object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&mch->smram), &error_abort);
+        memory_region_init_alias(&mch->open_high_smram, OBJECT(mch),
+                "smram-open-high", mch->ram_memory, 0xa0000, 0x20000);
+        memory_region_add_subregion_overlap(mch->system_memory, 0xfeda0000,
+                &mch->open_high_smram, 1);
+        memory_region_set_enabled(&mch->open_high_smram, false);
+
+        /* smram, as seen by SMM CPUs */
+        memory_region_init(&mch->smram, OBJECT(mch), "smram", 1ull << 32);
+        memory_region_set_enabled(&mch->smram, true);
+        memory_region_init_alias(&mch->low_smram, OBJECT(mch), "smram-low",
+                mch->ram_memory, 0xa0000, 0x20000);
+        memory_region_set_enabled(&mch->low_smram, true);
+        memory_region_add_subregion(&mch->smram, 0xa0000, &mch->low_smram);
+        memory_region_init_alias(&mch->high_smram, OBJECT(mch), "smram-high",
+                mch->ram_memory, 0xa0000, 0x20000);
+        memory_region_set_enabled(&mch->high_smram, true);
+        memory_region_add_subregion(&mch->smram, 0xfeda0000, &mch->high_smram);
+
+        memory_region_init_io(&mch->tseg_blackhole, OBJECT(mch),
+                &tseg_blackhole_ops, NULL,
+                "tseg-blackhole", 0);
+        memory_region_set_enabled(&mch->tseg_blackhole, false);
+        memory_region_add_subregion_overlap(mch->system_memory,
+                mch->below_4g_mem_size,
+                &mch->tseg_blackhole, 1);
+
+        memory_region_init_alias(&mch->tseg_window, OBJECT(mch), "tseg-window",
+                mch->ram_memory, mch->below_4g_mem_size, 0);
+        memory_region_set_enabled(&mch->tseg_window, false);
+        memory_region_add_subregion(&mch->smram, mch->below_4g_mem_size,
+                &mch->tseg_window);
+        object_property_add_const_link(qdev_get_machine(), "smram",
+                OBJECT(&mch->smram), &error_abort);
+    }
 
     init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
              mch->pci_address_space, &mch->pam_regions[0],
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..1250fff 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1583,6 +1583,7 @@ static int kvm_init(MachineState *ms)
     const char *kvm_type;
 
     s = KVM_STATE(ms->accelerator);
+    kvm_state = s;
 
     /*
      * On systems where the kernel can support different base page
@@ -1755,8 +1756,6 @@ static int kvm_init(MachineState *ms)
         kvm_irqchip_create(ms, s);
     }
 
-    kvm_state = s;
-
     if (kvm_eventfds_allowed) {
         s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
         s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865db..65716b6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1254,7 +1254,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (kvm_check_extension(s, KVM_CAP_X86_SMM)) {
+    if (pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
-- 
1.8.3.1

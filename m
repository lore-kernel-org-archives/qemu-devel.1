Received: from eggs.gnu.org ([2001:4830:134:3::10]:37230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchU-0001df-55
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1eGchT-0006R3-5U
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:24:48 -0500
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sun, 19 Nov 2017 21:24:09 -0600
Message-Id: <20171120032420.9134-2-mdavidsaver@gmail.com>
In-Reply-To: <20171120032420.9134-1-mdavidsaver@gmail.com>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 01/12] e500: add board config options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

allow board code to skip common NIC and guest image setup
and configure decrementor frequency.
Existing boards unchanged.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/ppc/e500.c      | 8 ++++++--
 hw/ppc/e500.h      | 3 +++
 hw/ppc/e500plat.c  | 1 +
 hw/ppc/mpc8544ds.c | 1 +
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 5cf0dabef3..9e7e1b29c4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -826,7 +826,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         env->mpic_iack = params->ccsrbar_base +
                          MPC8544_MPIC_REGS_OFFSET + 0xa0;
 
-        ppc_booke_timers_init(cpu, 400000000, PPC_TIMER_E500);
+        ppc_booke_timers_init(cpu, params->decrementor_freq, PPC_TIMER_E500);
 
         /* Register reset handler */
         if (!i) {
@@ -899,7 +899,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     if (!pci_bus)
         printf("couldn't create PCI controller!\n");
 
-    if (pci_bus) {
+    if (pci_bus && !params->tsec_nic) {
         /* Register network interfaces. */
         for (i = 0; i < nb_nics; i++) {
             pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio", NULL);
@@ -948,6 +948,10 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                     sysbus_mmio_get_region(s, 0));
     }
 
+    if (params->skip_load) {
+        return;
+    }
+
     /* Load kernel. */
     if (machine->kernel_filename) {
         kernel_base = cur_base;
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 70ba1d8f4f..40f72f2de2 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -22,6 +22,9 @@ typedef struct PPCE500Params {
     hwaddr pci_mmio_base;
     hwaddr pci_mmio_bus_base;
     hwaddr spin_base;
+    uint32_t decrementor_freq; /* in Hz */
+    bool skip_load;
+    bool tsec_nic;
 } PPCE500Params;
 
 void ppce500_init(MachineState *machine, PPCE500Params *params);
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index e59e80fb9e..3d07987bd1 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -47,6 +47,7 @@ static void e500plat_init(MachineState *machine)
         .pci_mmio_base = 0xC00000000ULL,
         .pci_mmio_bus_base = 0xE0000000ULL,
         .spin_base = 0xFEF000000ULL,
+        .decrementor_freq = 400000000,
     };
 
     /* Older KVM versions don't support EPR which breaks guests when we announce
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 1717953ec7..6d9931c475 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -40,6 +40,7 @@ static void mpc8544ds_init(MachineState *machine)
         .pci_mmio_bus_base = 0xC0000000ULL,
         .pci_pio_base = 0xE1000000ULL,
         .spin_base = 0xEF000000ULL,
+        .decrementor_freq = 400000000,
     };
 
     if (machine->ram_size > 0xc0000000) {
-- 
2.11.0

Received: from eggs.gnu.org ([208.118.235.92]:42775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgEU-0007y7-Kl
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehgDQ-0005d1-BX
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 13:38:42 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  2 Feb 2018 19:37:25 +0100
Message-Id: <20180202183731.29990-10-armbru@redhat.com>
In-Reply-To: <20180202183731.29990-1-armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v7 09/15] hw/ppc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, qemu-ppc@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines were then manually tweaked to pass checkpatch and some curly
braces were added to match QEMU style.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-ppc@nongnu.org

Conversions that aren't followed by exit() dropped, because they might
be inappropriate.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/e500.c          | 16 ++++++++--------
 hw/ppc/mac_newworld.c  |  2 +-
 hw/ppc/mac_oldworld.c  |  2 +-
 hw/ppc/ppc405_boards.c | 15 ++++++---------
 hw/ppc/ppc440_bamboo.c | 16 ++++++++--------
 hw/ppc/prep.c          |  4 ++--
 hw/ppc/virtex_ml507.c  |  4 ++--
 7 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index c4fe06ea2a..3fb40b262f 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -811,8 +811,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         cs = CPU(cpu);
 
         if (env->mmu_model != POWERPC_MMU_BOOKE206) {
-            fprintf(stderr, "MMU model %i not supported by this machine.\n",
-                env->mmu_model);
+            error_report("MMU model %i not supported by this machine.",
+                         env->mmu_model);
             exit(1);
         }
 
@@ -959,8 +959,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                           cur_base,
                                           ram_size - cur_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    machine->kernel_filename);
+            error_report("could not load kernel '%s'",
+                         machine->kernel_filename);
             exit(1);
         }
 
@@ -974,8 +974,8 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                           ram_size - initrd_base);
 
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
-                    machine->initrd_filename);
+            error_report("could not load initial ram disk '%s'",
+                         machine->initrd_filename);
             exit(1);
         }
 
@@ -1016,7 +1016,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
         kernel_size = load_uimage(filename, &bios_entry, &loadaddr, NULL,
                                   NULL, NULL);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load firmware '%s'\n", filename);
+            error_report("could not load firmware '%s'", filename);
             exit(1);
         }
     }
@@ -1029,7 +1029,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
                                        initrd_base, initrd_size,
                                        kernel_base, kernel_size);
     if (dt_size < 0) {
-        fprintf(stderr, "couldn't load device tree\n");
+        error_report("couldn't load device tree");
         exit(1);
     }
     assert(dt_size < DTB_MAX_SIZE);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3fa7c429d5..b832417a56 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -270,7 +270,7 @@ static void ppc_core99_init(MachineState *machine)
             }
         }
         if (ppc_boot_device == '\0') {
-            fprintf(stderr, "No valid boot device for Mac99 machine\n");
+            error_report("No valid boot device for Mac99 machine");
             exit(1);
         }
     }
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 010ea36bf2..d1f4546613 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -218,7 +218,7 @@ static void ppc_heathrow_init(MachineState *machine)
 #endif
         }
         if (ppc_boot_device == '\0') {
-            fprintf(stderr, "No valid boot device for G3 Beige machine\n");
+            error_report("No valid boot device for G3 Beige machine");
             exit(1);
         }
     }
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c66a..fae9c76174 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -324,8 +324,7 @@ static void ref405ep_init(MachineState *machine)
         kernel_size = load_image_targphys(kernel_filename, kernel_base,
                                           ram_size - kernel_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         printf("Load kernel size %ld at " TARGET_FMT_lx,
@@ -336,8 +335,8 @@ static void ref405ep_init(MachineState *machine)
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
-                fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         } else {
@@ -607,8 +606,7 @@ static void taihu_405ep_init(MachineState *machine)
         kernel_size = load_image_targphys(kernel_filename, kernel_base,
                                           ram_size - kernel_base);
         if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
         /* load initrd */
@@ -617,9 +615,8 @@ static void taihu_405ep_init(MachineState *machine)
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
-                fprintf(stderr,
-                        "qemu: could not load initial ram disk '%s'\n",
-                        initrd_filename);
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
                 exit(1);
             }
         } else {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 693c215108..7c72f1d4c1 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "net/net.h"
 #include "hw/hw.h"
@@ -186,8 +187,8 @@ static void bamboo_init(MachineState *machine)
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
-        fprintf(stderr, "MMU model %i not supported by this machine.\n",
-            env->mmu_model);
+        error_report("MMU model %i not supported by this machine.",
+                     env->mmu_model);
         exit(1);
     }
 
@@ -220,7 +221,7 @@ static void bamboo_init(MachineState *machine)
                                 NULL);
     pcibus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (!pcibus) {
-        fprintf(stderr, "couldn't create PCI controller!\n");
+        error_report("couldn't create PCI controller!");
         exit(1);
     }
 
@@ -261,8 +262,7 @@ static void bamboo_init(MachineState *machine)
         }
         /* XXX try again as binary */
         if (success < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
+            error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
     }
@@ -273,8 +273,8 @@ static void bamboo_init(MachineState *machine)
                                           ram_size - RAMDISK_ADDR);
 
         if (initrd_size < 0) {
-            fprintf(stderr, "qemu: could not load ram disk '%s' at %x\n",
-                    initrd_filename, RAMDISK_ADDR);
+            error_report("could not load ram disk '%s' at %x",
+                         initrd_filename, RAMDISK_ADDR);
             exit(1);
         }
     }
@@ -283,7 +283,7 @@ static void bamboo_init(MachineState *machine)
     if (kernel_filename) {
         if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
                                     initrd_size, kernel_cmdline) < 0) {
-            fprintf(stderr, "couldn't load device tree\n");
+            error_report("couldn't load device tree");
             exit(1);
         }
     }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index af08ac319a..794698d240 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -574,7 +574,7 @@ static void ppc_prep_init(MachineState *machine)
             }
         }
         if (ppc_boot_device == '\0') {
-            fprintf(stderr, "No valid boot device for Mac99 machine\n");
+            error_report("No valid boot device for Mac99 machine");
             exit(1);
         }
     }
@@ -595,7 +595,7 @@ static void ppc_prep_init(MachineState *machine)
     qdev_init_nofail(dev);
     pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
     if (pci_bus == NULL) {
-        fprintf(stderr, "Couldn't create PCI host controller.\n");
+        error_report("Couldn't create PCI host controller.");
         exit(1);
     }
     sysctrl->contiguous_map_irq = qdev_get_gpio_in(dev, 0);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 5ac4f76613..87d3c8db53 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -215,8 +215,8 @@ static void virtex_init(MachineState *machine)
     env = &cpu->env;
 
     if (env->mmu_model != POWERPC_MMU_BOOKE) {
-        fprintf(stderr, "MMU model %i not supported by this machine.\n",
-            env->mmu_model);
+        error_report("MMU model %i not supported by this machine.",
+                     env->mmu_model);
         exit(1);
     }
 
-- 
2.13.6

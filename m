Received: from eggs.gnu.org ([2001:4830:134:3::10]:52506)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drVK2-0007Fm-6U
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drVK1-0002IK-AE
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:28:46 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Mon, 11 Sep 2017 22:16:10 +0200
Message-Id: <20170911201610.15204-1-n54@gmx.com>
In-Reply-To: <20170911200002.4511-1-n54@gmx.com>
References: <20170911200002.4511-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH v2] Replace round_page() with
 TARGET_PAGE_ALIGN()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Kamil Rytarowski <n54@gmx.com>

This change fixes conflict with the DragonFly BSD headers.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 hw/ppc/mac_newworld.c | 11 +++--------
 hw/ppc/mac_oldworld.c | 11 +++--------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index d466634997..51bf83019b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -124,11 +124,6 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
     return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
 }
 
-static hwaddr round_page(hwaddr addr)
-{
-    return (addr + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK;
-}
-
 static void ppc_core99_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -256,7 +251,7 @@ static void ppc_core99_init(MachineState *machine)
         }
         /* load initrd */
         if (initrd_filename) {
-            initrd_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
+            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
@@ -264,11 +259,11 @@ static void ppc_core99_init(MachineState *machine)
                              initrd_filename);
                 exit(1);
             }
-            cmdline_base = round_page(initrd_base + initrd_size);
+            cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             initrd_base = 0;
             initrd_size = 0;
-            cmdline_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
+            cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
         }
         ppc_boot_device = 'm';
     } else {
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index fcac399562..feb31911ca 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -66,11 +66,6 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
     return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
 }
 
-static hwaddr round_page(hwaddr addr)
-{
-    return (addr + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK;
-}
-
 static void ppc_heathrow_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -191,7 +186,7 @@ static void ppc_heathrow_init(MachineState *machine)
         }
         /* load initrd */
         if (initrd_filename) {
-            initrd_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
+            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
             initrd_size = load_image_targphys(initrd_filename, initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
@@ -199,11 +194,11 @@ static void ppc_heathrow_init(MachineState *machine)
                              initrd_filename);
                 exit(1);
             }
-            cmdline_base = round_page(initrd_base + initrd_size);
+            cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
         } else {
             initrd_base = 0;
             initrd_size = 0;
-            cmdline_base = round_page(kernel_base + kernel_size + KERNEL_GAP);
+            cmdline_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
         }
         ppc_boot_device = 'm';
     } else {
-- 
2.14.1

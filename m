Received: from eggs.gnu.org ([2001:4830:134:3::10]:38099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96P-0004Uo-Eg
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96N-0002gT-Lv
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:21 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:44651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96N-0002eC-Bl
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:19 -0400
Received: by mail-wr0-x241.google.com with SMTP id p12-v6so10631196wrn.11
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:19 -0700 (PDT)
Received: from donizetti.lan ([82.84.124.111])
	by smtp.gmail.com with ESMTPSA id
	24-v6sm563454wrz.94.2018.06.29.23.11.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 29 Jun 2018 23:11:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:27 +0200
Message-Id: <20180630061040.6018-35-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/47] hw/i386: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '[<>][<>]=? ?[1-5]0' hw/ include/hw/

and modified manually.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/acpi-build.c |  4 ++--
 hw/i386/pc.c         | 23 ++++++++++++-----------
 hw/i386/pc_piix.c    |  3 ++-
 hw/i386/pc_q35.c     |  3 ++-
 hw/i386/pc_sysfw.c   | 10 ++++------
 5 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9bc6d97..796de91 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2248,8 +2248,8 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
                  (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
 }
 
-#define HOLE_640K_START  (640 * 1024)
-#define HOLE_640K_END   (1024 * 1024)
+#define HOLE_640K_START  (640 * KiB)
+#define HOLE_640K_END   (1 * MiB)
 
 static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
                                            uint64_t len, int default_node)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f310040..50d5553 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
@@ -448,12 +449,12 @@ void pc_cmos_init(PCMachineState *pcms,
 
     /* memory size */
     /* base memory (first MiB) */
-    val = MIN(pcms->below_4g_mem_size / 1024, 640);
+    val = MIN(pcms->below_4g_mem_size / KiB, 640);
     rtc_set_memory(s, 0x15, val);
     rtc_set_memory(s, 0x16, val >> 8);
     /* extended memory (next 64MiB) */
-    if (pcms->below_4g_mem_size > 1024 * 1024) {
-        val = (pcms->below_4g_mem_size - 1024 * 1024) / 1024;
+    if (pcms->below_4g_mem_size > 1 * MiB) {
+        val = (pcms->below_4g_mem_size - 1 * MiB) / KiB;
     } else {
         val = 0;
     }
@@ -464,8 +465,8 @@ void pc_cmos_init(PCMachineState *pcms,
     rtc_set_memory(s, 0x30, val);
     rtc_set_memory(s, 0x31, val >> 8);
     /* memory between 16MiB and 4GiB */
-    if (pcms->below_4g_mem_size > 16 * 1024 * 1024) {
-        val = (pcms->below_4g_mem_size - 16 * 1024 * 1024) / 65536;
+    if (pcms->below_4g_mem_size > 16 * MiB) {
+        val = (pcms->below_4g_mem_size - 16 * MiB) / (64 * KiB);
     } else {
         val = 0;
     }
@@ -1392,11 +1393,11 @@ void pc_memory_init(PCMachineState *pcms,
         }
 
         machine->device_memory->base =
-            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
+            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1 * GiB);
 
         if (pcmc->enforce_aligned_dimm) {
             /* size device region assuming 1G page max alignment per slot */
-            device_mem_size += (1ULL << 30) * machine->ram_slots;
+            device_mem_size += (1 * GiB) * machine->ram_slots;
         }
 
         if ((machine->device_memory->base + device_mem_size) <
@@ -1438,7 +1439,7 @@ void pc_memory_init(PCMachineState *pcms,
         if (!pcmc->broken_reserved_end) {
             res_mem_end += memory_region_size(&machine->device_memory->mr);
         }
-        *val = cpu_to_le64(ROUND_UP(res_mem_end, 0x1ULL << 30));
+        *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
         fw_cfg_add_file(fw_cfg, "etc/reserved-memory-end", val, sizeof(*val));
     }
 
@@ -1475,7 +1476,7 @@ uint64_t pc_pci_hole64_start(void)
         hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
     }
 
-    return ROUND_UP(hole64_start, 1ULL << 30);
+    return ROUND_UP(hole64_start, 1 * GiB);
 }
 
 qemu_irq pc_allocate_cpu_irq(void)
@@ -2095,7 +2096,7 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
         error_propagate(errp, error);
         return;
     }
-    if (value > (1ULL << 32)) {
+    if (value > 4 * GiB) {
         error_setg(&error,
                    "Machine option 'max-ram-below-4g=%"PRIu64
                    "' expects size less than or equal to 4G", value);
@@ -2103,7 +2104,7 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
         return;
     }
 
-    if (value < (1ULL << 20)) {
+    if (value < 1 * MiB) {
         warn_report("Only %" PRIu64 " bytes of RAM below the 4GiB boundary,"
                     "BIOS may not work with less than 1MiB", value);
     }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d357907..dc09466 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "hw/i386/pc.h"
@@ -131,7 +132,7 @@ static void pc_init1(MachineState *machine,
                 if (lowmem > 0xc0000000) {
                     lowmem = 0xc0000000;
                 }
-                if (lowmem & ((1ULL << 30) - 1)) {
+                if (lowmem & (1 * GiB - 1)) {
                     warn_report("Large machine and max_ram_below_4g "
                                 "(%" PRIu64 ") not a multiple of 1G; "
                                 "possible bad performance.",
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1a73e18..532241e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "sysemu/arch_init.h"
@@ -105,7 +106,7 @@ static void pc_q35_init(MachineState *machine)
     if (lowmem > pcms->max_ram_below_4g) {
         lowmem = pcms->max_ram_below_4g;
         if (machine->ram_size - lowmem > lowmem &&
-            lowmem & ((1ULL << 30) - 1)) {
+            lowmem & (1 * GiB - 1)) {
             warn_report("There is possibly poor performance as the ram size "
                         " (0x%" PRIx64 ") is more then twice the size of"
                         " max-ram-below-4g (%"PRIu64") and"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 73ac783..091e22d 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -28,6 +28,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qemu/units.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
@@ -56,7 +57,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
     flash_size = memory_region_size(flash_mem);
 
     /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(flash_size, 128 * 1024);
+    isa_bios_size = MIN(flash_size, 128 * KiB);
     isa_bios = g_malloc(sizeof(*isa_bios));
     memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
@@ -83,7 +84,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
  * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
  * size.
  */
-#define FLASH_MAP_BASE_MIN ((hwaddr)(0x100000000ULL - 8*1024*1024))
+#define FLASH_MAP_BASE_MIN ((hwaddr)(4 * GiB - 8 * MiB))
 
 /* This function maps flash drives from 4G downward, in order of their unit
  * numbers. The mapping starts at unit#0, with unit number increments of 1, and
@@ -221,10 +222,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
     g_free(filename);
 
     /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = bios_size;
-    if (isa_bios_size > (128 * 1024)) {
-        isa_bios_size = 128 * 1024;
-    }
+    isa_bios_size = MIN(bios_size, 128 * KiB);
     isa_bios = g_malloc(sizeof(*isa_bios));
     memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
-- 
1.8.3.1

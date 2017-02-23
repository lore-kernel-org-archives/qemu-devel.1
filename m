Received: from eggs.gnu.org ([2001:4830:134:3::10]:50045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cgyVt-0003fN-8a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cgyVo-0005Zn-Ch
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:53:13 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cgyVo-0005WC-45
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:53:08 -0500
Received: by mail-pf0-x243.google.com with SMTP id 68so1954369pfx.2
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:53:06 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 23 Feb 2017 10:52:48 -0800
Message-Id: <1487875968-23454-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: sim: instantiate local memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Xtensa core may have a number of RAM and ROM areas configured. Record
their size and location from the core configuration overlay and
instantiate them as RAM regions in the SIM machine.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/sim.c              |  40 ++++++++---
 target/xtensa/cpu.h          |  16 +++++
 target/xtensa/overlay_tool.h | 160 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 9 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 5e94004..d2d1d3a 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -37,6 +37,27 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
+static void xtensa_create_memory_regions(const XtensaMemory *memory,
+                                         const char *name)
+{
+    unsigned i;
+    char *num_name = malloc(strlen(name) + sizeof(i) * 3 + 1);
+
+    for (i = 0; i < memory->num; ++i) {
+        MemoryRegion *m;
+
+        sprintf(num_name, "%s%u", name, i);
+        m = g_malloc(sizeof(*m));
+        memory_region_init_ram(m, NULL, num_name,
+                               memory->location[i].size,
+                               &error_fatal);
+        vmstate_register_ram_global(m);
+        memory_region_add_subregion(get_system_memory(),
+                                    memory->location[i].addr, m);
+    }
+    free(num_name);
+}
+
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
@@ -55,7 +76,6 @@ static void xtensa_sim_init(MachineState *machine)
 {
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
-    MemoryRegion *ram, *rom;
     ram_addr_t ram_size = machine->ram_size;
     const char *cpu_model = machine->cpu_model;
     const char *kernel_filename = machine->kernel_filename;
@@ -82,15 +102,17 @@ static void xtensa_sim_init(MachineState *machine)
         sim_reset(cpu);
     }
 
-    ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "xtensa.sram", ram_size, &error_fatal);
-    vmstate_register_ram_global(ram);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    if (env) {
+        XtensaMemory sysram = env->config->sysram;
 
-    rom = g_malloc(sizeof(*rom));
-    memory_region_init_ram(rom, NULL, "xtensa.rom", 0x1000, &error_fatal);
-    vmstate_register_ram_global(rom);
-    memory_region_add_subregion(get_system_memory(), 0xfe000000, rom);
+        sysram.location[0].size = ram_size;
+        xtensa_create_memory_regions(&env->config->instrom, "xtensa.instrom");
+        xtensa_create_memory_regions(&env->config->instram, "xtensa.instram");
+        xtensa_create_memory_regions(&env->config->datarom, "xtensa.datarom");
+        xtensa_create_memory_regions(&env->config->dataram, "xtensa.dataram");
+        xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom");
+        xtensa_create_memory_regions(&sysram, "xtensa.sysram");
+    }
 
     if (kernel_filename) {
         uint64_t elf_entry;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 7e7131a..ecca17d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -212,6 +212,7 @@ enum {
 #define MAX_NCCOMPARE 3
 #define MAX_TLB_WAY_SIZE 8
 #define MAX_NDBREAK 2
+#define MAX_NMEMORY 4
 
 #define REGION_PAGE_MASK 0xe0000000
 
@@ -321,6 +322,14 @@ typedef struct XtensaCcompareTimer {
     QEMUTimer *timer;
 } XtensaCcompareTimer;
 
+typedef struct XtensaMemory {
+    unsigned num;
+    struct XtensaMemoryRegion {
+        uint32_t addr;
+        uint32_t size;
+    } location[MAX_NMEMORY];
+} XtensaMemory;
+
 struct XtensaConfig {
     const char *name;
     uint64_t options;
@@ -352,6 +361,13 @@ struct XtensaConfig {
     unsigned dcache_ways;
     uint32_t memctl_mask;
 
+    XtensaMemory instrom;
+    XtensaMemory instram;
+    XtensaMemory datarom;
+    XtensaMemory dataram;
+    XtensaMemory sysrom;
+    XtensaMemory sysram;
+
     uint32_t configid[2];
 
     uint32_t clock_freq_khz;
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 38e9be9..12bde44 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -318,6 +318,16 @@
     .itlb = ITLB(XCHAL_HAVE_SPANNING_WAY), \
     .dtlb = DTLB(XCHAL_HAVE_SPANNING_WAY)
 
+#ifndef XCHAL_SYSROM0_PADDR
+#define XCHAL_SYSROM0_PADDR 0xfe000000
+#define XCHAL_SYSROM0_SIZE  0x02000000
+#endif
+
+#ifndef XCHAL_SYSRAM0_PADDR
+#define XCHAL_SYSRAM0_PADDR 0x00000000
+#define XCHAL_SYSRAM0_SIZE  0x08000000
+#endif
+
 #elif XCHAL_HAVE_XLT_CACHEATTR || XCHAL_HAVE_MIMIC_CACHEATTR
 
 #define TLB_TEMPLATE { \
@@ -331,6 +341,28 @@
     .itlb = TLB_TEMPLATE, \
     .dtlb = TLB_TEMPLATE
 
+#ifndef XCHAL_SYSROM0_PADDR
+#define XCHAL_SYSROM0_PADDR 0x60000000
+#define XCHAL_SYSROM0_SIZE  0x04000000
+#endif
+
+#ifndef XCHAL_SYSRAM0_PADDR
+#define XCHAL_SYSRAM0_PADDR 0x50000000
+#define XCHAL_SYSRAM0_SIZE  0x04000000
+#endif
+
+#else
+
+#ifndef XCHAL_SYSROM0_PADDR
+#define XCHAL_SYSROM0_PADDR 0x60000000
+#define XCHAL_SYSROM0_SIZE  0x04000000
+#endif
+
+#ifndef XCHAL_SYSRAM0_PADDR
+#define XCHAL_SYSRAM0_PADDR 0x50000000
+#define XCHAL_SYSRAM0_SIZE  0x04000000
+#endif
+
 #endif
 
 #if (defined(TARGET_WORDS_BIGENDIAN) != 0) == (XCHAL_HAVE_BE != 0)
@@ -362,6 +394,53 @@
         MEMCTL_ISNP | MEMCTL_DSNP | \
         (XCHAL_HAVE_LOOPS && XCHAL_LOOP_BUFFER_SIZE ? MEMCTL_IL0EN : 0)
 
+#define MEM_LOCATION(name, n) \
+    { \
+        .addr = XCHAL_ ## name ## n ## _PADDR, \
+        .size = XCHAL_ ## name ## n ## _SIZE, \
+    }
+
+#define MEM_SECTIONS(name) \
+    MEM_LOCATION(name, 0), \
+    MEM_LOCATION(name, 1), \
+    MEM_LOCATION(name, 2), \
+    MEM_LOCATION(name, 3)
+
+#define MEM_SECTION(name) \
+    .num = XCHAL_NUM_ ## name, \
+    .location = { \
+        MEM_SECTIONS(name) \
+    }
+
+#define SYSMEM_SECTION(name) \
+    .num = 1, \
+    .location = { \
+        { \
+            .addr = XCHAL_ ## name ## 0_PADDR, \
+            .size = XCHAL_ ## name ## 0_SIZE, \
+        } \
+    }
+
+#define LOCAL_MEMORIES_SECTION \
+    .instrom = { \
+        MEM_SECTION(INSTROM) \
+    }, \
+    .instram = { \
+        MEM_SECTION(INSTRAM) \
+    }, \
+    .datarom = { \
+        MEM_SECTION(DATAROM) \
+    }, \
+    .dataram = { \
+        MEM_SECTION(DATARAM) \
+    }, \
+    .sysrom = { \
+        SYSMEM_SECTION(SYSROM) \
+    }, \
+    .sysram = { \
+        SYSMEM_SECTION(SYSRAM) \
+    }
+
 #define CONFIG_SECTION \
     .configid = { \
         XCHAL_HW_CONFIGID0, \
@@ -377,6 +456,7 @@
     TLB_SECTION, \
     DEBUG_SECTION, \
     CACHE_SECTION, \
+    LOCAL_MEMORIES_SECTION, \
     CONFIG_SECTION
 
 
@@ -629,3 +709,83 @@
 
 
 #define XTHAL_TIMER_UNCONFIGURED 0
+
+#if XCHAL_NUM_INSTROM < 1
+#define XCHAL_INSTROM0_PADDR 0
+#define XCHAL_INSTROM0_SIZE 0
+#endif
+#if XCHAL_NUM_INSTROM < 2
+#define XCHAL_INSTROM1_PADDR 0
+#define XCHAL_INSTROM1_SIZE 0
+#endif
+#if XCHAL_NUM_INSTROM < 3
+#define XCHAL_INSTROM2_PADDR 0
+#define XCHAL_INSTROM2_SIZE 0
+#endif
+#if XCHAL_NUM_INSTROM < 4
+#define XCHAL_INSTROM3_PADDR 0
+#define XCHAL_INSTROM3_SIZE 0
+#endif
+#if XCHAL_NUM_INSTROM > MAX_NMEMORY
+#error XCHAL_NUM_INSTROM > MAX_NMEMORY
+#endif
+
+#if XCHAL_NUM_INSTRAM < 1
+#define XCHAL_INSTRAM0_PADDR 0
+#define XCHAL_INSTRAM0_SIZE 0
+#endif
+#if XCHAL_NUM_INSTRAM < 2
+#define XCHAL_INSTRAM1_PADDR 0
+#define XCHAL_INSTRAM1_SIZE 0
+#endif
+#if XCHAL_NUM_INSTRAM < 3
+#define XCHAL_INSTRAM2_PADDR 0
+#define XCHAL_INSTRAM2_SIZE 0
+#endif
+#if XCHAL_NUM_INSTRAM < 4
+#define XCHAL_INSTRAM3_PADDR 0
+#define XCHAL_INSTRAM3_SIZE 0
+#endif
+#if XCHAL_NUM_INSTRAM > MAX_NMEMORY
+#error XCHAL_NUM_INSTRAM > MAX_NMEMORY
+#endif
+
+#if XCHAL_NUM_DATAROM < 1
+#define XCHAL_DATAROM0_PADDR 0
+#define XCHAL_DATAROM0_SIZE 0
+#endif
+#if XCHAL_NUM_DATAROM < 2
+#define XCHAL_DATAROM1_PADDR 0
+#define XCHAL_DATAROM1_SIZE 0
+#endif
+#if XCHAL_NUM_DATAROM < 3
+#define XCHAL_DATAROM2_PADDR 0
+#define XCHAL_DATAROM2_SIZE 0
+#endif
+#if XCHAL_NUM_DATAROM < 4
+#define XCHAL_DATAROM3_PADDR 0
+#define XCHAL_DATAROM3_SIZE 0
+#endif
+#if XCHAL_NUM_DATAROM > MAX_NMEMORY
+#error XCHAL_NUM_DATAROM > MAX_NMEMORY
+#endif
+
+#if XCHAL_NUM_DATARAM < 1
+#define XCHAL_DATARAM0_PADDR 0
+#define XCHAL_DATARAM0_SIZE 0
+#endif
+#if XCHAL_NUM_DATARAM < 2
+#define XCHAL_DATARAM1_PADDR 0
+#define XCHAL_DATARAM1_SIZE 0
+#endif
+#if XCHAL_NUM_DATARAM < 3
+#define XCHAL_DATARAM2_PADDR 0
+#define XCHAL_DATARAM2_SIZE 0
+#endif
+#if XCHAL_NUM_DATARAM < 4
+#define XCHAL_DATARAM3_PADDR 0
+#define XCHAL_DATARAM3_SIZE 0
+#endif
+#if XCHAL_NUM_DATARAM > MAX_NMEMORY
+#error XCHAL_NUM_DATARAM > MAX_NMEMORY
+#endif
-- 
2.1.4

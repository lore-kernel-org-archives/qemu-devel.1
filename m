Received: from eggs.gnu.org ([2001:4830:134:3::10]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fs4pL-0004jJ-Iw
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fs4pG-00021w-I7
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:27:59 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 21 Aug 2018 13:27:48 +0200
Message-Id: <1534850868-30172-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] ppc: Remove deprecated ppcemb target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, libvir-list@redhat.com, qemu-ppc@nongnu.org

There is no known available OS for ppc around anymore that uses page
sizes below 4k, so it does not make much sense that we keep wasting
our time on building and testing the ppcemb-softmmu target. It has
been deprecated since two releases, and nobody complained, so let's
remove this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                          | 13 +++----------
 cpus.c                             |  1 -
 default-configs/ppcemb-softmmu.mak | 23 -----------------------
 hw/ppc/ppc405_boards.c             | 14 --------------
 hw/ppc/ppc440_bamboo.c             |  7 -------
 hw/ppc/sam460ex.c                  |  7 -------
 hw/ppc/virtex_ml507.c              |  7 -------
 include/exec/poison.h              |  1 -
 qapi/common.json                   |  2 +-
 qemu-deprecated.texi               |  6 ------
 target/ppc/cpu-qom.h               |  2 --
 target/ppc/cpu.h                   | 16 ----------------
 target/ppc/kvm.c                   |  4 +---
 target/ppc/mmu_helper.c            |  6 +++---
 target/ppc/translate_init.inc.c    | 35 +----------------------------------
 tests/machine-none-test.c          |  1 -
 16 files changed, 9 insertions(+), 136 deletions(-)
 delete mode 100644 default-configs/ppcemb-softmmu.mak

diff --git a/configure b/configure
index e7bddc0..0fc55eb 100755
--- a/configure
+++ b/configure
@@ -195,8 +195,7 @@ supported_kvm_target() {
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
         mips:mips | mipsel:mips | \
-        ppc:ppc | ppcemb:ppc | ppc64:ppc | \
-        ppc:ppc64 | ppcemb:ppc64 | ppc64:ppc64 | \
+        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | \
         s390x:s390x)
             return 0
         ;;
@@ -6935,7 +6934,7 @@ if test "$linux" = "yes" ; then
   i386|x86_64|x32)
     linux_arch=x86
     ;;
-  ppcemb|ppc|ppc64)
+  ppc|ppc64)
     linux_arch=powerpc
     ;;
   s390x)
@@ -6965,7 +6964,7 @@ target_name=$(echo $target | cut -d '-' -f 1)
 target_bigendian="no"
 
 case "$target_name" in
-  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppcemb|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
+  armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
   target_bigendian=yes
   ;;
 esac
@@ -7093,12 +7092,6 @@ case "$target_name" in
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
     target_compiler=$cross_cc_powerpc
   ;;
-  ppcemb)
-    TARGET_BASE_ARCH=ppc
-    TARGET_ABI_DIR=ppc
-    gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
-    target_compiler=$cross_cc_ppcemb
-  ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
diff --git a/cpus.c b/cpus.c
index b5844b7..80ca683 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2203,7 +2203,6 @@ static CpuInfoArch sysemu_target_to_cpuinfo_arch(SysEmuTarget target)
         return CPU_INFO_ARCH_X86;
 
     case SYS_EMU_TARGET_PPC:
-    case SYS_EMU_TARGET_PPCEMB:
     case SYS_EMU_TARGET_PPC64:
         return CPU_INFO_ARCH_PPC;
 
diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/ppcemb-softmmu.mak
deleted file mode 100644
index ac44f15..0000000
--- a/default-configs/ppcemb-softmmu.mak
+++ /dev/null
@@ -1,23 +0,0 @@
-# Default configuration for ppcemb-softmmu
-
-include pci.mak
-include sound.mak
-include usb.mak
-CONFIG_PPC4XX=y
-CONFIG_M48T59=y
-CONFIG_SERIAL=y
-CONFIG_SERIAL_ISA=y
-CONFIG_I8257=y
-CONFIG_OPENPIC=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_PTIMER=y
-CONFIG_I8259=y
-CONFIG_XILINX=y
-CONFIG_XILINX_ETHLITE=y
-CONFIG_USB_EHCI_SYSBUS=y
-CONFIG_SM501=y
-CONFIG_DDC=y
-CONFIG_IDE_SII3112=y
-CONFIG_I2C=y
-CONFIG_BITBANG_I2C=y
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 7011107..3a54d52 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -202,13 +202,6 @@ static void ref405ep_init(MachineState *machine)
     DriveInfo *dinfo;
     MemoryRegion *sysmem = get_system_memory();
 
-#ifdef TARGET_PPCEMB
-    if (!qtest_enabled()) {
-        warn_report("qemu-system-ppcemb is deprecated, "
-                    "please use qemu-system-ppc instead.");
-    }
-#endif
-
     /* XXX: fix this */
     memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405ep.ram",
                                          0x08000000);
@@ -503,13 +496,6 @@ static void taihu_405ep_init(MachineState *machine)
     int fl_idx, fl_sectors;
     DriveInfo *dinfo;
 
-#ifdef TARGET_PPCEMB
-    if (!qtest_enabled()) {
-        warn_report("qemu-system-ppcemb is deprecated, "
-                    "please use qemu-system-ppc instead.");
-    }
-#endif
-
     /* RAM is soldered to the board so the size cannot be changed */
     ram_size = 0x08000000;
     memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 3d4c43b..f5720f9 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -195,13 +195,6 @@ static void bamboo_init(MachineState *machine)
         exit(1);
     }
 
-#ifdef TARGET_PPCEMB
-    if (!qtest_enabled()) {
-        warn_report("qemu-system-ppcemb is deprecated, "
-                    "please use qemu-system-ppc instead.");
-    }
-#endif
-
     qemu_register_reset(main_cpu_reset, cpu);
     ppc_booke_timers_init(cpu, 400000000, 0);
     ppc_dcr_init(env, NULL, NULL);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 9c77183..250fb86 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -419,13 +419,6 @@ static void sam460ex_init(MachineState *machine)
         exit(1);
     }
 
-#ifdef TARGET_PPCEMB
-    if (!qtest_enabled()) {
-        warn_report("qemu-system-ppcemb is deprecated, "
-                    "please use qemu-system-ppc instead.");
-    }
-#endif
-
     qemu_register_reset(main_cpu_reset, cpu);
     boot_info = g_malloc0(sizeof(*boot_info));
     env->load_info = boot_info;
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 7891464..ee9b4b4 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -211,13 +211,6 @@ static void virtex_init(MachineState *machine)
     int kernel_size;
     int i;
 
-#ifdef TARGET_PPCEMB
-    if (!qtest_enabled()) {
-        warn_report("qemu-system-ppcemb is deprecated, "
-                    "please use qemu-system-ppc instead.");
-    }
-#endif
-
     /* init CPUs */
     cpu = ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 400000000);
     env = &cpu->env;
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 41cd2eb..97d3b56 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -24,7 +24,6 @@
 #pragma GCC poison TARGET_NIOS2
 #pragma GCC poison TARGET_OPENRISC
 #pragma GCC poison TARGET_PPC
-#pragma GCC poison TARGET_PPCEMB
 #pragma GCC poison TARGET_PPC64
 #pragma GCC poison TARGET_ABI32
 #pragma GCC poison TARGET_S390X
diff --git a/qapi/common.json b/qapi/common.json
index c367adc..50ac121 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -146,6 +146,6 @@
   'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
              'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
              'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
-             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
+             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 67b7211..8cd2a3d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -182,12 +182,6 @@ replaced by the ``target'' output member.
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
-@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12.0)
-
-qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc64)
-should be used instead. That means that embedded 4xx PowerPC CPUs will not
-support page sizes < 4096 any longer.
-
 @section System emulator machines
 
 @subsection pc-0.10 and pc-0.11 (since 3.0)
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 433a71e..4ea6769 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -24,8 +24,6 @@
 
 #ifdef TARGET_PPC64
 #define TYPE_POWERPC_CPU "powerpc64-cpu"
-#elif defined(TARGET_PPCEMB)
-#define TYPE_POWERPC_CPU "embedded-powerpc-cpu"
 #else
 #define TYPE_POWERPC_CPU "powerpc-cpu"
 #endif
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4edcf62..758227d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -52,23 +52,7 @@
 #else /* defined (TARGET_PPC64) */
 /* PowerPC 32 definitions */
 #define TARGET_LONG_BITS 32
-
-#if defined(TARGET_PPCEMB)
-/* Specific definitions for PowerPC embedded */
-/* BookE have 36 bits physical address space */
-#if defined(CONFIG_USER_ONLY)
-/* It looks like a lot of Linux programs assume page size
- * is 4kB long. This is evil, but we have to deal with it...
- */
-#define TARGET_PAGE_BITS 12
-#else /* defined(CONFIG_USER_ONLY) */
-/* Pages can be 1 kB small */
-#define TARGET_PAGE_BITS 10
-#endif /* defined(CONFIG_USER_ONLY) */
-#else /* defined(TARGET_PPCEMB) */
-/* "standard" PowerPC 32 definitions */
 #define TARGET_PAGE_BITS 12
-#endif /* defined(TARGET_PPCEMB) */
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9211ee2..ef63842 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1315,9 +1315,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
     return 0;
 }
 
-#if defined(TARGET_PPCEMB)
-#define PPC_INPUT_INT PPC40x_INPUT_INT
-#elif defined(TARGET_PPC64)
+#if defined(TARGET_PPC64)
 #define PPC_INPUT_INT PPC970_INPUT_INT
 #else
 #define PPC_INPUT_INT PPC6xx_INPUT_INT
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index e6739e6..a1d848f 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2363,12 +2363,12 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
     tlb->size = booke_tlb_to_page_size((val >> PPC4XX_TLBHI_SIZE_SHIFT)
                                        & PPC4XX_TLBHI_SIZE_MASK);
     /* We cannot handle TLB size < TARGET_PAGE_SIZE.
-     * If this ever occurs, one should use the ppcemb target instead
-     * of the ppc or ppc64 one
+     * If this ever occurs, we should implement TARGET_PAGE_BITS_VARY
      */
     if ((val & PPC4XX_TLBHI_V) && tlb->size < TARGET_PAGE_SIZE) {
         cpu_abort(cs, "TLB size " TARGET_FMT_lu " < %u "
-                  "are not supported (%d)\n",
+                  "are not supported (%d)\n"
+                  "Please implement TARGET_PAGE_BITS_VARY\n",
                   tlb->size, TARGET_PAGE_SIZE, (int)((val >> 7) & 0x7));
     }
     tlb->EPN = val & ~(tlb->size - 1);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 7813b1b..c16d986 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9630,17 +9630,6 @@ static int ppc_fixup_cpu(PowerPCCPU *cpu)
     return 0;
 }
 
-static inline bool ppc_cpu_is_valid(PowerPCCPUClass *pcc)
-{
-#ifdef TARGET_PPCEMB
-    return pcc->mmu_model == POWERPC_MMU_BOOKE ||
-           pcc->mmu_model == POWERPC_MMU_SOFT_4xx ||
-           pcc->mmu_model == POWERPC_MMU_SOFT_4xx_Z;
-#else
-    return true;
-#endif
-}
-
 static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -9664,8 +9653,6 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    assert(ppc_cpu_is_valid(pcc));
-
     create_ppc_opcodes(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -9916,10 +9903,6 @@ static gint ppc_cpu_compare_class_pvr(gconstpointer a, gconstpointer b)
         return -1;
     }
 
-    if (!ppc_cpu_is_valid(pcc)) {
-        return -1;
-    }
-
     return pcc->pvr == pvr ? 0 : -1;
 }
 
@@ -9950,10 +9933,6 @@ static gint ppc_cpu_compare_class_pvr_mask(gconstpointer a, gconstpointer b)
         return -1;
     }
 
-    if (!ppc_cpu_is_valid(pcc)) {
-        return -1;
-    }
-
     if (pcc->pvr_match(pcc, pvr)) {
         return 0;
     }
@@ -10019,11 +9998,7 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
     g_free(typename);
     g_free(cpu_model);
 
-    if (oc && ppc_cpu_is_valid(POWERPC_CPU_CLASS(oc))) {
-        return oc;
-    }
-
-    return NULL;
+    return oc;
 }
 
 static void ppc_cpu_parse_featurestr(const char *type, char *features,
@@ -10129,9 +10104,6 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     char *name;
     int i;
 
-    if (!ppc_cpu_is_valid(pcc)) {
-        return;
-    }
     if (unlikely(strcmp(typename, TYPE_HOST_POWERPC_CPU) == 0)) {
         return;
     }
@@ -10189,11 +10161,6 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     const char *typename;
     CpuDefinitionInfoList *entry;
     CpuDefinitionInfo *info;
-    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
-
-    if (!ppc_cpu_is_valid(pcc)) {
-        return;
-    }
 
     typename = object_class_get_name(oc);
     info = g_malloc0(sizeof(*info));
diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 7e72466..2b3b750 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -44,7 +44,6 @@ static struct arch2cpu cpus_map[] = {
     { "or1k", "or1200" },
     { "ppc", "604" },
     { "ppc64", "power8e_v2.1" },
-    { "ppcemb", "440epb" },
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
     { "sh4eb", "sh7751r" },
-- 
1.8.3.1

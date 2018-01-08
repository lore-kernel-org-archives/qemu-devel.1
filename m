Received: from eggs.gnu.org ([2001:4830:134:3::10]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZO-0008Hr-Tl
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZL-0007zD-C2
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:06 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:61296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYgZK-0007uw-TO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:03 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:48 +0100
Message-Id: <20180108231048.23966-7-laurent@vivier.eu>
In-Reply-To: <20180108231048.23966-1-laurent@vivier.eu>
References: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 6/6] target/m68k: add HMP command "info tlb"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Dump MMU state and address mappings.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>

 hmp-commands-info.hx  |   2 +-
 target/m68k/cpu.h     |   1 +
 target/m68k/helper.c  | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/monitor.c |  13 +++
 4 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 54c3e5eac6..ad590a4ffb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -216,7 +216,7 @@ Show PCI information.
 ETEXI
 
 #if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) || \
-    defined(TARGET_PPC) || defined(TARGET_XTENSA)
+    defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
         .name       = "tlb",
         .args_type  = "",
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2f5a716139..e9c6e19af4 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -558,4 +558,5 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState *env, target_ulong *pc,
             | ((env->macsr >> 4) & 0xf);        /* Bits 0-3 */
 }
 
+void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUM68KState *env);
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index ef9ef6f55c..7ea30e9a3e 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -375,6 +375,222 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
 /* MMU: 68040 only */
 
+static void print_address_zone(FILE *f, fprintf_function cpu_fprintf,
+                               uint32_t logical, uint32_t physical,
+                               uint32_t size, int attr)
+{
+    cpu_fprintf(f, "%08x - %08x -> %08x - %08x %c ",
+                logical, logical + size - 1,
+                physical, physical + size - 1,
+                attr & 4 ? 'W' : '-');
+    size >>= 10;
+    if (size < 1024) {
+        cpu_fprintf(f, "(%d KiB)\n", size);
+    } else {
+        size >>= 10;
+        if (size < 1024) {
+            cpu_fprintf(f, "(%d MiB)\n", size);
+        } else {
+            size >>= 10;
+            cpu_fprintf(f, "(%d GiB)\n", size);
+        }
+    }
+}
+
+static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
+                             CPUM68KState *env, uint32_t root_pointer)
+{
+    int i, j, k;
+    int tic_size, tic_shift;
+    uint32_t tib_mask;
+    uint32_t tia, tib, tic;
+    uint32_t logical = 0xffffffff, physical = 0xffffffff;
+    uint32_t first_logical = 0xffffffff, first_physical = 0xffffffff;
+    uint32_t last_logical, last_physical;
+    int32_t size;
+    int last_attr = -1, attr = -1;
+    M68kCPU *cpu = m68k_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
+        /* 8k page */
+        tic_size = 32;
+        tic_shift = 13;
+        tib_mask = 0xffffff80;
+    } else {
+        /* 4k page */
+        tic_size = 64;
+        tic_shift = 12;
+        tib_mask = 0xffffff00;
+    }
+    for (i = 0; i < 128; i++) {
+        tia = ldl_phys(cs->as, M68K_POINTER_BASE(root_pointer) + i * 4);
+        if (!M68K_UDT_VALID(tia)) {
+            continue;
+        }
+        for (j = 0; j < 128; j++) {
+            tib = ldl_phys(cs->as, M68K_POINTER_BASE(tia) + j * 4);
+            if (!M68K_UDT_VALID(tia)) {
+                continue;
+            }
+            for (k = 0; k < tic_size; k++) {
+                tic = ldl_phys(cs->as, (tib & tib_mask) + k * 4);
+                if (!M68K_PDT_VALID(tia)) {
+                    continue;
+                }
+                if (M68K_PDT_INDIRECT(tic)) {
+                    tic = ldl_phys(cs->as, M68K_INDIRECT_POINTER(tic));
+                }
+
+                last_logical = logical;
+                logical = (i << 25) | (j << 18) | (k << tic_shift);
+
+                last_physical = physical;
+                physical = tic & ~((1 << tic_shift) - 1);
+
+                last_attr = attr;
+                attr = tic & ((1 << tic_shift) - 1);
+
+                if ((logical != (last_logical + (1 << tic_shift))) ||
+                    (physical != (last_physical + (1 << tic_shift))) ||
+                    (attr & 4) != (last_attr & 4)) {
+
+                    if (first_logical != 0xffffffff) {
+                        size = last_logical + (1 << tic_shift) -
+                               first_logical;
+                        print_address_zone(f, cpu_fprintf, first_logical,
+                                           first_physical, size, last_attr);
+                    }
+                    first_logical = logical;
+                    first_physical = physical;
+                }
+            }
+        }
+    }
+    if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
+        size = logical + (1 << tic_shift) - first_logical;
+        print_address_zone(f, cpu_fprintf, first_logical, first_physical, size,
+                           last_attr);
+    }
+}
+
+#define DUMP_CACHEFLAGS(a) \
+    switch (a & M68K_DESC_CACHEMODE) { \
+    case M68K_DESC_CM_WRTHRU: /* cachable, write-through */ \
+        cpu_fprintf(f, "T"); \
+        break; \
+    case M68K_DESC_CM_COPYBK: /* cachable, copyback */ \
+        cpu_fprintf(f, "C"); \
+        break; \
+    case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
+        cpu_fprintf(f, "S"); \
+        break; \
+    case M68K_DESC_CM_NCACHE: /* noncachable */ \
+        cpu_fprintf(f, "N"); \
+        break; \
+    }
+
+static void dump_ttr(FILE *f, fprintf_function cpu_fprintf, uint32_t ttr)
+{
+    if ((ttr & M68K_TTR_ENABLED) == 0) {
+        cpu_fprintf(f, "disabled\n");
+        return;
+    }
+    cpu_fprintf(f, "Base: 0x%08x Mask: 0x%08x Control: ",
+                ttr & M68K_TTR_ADDR_BASE,
+                (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
+    switch (ttr & M68K_TTR_SFIELD) {
+    case M68K_TTR_SFIELD_USER:
+        cpu_fprintf(f, "U");
+        break;
+    case M68K_TTR_SFIELD_SUPER:
+        cpu_fprintf(f, "S");
+        break;
+    default:
+        cpu_fprintf(f, "*");
+        break;
+    }
+    DUMP_CACHEFLAGS(ttr);
+    if (ttr & M68K_DESC_WRITEPROT) {
+        cpu_fprintf(f, "R");
+    } else {
+        cpu_fprintf(f, "W");
+    }
+    cpu_fprintf(f, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
+                               M68K_DESC_USERATTR_SHIFT);
+}
+
+void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUM68KState *env)
+{
+    if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
+        cpu_fprintf(f, "Translation disabled\n");
+        return;
+    }
+    cpu_fprintf(f, "Page Size: ");
+    if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
+        cpu_fprintf(f, "8kB\n");
+    } else {
+        cpu_fprintf(f, "4kB\n");
+    }
+
+    cpu_fprintf(f, "MMUSR: ");
+    if (env->mmu.mmusr & M68K_MMU_B_040) {
+        cpu_fprintf(f, "BUS ERROR\n");
+    } else {
+        cpu_fprintf(f, "Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
+        /* flags found on the page descriptor */
+        if (env->mmu.mmusr & M68K_MMU_G_040) {
+            cpu_fprintf(f, "G"); /* Global */
+        } else {
+            cpu_fprintf(f, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_S_040) {
+            cpu_fprintf(f, "S"); /* Supervisor */
+        } else {
+            cpu_fprintf(f, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_M_040) {
+            cpu_fprintf(f, "M"); /* Modified */
+        } else {
+            cpu_fprintf(f, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_WP_040) {
+            cpu_fprintf(f, "W"); /* Write protect */
+        } else {
+            cpu_fprintf(f, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_T_040) {
+            cpu_fprintf(f, "T"); /* Transparent */
+        } else {
+            cpu_fprintf(f, ".");
+        }
+        if (env->mmu.mmusr & M68K_MMU_R_040) {
+            cpu_fprintf(f, "R"); /* Resident */
+        } else {
+            cpu_fprintf(f, ".");
+        }
+        cpu_fprintf(f, " Cache: ");
+        DUMP_CACHEFLAGS(env->mmu.mmusr);
+        cpu_fprintf(f, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
+        cpu_fprintf(f, "\n");
+    }
+
+    cpu_fprintf(f, "ITTR0: ");
+    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_ITTR0]);
+    cpu_fprintf(f, "ITTR1: ");
+    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_ITTR1]);
+    cpu_fprintf(f, "DTTR0: ");
+    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_DTTR0]);
+    cpu_fprintf(f, "DTTR1: ");
+    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_DTTR1]);
+
+    cpu_fprintf(f, "SRP: 0x%08x\n", env->mmu.srp);
+    dump_address_map(f, cpu_fprintf, env, env->mmu.srp);
+
+    cpu_fprintf(f, "URP: 0x%08x\n", env->mmu.urp);
+    dump_address_map(f, cpu_fprintf, env, env->mmu.urp);
+}
+
 static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
                      int access_type)
 {
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 486213cd8b..db582a34ac 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -8,6 +8,19 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/hmp-target.h"
+#include "monitor/monitor.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env1 = mon_get_cpu_env();
+
+    if (!env1) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+
+    dump_mmu((FILE *)mon, (fprintf_function)monitor_printf, env1);
+}
 
 static const MonitorDef monitor_defs[] = {
     { "d0", offsetof(CPUM68KState, dregs[0]) },
-- 
2.14.3

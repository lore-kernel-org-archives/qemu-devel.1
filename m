Received: from eggs.gnu.org ([2001:4830:134:3::10]:58656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZH-0008AR-G9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eYgZF-0007hV-Pm
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:59 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eYgZF-0007ds-Er
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 18:10:57 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  9 Jan 2018 00:10:45 +0100
Message-Id: <20180108231048.23966-4-laurent@vivier.eu>
In-Reply-To: <20180108231048.23966-1-laurent@vivier.eu>
References: <20180108231048.23966-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 3/6] target/m68k: add Transparent Translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Add ittr0, ittr1, dttr0, dttr1 and manage Transparent Translations

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h       | 18 +++++++++++
 target/m68k/helper.c    | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/m68k/monitor.c   |  4 +++
 target/m68k/translate.c |  3 ++
 4 files changed, 104 insertions(+)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index c3c4493bd0..60e669c3b4 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -76,6 +76,14 @@
 #define EXCP_RTE            0x100
 #define EXCP_HALT_INSN      0x101
 
+#define M68K_DTTR0   0
+#define M68K_DTTR1   1
+#define M68K_ITTR0   2
+#define M68K_ITTR1   3
+
+#define M68K_MAX_TTR 2
+#define TTR(type, index) ttr[((type & ACCESS_CODE) == ACCESS_CODE) * 2 + index]
+
 #define NB_MMU_MODES 2
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
@@ -121,6 +129,7 @@ typedef struct CPUM68KState {
         uint16_t tcr;
         uint32_t urp;
         uint32_t srp;
+        uint32_t ttr[4];
     } mmu;
 
     /* Control registers.  */
@@ -315,6 +324,15 @@ typedef enum {
 #define M68K_PDT_INDIRECT(entry)    ((entry & 3) == 2)
 #define M68K_INDIRECT_POINTER(addr) (addr & ~3)
 
+/* bits for 68040 MMU Transparent Translation Registers */
+#define M68K_TTR_ADDR_BASE 0xff000000
+#define M68K_TTR_ADDR_MASK 0x00ff0000
+#define M68K_TTR_ADDR_MASK_SHIFT    8
+#define M68K_TTR_ENABLED   0x00008000
+#define M68K_TTR_SFIELD    0x00006000
+#define M68K_TTR_SFIELD_USER   0x0000
+#define M68K_TTR_SFIELD_SUPER  0x2000
+
 /* m68k Control Registers */
 
 /* ColdFire */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index c25c99c0fb..c5b436d382 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -230,6 +230,19 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
     case M68K_CR_ISP:
         env->sp[M68K_ISP] = val;
         return;
+    /* MC68040/MC68LC040 */
+    case M68K_CR_ITT0:
+        env->mmu.ttr[M68K_ITTR0] = val;
+        return;
+    case M68K_CR_ITT1:
+         env->mmu.ttr[M68K_ITTR1] = val;
+        return;
+    case M68K_CR_DTT0:
+        env->mmu.ttr[M68K_DTTR0] = val;
+        return;
+    case M68K_CR_DTT1:
+        env->mmu.ttr[M68K_DTTR1] = val;
+        return;
     }
     cpu_abort(CPU(cpu), "Unimplemented control register write 0x%x = 0x%x\n",
               reg, val);
@@ -260,6 +273,14 @@ uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
     /* MC68040/MC68LC040 */
     case M68K_CR_URP:
         return env->mmu.urp;
+    case M68K_CR_ITT0:
+        return env->mmu.ttr[M68K_ITTR0];
+    case M68K_CR_ITT1:
+        return env->mmu.ttr[M68K_ITTR1];
+    case M68K_CR_DTT0:
+        return env->mmu.ttr[M68K_DTTR0];
+    case M68K_CR_DTT1:
+        return env->mmu.ttr[M68K_DTTR1];
     }
     cpu_abort(CPU(cpu), "Unimplemented control register read 0x%x\n",
               reg);
@@ -338,6 +359,53 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
 /* MMU: 68040 only */
 
+static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
+                     int access_type)
+{
+    uint32_t base, mask;
+
+    /* check if transparent translation is enabled */
+    if ((ttr & M68K_TTR_ENABLED) == 0) {
+        return 0;
+    }
+
+    /* check mode access */
+    switch (ttr & M68K_TTR_SFIELD) {
+    case M68K_TTR_SFIELD_USER:
+        /* match only if user */
+        if ((access_type & ACCESS_SUPER) != 0) {
+            return 0;
+        }
+        break;
+    case M68K_TTR_SFIELD_SUPER:
+        /* match only if supervisor */
+        if ((access_type & ACCESS_SUPER) == 0) {
+            return 0;
+        }
+        break;
+    default:
+        /* all other values disable mode matching (FC2) */
+        break;
+    }
+
+    /* check address matching */
+
+    base = ttr & M68K_TTR_ADDR_BASE;
+    mask = (ttr & M68K_TTR_ADDR_MASK) ^ M68K_TTR_ADDR_MASK;
+    mask <<= M68K_TTR_ADDR_MASK_SHIFT;
+
+    if ((addr & mask) != (base & mask)) {
+        return 0;
+    }
+
+    *prot = PAGE_READ | PAGE_EXEC;
+    if ((ttr & M68K_DESC_WRITEPROT) == 0) {
+        *prot |= PAGE_WRITE;
+    }
+
+    return 1;
+}
+
 static int get_physical_address(CPUM68KState *env, hwaddr *physical,
                                 int *prot, target_ulong address,
                                 int access_type, target_ulong *page_size)
@@ -347,6 +415,17 @@ static int get_physical_address(CPUM68KState *env, hwaddr *physical,
     uint32_t page_offset;
     uint32_t entry;
     uint32_t next;
+    int i;
+
+    /* Transparent Translation (physical = logical) */
+    for (i = 0; i < M68K_MAX_TTR; i++) {
+        if (check_TTR(env->mmu.TTR(access_type, i),
+                      prot, address, access_type)) {
+            *physical = address;
+            *page_size = TARGET_PAGE_SIZE;
+            return 0;
+        }
+    }
 
     /* Page Table Root Pointer */
     *prot = PAGE_READ | PAGE_WRITE;
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 2b83e3bc0d..a20af6b09c 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -33,6 +33,10 @@ static const MonitorDef monitor_defs[] = {
     { "isp", offsetof(CPUM68KState, sp[2]) },
     { "urp", offsetof(CPUM68KState, mmu.urp) },
     { "srp", offsetof(CPUM68KState, mmu.srp) },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
     { NULL },
 };
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5acee66208..af70825480 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5983,6 +5983,9 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "VBR = 0x%08x\n", env->vbr);
     cpu_fprintf(f, "SSW %08x TCR %08x URP %08x SRP %08x\n",
                 env->mmu.ssw, env->mmu.tcr, env->mmu.urp, env->mmu.srp);
+    cpu_fprintf(f, "DTTR0/1: %08x/%08x ITTR0/1: %08x/%08x\n",
+                env->mmu.ttr[M68K_DTTR0], env->mmu.ttr[M68K_DTTR1],
+                env->mmu.ttr[M68K_ITTR0], env->mmu.ttr[M68K_ITTR1]);
 #endif
 }
 
-- 
2.14.3

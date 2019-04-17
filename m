Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE534C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D08520835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D08520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqOQ-00072E-2T
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:38:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4e-00006R-Hs
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4a-0000FR-OX
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGq4Y-0008P3-L1
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89C9D81F18
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:18:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A7F0019C7B;
	Wed, 17 Apr 2019 19:18:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 90C3711329F5; Wed, 17 Apr 2019 21:18:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:17:58 +0200
Message-Id: <20190417191805.28198-11-armbru@redhat.com>
In-Reply-To: <20190417191805.28198-1-armbru@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 17 Apr 2019 19:18:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/17] target: Clean up how the dump_mmu()
 print
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417191758.S0ODK9VmPcqawVdWd3_J1DHI0yLtzHwaH1GqP9AfEhs@z>

The various dump_mmu() take an fprintf()-like callback and a FILE * to
pass to it, and so do their helper functions.  Passing around callback
and argument is rather tiresome.

Most dump_mmu() are called only by the target's hmp_info_tlb().  These
all pass monitor_printf() cast to fprintf_function and the current
monitor cast to FILE *.

SPARC's dump_mmu() gets also called from target/sparc/ldst_helper.c a
few times #ifdef DEBUG_MMU.  These calls pass fprintf() and stdout.

The type-punning is technically undefined behaviour, but works in
practice.  Clean up: drop the callback, and call qemu_printf()
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 target/m68k/cpu.h          |   3 +-
 target/m68k/helper.c       | 115 ++++++++++++++++++-------------------
 target/m68k/monitor.c      |   2 +-
 target/nios2/cpu.h         |   2 +-
 target/nios2/mmu.c         |   7 ++-
 target/nios2/monitor.c     |   2 +-
 target/ppc/cpu.h           |   2 +-
 target/ppc/mmu-hash64.c    |   7 ++-
 target/ppc/mmu-hash64.h    |   2 +-
 target/ppc/mmu_helper.c    |  70 +++++++++++-----------
 target/ppc/monitor.c       |   2 +-
 target/sparc/cpu.h         |   2 +-
 target/sparc/ldst_helper.c |  18 +++---
 target/sparc/mmu_helper.c  |  97 +++++++++++++++----------------
 target/sparc/monitor.c     |   2 +-
 target/xtensa/cpu.h        |   2 +-
 target/xtensa/mmu_helper.c |  24 ++++----
 target/xtensa/monitor.c    |   2 +-
 18 files changed, 178 insertions(+), 183 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 9c1f0a2458..73952f6ece 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -573,5 +573,6 @@ static inline void cpu_get_tb_cpu_state(CPUM68KState *env, target_ulong *pc,
     }
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUM68KState *env);
+void dump_mmu(CPUM68KState *env);
+
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index bb64cf15c0..d958a34959 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -369,30 +369,28 @@ int m68k_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
 
 /* MMU: 68040 only */
 
-static void print_address_zone(FILE *f, fprintf_function cpu_fprintf,
-                               uint32_t logical, uint32_t physical,
+static void print_address_zone(uint32_t logical, uint32_t physical,
                                uint32_t size, int attr)
 {
-    cpu_fprintf(f, "%08x - %08x -> %08x - %08x %c ",
+    qemu_printf("%08x - %08x -> %08x - %08x %c ",
                 logical, logical + size - 1,
                 physical, physical + size - 1,
                 attr & 4 ? 'W' : '-');
     size >>= 10;
     if (size < 1024) {
-        cpu_fprintf(f, "(%d KiB)\n", size);
+        qemu_printf("(%d KiB)\n", size);
     } else {
         size >>= 10;
         if (size < 1024) {
-            cpu_fprintf(f, "(%d MiB)\n", size);
+            qemu_printf("(%d MiB)\n", size);
         } else {
             size >>= 10;
-            cpu_fprintf(f, "(%d GiB)\n", size);
+            qemu_printf("(%d GiB)\n", size);
         }
     }
 }
 
-static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
-                             CPUM68KState *env, uint32_t root_pointer)
+static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
 {
     int i, j, k;
     int tic_size, tic_shift;
@@ -454,7 +452,7 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
                     if (first_logical != 0xffffffff) {
                         size = last_logical + (1 << tic_shift) -
                                first_logical;
-                        print_address_zone(f, cpu_fprintf, first_logical,
+                        print_address_zone(first_logical,
                                            first_physical, size, last_attr);
                     }
                     first_logical = logical;
@@ -465,126 +463,125 @@ static void dump_address_map(FILE *f, fprintf_function cpu_fprintf,
     }
     if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
         size = logical + (1 << tic_shift) - first_logical;
-        print_address_zone(f, cpu_fprintf, first_logical, first_physical, size,
-                           last_attr);
+        print_address_zone(first_logical, first_physical, size, last_attr);
     }
 }
 
 #define DUMP_CACHEFLAGS(a) \
     switch (a & M68K_DESC_CACHEMODE) { \
     case M68K_DESC_CM_WRTHRU: /* cachable, write-through */ \
-        cpu_fprintf(f, "T"); \
+        qemu_printf("T"); \
         break; \
     case M68K_DESC_CM_COPYBK: /* cachable, copyback */ \
-        cpu_fprintf(f, "C"); \
+        qemu_printf("C"); \
         break; \
     case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
-        cpu_fprintf(f, "S"); \
+        qemu_printf("S"); \
         break; \
     case M68K_DESC_CM_NCACHE: /* noncachable */ \
-        cpu_fprintf(f, "N"); \
+        qemu_printf("N"); \
         break; \
     }
 
-static void dump_ttr(FILE *f, fprintf_function cpu_fprintf, uint32_t ttr)
+static void dump_ttr(uint32_t ttr)
 {
     if ((ttr & M68K_TTR_ENABLED) == 0) {
-        cpu_fprintf(f, "disabled\n");
+        qemu_printf("disabled\n");
         return;
     }
-    cpu_fprintf(f, "Base: 0x%08x Mask: 0x%08x Control: ",
+    qemu_printf("Base: 0x%08x Mask: 0x%08x Control: ",
                 ttr & M68K_TTR_ADDR_BASE,
                 (ttr & M68K_TTR_ADDR_MASK) << M68K_TTR_ADDR_MASK_SHIFT);
     switch (ttr & M68K_TTR_SFIELD) {
     case M68K_TTR_SFIELD_USER:
-        cpu_fprintf(f, "U");
+        qemu_printf("U");
         break;
     case M68K_TTR_SFIELD_SUPER:
-        cpu_fprintf(f, "S");
+        qemu_printf("S");
         break;
     default:
-        cpu_fprintf(f, "*");
+        qemu_printf("*");
         break;
     }
     DUMP_CACHEFLAGS(ttr);
     if (ttr & M68K_DESC_WRITEPROT) {
-        cpu_fprintf(f, "R");
+        qemu_printf("R");
     } else {
-        cpu_fprintf(f, "W");
+        qemu_printf("W");
     }
-    cpu_fprintf(f, " U: %d\n", (ttr & M68K_DESC_USERATTR) >>
+    qemu_printf(" U: %d\n", (ttr & M68K_DESC_USERATTR) >>
                                M68K_DESC_USERATTR_SHIFT);
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUM68KState *env)
+void dump_mmu(CPUM68KState *env)
 {
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
-        cpu_fprintf(f, "Translation disabled\n");
+        qemu_printf("Translation disabled\n");
         return;
     }
-    cpu_fprintf(f, "Page Size: ");
+    qemu_printf("Page Size: ");
     if (env->mmu.tcr & M68K_TCR_PAGE_8K) {
-        cpu_fprintf(f, "8kB\n");
+        qemu_printf("8kB\n");
     } else {
-        cpu_fprintf(f, "4kB\n");
+        qemu_printf("4kB\n");
     }
 
-    cpu_fprintf(f, "MMUSR: ");
+    qemu_printf("MMUSR: ");
     if (env->mmu.mmusr & M68K_MMU_B_040) {
-        cpu_fprintf(f, "BUS ERROR\n");
+        qemu_printf("BUS ERROR\n");
     } else {
-        cpu_fprintf(f, "Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
+        qemu_printf("Phy=%08x Flags: ", env->mmu.mmusr & 0xfffff000);
         /* flags found on the page descriptor */
         if (env->mmu.mmusr & M68K_MMU_G_040) {
-            cpu_fprintf(f, "G"); /* Global */
+            qemu_printf("G"); /* Global */
         } else {
-            cpu_fprintf(f, ".");
+            qemu_printf(".");
         }
         if (env->mmu.mmusr & M68K_MMU_S_040) {
-            cpu_fprintf(f, "S"); /* Supervisor */
+            qemu_printf("S"); /* Supervisor */
         } else {
-            cpu_fprintf(f, ".");
+            qemu_printf(".");
         }
         if (env->mmu.mmusr & M68K_MMU_M_040) {
-            cpu_fprintf(f, "M"); /* Modified */
+            qemu_printf("M"); /* Modified */
         } else {
-            cpu_fprintf(f, ".");
+            qemu_printf(".");
         }
         if (env->mmu.mmusr & M68K_MMU_WP_040) {
-            cpu_fprintf(f, "W"); /* Write protect */
+            qemu_printf("W"); /* Write protect */
         } else {
-            cpu_fprintf(f, ".");
+            qemu_printf(".");
         }
         if (env->mmu.mmusr & M68K_MMU_T_040) {
-            cpu_fprintf(f, "T"); /* Transparent */
+            qemu_printf("T"); /* Transparent */
         } else {
-            cpu_fprintf(f, ".");
+            qemu_printf(".");
         }
         if (env->mmu.mmusr & M68K_MMU_R_040) {
-            cpu_fprintf(f, "R"); /* Resident */
+            qemu_printf("R"); /* Resident */
         } else {
-            cpu_fprintf(f, ".");
+            qemu_printf(".");
         }
-        cpu_fprintf(f, " Cache: ");
+        qemu_printf(" Cache: ");
         DUMP_CACHEFLAGS(env->mmu.mmusr);
-        cpu_fprintf(f, " U: %d\n", (env->mmu.mmusr >> 8) & 3);
-        cpu_fprintf(f, "\n");
+        qemu_printf(" U: %d\n", (env->mmu.mmusr >> 8) & 3);
+        qemu_printf("\n");
     }
 
-    cpu_fprintf(f, "ITTR0: ");
-    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_ITTR0]);
-    cpu_fprintf(f, "ITTR1: ");
-    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_ITTR1]);
-    cpu_fprintf(f, "DTTR0: ");
-    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_DTTR0]);
-    cpu_fprintf(f, "DTTR1: ");
-    dump_ttr(f, cpu_fprintf, env->mmu.ttr[M68K_DTTR1]);
+    qemu_printf("ITTR0: ");
+    dump_ttr(env->mmu.ttr[M68K_ITTR0]);
+    qemu_printf("ITTR1: ");
+    dump_ttr(env->mmu.ttr[M68K_ITTR1]);
+    qemu_printf("DTTR0: ");
+    dump_ttr(env->mmu.ttr[M68K_DTTR0]);
+    qemu_printf("DTTR1: ");
+    dump_ttr(env->mmu.ttr[M68K_DTTR1]);
 
-    cpu_fprintf(f, "SRP: 0x%08x\n", env->mmu.srp);
-    dump_address_map(f, cpu_fprintf, env, env->mmu.srp);
+    qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
+    dump_address_map(env, env->mmu.srp);
 
-    cpu_fprintf(f, "URP: 0x%08x\n", env->mmu.urp);
-    dump_address_map(f, cpu_fprintf, env, env->mmu.urp);
+    qemu_printf("URP: 0x%08x\n", env->mmu.urp);
+    dump_address_map(env, env->mmu.urp);
 }
 
 static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index db582a34ac..2055fe8a00 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -19,7 +19,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    dump_mmu((FILE *)mon, (fprintf_function)monitor_printf, env1);
+    dump_mmu(env1);
 }
 
 static const MonitorDef monitor_defs[] = {
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 047f3764b7..6fa993bb0d 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -212,7 +212,7 @@ static inline Nios2CPU *nios2_env_get_cpu(CPUNios2State *env)
 void nios2_tcg_init(void);
 void nios2_cpu_do_interrupt(CPUState *cs);
 int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env);
+void dump_mmu(CPUNios2State *env);
 void nios2_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                           int flags);
 hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 69b71cba4a..5acf442d8b 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "mmu.h"
@@ -264,18 +265,18 @@ void mmu_init(CPUNios2State *env)
     mmu->tlb = g_new0(Nios2TLBEntry, cpu->tlb_num_entries);
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env)
+void dump_mmu(CPUNios2State *env)
 {
     Nios2CPU *cpu = nios2_env_get_cpu(env);
     int i;
 
-    cpu_fprintf(f, "MMU: ways %d, entries %d, pid bits %d\n",
+    qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
                 cpu->tlb_num_ways, cpu->tlb_num_entries,
                 cpu->pid_num_bits);
 
     for (i = 0; i < cpu->tlb_num_entries; i++) {
         Nios2TLBEntry *entry = &env->mmu.tlb[i];
-        cpu_fprintf(f, "TLB[%d] = %08X %08X %c VPN %05X "
+        qemu_printf("TLB[%d] = %08X %08X %c VPN %05X "
                     "PID %02X %c PFN %05X %c%c%c%c\n",
                     i, entry->tag, entry->data,
                     (entry->tag & (1 << 10)) ? 'V' : '-',
diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
index 422c81656a..d5e3393716 100644
--- a/target/nios2/monitor.c
+++ b/target/nios2/monitor.c
@@ -31,5 +31,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env();
 
-    dump_mmu((FILE *)mon, (fprintf_function)monitor_printf, env1);
+    dump_mmu(env1);
 }
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 382a323c61..8572241364 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2629,7 +2629,7 @@ static inline ppc_avr_t *cpu_avr_ptr(CPUPPCState *env, int i)
     return (ppc_avr_t *)((uintptr_t)env + avr_full_offset(i));
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env);
+void dump_mmu(CPUPPCState *env);
 
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len);
 #endif /* PPC_CPU_H */
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a2b1ec5040..214149f65b 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "mmu-hash64.h"
@@ -71,7 +72,7 @@ static ppc_slb_t *slb_lookup(PowerPCCPU *cpu, target_ulong eaddr)
     return NULL;
 }
 
-void dump_slb(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu)
+void dump_slb(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
     int i;
@@ -79,14 +80,14 @@ void dump_slb(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu)
 
     cpu_synchronize_state(CPU(cpu));
 
-    cpu_fprintf(f, "SLB\tESID\t\t\tVSID\n");
+    qemu_printf("SLB\tESID\t\t\tVSID\n");
     for (i = 0; i < cpu->hash64_opts->slb_size; i++) {
         slbe = env->slb[i].esid;
         slbv = env->slb[i].vsid;
         if (slbe == 0 && slbv == 0) {
             continue;
         }
-        cpu_fprintf(f, "%d\t0x%016" PRIx64 "\t0x%016" PRIx64 "\n",
+        qemu_printf("%d\t0x%016" PRIx64 "\t0x%016" PRIx64 "\n",
                     i, slbe, slbv);
     }
 }
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 6b555b7220..5be7ad86db 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -4,7 +4,7 @@
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
-void dump_slb(FILE *f, fprintf_function cpu_fprintf, PowerPCCPU *cpu);
+void dump_slb(PowerPCCPU *cpu);
 int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
                   target_ulong esid, target_ulong vsid);
 hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr);
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 4a6be4d63b..ab72473eeb 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -29,6 +29,7 @@
 #include "exec/log.h"
 #include "helper_regs.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "mmu-book3s-v3.h"
 #include "mmu-radix64.h"
 
@@ -1116,19 +1117,18 @@ static const char *book3e_tsize_to_str[32] = {
     "1T", "2T"
 };
 
-static void mmubooke_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
-                                 CPUPPCState *env)
+static void mmubooke_dump_mmu(CPUPPCState *env)
 {
     ppcemb_tlb_t *entry;
     int i;
 
     if (kvm_enabled() && !env->kvm_sw_tlb) {
-        cpu_fprintf(f, "Cannot access KVM TLB\n");
+        qemu_printf("Cannot access KVM TLB\n");
         return;
     }
 
-    cpu_fprintf(f, "\nTLB:\n");
-    cpu_fprintf(f, "Effective          Physical           Size PID   Prot     "
+    qemu_printf("\nTLB:\n");
+    qemu_printf("Effective          Physical           Size PID   Prot     "
                 "Attr\n");
 
     entry = &env->tlb.tlbe[0];
@@ -1153,22 +1153,21 @@ static void mmubooke_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
         } else {
             snprintf(size_buf, sizeof(size_buf), "%3" PRId64 "k", size / KiB);
         }
-        cpu_fprintf(f, "0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
+        qemu_printf("0x%016" PRIx64 " 0x%016" PRIx64 " %s %-5u %08x %08x\n",
                     (uint64_t)ea, (uint64_t)pa, size_buf, (uint32_t)entry->PID,
                     entry->prot, entry->attr);
     }
 
 }
 
-static void mmubooke206_dump_one_tlb(FILE *f, fprintf_function cpu_fprintf,
-                                     CPUPPCState *env, int tlbn, int offset,
+static void mmubooke206_dump_one_tlb(CPUPPCState *env, int tlbn, int offset,
                                      int tlbsize)
 {
     ppcmas_tlb_t *entry;
     int i;
 
-    cpu_fprintf(f, "\nTLB%d:\n", tlbn);
-    cpu_fprintf(f, "Effective          Physical           Size TID   TS SRWX"
+    qemu_printf("\nTLB%d:\n", tlbn);
+    qemu_printf("Effective          Physical           Size TID   TS SRWX"
                 " URWX WIMGE U0123\n");
 
     entry = &env->tlb.tlbm[offset];
@@ -1185,7 +1184,7 @@ static void mmubooke206_dump_one_tlb(FILE *f, fprintf_function cpu_fprintf,
         ea = entry->mas2 & ~(size - 1);
         pa = entry->mas7_3 & ~(size - 1);
 
-        cpu_fprintf(f, "0x%016" PRIx64 " 0x%016" PRIx64 " %4s %-5u %1u  S%c%c%c"
+        qemu_printf("0x%016" PRIx64 " 0x%016" PRIx64 " %4s %-5u %1u  S%c%c%c"
                     "U%c%c%c %c%c%c%c%c U%c%c%c%c\n",
                     (uint64_t)ea, (uint64_t)pa,
                     book3e_tsize_to_str[tsize],
@@ -1209,14 +1208,13 @@ static void mmubooke206_dump_one_tlb(FILE *f, fprintf_function cpu_fprintf,
     }
 }
 
-static void mmubooke206_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
-                                 CPUPPCState *env)
+static void mmubooke206_dump_mmu(CPUPPCState *env)
 {
     int offset = 0;
     int i;
 
     if (kvm_enabled() && !env->kvm_sw_tlb) {
-        cpu_fprintf(f, "Cannot access KVM TLB\n");
+        qemu_printf("Cannot access KVM TLB\n");
         return;
     }
 
@@ -1227,13 +1225,12 @@ static void mmubooke206_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
             continue;
         }
 
-        mmubooke206_dump_one_tlb(f, cpu_fprintf, env, i, offset, size);
+        mmubooke206_dump_one_tlb(env, i, offset, size);
         offset += size;
     }
 }
 
-static void mmu6xx_dump_BATs(FILE *f, fprintf_function cpu_fprintf,
-                             CPUPPCState *env, int type)
+static void mmu6xx_dump_BATs(CPUPPCState *env, int type)
 {
     target_ulong *BATlt, *BATut, *BATu, *BATl;
     target_ulong BEPIl, BEPIu, bl;
@@ -1256,7 +1253,7 @@ static void mmu6xx_dump_BATs(FILE *f, fprintf_function cpu_fprintf,
         BEPIu = *BATu & 0xF0000000;
         BEPIl = *BATu & 0x0FFE0000;
         bl = (*BATu & 0x00001FFC) << 15;
-        cpu_fprintf(f, "%s BAT%d BATu " TARGET_FMT_lx
+        qemu_printf("%s BAT%d BATu " TARGET_FMT_lx
                     " BATl " TARGET_FMT_lx "\n\t" TARGET_FMT_lx " "
                     TARGET_FMT_lx " " TARGET_FMT_lx "\n",
                     type == ACCESS_CODE ? "code" : "data", i,
@@ -1264,44 +1261,43 @@ static void mmu6xx_dump_BATs(FILE *f, fprintf_function cpu_fprintf,
     }
 }
 
-static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
-                            CPUPPCState *env)
+static void mmu6xx_dump_mmu(CPUPPCState *env)
 {
     PowerPCCPU *cpu = ppc_env_get_cpu(env);
     ppc6xx_tlb_t *tlb;
     target_ulong sr;
     int type, way, entry, i;
 
-    cpu_fprintf(f, "HTAB base = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(cpu));
-    cpu_fprintf(f, "HTAB mask = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(cpu));
+    qemu_printf("HTAB base = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_base(cpu));
+    qemu_printf("HTAB mask = 0x%"HWADDR_PRIx"\n", ppc_hash32_hpt_mask(cpu));
 
-    cpu_fprintf(f, "\nSegment registers:\n");
+    qemu_printf("\nSegment registers:\n");
     for (i = 0; i < 32; i++) {
         sr = env->sr[i];
         if (sr & 0x80000000) {
-            cpu_fprintf(f, "%02d T=%d Ks=%d Kp=%d BUID=0x%03x "
+            qemu_printf("%02d T=%d Ks=%d Kp=%d BUID=0x%03x "
                         "CNTLR_SPEC=0x%05x\n", i,
                         sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
                         sr & 0x20000000 ? 1 : 0, (uint32_t)((sr >> 20) & 0x1FF),
                         (uint32_t)(sr & 0xFFFFF));
         } else {
-            cpu_fprintf(f, "%02d T=%d Ks=%d Kp=%d N=%d VSID=0x%06x\n", i,
+            qemu_printf("%02d T=%d Ks=%d Kp=%d N=%d VSID=0x%06x\n", i,
                         sr & 0x80000000 ? 1 : 0, sr & 0x40000000 ? 1 : 0,
                         sr & 0x20000000 ? 1 : 0, sr & 0x10000000 ? 1 : 0,
                         (uint32_t)(sr & 0x00FFFFFF));
         }
     }
 
-    cpu_fprintf(f, "\nBATs:\n");
-    mmu6xx_dump_BATs(f, cpu_fprintf, env, ACCESS_INT);
-    mmu6xx_dump_BATs(f, cpu_fprintf, env, ACCESS_CODE);
+    qemu_printf("\nBATs:\n");
+    mmu6xx_dump_BATs(env, ACCESS_INT);
+    mmu6xx_dump_BATs(env, ACCESS_CODE);
 
     if (env->id_tlbs != 1) {
-        cpu_fprintf(f, "ERROR: 6xx MMU should have separated TLB"
+        qemu_printf("ERROR: 6xx MMU should have separated TLB"
                     " for code and data\n");
     }
 
-    cpu_fprintf(f, "\nTLBs                       [EPN    EPN + SIZE]\n");
+    qemu_printf("\nTLBs                       [EPN    EPN + SIZE]\n");
 
     for (type = 0; type < 2; type++) {
         for (way = 0; way < env->nb_ways; way++) {
@@ -1310,7 +1306,7 @@ static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
                  entry++) {
 
                 tlb = &env->tlb.tlb6[entry];
-                cpu_fprintf(f, "%s TLB %02d/%02d way:%d %s ["
+                qemu_printf("%s TLB %02d/%02d way:%d %s ["
                             TARGET_FMT_lx " " TARGET_FMT_lx "]\n",
                             type ? "code" : "data", entry % env->nb_tlb,
                             env->nb_tlb, way,
@@ -1321,31 +1317,31 @@ static void mmu6xx_dump_mmu(FILE *f, fprintf_function cpu_fprintf,
     }
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
+void dump_mmu(CPUPPCState *env)
 {
     switch (env->mmu_model) {
     case POWERPC_MMU_BOOKE:
-        mmubooke_dump_mmu(f, cpu_fprintf, env);
+        mmubooke_dump_mmu(env);
         break;
     case POWERPC_MMU_BOOKE206:
-        mmubooke206_dump_mmu(f, cpu_fprintf, env);
+        mmubooke206_dump_mmu(env);
         break;
     case POWERPC_MMU_SOFT_6xx:
     case POWERPC_MMU_SOFT_74xx:
-        mmu6xx_dump_mmu(f, cpu_fprintf, env);
+        mmu6xx_dump_mmu(env);
         break;
 #if defined(TARGET_PPC64)
     case POWERPC_MMU_64B:
     case POWERPC_MMU_2_03:
     case POWERPC_MMU_2_06:
     case POWERPC_MMU_2_07:
-        dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
+        dump_slb(ppc_env_get_cpu(env));
         break;
     case POWERPC_MMU_3_00:
         if (ppc64_v3_radix(ppc_env_get_cpu(env))) {
             /* TODO - Unsupported */
         } else {
-            dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
+            dump_slb(ppc_env_get_cpu(env));
             break;
         }
 #endif
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 04deec8030..42e58163fc 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -66,7 +66,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
+    dump_mmu(env1);
 }
 
 const MonitorDef monitor_defs[] = {
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ab9fa3ddbf..b298bd9c29 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -583,7 +583,7 @@ void sparc_cpu_list(void);
 int sparc_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                                int mmu_idx);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env);
+void dump_mmu(CPUSPARCState *env);
 
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 5bc090213c..a7fcb84ac0 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -198,7 +198,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong demap_addr,
             replace_tlb_entry(&tlb[i], 0, 0, env1);
 #ifdef DEBUG_MMU
             DPRINTF_MMU("%s demap invalidated entry [%02u]\n", strmmu, i);
-            dump_mmu(stdout, fprintf, env1);
+            dump_mmu(env1);
 #endif
         }
     }
@@ -260,7 +260,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
             replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);
 #ifdef DEBUG_MMU
             DPRINTF_MMU("%s lru replaced invalid entry [%i]\n", strmmu, i);
-            dump_mmu(stdout, fprintf, env1);
+            dump_mmu(env1);
 #endif
             return;
         }
@@ -279,7 +279,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
 #ifdef DEBUG_MMU
                 DPRINTF_MMU("%s lru replaced unlocked %s entry [%i]\n",
                             strmmu, (replace_used ? "used" : "unused"), i);
-                dump_mmu(stdout, fprintf, env1);
+                dump_mmu(env1);
 #endif
                 return;
             }
@@ -886,7 +886,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                 break;
             }
 #ifdef DEBUG_MMU
-            dump_mmu(stdout, fprintf, env);
+            dump_mmu(env);
 #endif
         }
         break;
@@ -941,7 +941,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
                             reg, oldreg, env->mmuregs[reg]);
             }
 #ifdef DEBUG_MMU
-            dump_mmu(stdout, fprintf, env);
+            dump_mmu(env);
 #endif
         }
         break;
@@ -1634,7 +1634,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                             PRIx64 "\n", reg, oldreg, env->immuregs[reg]);
             }
 #ifdef DEBUG_MMU
-            dump_mmu(stdout, fprintf, env);
+            dump_mmu(env);
 #endif
             return;
         }
@@ -1658,7 +1658,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("immu data access replaced entry [%i]\n", i);
-            dump_mmu(stdout, fprintf, env);
+            dump_mmu(env);
 #endif
             return;
         }
@@ -1718,7 +1718,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
                             PRIx64 "\n", reg, oldreg, env->dmmuregs[reg]);
             }
 #ifdef DEBUG_MMU
-            dump_mmu(stdout, fprintf, env);
+            dump_mmu(env);
 #endif
             return;
         }
@@ -1740,7 +1740,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             }
 #ifdef DEBUG_MMU
             DPRINTF_MMU("dmmu data access replaced entry [%i]\n", i);
-            dump_mmu(stdout, fprintf, env);
+            dump_mmu(env);
 #endif
             return;
         }
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 135a9c9d9b..afcc5b617d 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "qemu/qemu-print.h"
 #include "trace.h"
 
 /* Sparc MMU emulation */
@@ -320,7 +321,7 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
     return 0;
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
+void dump_mmu(CPUSPARCState *env)
 {
     CPUState *cs = CPU(sparc_env_get_cpu(env));
     target_ulong va, va1, va2;
@@ -330,29 +331,29 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
 
     pde_ptr = (env->mmuregs[1] << 4) + (env->mmuregs[2] << 2);
     pde = ldl_phys(cs->as, pde_ptr);
-    (*cpu_fprintf)(f, "Root ptr: " TARGET_FMT_plx ", ctx: %d\n",
-                   (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
+    qemu_printf("Root ptr: " TARGET_FMT_plx ", ctx: %d\n",
+                (hwaddr)env->mmuregs[1] << 4, env->mmuregs[2]);
     for (n = 0, va = 0; n < 256; n++, va += 16 * 1024 * 1024) {
         pde = mmu_probe(env, va, 2);
         if (pde) {
             pa = cpu_get_phys_page_debug(cs, va);
-            (*cpu_fprintf)(f, "VA: " TARGET_FMT_lx ", PA: " TARGET_FMT_plx
-                           " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
+            qemu_printf("VA: " TARGET_FMT_lx ", PA: " TARGET_FMT_plx
+                        " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
                     pa = cpu_get_phys_page_debug(cs, va1);
-                    (*cpu_fprintf)(f, " VA: " TARGET_FMT_lx ", PA: "
-                                   TARGET_FMT_plx " PDE: " TARGET_FMT_lx "\n",
-                                   va1, pa, pde);
+                    qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
+                                TARGET_FMT_plx " PDE: " TARGET_FMT_lx "\n",
+                                va1, pa, pde);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
                             pa = cpu_get_phys_page_debug(cs, va2);
-                            (*cpu_fprintf)(f, "  VA: " TARGET_FMT_lx ", PA: "
-                                           TARGET_FMT_plx " PTE: "
-                                           TARGET_FMT_lx "\n",
-                                           va2, pa, pde);
+                            qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
+                                        TARGET_FMT_plx " PTE: "
+                                        TARGET_FMT_lx "\n",
+                                        va2, pa, pde);
                         }
                     }
                 }
@@ -739,21 +740,21 @@ int sparc_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
     return 1;
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
+void dump_mmu(CPUSPARCState *env)
 {
     unsigned int i;
     const char *mask;
 
-    (*cpu_fprintf)(f, "MMU contexts: Primary: %" PRId64 ", Secondary: %"
-                   PRId64 "\n",
-                   env->dmmu.mmu_primary_context,
-                   env->dmmu.mmu_secondary_context);
-    (*cpu_fprintf)(f, "DMMU Tag Access: %" PRIx64 ", TSB Tag Target: %" PRIx64
-                   "\n", env->dmmu.tag_access, env->dmmu.tsb_tag_target);
+    qemu_printf("MMU contexts: Primary: %" PRId64 ", Secondary: %"
+                PRId64 "\n",
+                env->dmmu.mmu_primary_context,
+                env->dmmu.mmu_secondary_context);
+    qemu_printf("DMMU Tag Access: %" PRIx64 ", TSB Tag Target: %" PRIx64
+                "\n", env->dmmu.tag_access, env->dmmu.tsb_tag_target);
     if ((env->lsu & DMMU_E) == 0) {
-        (*cpu_fprintf)(f, "DMMU disabled\n");
+        qemu_printf("DMMU disabled\n");
     } else {
-        (*cpu_fprintf)(f, "DMMU dump\n");
+        qemu_printf("DMMU dump\n");
         for (i = 0; i < 64; i++) {
             switch (TTE_PGSIZE(env->dtlb[i].tte)) {
             default:
@@ -771,26 +772,26 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
                 break;
             }
             if (TTE_IS_VALID(env->dtlb[i].tte)) {
-                (*cpu_fprintf)(f, "[%02u] VA: %" PRIx64 ", PA: %llx"
-                               ", %s, %s, %s, %s, ctx %" PRId64 " %s\n",
-                               i,
-                               env->dtlb[i].tag & (uint64_t)~0x1fffULL,
-                               TTE_PA(env->dtlb[i].tte),
-                               mask,
-                               TTE_IS_PRIV(env->dtlb[i].tte) ? "priv" : "user",
-                               TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
-                               TTE_IS_LOCKED(env->dtlb[i].tte) ?
-                               "locked" : "unlocked",
-                               env->dtlb[i].tag & (uint64_t)0x1fffULL,
-                               TTE_IS_GLOBAL(env->dtlb[i].tte) ?
-                               "global" : "local");
+                qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
+                            ", %s, %s, %s, %s, ctx %" PRId64 " %s\n",
+                            i,
+                            env->dtlb[i].tag & (uint64_t)~0x1fffULL,
+                            TTE_PA(env->dtlb[i].tte),
+                            mask,
+                            TTE_IS_PRIV(env->dtlb[i].tte) ? "priv" : "user",
+                            TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
+                            TTE_IS_LOCKED(env->dtlb[i].tte) ?
+                            "locked" : "unlocked",
+                            env->dtlb[i].tag & (uint64_t)0x1fffULL,
+                            TTE_IS_GLOBAL(env->dtlb[i].tte) ?
+                            "global" : "local");
             }
         }
     }
     if ((env->lsu & IMMU_E) == 0) {
-        (*cpu_fprintf)(f, "IMMU disabled\n");
+        qemu_printf("IMMU disabled\n");
     } else {
-        (*cpu_fprintf)(f, "IMMU dump\n");
+        qemu_printf("IMMU dump\n");
         for (i = 0; i < 64; i++) {
             switch (TTE_PGSIZE(env->itlb[i].tte)) {
             default:
@@ -808,18 +809,18 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUSPARCState *env)
                 break;
             }
             if (TTE_IS_VALID(env->itlb[i].tte)) {
-                (*cpu_fprintf)(f, "[%02u] VA: %" PRIx64 ", PA: %llx"
-                               ", %s, %s, %s, ctx %" PRId64 " %s\n",
-                               i,
-                               env->itlb[i].tag & (uint64_t)~0x1fffULL,
-                               TTE_PA(env->itlb[i].tte),
-                               mask,
-                               TTE_IS_PRIV(env->itlb[i].tte) ? "priv" : "user",
-                               TTE_IS_LOCKED(env->itlb[i].tte) ?
-                               "locked" : "unlocked",
-                               env->itlb[i].tag & (uint64_t)0x1fffULL,
-                               TTE_IS_GLOBAL(env->itlb[i].tte) ?
-                               "global" : "local");
+                qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
+                            ", %s, %s, %s, ctx %" PRId64 " %s\n",
+                            i,
+                            env->itlb[i].tag & (uint64_t)~0x1fffULL,
+                            TTE_PA(env->itlb[i].tte),
+                            mask,
+                            TTE_IS_PRIV(env->itlb[i].tte) ? "priv" : "user",
+                            TTE_IS_LOCKED(env->itlb[i].tte) ?
+                            "locked" : "unlocked",
+                            env->itlb[i].tag & (uint64_t)0x1fffULL,
+                            TTE_IS_GLOBAL(env->itlb[i].tte) ?
+                            "global" : "local");
             }
         }
     }
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index f3ca524ae9..3ec3b51a3d 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -36,7 +36,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
+    dump_mmu(env1);
 }
 
 #ifndef TARGET_SPARC64
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 4aaf1f7bb2..86f6d6d72c 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -673,7 +673,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
         uint32_t vaddr, int is_write, int mmu_idx,
         uint32_t *paddr, uint32_t *page_size, unsigned *access);
 void reset_mmu(CPUXtensaState *env);
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env);
+void dump_mmu(CPUXtensaState *env);
 
 static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 2096fbbd9f..79a10da231 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qemu/qemu-print.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
@@ -740,8 +741,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
     }
 }
 
-static void dump_tlb(FILE *f, fprintf_function cpu_fprintf,
-                     CPUXtensaState *env, bool dtlb)
+static void dump_tlb(CPUXtensaState *env, bool dtlb)
 {
     unsigned wi, ei;
     const xtensa_tlb *conf =
@@ -780,13 +780,11 @@ static void dump_tlb(FILE *f, fprintf_function cpu_fprintf,
 
                 if (print_header) {
                     print_header = false;
-                    cpu_fprintf(f, "Way %u (%d %s)\n", wi, sz, sz_text);
-                    cpu_fprintf(f,
-                                "\tVaddr       Paddr       ASID  Attr RWX Cache\n"
+                    qemu_printf("Way %u (%d %s)\n", wi, sz, sz_text);
+                    qemu_printf("\tVaddr       Paddr       ASID  Attr RWX Cache\n"
                                 "\t----------  ----------  ----  ---- --- -------\n");
                 }
-                cpu_fprintf(f,
-                            "\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %-7s\n",
+                qemu_printf("\t0x%08x  0x%08x  0x%02x  0x%02x %c%c%c %-7s\n",
                             entry->vaddr,
                             entry->paddr,
                             entry->asid,
@@ -801,18 +799,18 @@ static void dump_tlb(FILE *f, fprintf_function cpu_fprintf,
     }
 }
 
-void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUXtensaState *env)
+void dump_mmu(CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_PROTECTION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION) |
                 XTENSA_OPTION_BIT(XTENSA_OPTION_MMU))) {
 
-        cpu_fprintf(f, "ITLB:\n");
-        dump_tlb(f, cpu_fprintf, env, false);
-        cpu_fprintf(f, "\nDTLB:\n");
-        dump_tlb(f, cpu_fprintf, env, true);
+        qemu_printf("ITLB:\n");
+        dump_tlb(env, false);
+        qemu_printf("\nDTLB:\n");
+        dump_tlb(env, true);
     } else {
-        cpu_fprintf(f, "No TLB for this CPU core\n");
+        qemu_printf("No TLB for this CPU core\n");
     }
 }
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index 2ee2b5b23e..cf7957bb63 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -35,5 +35,5 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    dump_mmu((FILE*)mon, (fprintf_function)monitor_printf, env1);
+    dump_mmu(env1);
 }
-- 
2.17.2



Received: from eggs.gnu.org ([2001:4830:134:3::10]:51831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj4y-0005Dg-7R
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj4u-0005G5-Tl
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:04 -0500
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com
	([104.47.36.80]:16320
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj4u-0005Fm-ID
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:00 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:51:59 -0500
Message-ID: <148900631908.27090.16339695025371616457.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 05/20] monitor/i386: use debug apis when
 accessing guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

updates hmp monitor to use debug version of memory access apis when
reading the guest memory.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 cpus.c                |    2 -
 disas.c               |    2 -
 monitor.c             |    2 -
 target/i386/helper.c  |   16 +++----
 target/i386/monitor.c |  114 +++++++++++++++++++++++++++++--------------------
 5 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/cpus.c b/cpus.c
index c857ad2..5c3b596 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1906,7 +1906,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
         l = sizeof(buf);
         if (l > size)
             l = size;
-        cpu_physical_memory_read(addr, buf, l);
+        cpu_physical_memory_read_debug(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
diff --git a/disas.c b/disas.c
index d335c55..6d67de5 100644
--- a/disas.c
+++ b/disas.c
@@ -357,7 +357,7 @@ monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
     CPUDebug *s = container_of(info, CPUDebug, info);
 
     if (monitor_disas_is_physical) {
-        cpu_physical_memory_read(memaddr, myaddr, length);
+        cpu_physical_memory_read_debug(memaddr, myaddr, length);
     } else {
         cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
     }
diff --git a/monitor.c b/monitor.c
index ec7623e..4a1c772 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1350,7 +1350,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         if (l > line_size)
             l = line_size;
         if (is_physical) {
-            cpu_physical_memory_read(addr, buf, l);
+            cpu_physical_memory_read_debug(addr, buf, l);
         } else {
             if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
                 monitor_printf(mon, " Cannot access memory\n");
diff --git a/target/i386/helper.c b/target/i386/helper.c
index e2af340..05395d7 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -1061,7 +1061,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             if (la57) {
                 pml5e_addr = ((env->cr[3] & ~0xfff) +
                         (((addr >> 48) & 0x1ff) << 3)) & env->a20_mask;
-                pml5e = x86_ldq_phys(cs, pml5e_addr);
+                pml5e = ldq_phys_debug(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     return -1;
                 }
@@ -1071,13 +1071,13 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
             pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
                     (((addr >> 39) & 0x1ff) << 3)) & env->a20_mask;
-            pml4e = x86_ldq_phys(cs, pml4e_addr);
+            pml4e = ldq_phys_debug(cs, pml4e_addr);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 return -1;
             }
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) +
                          (((addr >> 30) & 0x1ff) << 3)) & env->a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
+            pdpe = ldq_phys_debug(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 return -1;
             }
@@ -1092,14 +1092,14 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         {
             pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
                 env->a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
+            pdpe = ldq_phys_debug(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK))
                 return -1;
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & env->a20_mask;
-        pde = x86_ldq_phys(cs, pde_addr);
+        pde = ldq_phys_debug(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             return -1;
         }
@@ -1112,7 +1112,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             pte_addr = ((pde & PG_ADDRESS_MASK) +
                         (((addr >> 12) & 0x1ff) << 3)) & env->a20_mask;
             page_size = 4096;
-            pte = x86_ldq_phys(cs, pte_addr);
+            pte = ldq_phys_debug(cs, pte_addr);
         }
         if (!(pte & PG_PRESENT_MASK)) {
             return -1;
@@ -1122,7 +1122,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
         /* page directory entry */
         pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & env->a20_mask;
-        pde = x86_ldl_phys(cs, pde_addr);
+        pde = ldl_phys_debug(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK))
             return -1;
         if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -1131,7 +1131,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         } else {
             /* page directory entry */
             pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & env->a20_mask;
-            pte = x86_ldl_phys(cs, pte_addr);
+            pte = ldl_phys_debug(cs, pte_addr);
             if (!(pte & PG_PRESENT_MASK)) {
                 return -1;
             }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 77ead60..7c39e05 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -59,14 +59,16 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                    pte & PG_RW_MASK ? 'W' : '-');
 }
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env)
+static void tlb_info_32(Monitor *mon, CPUState *cs)
 {
     unsigned int l1, l2;
     uint32_t pgd, pde, pte;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
 
     pgd = env->cr[3] & ~0xfff;
     for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        pde = ldl_phys_debug(cs, pgd + l1 * 4);
         pde = le32_to_cpu(pde);
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -74,7 +76,7 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
                 print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    pte = ldl_phys_debug(cs, (pde & ~0xfff) + l2 * 4);
                     pte = le32_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l1 << 22) + (l2 << 12),
@@ -87,20 +89,22 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
     }
 }
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
+static void tlb_info_pae32(Monitor *mon, CPUState *cs)
 {
     unsigned int l1, l2, l3;
     uint64_t pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
 
     pdp_addr = env->cr[3] & ~0x1f;
     for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        pdpe = ldq_phys_debug(cs, pdp_addr + l1 * 8);
         pdpe = le64_to_cpu(pdpe);
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                pde = ldq_phys_debug(cs, pd_addr + l2 * 8);
                 pde = le64_to_cpu(pde);
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
@@ -110,7 +114,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            pte = ldq_phys_debug(cs, pt_addr + l3 * 8);
                             pte = le64_to_cpu(pte);
                             if (pte & PG_PRESENT_MASK) {
                                 print_pte(mon, env, (l1 << 30) + (l2 << 21)
@@ -127,15 +131,17 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
 }
 
 #ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env,
+static void tlb_info_la48(Monitor *mon, CPUState *cs,
         uint64_t l0, uint64_t pml4_addr)
 {
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
     uint64_t l1, l2, l3, l4;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
 
     for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8);
         pml4e = le64_to_cpu(pml4e);
         if (!(pml4e & PG_PRESENT_MASK)) {
             continue;
@@ -143,7 +149,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
         pdp_addr = pml4e & 0x3fffffffff000ULL;
         for (l2 = 0; l2 < 512; l2++) {
-            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+            pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8);
             pdpe = le64_to_cpu(pdpe);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 continue;
@@ -158,7 +164,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l3 = 0; l3 < 512; l3++) {
-                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                pde = ldq_phys_debug(cs, pd_addr + l3 * 8);
                 pde = le64_to_cpu(pde);
                 if (!(pde & PG_PRESENT_MASK)) {
                     continue;
@@ -173,9 +179,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
                 pt_addr = pde & 0x3fffffffff000ULL;
                 for (l4 = 0; l4 < 512; l4++) {
-                    cpu_physical_memory_read(pt_addr
-                            + l4 * 8,
-                            &pte, 8);
+                    pte = ldq_phys_debug(cs, pt_addr + l4 * 8);
                     pte = le64_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l0 << 48) + (l1 << 39) +
@@ -188,18 +192,20 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
     }
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env)
+static void tlb_info_la57(Monitor *mon, CPUState *cs)
 {
     uint64_t l0;
     uint64_t pml5e;
     uint64_t pml5_addr;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
 
     pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
     for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        pml5e = ldq_phys_debug(cs, pml5_addr + l0 * 8);
         pml5e = le64_to_cpu(pml5e);
         if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
+            tlb_info_la48(mon, cs, l0, pml5e & 0x3fffffffff000ULL);
         }
     }
 }
@@ -207,9 +213,13 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
+    X86CPU *cpu;
+    CPUState *cs;
     CPUArchState *env;
 
-    env = mon_get_cpu_env();
+    cs = mon_get_cpu();
+    cpu = X86_CPU(cs);
+    env = &cpu->env;
     if (!env) {
         monitor_printf(mon, "No CPU available\n");
         return;
@@ -223,17 +233,17 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                tlb_info_la57(mon, env);
+                tlb_info_la57(mon, cs);
             } else {
-                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
+                tlb_info_la48(mon, cs, 0, env->cr[3] & 0x3fffffffff000ULL);
             }
         } else
 #endif
         {
-            tlb_info_pae32(mon, env);
+            tlb_info_pae32(mon, cs);
         }
     } else {
-        tlb_info_32(mon, env);
+        tlb_info_32(mon, cs);
     }
 }
 
@@ -260,18 +270,20 @@ static void mem_print(Monitor *mon, hwaddr *pstart,
     }
 }
 
-static void mem_info_32(Monitor *mon, CPUArchState *env)
+static void mem_info_32(Monitor *mon, CPUState *cs)
 {
     unsigned int l1, l2;
     int prot, last_prot;
     uint32_t pgd, pde, pte;
     hwaddr start, end;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
 
     pgd = env->cr[3] & ~0xfff;
     last_prot = 0;
     start = -1;
     for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        pde = ldl_phys_debug(cs, pgd + l1 * 4);
         pde = le32_to_cpu(pde);
         end = l1 << 22;
         if (pde & PG_PRESENT_MASK) {
@@ -280,7 +292,7 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
                 mem_print(mon, &start, &last_prot, end, prot);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    pte = ldl_phys_debug(cs, (pde & ~0xfff) + l2 * 4);
                     pte = le32_to_cpu(pte);
                     end = (l1 << 22) + (l2 << 12);
                     if (pte & PG_PRESENT_MASK) {
@@ -301,25 +313,27 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
     mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, 0);
 }
 
-static void mem_info_pae32(Monitor *mon, CPUArchState *env)
+static void mem_info_pae32(Monitor *mon, CPUState *cs)
 {
     unsigned int l1, l2, l3;
     int prot, last_prot;
     uint64_t pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
     hwaddr start, end;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
 
     pdp_addr = env->cr[3] & ~0x1f;
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        pdpe = ldq_phys_debug(cs, pdp_addr + l1 * 8);
         pdpe = le64_to_cpu(pdpe);
         end = l1 << 30;
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                pde = ldq_phys_debug(cs, pd_addr + l2 * 8);
                 pde = le64_to_cpu(pde);
                 end = (l1 << 30) + (l2 << 21);
                 if (pde & PG_PRESENT_MASK) {
@@ -330,7 +344,7 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            pte = ldq_phys_debug(cs, pt_addr + l3 * 8);
                             pte = le64_to_cpu(pte);
                             end = (l1 << 30) + (l2 << 21) + (l3 << 12);
                             if (pte & PG_PRESENT_MASK) {
@@ -358,10 +372,12 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
 
 
 #ifdef TARGET_X86_64
-static void mem_info_la48(Monitor *mon, CPUArchState *env)
+static void mem_info_la48(Monitor *mon, CPUState *cs)
 {
     int prot, last_prot;
     uint64_t l1, l2, l3, l4;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
 
@@ -369,13 +385,13 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8);
         pml4e = le64_to_cpu(pml4e);
         end = l1 << 39;
         if (pml4e & PG_PRESENT_MASK) {
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+                pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8);
                 pdpe = le64_to_cpu(pdpe);
                 end = (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -387,7 +403,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                     } else {
                         pd_addr = pdpe & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                            pde = ldq_phys_debug(cs, pd_addr + l3 * 8);
                             pde = le64_to_cpu(pde);
                             end = (l1 << 39) + (l2 << 30) + (l3 << 21);
                             if (pde & PG_PRESENT_MASK) {
@@ -399,9 +415,8 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                                 } else {
                                     pt_addr = pde & 0x3fffffffff000ULL;
                                     for (l4 = 0; l4 < 512; l4++) {
-                                        cpu_physical_memory_read(pt_addr
-                                                                 + l4 * 8,
-                                                                 &pte, 8);
+                                        pte = ldq_phys_debug(cs,
+                                                             pt_addr + l4 * 8);
                                         pte = le64_to_cpu(pte);
                                         end = (l1 << 39) + (l2 << 30) +
                                             (l3 << 21) + (l4 << 12);
@@ -435,10 +450,12 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
     mem_print(mon, &start, &last_prot, (hwaddr)1 << 48, 0);
 }
 
-static void mem_info_la57(Monitor *mon, CPUArchState *env)
+static void mem_info_la57(Monitor *mon, CPUState *cs)
 {
     int prot, last_prot;
     uint64_t l0, l1, l2, l3, l4;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUArchState *env = &cpu->env;
     uint64_t pml5e, pml4e, pdpe, pde, pte;
     uint64_t pml5_addr, pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
 
@@ -446,7 +463,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        pml5e = ldq_phys_debug(cs, pml5_addr + l0 * 8);
         pml4e = le64_to_cpu(pml5e);
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
@@ -457,7 +474,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
         pml4_addr = pml5e & 0x3fffffffff000ULL;
         for (l1 = 0; l1 < 512; l1++) {
-            cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+            pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8);
             pml4e = le64_to_cpu(pml4e);
             end = (l0 << 48) + (l1 << 39);
             if (!(pml4e & PG_PRESENT_MASK)) {
@@ -468,7 +485,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+                pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8);
                 pdpe = le64_to_cpu(pdpe);
                 end = (l0 << 48) + (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -487,7 +504,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
                 pd_addr = pdpe & 0x3fffffffff000ULL;
                 for (l3 = 0; l3 < 512; l3++) {
-                    cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                    pde = ldq_phys_debug(cs, pd_addr + l3 * 8);
                     pde = le64_to_cpu(pde);
                     end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
                     if (pde & PG_PRESENT_MASK) {
@@ -506,7 +523,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
                     pt_addr = pde & 0x3fffffffff000ULL;
                     for (l4 = 0; l4 < 512; l4++) {
-                        cpu_physical_memory_read(pt_addr + l4 * 8, &pte, 8);
+                        pte = ldq_phys_debug(cs, pt_addr + l4 * 8);
                         pte = le64_to_cpu(pte);
                         end = (l0 << 48) + (l1 << 39) + (l2 << 30) +
                             (l3 << 21) + (l4 << 12);
@@ -530,8 +547,13 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
 void hmp_info_mem(Monitor *mon, const QDict *qdict)
 {
+    X86CPU *cpu;
+    CPUState *cs;
     CPUArchState *env;
 
+    cs = mon_get_cpu();
+    cpu = X86_CPU(cs);
+    env = &cpu->env;
     env = mon_get_cpu_env();
     if (!env) {
         monitor_printf(mon, "No CPU available\n");
@@ -546,17 +568,17 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                mem_info_la57(mon, env);
+                mem_info_la57(mon, cs);
             } else {
-                mem_info_la48(mon, env);
+                mem_info_la48(mon, cs);
             }
         } else
 #endif
         {
-            mem_info_pae32(mon, env);
+            mem_info_pae32(mon, cs);
         }
     } else {
-        mem_info_32(mon, env);
+        mem_info_32(mon, cs);
     }
 }
 

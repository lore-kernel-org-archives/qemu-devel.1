Received: from eggs.gnu.org ([2001:4830:134:3::10]:53180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj9L-0000Xe-2b
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj9H-0006aG-S6
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:29:35 -0500
Received: from mail-co1nam03on0044.outbound.protection.outlook.com
	([104.47.40.44]:57248
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj9H-0006a3-Dr
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:29:31 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:54:29 -0500
Message-ID: <148900646933.27090.3645480451819334521.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 19/20] target/i386: clear memory
 encryption bit when walking SEV guest page table
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

In SEV-enabled guest the pte entry will have C-bit set, we need to
clear the C-bit when walking the page table. The C-bit position should be
available in cpuid Fn8000_001f[EBX]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/helper.c  |   39 ++++++++++++++++++-----
 target/i386/monitor.c |   83 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 94 insertions(+), 28 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 05395d7..bbdef4d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "sysemu/kvm.h"
 #include "kvm_i386.h"
+#include "sysemu/sev.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
@@ -1029,6 +1030,22 @@ do_check_protect_pse36:
     return 1;
 }
 
+static uint64_t get_me_mask(void)
+{
+    uint64_t me_mask = 0;
+
+    /*
+     * When SEV is active, Fn8000_001F[EBX] Bit 0:5 contains the C-bit position
+     */
+    if (sev_enabled()) {
+        uint32_t pos;
+        pos = kvm_arch_get_supported_cpuid(kvm_state, 0x8000001f, 0, R_EBX);
+        me_mask = (1UL << (pos & 0x3f));
+    }
+
+    return ~me_mask;
+}
+
 hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -1037,6 +1054,12 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     uint64_t pte;
     uint32_t page_offset;
     int page_size;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
+
+    /* In SEV guest, CR3 will have memory encryption bit set, clear it */
+    env->cr[3] &= me_mask;
 
     if (!(env->cr[0] & CR0_PG_MASK)) {
         pte = addr & env->a20_mask;
@@ -1061,7 +1084,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             if (la57) {
                 pml5e_addr = ((env->cr[3] & ~0xfff) +
                         (((addr >> 48) & 0x1ff) << 3)) & env->a20_mask;
-                pml5e = ldq_phys_debug(cs, pml5e_addr);
+                pml5e = ldq_phys_debug(cs, pml5e_addr) & me_mask;
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     return -1;
                 }
@@ -1071,13 +1094,13 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
             pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
                     (((addr >> 39) & 0x1ff) << 3)) & env->a20_mask;
-            pml4e = ldq_phys_debug(cs, pml4e_addr);
+            pml4e = ldq_phys_debug(cs, pml4e_addr) & me_mask;
             if (!(pml4e & PG_PRESENT_MASK)) {
                 return -1;
             }
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) +
                          (((addr >> 30) & 0x1ff) << 3)) & env->a20_mask;
-            pdpe = ldq_phys_debug(cs, pdpe_addr);
+            pdpe = ldq_phys_debug(cs, pdpe_addr) & me_mask;
             if (!(pdpe & PG_PRESENT_MASK)) {
                 return -1;
             }
@@ -1092,14 +1115,14 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         {
             pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
                 env->a20_mask;
-            pdpe = ldq_phys_debug(cs, pdpe_addr);
+            pdpe = ldq_phys_debug(cs, pdpe_addr) & me_mask;
             if (!(pdpe & PG_PRESENT_MASK))
                 return -1;
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & env->a20_mask;
-        pde = ldq_phys_debug(cs, pde_addr);
+        pde = ldq_phys_debug(cs, pde_addr) & me_mask;
         if (!(pde & PG_PRESENT_MASK)) {
             return -1;
         }
@@ -1112,7 +1135,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             pte_addr = ((pde & PG_ADDRESS_MASK) +
                         (((addr >> 12) & 0x1ff) << 3)) & env->a20_mask;
             page_size = 4096;
-            pte = ldq_phys_debug(cs, pte_addr);
+            pte = ldq_phys_debug(cs, pte_addr) & me_mask;
         }
         if (!(pte & PG_PRESENT_MASK)) {
             return -1;
@@ -1122,7 +1145,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
         /* page directory entry */
         pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & env->a20_mask;
-        pde = ldl_phys_debug(cs, pde_addr);
+        pde = ldl_phys_debug(cs, pde_addr) & me_mask;
         if (!(pde & PG_PRESENT_MASK))
             return -1;
         if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -1131,7 +1154,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         } else {
             /* page directory entry */
             pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & env->a20_mask;
-            pte = ldl_phys_debug(cs, pte_addr);
+            pte = ldl_phys_debug(cs, pte_addr) & me_mask;
             if (!(pte & PG_PRESENT_MASK)) {
                 return -1;
             }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 7c39e05..04982fa 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -27,6 +27,7 @@
 #include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sev.h"
 #include "hmp.h"
 
 
@@ -59,6 +60,22 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                    pte & PG_RW_MASK ? 'W' : '-');
 }
 
+static uint64_t get_me_mask(void)
+{
+    uint64_t me_mask = 0;
+
+    /*
+     * When SEV is active, Fn8000_001F[EBX] Bit 0:5 contains the C-bit position
+     */
+    if (sev_enabled()) {
+        uint32_t pos;
+        pos = kvm_arch_get_supported_cpuid(kvm_state, 0x8000001f, 0, R_EBX);
+        me_mask = (1UL << (pos & 0x3f));
+    }
+
+    return ~me_mask;
+}
+
 static void tlb_info_32(Monitor *mon, CPUState *cs)
 {
     unsigned int l1, l2;
@@ -96,15 +113,19 @@ static void tlb_info_pae32(Monitor *mon, CPUState *cs)
     uint64_t pdp_addr, pd_addr, pt_addr;
     X86CPU *cpu = X86_CPU(cs);
     CPUArchState *env = &cpu->env;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     pdp_addr = env->cr[3] & ~0x1f;
+    pdp_addr &= me_mask;
     for (l1 = 0; l1 < 4; l1++) {
-        pdpe = ldq_phys_debug(cs, pdp_addr + l1 * 8);
+        pdpe = ldq_phys_debug(cs, pdp_addr + l1 * 8) & me_mask;
         pdpe = le64_to_cpu(pdpe);
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                pde = ldq_phys_debug(cs, pd_addr + l2 * 8);
+                pde = ldq_phys_debug(cs, pd_addr + l2 * 8) & me_mask;
                 pde = le64_to_cpu(pde);
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
@@ -114,7 +135,8 @@ static void tlb_info_pae32(Monitor *mon, CPUState *cs)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            pte = ldq_phys_debug(cs, pt_addr + l3 * 8);
+                            pte = ldq_phys_debug(cs, pt_addr + l3 * 8)
+                                        & me_mask;
                             pte = le64_to_cpu(pte);
                             if (pte & PG_PRESENT_MASK) {
                                 print_pte(mon, env, (l1 << 30) + (l2 << 21)
@@ -131,6 +153,7 @@ static void tlb_info_pae32(Monitor *mon, CPUState *cs)
 }
 
 #ifdef TARGET_X86_64
+
 static void tlb_info_la48(Monitor *mon, CPUState *cs,
         uint64_t l0, uint64_t pml4_addr)
 {
@@ -139,9 +162,12 @@ static void tlb_info_la48(Monitor *mon, CPUState *cs,
     uint64_t l1, l2, l3, l4;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     for (l1 = 0; l1 < 512; l1++) {
-        pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8);
+        pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8) & me_mask;
         pml4e = le64_to_cpu(pml4e);
         if (!(pml4e & PG_PRESENT_MASK)) {
             continue;
@@ -149,7 +175,7 @@ static void tlb_info_la48(Monitor *mon, CPUState *cs,
 
         pdp_addr = pml4e & 0x3fffffffff000ULL;
         for (l2 = 0; l2 < 512; l2++) {
-            pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8);
+            pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8) & me_mask;
             pdpe = le64_to_cpu(pdpe);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 continue;
@@ -164,7 +190,7 @@ static void tlb_info_la48(Monitor *mon, CPUState *cs,
 
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l3 = 0; l3 < 512; l3++) {
-                pde = ldq_phys_debug(cs, pd_addr + l3 * 8);
+                pde = ldq_phys_debug(cs, pd_addr + l3 * 8) & me_mask;
                 pde = le64_to_cpu(pde);
                 if (!(pde & PG_PRESENT_MASK)) {
                     continue;
@@ -179,7 +205,7 @@ static void tlb_info_la48(Monitor *mon, CPUState *cs,
 
                 pt_addr = pde & 0x3fffffffff000ULL;
                 for (l4 = 0; l4 < 512; l4++) {
-                    pte = ldq_phys_debug(cs, pt_addr + l4 * 8);
+                    pte = ldq_phys_debug(cs, pt_addr + l4 * 8) & me_mask;
                     pte = le64_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l0 << 48) + (l1 << 39) +
@@ -199,10 +225,14 @@ static void tlb_info_la57(Monitor *mon, CPUState *cs)
     uint64_t pml5_addr;
     X86CPU *cpu = X86_CPU(cs);
     CPUArchState *env = &cpu->env;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
+    pml5_addr &= me_mask;
     for (l0 = 0; l0 < 512; l0++) {
-        pml5e = ldq_phys_debug(cs, pml5_addr + l0 * 8);
+        pml5e = ldq_phys_debug(cs, pml5_addr + l0 * 8) & me_mask;
         pml5e = le64_to_cpu(pml5e);
         if (pml5e & PG_PRESENT_MASK) {
             tlb_info_la48(mon, cs, l0, pml5e & 0x3fffffffff000ULL);
@@ -322,18 +352,22 @@ static void mem_info_pae32(Monitor *mon, CPUState *cs)
     hwaddr start, end;
     X86CPU *cpu = X86_CPU(cs);
     CPUArchState *env = &cpu->env;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     pdp_addr = env->cr[3] & ~0x1f;
+    pdp_addr &= me_mask;
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 4; l1++) {
-        pdpe = ldq_phys_debug(cs, pdp_addr + l1 * 8);
+        pdpe = ldq_phys_debug(cs, pdp_addr + l1 * 8) & me_mask;
         pdpe = le64_to_cpu(pdpe);
         end = l1 << 30;
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                pde = ldq_phys_debug(cs, pd_addr + l2 * 8);
+                pde = ldq_phys_debug(cs, pd_addr + l2 * 8) & me_mask;
                 pde = le64_to_cpu(pde);
                 end = (l1 << 30) + (l2 << 21);
                 if (pde & PG_PRESENT_MASK) {
@@ -344,7 +378,8 @@ static void mem_info_pae32(Monitor *mon, CPUState *cs)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            pte = ldq_phys_debug(cs, pt_addr + l3 * 8);
+                            pte = ldq_phys_debug(cs, pt_addr + l3 * 8)
+                                        & me_mask;
                             pte = le64_to_cpu(pte);
                             end = (l1 << 30) + (l2 << 21) + (l3 << 12);
                             if (pte & PG_PRESENT_MASK) {
@@ -380,18 +415,22 @@ static void mem_info_la48(Monitor *mon, CPUState *cs)
     CPUArchState *env = &cpu->env;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     pml4_addr = env->cr[3] & 0x3fffffffff000ULL;
+    pml4_addr &= me_mask;
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 512; l1++) {
-        pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8);
+        pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8) & me_mask;
         pml4e = le64_to_cpu(pml4e);
         end = l1 << 39;
         if (pml4e & PG_PRESENT_MASK) {
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8);
+                pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8) & me_mask;
                 pdpe = le64_to_cpu(pdpe);
                 end = (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -403,7 +442,8 @@ static void mem_info_la48(Monitor *mon, CPUState *cs)
                     } else {
                         pd_addr = pdpe & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            pde = ldq_phys_debug(cs, pd_addr + l3 * 8);
+                            pde = ldq_phys_debug(cs, pd_addr + l3 * 8)
+                                        & me_mask;
                             pde = le64_to_cpu(pde);
                             end = (l1 << 39) + (l2 << 30) + (l3 << 21);
                             if (pde & PG_PRESENT_MASK) {
@@ -458,12 +498,15 @@ static void mem_info_la57(Monitor *mon, CPUState *cs)
     CPUArchState *env = &cpu->env;
     uint64_t pml5e, pml4e, pdpe, pde, pte;
     uint64_t pml5_addr, pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
+    uint64_t me_mask;
 
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
+    me_mask = get_me_mask();
+
+    pml5_addr = env->cr[3] & 0x3fffffffff000ULL & me_mask;
     last_prot = 0;
     start = -1;
     for (l0 = 0; l0 < 512; l0++) {
-        pml5e = ldq_phys_debug(cs, pml5_addr + l0 * 8);
+        pml5e = ldq_phys_debug(cs, pml5_addr + l0 * 8) & me_mask;
         pml4e = le64_to_cpu(pml5e);
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
@@ -474,7 +517,7 @@ static void mem_info_la57(Monitor *mon, CPUState *cs)
 
         pml4_addr = pml5e & 0x3fffffffff000ULL;
         for (l1 = 0; l1 < 512; l1++) {
-            pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8);
+            pml4e = ldq_phys_debug(cs, pml4_addr + l1 * 8) & me_mask;
             pml4e = le64_to_cpu(pml4e);
             end = (l0 << 48) + (l1 << 39);
             if (!(pml4e & PG_PRESENT_MASK)) {
@@ -485,7 +528,7 @@ static void mem_info_la57(Monitor *mon, CPUState *cs)
 
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8);
+                pdpe = ldq_phys_debug(cs, pdp_addr + l2 * 8) & me_mask;
                 pdpe = le64_to_cpu(pdpe);
                 end = (l0 << 48) + (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -504,7 +547,7 @@ static void mem_info_la57(Monitor *mon, CPUState *cs)
 
                 pd_addr = pdpe & 0x3fffffffff000ULL;
                 for (l3 = 0; l3 < 512; l3++) {
-                    pde = ldq_phys_debug(cs, pd_addr + l3 * 8);
+                    pde = ldq_phys_debug(cs, pd_addr + l3 * 8) & me_mask;
                     pde = le64_to_cpu(pde);
                     end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
                     if (pde & PG_PRESENT_MASK) {
@@ -523,7 +566,7 @@ static void mem_info_la57(Monitor *mon, CPUState *cs)
 
                     pt_addr = pde & 0x3fffffffff000ULL;
                     for (l4 = 0; l4 < 512; l4++) {
-                        pte = ldq_phys_debug(cs, pt_addr + l4 * 8);
+                        pte = ldq_phys_debug(cs, pt_addr + l4 * 8) & me_mask;
                         pte = le64_to_cpu(pte);
                         end = (l0 << 48) + (l1 << 39) + (l2 << 30) +
                             (l3 << 21) + (l4 << 12);

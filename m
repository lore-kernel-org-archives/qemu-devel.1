Received: from eggs.gnu.org ([2001:4830:134:3::10]:50193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfwI-0006oO-3e
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfwE-0002uf-ND
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:05:05 -0500
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com
	([104.47.41.73]:18336
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfwE-0002tn-Db
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:05:02 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:45 -0600
Message-Id: <20171206200346.116537-23-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 22/23] target/i386: clear C-bit when walking
 SEV guest page table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

In SEV-enabled guest the pte entry will have C-bit set, we need to
clear the C-bit when walking the page table. The C-bit position should
be available in cpuid Fn8000_001f[EBX]

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/helper.c  | 46 +++++++++++++++++++--------
 target/i386/monitor.c | 86 ++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 94 insertions(+), 38 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 5dc9e8839bc8..7dbbb9812950 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -723,6 +723,22 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+static uint64_t get_me_mask(void)
+{
+    uint64_t me_mask = 0;
+
+    /*
+     * When SEV is active, Fn8000_001F[EBX] Bit 0:5 contains the C-bit position
+     */
+    if (kvm_memcrypt_enabled()) {
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
@@ -732,6 +748,9 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int32_t a20_mask;
     uint32_t page_offset;
     int page_size;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     a20_mask = x86_get_a20_mask(env);
     if (!(env->cr[0] & CR0_PG_MASK)) {
@@ -755,25 +774,25 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & ~0xfff & me_mask) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                pml5e = ldq_phys_debug(cs, pml5e_addr);
+                pml5e = ldq_phys_debug(cs, pml5e_addr) & me_mask;
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     return -1;
                 }
             } else {
-                pml5e = env->cr[3];
+                pml5e = env->cr[3] & me_mask;
             }
 
             pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
                     (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            pml4e = ldq_phys_debug(cs, pml4e_addr);
+            pml4e = ldq_phys_debug(cs, pml4e_addr) & me_mask;
             if (!(pml4e & PG_PRESENT_MASK)) {
                 return -1;
             }
             pdpe_addr = ((pml4e & PG_ADDRESS_MASK) +
                          (((addr >> 30) & 0x1ff) << 3)) & a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
+            pdpe = ldq_phys_debug(cs, pdpe_addr) & me_mask;
             if (!(pdpe & PG_PRESENT_MASK)) {
                 return -1;
             }
@@ -786,16 +805,16 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         } else
 #endif
         {
-            pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
-                a20_mask;
-            pdpe = ldq_phys_debug(cs, pdpe_addr);
+            pdpe_addr = ((env->cr[3] & ~0x1f & me_mask) + ((addr >> 27) & 0x18))
+                          & a20_mask;
+            pdpe = ldq_phys_debug(cs, pdpe_addr) & me_mask;
             if (!(pdpe & PG_PRESENT_MASK))
                 return -1;
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
-        pde = ldq_phys_debug(cs, pde_addr);
+        pde = ldq_phys_debug(cs, pde_addr) & me_mask;
         if (!(pde & PG_PRESENT_MASK)) {
             return -1;
         }
@@ -808,7 +827,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             pte_addr = ((pde & PG_ADDRESS_MASK) +
                         (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
             page_size = 4096;
-            pte = ldq_phys_debug(cs, pte_addr);
+            pte = ldq_phys_debug(cs, pte_addr) & me_mask;
         }
         if (!(pte & PG_PRESENT_MASK)) {
             return -1;
@@ -817,8 +836,9 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         uint32_t pde;
 
         /* page directory entry */
-        pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
-        pde = ldl_phys_debug(cs, pde_addr);
+        pde_addr = ((env->cr[3] & ~0xfff & me_mask) + ((addr >> 20) & 0xffc))
+                     & a20_mask;
+        pde = ldl_phys_debug(cs, pde_addr) & me_mask;
         if (!(pde & PG_PRESENT_MASK))
             return -1;
         if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -827,7 +847,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         } else {
             /* page directory entry */
             pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & a20_mask;
-            pte = ldl_phys_debug(cs, pte_addr);
+            pte = ldl_phys_debug(cs, pte_addr) & me_mask;
             if (!(pte & PG_PRESENT_MASK)) {
                 return -1;
             }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 96890547f6b4..0b290f004a21 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -59,6 +59,22 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                    pte & PG_RW_MASK ? 'W' : '-');
 }
 
+static uint64_t get_me_mask(void)
+{
+    uint64_t me_mask = 0;
+
+    /*
+     * When SEV is active, Fn8000_001F[EBX] Bit 0:5 contains the C-bit position
+     */
+    if (kvm_memcrypt_enabled()) {
+        uint32_t pos;
+        pos = kvm_arch_get_supported_cpuid(kvm_state, 0x8000001f, 0, R_EBX);
+        me_mask = (1UL << (pos & 0x3f));
+    }
+
+    return ~me_mask;
+}
+
 static void tlb_info_32(Monitor *mon, CPUArchState *env)
 {
     unsigned int l1, l2;
@@ -93,16 +109,20 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
     unsigned int l1, l2, l3;
     uint64_t pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     pdp_addr = env->cr[3] & ~0x1f;
+    pdp_addr &= me_mask;
     for (l1 = 0; l1 < 4; l1++) {
         cpu_physical_memory_read_debug(pdp_addr + l1 * 8, &pdpe, 8);
-        pdpe = le64_to_cpu(pdpe);
+        pdpe = le64_to_cpu(pdpe & me_mask);
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
                 cpu_physical_memory_read_debug(pd_addr + l2 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
+                pde = le64_to_cpu(pde & me_mask);
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
                         /* 2M pages with PAE, CR4.PSE is ignored */
@@ -113,7 +133,7 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
                         for (l3 = 0; l3 < 512; l3++) {
                             cpu_physical_memory_read_debug(pt_addr + l3 * 8,
                                                            &pte, 8);
-                            pte = le64_to_cpu(pte);
+                            pte = le64_to_cpu(pte & me_mask);
                             if (pte & PG_PRESENT_MASK) {
                                 print_pte(mon, env, (l1 << 30) + (l2 << 21)
                                           + (l3 << 12),
@@ -135,10 +155,13 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
     uint64_t l1, l2, l3, l4;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
     for (l1 = 0; l1 < 512; l1++) {
         cpu_physical_memory_read_debug(pml4_addr + l1 * 8, &pml4e, 8);
-        pml4e = le64_to_cpu(pml4e);
+        pml4e = le64_to_cpu(pml4e & me_mask);
         if (!(pml4e & PG_PRESENT_MASK)) {
             continue;
         }
@@ -146,7 +169,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
         pdp_addr = pml4e & 0x3fffffffff000ULL;
         for (l2 = 0; l2 < 512; l2++) {
             cpu_physical_memory_read_debug(pdp_addr + l2 * 8, &pdpe, 8);
-            pdpe = le64_to_cpu(pdpe);
+            pdpe = le64_to_cpu(pdpe & me_mask);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 continue;
             }
@@ -161,7 +184,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l3 = 0; l3 < 512; l3++) {
                 cpu_physical_memory_read_debug(pd_addr + l3 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
+                pde = le64_to_cpu(pde & me_mask);
                 if (!(pde & PG_PRESENT_MASK)) {
                     continue;
                 }
@@ -176,7 +199,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
                 pt_addr = pde & 0x3fffffffff000ULL;
                 for (l4 = 0; l4 < 512; l4++) {
                     cpu_physical_memory_read_debug(pt_addr + l4 * 8, &pte, 8);
-                    pte = le64_to_cpu(pte);
+                    pte = le64_to_cpu(pte & me_mask);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l0 << 48) + (l1 << 39) +
                                 (l2 << 30) + (l3 << 21) + (l4 << 12),
@@ -193,11 +216,14 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
     uint64_t l0;
     uint64_t pml5e;
     uint64_t pml5_addr;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
+    pml5_addr = env->cr[3] & 0x3fffffffff000ULL & me_mask;
     for (l0 = 0; l0 < 512; l0++) {
         cpu_physical_memory_read_debug(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
+        pml5e = le64_to_cpu(pml5e & me_mask);
         if (pml5e & PG_PRESENT_MASK) {
             tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
         }
@@ -225,7 +251,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
             if (env->cr[4] & CR4_LA57_MASK) {
                 tlb_info_la57(mon, env);
             } else {
-                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL);
+                tlb_info_la48(mon, env, 0, env->cr[3] & 0x3fffffffff000ULL &
+                              get_me_mask());
             }
         } else
 #endif
@@ -309,19 +336,22 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
     uint64_t pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
     hwaddr start, end;
+    uint64_t me_mask;
 
-    pdp_addr = env->cr[3] & ~0x1f;
+    me_mask = get_me_mask();
+
+    pdp_addr = env->cr[3] & ~0x1f & me_mask;
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 4; l1++) {
         cpu_physical_memory_read_debug(pdp_addr + l1 * 8, &pdpe, 8);
-        pdpe = le64_to_cpu(pdpe);
+        pdpe = le64_to_cpu(pdpe & me_mask);
         end = l1 << 30;
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
                 cpu_physical_memory_read_debug(pd_addr + l2 * 8, &pde, 8);
-                pde = le64_to_cpu(pde);
+                pde = le64_to_cpu(pde & me_mask);
                 end = (l1 << 30) + (l2 << 21);
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
@@ -333,7 +363,7 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
                         for (l3 = 0; l3 < 512; l3++) {
                             cpu_physical_memory_read_debug(pt_addr + l3 * 8,
                                                            &pte, 8);
-                            pte = le64_to_cpu(pte);
+                            pte = le64_to_cpu(pte & me_mask);
                             end = (l1 << 30) + (l2 << 21) + (l3 << 12);
                             if (pte & PG_PRESENT_MASK) {
                                 prot = pte & pde & (PG_USER_MASK | PG_RW_MASK |
@@ -366,19 +396,22 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
     uint64_t l1, l2, l3, l4;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
-    pml4_addr = env->cr[3] & 0x3fffffffff000ULL;
+    pml4_addr = env->cr[3] & 0x3fffffffff000ULL & me_mask;
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 512; l1++) {
         cpu_physical_memory_read_debug(pml4_addr + l1 * 8, &pml4e, 8);
-        pml4e = le64_to_cpu(pml4e);
+        pml4e = le64_to_cpu(pml4e & me_mask);
         end = l1 << 39;
         if (pml4e & PG_PRESENT_MASK) {
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
                 cpu_physical_memory_read_debug(pdp_addr + l2 * 8, &pdpe, 8);
-                pdpe = le64_to_cpu(pdpe);
+                pdpe = le64_to_cpu(pdpe & me_mask);
                 end = (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
                     if (pdpe & PG_PSE_MASK) {
@@ -391,7 +424,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                         for (l3 = 0; l3 < 512; l3++) {
                             cpu_physical_memory_read_debug(pd_addr + l3 * 8,
                                                            &pde, 8);
-                            pde = le64_to_cpu(pde);
+                            pde = le64_to_cpu(pde & me_mask);
                             end = (l1 << 39) + (l2 << 30) + (l3 << 21);
                             if (pde & PG_PRESENT_MASK) {
                                 if (pde & PG_PSE_MASK) {
@@ -405,7 +438,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                                         cpu_physical_memory_read_debug(pt_addr
                                                                   + l4 * 8,
                                                                   &pte, 8);
-                                        pte = le64_to_cpu(pte);
+                                        pte = le64_to_cpu(pte & me_mask);
                                         end = (l1 << 39) + (l2 << 30) +
                                             (l3 << 21) + (l4 << 12);
                                         if (pte & PG_PRESENT_MASK) {
@@ -444,13 +477,16 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
     uint64_t l0, l1, l2, l3, l4;
     uint64_t pml5e, pml4e, pdpe, pde, pte;
     uint64_t pml5_addr, pml4_addr, pdp_addr, pd_addr, pt_addr, start, end;
+    uint64_t me_mask;
+
+    me_mask = get_me_mask();
 
-    pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
+    pml5_addr = env->cr[3] & 0x3fffffffff000ULL & me_mask;
     last_prot = 0;
     start = -1;
     for (l0 = 0; l0 < 512; l0++) {
         cpu_physical_memory_read_debug(pml5_addr + l0 * 8, &pml5e, 8);
-        pml5e = le64_to_cpu(pml5e);
+        pml5e = le64_to_cpu(pml5e & me_mask);
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
             prot = 0;
@@ -461,7 +497,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
         pml4_addr = pml5e & 0x3fffffffff000ULL;
         for (l1 = 0; l1 < 512; l1++) {
             cpu_physical_memory_read_debug(pml4_addr + l1 * 8, &pml4e, 8);
-            pml4e = le64_to_cpu(pml4e);
+            pml4e = le64_to_cpu(pml4e & me_mask);
             end = (l0 << 48) + (l1 << 39);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 prot = 0;
@@ -472,7 +508,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
                 cpu_physical_memory_read_debug(pdp_addr + l2 * 8, &pdpe, 8);
-                pdpe = le64_to_cpu(pdpe);
+                pdpe = le64_to_cpu(pdpe & me_mask);
                 end = (l0 << 48) + (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
                     prot = 0;
@@ -491,7 +527,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                 pd_addr = pdpe & 0x3fffffffff000ULL;
                 for (l3 = 0; l3 < 512; l3++) {
                     cpu_physical_memory_read_debug(pd_addr + l3 * 8, &pde, 8);
-                    pde = le64_to_cpu(pde);
+                    pde = le64_to_cpu(pde & me_mask);
                     end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
                     if (pde & PG_PRESENT_MASK) {
                         prot = 0;
@@ -510,7 +546,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                     pt_addr = pde & 0x3fffffffff000ULL;
                     for (l4 = 0; l4 < 512; l4++) {
                         cpu_physical_memory_read_debug(pt_addr + l4 * 8, &pte, 8);
-                        pte = le64_to_cpu(pte);
+                        pte = le64_to_cpu(pte & me_mask);
                         end = (l0 << 48) + (l1 << 39) + (l2 << 30) +
                             (l3 << 21) + (l4 << 12);
                         if (pte & PG_PRESENT_MASK) {
-- 
2.9.5

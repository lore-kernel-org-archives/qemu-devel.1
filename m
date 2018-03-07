Received: from eggs.gnu.org ([2001:4830:134:3::10]:50215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHZ-0004bP-36
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etcHV-0008C2-2t
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:13 -0500
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com
	([104.47.38.86]:21159
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etcHU-0008Be-RI
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:51:08 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Mar 2018 10:50:14 -0600
Message-Id: <20180307165038.88640-5-brijesh.singh@amd.com>
In-Reply-To: <20180307165038.88640-1-brijesh.singh@amd.com>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 04/28] monitor/i386: use debug APIs when
 accessing guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

Updates HMP commands to use the debug version of APIs when accessing the
guest memory.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 cpus.c                |  2 +-
 disas.c               |  2 +-
 monitor.c             |  6 +++---
 target/i386/helper.c  | 14 ++++++------
 target/i386/monitor.c | 60 +++++++++++++++++++++++++++------------------------
 5 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/cpus.c b/cpus.c
index 4f5f88edba9e..e88d33210101 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2268,7 +2268,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
         l = sizeof(buf);
         if (l > size)
             l = size;
-        cpu_physical_memory_read(addr, buf, l);
+        cpu_physical_memory_read_debug(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
             error_setg(errp, QERR_IO_ERROR);
             goto exit;
diff --git a/disas.c b/disas.c
index d4ad1089efb3..fcedbf263302 100644
--- a/disas.c
+++ b/disas.c
@@ -586,7 +586,7 @@ static int
 physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
 {
-    cpu_physical_memory_read(memaddr, myaddr, length);
+    cpu_physical_memory_read_debug(memaddr, myaddr, length);
     return 0;
 }
 
diff --git a/monitor.c b/monitor.c
index a4417f26cde3..3f4ba902266b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1368,7 +1368,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
         if (l > line_size)
             l = line_size;
         if (is_physical) {
-            cpu_physical_memory_read(addr, buf, l);
+            cpu_physical_memory_read_debug(addr, buf, l);
         } else {
             if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
                 monitor_printf(mon, " Cannot access memory\n");
@@ -1574,8 +1574,8 @@ static void hmp_sum(Monitor *mon, const QDict *qdict)
 
     sum = 0;
     for(addr = start; addr < (start + size); addr++) {
-        uint8_t val = address_space_ldub(&address_space_memory, addr,
-                                         MEMTXATTRS_UNSPECIFIED, NULL);
+        uint8_t val;
+        cpu_physical_memory_read_debug(addr, &val, 1);
         /* BSD sum algorithm ('sum' Unix command) */
         sum = (sum >> 1) | (sum << 15);
         sum += val;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 9fba146b7fb0..58fb6eec562a 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -757,7 +757,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             if (la57) {
                 pml5e_addr = ((env->cr[3] & ~0xfff) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
-                pml5e = x86_ldq_phys(cs, pml5e_addr);
+                pml5e = ldq_phys_debug(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     return -1;
                 }
@@ -767,7 +767,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
             pml4e_addr = ((pml5e & PG_ADDRESS_MASK) +
                     (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
-            pml4e = x86_ldq_phys(cs, pml4e_addr);
+            pml4e = ldq_phys_debug(cs, pml4e_addr);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 return -1;
             }
@@ -788,14 +788,14 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         {
             pdpe_addr = ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18)) &
                 a20_mask;
-            pdpe = x86_ldq_phys(cs, pdpe_addr);
+            pdpe = ldq_phys_debug(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK))
                 return -1;
         }
 
         pde_addr = ((pdpe & PG_ADDRESS_MASK) +
                     (((addr >> 21) & 0x1ff) << 3)) & a20_mask;
-        pde = x86_ldq_phys(cs, pde_addr);
+        pde = ldq_phys_debug(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             return -1;
         }
@@ -808,7 +808,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
             pte_addr = ((pde & PG_ADDRESS_MASK) +
                         (((addr >> 12) & 0x1ff) << 3)) & a20_mask;
             page_size = 4096;
-            pte = x86_ldq_phys(cs, pte_addr);
+            pte = ldq_phys_debug(cs, pte_addr);
         }
         if (!(pte & PG_PRESENT_MASK)) {
             return -1;
@@ -818,7 +818,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
         /* page directory entry */
         pde_addr = ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
-        pde = x86_ldl_phys(cs, pde_addr);
+        pde = ldl_phys_debug(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK))
             return -1;
         if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -827,7 +827,7 @@ hwaddr x86_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         } else {
             /* page directory entry */
             pte_addr = ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) & a20_mask;
-            pte = x86_ldl_phys(cs, pte_addr);
+            pte = ldl_phys_debug(cs, pte_addr);
             if (!(pte & PG_PRESENT_MASK)) {
                 return -1;
             }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 75429129fde0..55ea10deb8ef 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -68,7 +68,7 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
 
     pgd = env->cr[3] & ~0xfff;
     for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        cpu_physical_memory_read_debug(pgd + l1 * 4, &pde, 4);
         pde = le32_to_cpu(pde);
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -76,7 +76,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
                 print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    cpu_physical_memory_read_debug((pde & ~0xfff) + l2 * 4,
+                                                   &pte, 4);
                     pte = le32_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l1 << 22) + (l2 << 12),
@@ -97,12 +98,12 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
 
     pdp_addr = env->cr[3] & ~0x1f;
     for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        cpu_physical_memory_read_debug(pdp_addr + l1 * 8, &pdpe, 8);
         pdpe = le64_to_cpu(pdpe);
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                cpu_physical_memory_read_debug(pd_addr + l2 * 8, &pde, 8);
                 pde = le64_to_cpu(pde);
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
@@ -112,7 +113,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            cpu_physical_memory_read_debug(pt_addr + l3 * 8,
+                                                           &pte, 8);
                             pte = le64_to_cpu(pte);
                             if (pte & PG_PRESENT_MASK) {
                                 print_pte(mon, env, (l1 << 30) + (l2 << 21)
@@ -137,7 +139,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
     uint64_t pdp_addr, pd_addr, pt_addr;
 
     for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        cpu_physical_memory_read_debug(pml4_addr + l1 * 8, &pml4e, 8);
         pml4e = le64_to_cpu(pml4e);
         if (!(pml4e & PG_PRESENT_MASK)) {
             continue;
@@ -145,7 +147,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
         pdp_addr = pml4e & 0x3fffffffff000ULL;
         for (l2 = 0; l2 < 512; l2++) {
-            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+            cpu_physical_memory_read_debug(pdp_addr + l2 * 8, &pdpe, 8);
             pdpe = le64_to_cpu(pdpe);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 continue;
@@ -160,7 +162,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l3 = 0; l3 < 512; l3++) {
-                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                cpu_physical_memory_read_debug(pd_addr + l3 * 8, &pde, 8);
                 pde = le64_to_cpu(pde);
                 if (!(pde & PG_PRESENT_MASK)) {
                     continue;
@@ -175,9 +177,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
                 pt_addr = pde & 0x3fffffffff000ULL;
                 for (l4 = 0; l4 < 512; l4++) {
-                    cpu_physical_memory_read(pt_addr
-                            + l4 * 8,
-                            &pte, 8);
+                    cpu_physical_memory_read_debug(pt_addr + l4 * 8, &pte, 8);
                     pte = le64_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l0 << 48) + (l1 << 39) +
@@ -198,7 +198,7 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
 
     pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
     for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        cpu_physical_memory_read_debug(pml5_addr + l0 * 8, &pml5e, 8);
         pml5e = le64_to_cpu(pml5e);
         if (pml5e & PG_PRESENT_MASK) {
             tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
@@ -273,7 +273,7 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        cpu_physical_memory_read_debug(pgd + l1 * 4, &pde, 4);
         pde = le32_to_cpu(pde);
         end = l1 << 22;
         if (pde & PG_PRESENT_MASK) {
@@ -282,7 +282,8 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
                 mem_print(mon, &start, &last_prot, end, prot);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    cpu_physical_memory_read_debug((pde & ~0xfff) + l2 * 4,
+                                                   &pte, 4);
                     pte = le32_to_cpu(pte);
                     end = (l1 << 22) + (l2 << 12);
                     if (pte & PG_PRESENT_MASK) {
@@ -315,13 +316,13 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        cpu_physical_memory_read_debug(pdp_addr + l1 * 8, &pdpe, 8);
         pdpe = le64_to_cpu(pdpe);
         end = l1 << 30;
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                cpu_physical_memory_read_debug(pd_addr + l2 * 8, &pde, 8);
                 pde = le64_to_cpu(pde);
                 end = (l1 << 30) + (l2 << 21);
                 if (pde & PG_PRESENT_MASK) {
@@ -332,7 +333,8 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            cpu_physical_memory_read_debug(pt_addr + l3 * 8,
+                                                           &pte, 8);
                             pte = le64_to_cpu(pte);
                             end = (l1 << 30) + (l2 << 21) + (l3 << 12);
                             if (pte & PG_PRESENT_MASK) {
@@ -371,13 +373,13 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        cpu_physical_memory_read_debug(pml4_addr + l1 * 8, &pml4e, 8);
         pml4e = le64_to_cpu(pml4e);
         end = l1 << 39;
         if (pml4e & PG_PRESENT_MASK) {
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+                cpu_physical_memory_read_debug(pdp_addr + l2 * 8, &pdpe, 8);
                 pdpe = le64_to_cpu(pdpe);
                 end = (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -389,7 +391,8 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                     } else {
                         pd_addr = pdpe & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                            cpu_physical_memory_read_debug(pd_addr + l3 * 8,
+                                                           &pde, 8);
                             pde = le64_to_cpu(pde);
                             end = (l1 << 39) + (l2 << 30) + (l3 << 21);
                             if (pde & PG_PRESENT_MASK) {
@@ -401,9 +404,9 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                                 } else {
                                     pt_addr = pde & 0x3fffffffff000ULL;
                                     for (l4 = 0; l4 < 512; l4++) {
-                                        cpu_physical_memory_read(pt_addr
-                                                                 + l4 * 8,
-                                                                 &pte, 8);
+                                        cpu_physical_memory_read_debug(pt_addr
+                                                                  + l4 * 8,
+                                                                  &pte, 8);
                                         pte = le64_to_cpu(pte);
                                         end = (l1 << 39) + (l2 << 30) +
                                             (l3 << 21) + (l4 << 12);
@@ -448,7 +451,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        cpu_physical_memory_read_debug(pml5_addr + l0 * 8, &pml5e, 8);
         pml5e = le64_to_cpu(pml5e);
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
@@ -459,7 +462,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
         pml4_addr = pml5e & 0x3fffffffff000ULL;
         for (l1 = 0; l1 < 512; l1++) {
-            cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+            cpu_physical_memory_read_debug(pml4_addr + l1 * 8, &pml4e, 8);
             pml4e = le64_to_cpu(pml4e);
             end = (l0 << 48) + (l1 << 39);
             if (!(pml4e & PG_PRESENT_MASK)) {
@@ -470,7 +473,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+                cpu_physical_memory_read_debug(pdp_addr + l2 * 8, &pdpe, 8);
                 pdpe = le64_to_cpu(pdpe);
                 end = (l0 << 48) + (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -489,7 +492,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
                 pd_addr = pdpe & 0x3fffffffff000ULL;
                 for (l3 = 0; l3 < 512; l3++) {
-                    cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                    cpu_physical_memory_read_debug(pd_addr + l3 * 8, &pde, 8);
                     pde = le64_to_cpu(pde);
                     end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
                     if (pde & PG_PRESENT_MASK) {
@@ -508,7 +511,8 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
                     pt_addr = pde & 0x3fffffffff000ULL;
                     for (l4 = 0; l4 < 512; l4++) {
-                        cpu_physical_memory_read(pt_addr + l4 * 8, &pte, 8);
+                        cpu_physical_memory_read_debug(pt_addr + l4 * 8,
+                                                       &pte, 8);
                         pte = le64_to_cpu(pte);
                         end = (l0 << 48) + (l1 << 39) + (l2 << 30) +
                             (l3 << 21) + (l4 << 12);
-- 
2.14.3

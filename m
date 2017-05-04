Received: from eggs.gnu.org ([2001:4830:134:3::10]:56811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651n-0001KZ-BS
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d651k-0005wf-8o
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:53:55 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d651k-0005wO-3c
	for qemu-devel@nongnu.org; Wed, 03 May 2017 20:53:52 -0400
Received: by mail-pf0-x244.google.com with SMTP id o68so716235pfj.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 17:53:51 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Thu,  4 May 2017 09:53:19 +0900
Message-Id: <461a4b944f7e036b2f6bd1fce83ad4fe09e5e2bc.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
In-Reply-To: <cover.1493858877.git.shorne@gmail.com>
References: <cover.1493858877.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 04/11] target/openrisc: Fixes for memory
 debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stafford Horne <shorne@gmail.com>

When debugging in gdb you might want to inspect instructions in mapped
pages or in exception vectors like 0x800 etc.  This was previously not
possible in qemu since the *get_phys_page_debug() routine only looked
into the data tlb.

Change to fall back to look into instruction tlb and plain physical
pages.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/mmu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 56b11d3..ce2a29d 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -124,7 +124,7 @@ static int cpu_openrisc_get_phys_addr(OpenRISCCPU *cpu,
 {
     int ret = TLBRET_MATCH;
 
-    if (rw == 2) {    /* ITLB */
+    if (rw == MMU_INST_FETCH) {    /* ITLB */
        *physical = 0;
         ret = cpu->env.tlb->cpu_openrisc_map_address_code(cpu, physical,
                                                           prot, address, rw);
@@ -221,12 +221,28 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     hwaddr phys_addr;
     int prot;
+    int miss;
 
-    if (cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr, 0)) {
-        return -1;
+    /* Check memory for any kind of address, since during debug the
+       gdb can ask for anything, check data tlb for address */
+    miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr, 0);
+
+    /* Check instruction tlb */
+    if (miss) {
+        miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr,
+                                          MMU_INST_FETCH);
+    }
+
+    /* Last, fall back to a plain address */
+    if (miss) {
+        miss = cpu_openrisc_get_phys_nommu(cpu, &phys_addr, &prot, addr, 0);
     }
 
-    return phys_addr;
+    if (miss) {
+        return -1;
+    } else {
+        return phys_addr;
+    }
 }
 
 void cpu_openrisc_mmu_init(OpenRISCCPU *cpu)
-- 
2.9.3

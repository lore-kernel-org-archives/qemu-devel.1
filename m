Received: from eggs.gnu.org ([2001:4830:134:3::10]:60381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3S-0001uP-Si
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3R-0006Vp-4M
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:02 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3Q-0006VU-Uu
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:01 -0400
Received: by mail-pf0-x244.google.com with SMTP id v14so25734945pfd.3
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:15:00 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:18 +0900
Message-Id: <d7f2141c62e684e5156892055e43d36194b4ff25.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL 04/11] target/openrisc: Fixes for memory
 debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

When debugging in gdb you might want to inspect instructions in mapped
pages or in exception vectors like 0x800 etc.  This was previously not
possible in qemu since the *get_phys_page_debug() routine only looked
into the data tlb.

Change to fall back to look into instruction tlb and plain physical
pages.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/mmu.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index 56b11d3..a6d7bcd 100644
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
@@ -221,12 +221,27 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
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
+        miss = cpu_openrisc_get_phys_addr(cpu, &phys_addr, &prot, addr, MMU_INST_FETCH);
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eHOb3-0007hR-NK
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 01:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eHOb0-0006e8-J2
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 01:33:21 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1eHOb0-0006dM-DC
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 01:33:18 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed, 22 Nov 2017 07:32:50 +0100
Message-Id: <20171122063250.7674-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH] Remove MemoryRegionSection check code from
 sparc_cpu_get_phys_page_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

This code is preventing the MMU debug code from displaying virtual
mappings of IO devices (anything that is not located in the RAM).

Before this patch, Qemu would output 0xffffffffffffffff (-1) as the
physical address corresponding to a IO device virtual address.

With this patch the intended physical adresse is displayed.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 target/sparc/mmu_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index d5b6c1e48c..f2d2250e7a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -857,18 +857,12 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     CPUSPARCState *env = &cpu->env;
     hwaddr phys_addr;
     int mmu_idx = cpu_mmu_index(env, false);
-    MemoryRegionSection section;
 
     if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 2, mmu_idx) != 0) {
         if (cpu_sparc_get_phys_page(env, &phys_addr, addr, 0, mmu_idx) != 0) {
             return -1;
         }
     }
-    section = memory_region_find(get_system_memory(), phys_addr, 1);
-    memory_region_unref(section.mr);
-    if (!int128_nz(section.size)) {
-        return -1;
-    }
     return phys_addr;
 }
 #endif
-- 
2.14.1

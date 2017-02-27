Received: from eggs.gnu.org ([2001:4830:134:3::10]:35244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc9-0000hY-VH
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciDc8-0006kw-Og
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:12:49 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 27 Feb 2017 16:12:39 +1100
Message-Id: <20170227051239.2680-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170227051239.2680-1-david@gibson.dropbear.id.au>
References: <20170227051239.2680-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 9/9] target/ppc: Correct SDR1 masking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, aik@ozlabs.ru, sjitindarsingh@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

SDR_64_HTABORG, which indicates the bits of the SDR1 register to use for
the base of a 64-bit machine's hashed page table (HPT) isn't correct.  It
includes the top 46 bits of the register, but in fact the top 4 bits must
be zero (according to the ISA v2.07).  No actual implementation has
supported close to 2^60 bytes of physical address space, so it's kind of
irrelevant, but we might as well correct this.

In addition, although we checked for bad size values in SDR1, we never
reported an error if entirely invalid bits were set there.  Add this check
to ppc_store_sdr1().

Reported-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.h | 2 +-
 target/ppc/mmu_helper.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 9c74823..54f1e37 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -56,7 +56,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
  * Hash page table definitions
  */
 
-#define SDR_64_HTABORG         0xFFFFFFFFFFFC0000ULL
+#define SDR_64_HTABORG         0x0FFFFFFFFFFC0000ULL
 #define SDR_64_HTABSIZE        0x000000000000001FULL
 
 #define HPTES_PER_GROUP         8
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 3bc8030..a1af3d6 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -2007,8 +2007,14 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
     assert(!cpu->vhyp);
 #if defined(TARGET_PPC64)
     if (env->mmu_model & POWERPC_MMU_64) {
+        target_ulong sdr_mask = SDR_64_HTABORG | SDR_64_HTABSIZE;
         target_ulong htabsize = value & SDR_64_HTABSIZE;
 
+        if (value & ~sdr_mask) {
+            error_report("Invalid bits 0x"TARGET_FMT_lx" set in SDR1",
+                         value & ~sdr_mask);
+            value &= sdr_mask;
+        }
         if (htabsize > 28) {
             error_report("Invalid HTABSIZE 0x" TARGET_FMT_lx" stored in SDR1",
                          htabsize);
-- 
2.9.3

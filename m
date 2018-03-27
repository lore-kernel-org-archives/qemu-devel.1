Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gNM-00029d-Jv
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f0gNJ-0002us-HM
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:38:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 27 Mar 2018 15:37:40 +1100
Message-Id: <20180327043741.7705-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180327043741.7705-1-david@gibson.dropbear.id.au>
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 11/12] target/ppc: Remove unnecessary
 POWERPC_MMU_V3 flag from mmu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The only place we test this flag is in conjunction with
ppc64_use_proc_tbl().  That checks for the LPCR_UPRT bit, which we already
ensure can't be set except on a machine with a v3 MMU (i.e. POWER9).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-qom.h    | 4 +---
 target/ppc/mmu-hash64.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 2bd58b2a84..ef96d42cf2 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -68,7 +68,6 @@ enum powerpc_mmu_t {
     /* PowerPC 601 MMU model (specific BATs format)            */
     POWERPC_MMU_601        = 0x0000000A,
 #define POWERPC_MMU_64       0x00010000
-#define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
     /* 64 bits PowerPC MMU                                     */
     POWERPC_MMU_64B        = POWERPC_MMU_64 | 0x00000001,
     /* Architecture 2.03 and later (has LPCR) */
@@ -78,8 +77,7 @@ enum powerpc_mmu_t {
     /* Architecture 2.07 variant                               */
     POWERPC_MMU_2_07       = POWERPC_MMU_64 | 0x00000004,
     /* Architecture 3.00 variant                               */
-    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_V3
-                             | 0x00000005,
+    POWERPC_MMU_3_00       = POWERPC_MMU_64 | 0x00000005,
 };
 #define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
 #define POWERPC_MMU_VER_64B POWERPC_MMU_VER(POWERPC_MMU_64B)
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 3b00bdee91..d964f2f5b0 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -761,7 +761,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
     slb = slb_lookup(cpu, eaddr);
     if (!slb) {
         /* No entry found, check if in-memory segment tables are in use */
-        if ((env->mmu_model & POWERPC_MMU_V3) && ppc64_use_proc_tbl(cpu)) {
+        if (ppc64_use_proc_tbl(cpu)) {
             /* TODO - Unsupported */
             error_report("Segment Table Support Unimplemented");
             exit(1);
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caliborn@SDF.ORG>) id 1cW6ez-00059v-BF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caliborn@SDF.ORG>) id 1cW6ev-0002BM-Vw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:21:41 -0500
Date: Tue, 24 Jan 2017 18:56:32 +0000 (UTC)
From: Valentin Plotkin <caliborn@SDF.ORG>
Message-ID: <Pine.NEB.4.64.1701241855380.2138@sdf.lonestar.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Qemu-devel] [PATCH] PPC: MMU compatibility check.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org



Hi everyone,

I looked at the "qemu-system-ppc -nographic -cpu G2leGP3 -M ppce500" on 
the BiteSizedTasks page. The segfault was caused by machine initialization 
code which expected a certain MMU model, checked, so unused SPR were read, 
returning zeros. bamboo and virtex machines are affected as well, but it 
doesn't always cause segfault, usually running into unmapped memory and 
failing somewhat more nicely.

I added the checks. It would be possible to add support for other MMU 
models, but I'm not sure if there is any point (would any guest OS support 
mutually exclusive CPU and machine)?

---
  hw/ppc/e500.c          | 5 +++++
  hw/ppc/ppc440_bamboo.c | 5 +++++
  hw/ppc/virtex_ml507.c  | 5 +++++
  3 files changed, 15 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index cf8b122..cd352f6 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -631,6 +631,11 @@ static uint64_t mmubooke_initial_mapsize(CPUPPCState 
*env)

  static void mmubooke_create_initial_mapping(CPUPPCState *env)
  {
+    if(env->mmu_model!=POWERPC_MMU_BOOKE206){
+        fprintf(stderr,"MMU model %i not supported by this machine.\n", 
env->mmu_model);
+        exit(-1);
+    }
+
      ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 0);
      hwaddr size;
      int ps;
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 5c535b1..61e7028 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -124,6 +124,11 @@ static void 
mmubooke_create_initial_mapping(CPUPPCState *env,
                                       target_ulong va,
                                       hwaddr pa)
  {
+    if(env->mmu_model!=POWERPC_MMU_BOOKE){
+        fprintf(stderr,"MMU model %i not supported by this machine.\n", 
env->mmu_model);
+        exit(-1);
+    }
+
      ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];

      tlb->attr = 0;
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index b97d966..4041ff3 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -69,6 +69,11 @@ static void mmubooke_create_initial_mapping(CPUPPCState 
*env,
                                       target_ulong va,
                                       hwaddr pa)
  {
+    if(env->mmu_model!=POWERPC_MMU_BOOKE){
+        fprintf(stderr,"MMU model %i not supported by this machine.\n", 
env->mmu_model);
+        exit(-1);
+    }
+
      ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];

      tlb->attr = 0;
-- 
2.5.5

Valentin Plotkin
caliborn@sdf.org
SDF Public Access UNIX System - http://sdf.org

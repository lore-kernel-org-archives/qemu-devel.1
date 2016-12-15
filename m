Received: from eggs.gnu.org ([2001:4830:134:3::10]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC8-0003qD-Ez
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC5-0001TJ-Aw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC5-0001SF-2O
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jpKx130476
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:43 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku130e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:43 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:42 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:38 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-45-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 44/67] target-ppc: Fix CPU migration from
 qemu-2.6 <-> later versions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: David Gibson <david@gibson.dropbear.id.au>

When migration for target-ppc was converted to vmstate, several
VMSTATE_EQUAL() checks were foolishly included of things that really
should be internal state.  Specifically we verified equality of the
insns_flags and insns_flags2 fields, which are used within TCG to
determine which groups of instructions are available on this cpu
model.  Between qemu-2.6 and qemu-2.7 we made some changes to these
classes which broke migration.

This path fixes migration both forwards and backwards.  On migration
from 2.6 to later versions we import the fields into teporary
variables, which we then ignore.  In migration backwards, we populate
the temporary fields from the runtime fields, but mask out the bits
which were added after qemu-2.6, allowing the VMSTATE_EQUAL in
qemu-2.6 to accept the stream.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
(cherry picked from commit 16a2497bd44cac1856e259654fd304079bd1dcdc)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target-ppc/cpu.h     |  6 ++++++
 target-ppc/machine.c | 29 +++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/target-ppc/cpu.h b/target-ppc/cpu.h
index 786ab5c..d4d1509 100644
--- a/target-ppc/cpu.h
+++ b/target-ppc/cpu.h
@@ -1164,6 +1164,12 @@ struct PowerPCCPU {
     int cpu_dt_id;
     uint32_t max_compat;
     uint32_t cpu_version;
+
+    /* fields used only during migration for compatibility hacks */
+    target_ulong mig_msr_mask;
+    uint64_t mig_insns_flags;
+    uint64_t mig_insns_flags2;
+    uint32_t mig_nb_BATs;
 };
 
 static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
diff --git a/target-ppc/machine.c b/target-ppc/machine.c
index 4820f22..56a59e0 100644
--- a/target-ppc/machine.c
+++ b/target-ppc/machine.c
@@ -141,6 +141,21 @@ static void cpu_pre_save(void *opaque)
     PowerPCCPU *cpu = opaque;
     CPUPPCState *env = &cpu->env;
     int i;
+    uint64_t insns_compat_mask =
+        PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MFTB
+        | PPC_FLOAT | PPC_FLOAT_FSEL | PPC_FLOAT_FRES
+        | PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE | PPC_FLOAT_FRSQRTES
+        | PPC_FLOAT_STFIWX | PPC_FLOAT_EXT
+        | PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ
+        | PPC_MEM_SYNC | PPC_MEM_EIEIO | PPC_MEM_TLBIE | PPC_MEM_TLBSYNC
+        | PPC_64B | PPC_64BX | PPC_ALTIVEC
+        | PPC_SEGMENT_64B | PPC_SLBI | PPC_POPCNTB | PPC_POPCNTWD;
+    uint64_t insns_compat_mask2 = PPC2_VSX | PPC2_VSX207 | PPC2_DFP | PPC2_DBRX
+        | PPC2_PERM_ISA206 | PPC2_DIVE_ISA206
+        | PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206
+        | PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207
+        | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207
+        | PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_TM;
 
     env->spr[SPR_LR] = env->lr;
     env->spr[SPR_CTR] = env->ctr;
@@ -162,6 +177,12 @@ static void cpu_pre_save(void *opaque)
         env->spr[SPR_IBAT4U + 2*i] = env->IBAT[0][i+4];
         env->spr[SPR_IBAT4U + 2*i + 1] = env->IBAT[1][i+4];
     }
+
+    /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
+    cpu->mig_msr_mask = env->msr_mask;
+    cpu->mig_insns_flags = env->insns_flags & insns_compat_mask;
+    cpu->mig_insns_flags2 = env->insns_flags2 & insns_compat_mask2;
+    cpu->mig_nb_BATs = env->nb_BATs;
 }
 
 static int cpu_post_load(void *opaque, int version_id)
@@ -562,10 +583,10 @@ const VMStateDescription vmstate_ppc_cpu = {
         /* FIXME: access_type? */
 
         /* Sanity checking */
-        VMSTATE_UINTTL_EQUAL(env.msr_mask, PowerPCCPU),
-        VMSTATE_UINT64_EQUAL(env.insns_flags, PowerPCCPU),
-        VMSTATE_UINT64_EQUAL(env.insns_flags2, PowerPCCPU),
-        VMSTATE_UINT32_EQUAL(env.nb_BATs, PowerPCCPU),
+        VMSTATE_UINTTL(mig_msr_mask, PowerPCCPU),
+        VMSTATE_UINT64(mig_insns_flags, PowerPCCPU),
+        VMSTATE_UINT64(mig_insns_flags2, PowerPCCPU),
+        VMSTATE_UINT32(mig_nb_BATs, PowerPCCPU),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
-- 
1.9.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3drB-0007j8-SU
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3drA-0005EG-Jw
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:28:53 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 27 Apr 2017 17:28:43 +1000
Message-Id: <20170427072843.8089-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170427072843.8089-1-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 4/4] ppc: Rework CPU compatibility testing
 across migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Cc: agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Migrating between different CPU versions is a bit complicated for ppc.
A long time ago, we ensured identical CPU versions at either end by
checking the PVR had the same value.  However, this breaks under KVM
HV, because we always have to use the host's PVR - it's not
virtualized.  That would mean we couldn't migrate between hosts with
different PVRs, even if the CPUs are close enough to compatible in
practice (sometimes identical cores with different surrounding logic
have different PVRs, so this happens in practice quite often).

So, we removed the PVR check, but instead checked that several flags
indicating supported instructions matched.  This turns out to be a bad
idea, because those instruction masks are not architected information, but
essentially a TCG implementation detail.  So changes to qemu internal CPU
modelling can break migration - this happened between qemu-2.6 and
qemu-2.7.  That was addressed by 146c11f1 "target-ppc: Allow eventual
removal of old migration mistakes".

Now, verification of CPU compatibility across a migration basically doesn't
happen.  We simply ignore the PVR of the incoming migration, and hope the
cpu on the destination is close enough to work.

Now that we've cleaned up handling of processor compatibility modes for
pseries machine type, we can do better.  We allow migration if:

    * The source and destination PVRs are for the same type of CPU, as
      determined by CPU class's pvr_match function
OR  * When the source was in a compatibility mode, and the destination CPU
      supports the same compatibility mode

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/machine.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 6cb3a48..20a46c9 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -8,6 +8,7 @@
 #include "helper_regs.h"
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
+#include "qapi/error.h"
 
 static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
 {
@@ -195,6 +196,30 @@ static void cpu_pre_save(void *opaque)
     }
 }
 
+/*
+ * Determine if a given PVR is a "close enough" match to the CPU
+ * object.  For TCG and KVM PR it would probably be sufficient to
+ * require an exact PVR match.  However for KVM HV the user is
+ * restricted to a PVR exactly matching the host CPU.  The correct way
+ * to handle this is to put the guest into an architected
+ * compatibility mode.  However, to allow a more forgiving transition
+ * and migration from before this was widely done, we allow migration
+ * between sufficiently similar PVRs, as determined by the CPU class's
+ * pvr_match() hook.
+ */
+static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
+{
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    if (pvr == pcc->pvr) {
+        return true;
+    }
+    if (pcc->pvr_match) {
+        return pcc->pvr_match(pcc, pvr);
+    }
+    return false;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     PowerPCCPU *cpu = opaque;
@@ -203,10 +228,31 @@ static int cpu_post_load(void *opaque, int version_id)
     target_ulong msr;
 
     /*
-     * We always ignore the source PVR. The user or management
-     * software has to take care of running QEMU in a compatible mode.
+     * If we're operating in compat mode, we should be ok as long as
+     * the destination supports the same compatiblity mode.
+     *
+     * Otherwise, however, we require that the destination has exactly
+     * the same CPU model as the source.
      */
-    env->spr[SPR_PVR] = env->spr_cb[SPR_PVR].default_value;
+
+#if defined(TARGET_PPC64)
+    if (cpu->compat_pvr) {
+        Error *local_err = NULL;
+
+        ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            error_free(local_err);
+            return -1;
+        }
+    } else
+#endif
+    {
+        if (!pvr_match(cpu, env->spr[SPR_PVR])) {
+            return -1;
+        }
+    }
+
     env->lr = env->spr[SPR_LR];
     env->ctr = env->spr[SPR_CTR];
     cpu_write_xer(env, env->spr[SPR_XER]);
@@ -560,6 +606,24 @@ static const VMStateDescription vmstate_tlbmas = {
     }
 };
 
+static bool compat_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->vhyp != NULL;
+}
+
+static const VMStateDescription vmstate_compat = {
+    .name = "cpu/compat",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = compat_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(compat_pvr, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -613,6 +677,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlb6xx,
         &vmstate_tlbemb,
         &vmstate_tlbmas,
+        &vmstate_compat,
         NULL
     }
 };
-- 
2.9.3

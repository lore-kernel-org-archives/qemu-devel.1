Received: from eggs.gnu.org ([2001:4830:134:3::10]:34332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0008S6-4v
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRg-0007s6-1G
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:16 +1000
Message-Id: <20170630104632.27942-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/21] ppc: Rework CPU compatibility testing
 across migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

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

Now that we've cleaned up handling of processor compatibility modes
for pseries machine type, we can do better.  For new machine types
(pseries-2.10+) We allow migration if:

    * The source and destination PVRs are for the same type of CPU, as
      determined by CPU class's pvr_match function
OR  * When the source was in a compatibility mode, and the destination CPU
      supports the same compatibility mode

For older machine types we retain the existing behaviour - current CAS
code will usually set a compat mode which would break backwards
migration if we made them use the new behaviour. [Fixed from an
earlier version by Greg Kurz].

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Tested-by: Andrea Bolognani <abologna@redhat.com>
---
 hw/ppc/spapr.c              |  7 ++++-
 target/ppc/cpu.h            |  1 +
 target/ppc/machine.c        | 69 +++++++++++++++++++++++++++++++++++++++++++--
 target/ppc/translate_init.c |  2 ++
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 81007b9..52f4e72 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3362,7 +3362,12 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
  * pseries-2.9
  */
 #define SPAPR_COMPAT_2_9                                               \
-    HW_COMPAT_2_9
+    HW_COMPAT_2_9                                                      \
+    {                                                                  \
+        .driver = TYPE_POWERPC_CPU,                                    \
+        .property = "pre-2.10-migration",                              \
+        .value    = "on",                                              \
+    },                                                                 \
 
 static void spapr_machine_2_9_instance_options(MachineState *machine)
 {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 09393e6..6ee2a26 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1211,6 +1211,7 @@ struct PowerPCCPU {
     uint64_t mig_insns_flags;
     uint64_t mig_insns_flags2;
     uint32_t mig_nb_BATs;
+    bool pre_2_10_migration;
 };
 
 static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 445f489..f578156 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -8,6 +8,7 @@
 #include "helper_regs.h"
 #include "mmu-hash64.h"
 #include "migration/cpu.h"
+#include "qapi/error.h"
 
 static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
 {
@@ -195,6 +196,27 @@ static void cpu_pre_save(void *opaque)
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
+    return pcc->pvr_match(pcc, pvr);
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     PowerPCCPU *cpu = opaque;
@@ -203,10 +225,31 @@ static int cpu_post_load(void *opaque, int version_id)
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
@@ -560,6 +603,25 @@ static const VMStateDescription vmstate_tlbmas = {
     }
 };
 
+static bool compat_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    assert(!(cpu->compat_pvr && !cpu->vhyp));
+    return !cpu->pre_2_10_migration && cpu->compat_pvr != 0;
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
@@ -613,6 +675,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlb6xx,
         &vmstate_tlbemb,
         &vmstate_tlbmas,
+        &vmstate_compat,
         NULL
     }
 };
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index e837cd2..ee84044 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10606,6 +10606,8 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
 
 static Property ppc_cpu_properties[] = {
     DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migration, false),
+    DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migration,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934S-0005Z4-Sw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f934O-0005Qc-8J
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:29:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 19 Apr 2018 16:29:14 +1000
Message-Id: <20180419062917.31486-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180419062917.31486-1-david@gibson.dropbear.id.au>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC for-2.13 4/7] spapr: Add cpu_apply hook to
 capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org, abologna@redhat.com
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

spapr capabilities have an apply hook to actually activate (or deactivate)
the feature in the system at reset time.  However, a number of capabilities
affect the setup of cpus, and need to be applied to each of them -
including hotplugged cpus for extra complication.  To make this simpler,
add an optional cpu_apply hook that is called from spapr_cpu_reset().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c     | 19 +++++++++++++++++++
 hw/ppc/spapr_cpu_core.c |  2 ++
 include/hw/ppc/spapr.h  |  1 +
 3 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 5762b88689..e71de14ffb 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -61,6 +61,8 @@ typedef struct sPAPRCapabilityInfo {
     sPAPRCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
     void (*apply)(sPAPRMachineState *spapr, uint8_t val, Error **errp);
+    void (*cpu_apply)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+                      uint8_t val, Error **errp);
 } sPAPRCapabilityInfo;
 
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
@@ -547,6 +549,23 @@ void spapr_caps_reset(sPAPRMachineState *spapr)
     }
 }
 
+void spapr_caps_cpu_reset(sPAPRMachineState *spapr, PowerPCCPU *cpu)
+{
+    int i;
+
+    for (i = 0; i < SPAPR_CAP_NUM; i++) {
+        sPAPRCapabilityInfo *info = &capability_table[i];
+
+        /*
+         * If the apply function can't set the desired level and thinks it's
+         * fatal, it should cause that.
+         */
+        if (info->cpu_apply) {
+            info->cpu_apply(spapr, cpu, spapr->eff.caps[i], &error_fatal);
+        }
+    }
+}
+
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
 {
     Error *local_err = NULL;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 0a668b8954..f041182593 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -67,6 +67,8 @@ static void spapr_cpu_reset(void *opaque)
 
     /* Set a full AMOR so guest can use the AMR as it sees fit */
     env->spr[SPR_AMOR] = 0xffffffffffffffffull;
+
+    spapr_caps_cpu_reset(SPAPR_MACHINE(qdev_get_machine()), cpu);
 }
 
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r3)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a3d616c612..ced3246d0e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -802,6 +802,7 @@ static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 }
 
 void spapr_caps_reset(sPAPRMachineState *spapr);
+void spapr_caps_cpu_reset(sPAPRMachineState *spapr, PowerPCCPU *cpu);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
 
-- 
2.14.3

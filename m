Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOZ-0008Mb-6u
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOW-00072N-Av
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:37 +1100
Message-Id: <20171017042152.29443-20-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/34] ppc: move '-cpu foo,
 compat=xxx' parsing into ppc_cpu_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

there is a dedicated callback CPUClass::parse_features
which purpose is to convert -cpu features into a set of
global properties AND deal with compat/legacy features
that couldn't be directly translated into CPU's properties.

Create ppc variant of it (ppc_cpu_parse_featurestr) and
move 'compat=val' handling from spapr_cpu_core.c into it.
That removes a dependency of board/core code on cpu_model
parsing and would let to reuse common -cpu parsing
introduced by 6063d4c0

Set "max-cpu-compat" property only if it exists, in practice
it should limit 'compat' hack to spapr machine and allow
to avoid including machine/spapr headers in target/ppc/cpu.c

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c              |  2 +-
 hw/ppc/spapr_cpu_core.c     | 50 ---------------------------------------
 include/hw/ppc/spapr.h      |  1 -
 target/ppc/cpu-qom.h        |  1 +
 target/ppc/translate_init.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 147fd2cfd3..112dd91348 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2373,7 +2373,7 @@ static void ppc_spapr_init(MachineState *machine)
         machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
     }
 
-    spapr_cpu_parse_features(spapr);
+    cpu_parse_cpu_model(TYPE_POWERPC_CPU, machine->cpu_model);
 
     spapr_set_vsmt_mode(spapr, &error_fatal);
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 79a9615080..b6610dd431 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -21,56 +21,6 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/error-report.h"
 
-void spapr_cpu_parse_features(sPAPRMachineState *spapr)
-{
-    /*
-     * Backwards compatibility hack:
-     *
-     *   CPUs had a "compat=" property which didn't make sense for
-     *   anything except pseries.  It was replaced by "max-cpu-compat"
-     *   machine option.  This supports old command lines like
-     *       -cpu POWER8,compat=power7
-     *   By stripping the compat option and applying it to the machine
-     *   before passing it on to the cpu level parser.
-     */
-    gchar **inpieces;
-    gchar *newprops;
-    int i, j;
-    gchar *compat_str = NULL;
-
-    inpieces = g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
-
-    /* inpieces[0] is the actual model string */
-    i = 1;
-    j = 1;
-    while (inpieces[i]) {
-        if (g_str_has_prefix(inpieces[i], "compat=")) {
-            /* in case of multiple compat= options */
-            g_free(compat_str);
-            compat_str = inpieces[i];
-        } else {
-            j++;
-        }
-
-        i++;
-        /* Excise compat options from list */
-        inpieces[j] = inpieces[i];
-    }
-
-    if (compat_str) {
-        char *val = compat_str + strlen("compat=");
-
-        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
-                                &error_fatal);
-
-    }
-
-    newprops = g_strjoinv(",", inpieces);
-    cpu_parse_cpu_model(TYPE_POWERPC_CPU, newprops);
-    g_free(newprops);
-    g_strfreev(inpieces);
-}
-
 static void spapr_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c1b365f564..8ca4f9498f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -659,7 +659,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
                                             uint32_t count, uint32_t index);
 void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
-void spapr_cpu_parse_features(sPAPRMachineState *spapr);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
 void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
                           Error **errp);
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index d0cf6ca2a9..429b47f959 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -181,6 +181,7 @@ typedef struct PowerPCCPUClass {
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
     void (*parent_reset)(CPUState *cpu);
+    void (*parent_parse_features)(const char *type, char *str, Error **errp);
 
     uint32_t pvr;
     bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 0d6379fcc5..3d16481ca1 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10097,6 +10097,61 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
     return NULL;
 }
 
+static void ppc_cpu_parse_featurestr(const char *type, char *features,
+                                     Error **errp)
+{
+    Object *machine = qdev_get_machine();
+    const PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(object_class_by_name(type));
+
+    if (!features) {
+        return;
+    }
+
+    if (object_property_find(machine, "max-cpu-compat", NULL)) {
+        int i;
+        char **inpieces;
+        char *s = features;
+        Error *local_err = NULL;
+        char *compat_str = NULL;
+
+        /*
+         * Backwards compatibility hack:
+         *
+         *   CPUs had a "compat=" property which didn't make sense for
+         *   anything except pseries.  It was replaced by "max-cpu-compat"
+         *   machine option.  This supports old command lines like
+         *       -cpu POWER8,compat=power7
+         *   By stripping the compat option and applying it to the machine
+         *   before passing it on to the cpu level parser.
+         */
+        inpieces = g_strsplit(features, ",", 0);
+        *s = '\0';
+        for (i = 0; inpieces[i]; i++) {
+            if (g_str_has_prefix(inpieces[i], "compat=")) {
+                compat_str = inpieces[i];
+                continue;
+            }
+            if ((i != 0) && (s != features)) {
+                s = g_stpcpy(s, ",");
+            }
+            s = g_stpcpy(s, inpieces[i]);
+        }
+
+        if (compat_str) {
+            char *v = compat_str + strlen("compat=");
+            object_property_set_str(machine, v, "max-cpu-compat", &local_err);
+        }
+        g_strfreev(inpieces);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    /* do property processing with generic handler */
+    pcc->parent_parse_features(type, features, errp);
+}
+
 const char *ppc_cpu_lookup_alias(const char *alias)
 {
     int ai;
@@ -10489,6 +10544,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = ppc_cpu_reset;
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    pcc->parent_parse_features = cc->parse_features;
+    cc->parse_features = ppc_cpu_parse_featurestr;
     cc->has_work = ppc_cpu_has_work;
     cc->do_interrupt = ppc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
-- 
2.13.6

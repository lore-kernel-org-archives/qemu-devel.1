Received: from eggs.gnu.org ([2001:4830:134:3::10]:50688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOb-0008Pa-6B
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOY-00077Y-Un
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:25 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:36 +1100
Message-Id: <20171017042152.29443-19-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 18/34] ppc: spapr: replace
 ppc_cpu_parse_features() with cpu_parse_cpu_model()
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

ppc_cpu_parse_features() is doing practically the same thing as
generic cpu_parse_cpu_model(). So remove duplicated impl. and
reuse generic one.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c            | 25 -------------------------
 hw/ppc/spapr_cpu_core.c |  9 ++++-----
 include/hw/ppc/ppc.h    |  2 --
 3 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 05da316e0b..7ec35de5ae 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1359,28 +1359,3 @@ void PPC_debug_write (void *opaque, uint32_t addr, uint32_t val)
         break;
     }
 }
-
-void ppc_cpu_parse_features(const char *cpu_model)
-{
-    CPUClass *cc;
-    ObjectClass *oc;
-    const char *typename;
-    gchar **model_pieces;
-
-    model_pieces = g_strsplit(cpu_model, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("Invalid/empty CPU model name");
-        exit(1);
-    }
-
-    oc = cpu_class_by_name(TYPE_POWERPC_CPU, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("Unable to find CPU definition: %s", model_pieces[0]);
-        exit(1);
-    }
-
-    typename = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
-    cc->parse_features(typename, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-}
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 37beb56e8b..79a9615080 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -34,6 +34,7 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
      *   before passing it on to the cpu level parser.
      */
     gchar **inpieces;
+    gchar *newprops;
     int i, j;
     gchar *compat_str = NULL;
 
@@ -58,17 +59,15 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
 
     if (compat_str) {
         char *val = compat_str + strlen("compat=");
-        gchar *newprops = g_strjoinv(",", inpieces);
 
         object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
                                 &error_fatal);
 
-        ppc_cpu_parse_features(newprops);
-        g_free(newprops);
-    } else {
-        ppc_cpu_parse_features(MACHINE(spapr)->cpu_model);
     }
 
+    newprops = g_strjoinv(",", inpieces);
+    cpu_parse_cpu_model(TYPE_POWERPC_CPU, newprops);
+    g_free(newprops);
     g_strfreev(inpieces);
 }
 
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4e7fe110d6..ff0ac306be 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -105,6 +105,4 @@ enum {
 
 /* ppc_booke.c */
 void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags);
-
-void ppc_cpu_parse_features(const char *cpu_model);
 #endif
-- 
2.13.6

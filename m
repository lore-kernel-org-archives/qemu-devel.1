Received: from eggs.gnu.org ([2001:4830:134:3::10]:45078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xW-0002yY-3o
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xV-0003Mh-4R
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:14 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:38 +0200
Message-Id: <1507220690-265042-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 11/23] ppc: spapr: replace
 ppc_cpu_parse_features() with cpu_parse_cpu_model()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

ppc_cpu_parse_features() is doing practically the same thing as
generic cpu_parse_cpu_model(). So remove duplicated impl. and
reuse generic one.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/ppc/ppc.h    |  2 --
 hw/ppc/ppc.c            | 25 -------------------------
 hw/ppc/spapr_cpu_core.c |  9 ++++-----
 3 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4e7fe11..ff0ac30 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -105,6 +105,4 @@ enum {
 
 /* ppc_booke.c */
 void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags);
-
-void ppc_cpu_parse_features(const char *cpu_model);
 #endif
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 05da316..7ec35de 100644
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
index 3e20b1d..3dea5ff 100644
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
 
-- 
2.7.4

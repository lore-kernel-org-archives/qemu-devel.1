Received: from eggs.gnu.org ([209.51.188.92]:58087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGank-0002lb-6u
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanh-0007k0-P7
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:55 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 16 Apr 2019 23:59:41 -0300
Message-Id: <20190417025944.16154-3-ehabkost@redhat.com>
In-Reply-To: <20190417025944.16154-1-ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] cpu: Extract CPU class lookup from
 parse_cpu_option()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The new function will be useful in user mode, when we already
have a CPU model and don't need to parse any extra options.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h |  9 +++++++++
 exec.c            | 22 ++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index d28c690b27..e11b14d9ac 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -699,6 +699,15 @@ CPUState *cpu_create(const char *typename);
  */
 const char *parse_cpu_option(const char *cpu_option);
 
+/**
+ * lookup_cpu_class:
+ * @cpu_model: CPU model name
+ *
+ * Look up CPU class corresponding to a given CPU model name.
+ */
+CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp);
+
+
 /**
  * cpu_has_work:
  * @cpu: The vCPU to check.
diff --git a/exec.c b/exec.c
index 840677f15f..d359e709a6 100644
--- a/exec.c
+++ b/exec.c
@@ -982,24 +982,26 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 #endif
 }
 
+CPUClass *lookup_cpu_class(const char *cpu_model, Error **errp)
+{
+    ObjectClass *oc = cpu_class_by_name(CPU_RESOLVING_TYPE, cpu_model);
+    if (oc == NULL) {
+        error_setg(errp, "unable to find CPU model '%s'", cpu_model);
+        return NULL;
+    }
+    return CPU_CLASS(oc);
+}
+
 const char *parse_cpu_option(const char *cpu_option)
 {
-    ObjectClass *oc;
     CPUClass *cc;
     gchar **model_pieces;
     const char *cpu_type;
 
     model_pieces = g_strsplit(cpu_option, ",", 2);
 
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("unable to find CPU model '%s'", model_pieces[0]);
-        g_strfreev(model_pieces);
-        exit(EXIT_FAILURE);
-    }
-
-    cpu_type = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
+    cc = lookup_cpu_class(model_pieces[0], &error_fatal);
+    cpu_type = object_class_get_name(OBJECT_CLASS(cc));
     cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
     g_strfreev(model_pieces);
     return cpu_type;
-- 
2.18.0.rc1.1.g3f1ff2140

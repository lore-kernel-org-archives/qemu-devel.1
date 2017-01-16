Received: from eggs.gnu.org ([2001:4830:134:3::10]:50424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTEZ2-0003cb-Mt
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTEZ1-00014w-8h
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTEZ1-00014l-0V
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:39 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C3A861BA4
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 21:11:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 19:11:24 -0200
Message-Id: <20170116211124.29245-5-ehabkost@redhat.com>
In-Reply-To: <20170116211124.29245-1-ehabkost@redhat.com>
References: <20170116211124.29245-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] target-i386: Implement
 query-cpu-model-expansion QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>

Implement query-cpu-model-expansion for target-i386.

This should meet all the requirements while being simple. In the
case of static expansion, it will use the new "base" CPU model,
and in the case of full expansion, it will keep the original CPU
model name+props, and append extra properties.

A future follow-up should improve the implementation of
type=full, so that it returns more detailed data, including every
writable QOM property in the CPU object.

Cc: libvir-list@redhat.com
Cc: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Fix typos
  * Reported-by: Markus Armbruster <armbru@redhat.com>
* Removed static/migration-safe field from return value
  (they will be added by a separate patch)
* Use a dictionary to keep track of the properties that
  should be included in the expansion, instead of hardcoding them
* Removed test case to keep series simple (test case will be
  submitted as a separate series)
---
 monitor.c         |   4 +-
 target/i386/cpu.c | 191 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 0841d436b0..90c12b3cd5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -983,8 +983,10 @@ static void qmp_unregister_commands_hack(void)
 #ifndef TARGET_ARM
     qmp_unregister_command("query-gic-capabilities");
 #endif
-#if !defined(TARGET_S390X)
+#if !defined(TARGET_S390X) && !defined(TARGET_I386)
     qmp_unregister_command("query-cpu-model-expansion");
+#endif
+#if !defined(TARGET_S390X)
     qmp_unregister_command("query-cpu-model-baseline");
     qmp_unregister_command("query-cpu-model-comparison");
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1a1bb75a75..0b68c2d423 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -29,10 +29,16 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qbool.h"
+#include "qapi/qmp/qint.h"
+#include "qapi/qmp/qfloat.h"
 
 #include "qapi-types.h"
 #include "qapi-visit.h"
 #include "qapi/visitor.h"
+#include "qom/qom-qobject.h"
 #include "sysemu/arch_init.h"
 
 #if defined(CONFIG_KVM)
@@ -2261,7 +2267,7 @@ static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
     }
 }
 
-/* Load data from X86CPUDefinition
+/* Load data from X86CPUDefinition into a X86CPU object
  */
 static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
 {
@@ -2270,6 +2276,11 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
     char host_vendor[CPUID_VENDOR_SZ + 1];
     FeatureWord w;
 
+    /*NOTE: any property set by this function should be returned by
+     * x86_cpu_static_props(), so static expansion of
+     * query-cpu-model-expansion is always complete.
+     */
+
     /* CPU models only set _minimum_ values for level/xlevel: */
     object_property_set_int(OBJECT(cpu), def->level, "min-level", errp);
     object_property_set_int(OBJECT(cpu), def->xlevel, "min-xlevel", errp);
@@ -2314,6 +2325,184 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
 
 }
 
+/* Return a QDict containing keys for all properties that can be included
+ * in static expansion of CPU models. All properties set by x86_cpu_load_def()
+ * must be included in the dictionary.
+ */
+static QDict *x86_cpu_static_props(void)
+{
+    FeatureWord w;
+    int i;
+    static const char *props[] = {
+        "min-level",
+        "min-xlevel",
+        "family",
+        "model",
+        "stepping",
+        "model-id",
+        "vendor",
+        "lmce",
+        NULL,
+    };
+    static QDict *d;
+
+    if (d) {
+        return d;
+    }
+
+    d = qdict_new();
+    for (i = 0; props[i]; i++) {
+        qdict_put_obj(d, props[i], qnull());
+    }
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        FeatureWordInfo *fi = &feature_word_info[w];
+        int bit;
+        for (bit = 0; bit < 32; bit++) {
+            if (!fi->feat_names[bit]) {
+                continue;
+            }
+            qdict_put_obj(d, fi->feat_names[bit], qnull());
+        }
+    }
+
+    return d;
+}
+
+/* Add an entry to @props dict, with the value for property. */
+static void x86_cpu_expand_prop(X86CPU *cpu, QDict *props, const char *prop)
+{
+    QObject *value = object_property_get_qobject(OBJECT(cpu), prop,
+                                                 &error_abort);
+
+    qdict_put_obj(props, prop, value);
+}
+
+/* Convert CPU model data from X86CPU object to a property dictionary
+ * that can recreate exactly the same CPU model.
+ */
+static void x86_cpu_to_dict(X86CPU *cpu, QDict *props)
+{
+    QDict *sprops = x86_cpu_static_props();
+    const QDictEntry *e;
+
+    for (e = qdict_first(sprops); e; e = qdict_next(sprops, e)) {
+        const char *prop = qdict_entry_key(e);
+        x86_cpu_expand_prop(cpu, props, prop);
+    }
+}
+
+static void object_apply_props(Object *obj, QDict *props, Error **errp)
+{
+    const QDictEntry *prop;
+    Error *err = NULL;
+
+    for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
+        object_property_set_qobject(obj, qdict_entry_value(prop),
+                                         qdict_entry_key(prop), &err);
+        if (err) {
+            break;
+        }
+    }
+
+    error_propagate(errp, err);
+}
+
+/* Create X86CPU object according to model+props specification */
+static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
+{
+    X86CPU *xc = NULL;
+    X86CPUClass *xcc;
+    Error *err = NULL;
+
+    xcc = X86_CPU_CLASS(cpu_class_by_name(TYPE_X86_CPU, model));
+    if (xcc == NULL) {
+        error_setg(&err, "CPU model '%s' not found", model);
+        goto out;
+    }
+
+    xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
+    if (props) {
+        object_apply_props(OBJECT(xc), props, &err);
+        if (err) {
+            goto out;
+        }
+    }
+
+    x86_cpu_expand_features(xc, &err);
+    if (err) {
+        goto out;
+    }
+
+out:
+    if (err) {
+        error_propagate(errp, err);
+        object_unref(OBJECT(xc));
+        xc = NULL;
+    }
+    return xc;
+}
+
+CpuModelExpansionInfo *
+arch_query_cpu_model_expansion(CpuModelExpansionType type,
+                                                      CpuModelInfo *model,
+                                                      Error **errp)
+{
+    X86CPU *xc = NULL;
+    Error *err = NULL;
+    CpuModelExpansionInfo *ret = g_new0(CpuModelExpansionInfo, 1);
+    QDict *props = NULL;
+    const char *base_name;
+
+    xc = x86_cpu_from_model(model->name,
+                            model->has_props ?
+                                qobject_to_qdict(model->props) :
+                                NULL, &err);
+    if (err) {
+        goto out;
+    }
+
+
+    switch (type) {
+    case CPU_MODEL_EXPANSION_TYPE_STATIC:
+        /* Static expansion will be based on "base" only */
+        base_name = "base";
+    break;
+    case CPU_MODEL_EXPANSION_TYPE_FULL:
+        /* As we don't return every single property, full expansion needs
+         * to keep the original model name+props, and add extra
+         * properties on top of that.
+         */
+        base_name = model->name;
+        if (model->has_props && model->props) {
+            props = qdict_clone_shallow(qobject_to_qdict(model->props));
+        }
+    break;
+    default:
+        error_setg(&err, "Unsupportted expansion type");
+        goto out;
+    }
+
+    if (!props) {
+        props = qdict_new();
+    }
+    x86_cpu_to_dict(xc, props);
+
+    ret->model = g_new0(CpuModelInfo, 1);
+    ret->model->name = g_strdup(base_name);
+    ret->model->props = QOBJECT(props);
+    ret->model->has_props = true;
+
+out:
+    object_unref(OBJECT(xc));
+    if (err) {
+        error_propagate(errp, err);
+        qapi_free_CpuModelExpansionInfo(ret);
+        ret = NULL;
+    }
+    return ret;
+}
+
 X86CPU *cpu_x86_init(const char *cpu_model)
 {
     return X86_CPU(cpu_generic_init(TYPE_X86_CPU, cpu_model));
-- 
2.11.0.259.g40922b1

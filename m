Received: from eggs.gnu.org ([2001:4830:134:3::10]:43815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO76-00087t-Pm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO75-0005JM-Nx
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO75-0005J3-Hk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:27 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:25:01 -0300
Message-Id: <20170227162501.29280-12-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] i386: Improve query-cpu-model-expansion
 full mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>

This keeps the same results on type=static expansion, but make
type=full expansion return every single QOM property on the CPU
object that have a different value from the "base' CPU model,
plus all the CPU feature flag properties.

Cc: Jiri Denemark <jdenemar@redhat.com>
Message-Id: <20170222190029.17243-4-ehabkost@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 139b7ea12e..89421c893b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2419,6 +2419,34 @@ static void x86_cpu_to_dict(X86CPU *cpu, QDict *props)
     }
 }
 
+/* Convert CPU model data from X86CPU object to a property dictionary
+ * that can recreate exactly the same CPU model, including every
+ * writeable QOM property.
+ */
+static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
+{
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
+
+    object_property_iter_init(&iter, OBJECT(cpu));
+    while ((prop = object_property_iter_next(&iter))) {
+        /* skip read-only or write-only properties */
+        if (!prop->get || !prop->set) {
+            continue;
+        }
+
+        /* "hotplugged" is the only property that is configurable
+         * on the command-line but will be set differently on CPUs
+         * created using "-cpu ... -smp ..." and by CPUs created
+         * on the fly by x86_cpu_from_model() for querying. Skip it.
+         */
+        if (!strcmp(prop->name, "hotplugged")) {
+            continue;
+        }
+        x86_cpu_expand_prop(cpu, props, prop->name);
+    }
+}
+
 static void object_apply_props(Object *obj, QDict *props, Error **errp)
 {
     const QDictEntry *prop;
@@ -2489,11 +2517,13 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
         goto out;
     }
 
+    props = qdict_new();
 
     switch (type) {
     case CPU_MODEL_EXPANSION_TYPE_STATIC:
         /* Static expansion will be based on "base" only */
         base_name = "base";
+        x86_cpu_to_dict(xc, props);
     break;
     case CPU_MODEL_EXPANSION_TYPE_FULL:
         /* As we don't return every single property, full expansion needs
@@ -2501,9 +2531,7 @@ arch_query_cpu_model_expansion(CpuModelExpansionType type,
          * properties on top of that.
          */
         base_name = model->name;
-        if (model->has_props && model->props) {
-            props = qdict_clone_shallow(qobject_to_qdict(model->props));
-        }
+        x86_cpu_to_dict_full(xc, props);
     break;
     default:
         error_setg(&err, "Unsupportted expansion type");
-- 
2.11.0.259.g40922b1

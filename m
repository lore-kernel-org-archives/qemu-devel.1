Received: from eggs.gnu.org ([2001:4830:134:3::10]:54348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiFqa-0002Lq-Q3
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fiFqX-0002A0-Oa
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:12:40 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 25 Jul 2018 11:12:33 +0200
Message-Id: <20180725091233.3300-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/cpu_models: Add "-cpu max" support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Collin Walling <walling@linux.ibm.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>

The "max" CPU model behaves like "-cpu host" when KVM is enabled, and like
a CPU with the maximum possible feature set when TCG is enabled.

While the "host" model can not be used under TCG ("kvm_required"), the
"max" model can and "Enables all features supported by the accelerator in
the current host".

So we can treat "host" just as a special case of "max" (like x86 does).
It differs to the "qemu" CPU model under TCG such that compatibility
handling will not be performed and that some experimental CPU features
not yet part of the "qemu" model might be indicated.

These are right now under TCG (see "qemu_MAX"):
- stfle53
- msa5-base
- zpci

This will result right now in the following warning when starting QEMU TCG
with the "max" model:
    "qemu-system-s390x: warning: 'msa5-base' requires 'kimd-sha-512'."

The "qemu" model (used as default in QEMU under TCG) will continue to
work without such warnings. The "max" mdel in the current form
might be interesting for kvm-unit-tests (where we would e.g. now also
test "msa5-base").

The "max" model is neither static nor migration safe (like the "host"
model). It is independent of the machine but dependends on the accelerator.
It can be used to detect the maximum CPU model also under TCG from upper
layers without having to care about CPU model names for CPU model
expansion.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 81 +++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 25 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 604898a882..708bf0e3ba 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -307,7 +307,10 @@ static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
     const char *name_a = object_class_get_name((ObjectClass *)a);
     const char *name_b = object_class_get_name((ObjectClass *)b);
 
-    /* move qemu and host to the top of the list, qemu first, host second */
+    /*
+     * Move qemu, host and max to the top of the list, qemu first, host second,
+     * max third.
+     */
     if (name_a[0] == 'q') {
         return -1;
     } else if (name_b[0] == 'q') {
@@ -316,6 +319,10 @@ static gint s390_cpu_list_compare(gconstpointer a, gconstpointer b)
         return -1;
     } else if (name_b[0] == 'h') {
         return 1;
+    } else if (name_a[0] == 'm') {
+        return -1;
+    } else if (name_b[0] == 'm') {
+        return 1;
     }
 
     /* keep the same order we have in our table (sorted by release date) */
@@ -1077,27 +1084,6 @@ static void s390_cpu_model_initfn(Object *obj)
     }
 }
 
-#ifdef CONFIG_KVM
-static void s390_host_cpu_model_initfn(Object *obj)
-{
-    S390CPU *cpu = S390_CPU(obj);
-    Error *err = NULL;
-
-    if (!kvm_enabled() || !kvm_s390_cpu_models_supported()) {
-        return;
-    }
-
-    cpu->model = g_malloc0(sizeof(*cpu->model));
-    kvm_s390_get_host_cpu_model(cpu->model, &err);
-    if (err) {
-        error_report_err(err);
-        g_free(cpu->model);
-        /* fallback to unsupported cpu models */
-        cpu->model = NULL;
-    }
-}
-#endif
-
 static S390CPUDef s390_qemu_cpu_def;
 static S390CPUModel s390_qemu_cpu_model;
 
@@ -1136,6 +1122,30 @@ static void s390_qemu_cpu_model_initfn(Object *obj)
     memcpy(cpu->model, &s390_qemu_cpu_model, sizeof(*cpu->model));
 }
 
+static void s390_max_cpu_model_initfn(Object *obj)
+{
+    const S390CPUModel *max_model;
+    S390CPU *cpu = S390_CPU(obj);
+    Error *local_err = NULL;
+
+    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
+        /* "max" and "host" always work, even without CPU model support */
+        return;
+    }
+
+    max_model = get_max_cpu_model(&local_err);
+    if (local_err) {
+        g_assert(kvm_enabled());
+        error_report_err(local_err);
+        /* fallback to unsupported CPU models */
+        return;
+    }
+
+    cpu->model = g_new(S390CPUModel, 1);
+    /* copy the CPU model so we can modify it */
+    memcpy(cpu->model, max_model, sizeof(*cpu->model));
+}
+
 static void s390_cpu_model_finalize(Object *obj)
 {
     S390CPU *cpu = S390_CPU(obj);
@@ -1209,6 +1219,20 @@ static void s390_qemu_cpu_model_class_init(ObjectClass *oc, void *data)
                                 qemu_hw_version());
 }
 
+static void s390_max_cpu_model_class_init(ObjectClass *oc, void *data)
+{
+    S390CPUClass *xcc = S390_CPU_CLASS(oc);
+
+    /*
+     * The "max" model is neither static nor migration safe. Under KVM
+     * it represents the "host" model. Under TCG it represents some kind of
+     * "qemu" CPU model without compat handling and maybe with some additional
+     * CPU features that are not yet unlocked in the "qemu" model.
+     */
+    xcc->desc =
+        "Enables all features supported by the accelerator in the current host";
+}
+
 /* Generate type name for a cpu model. Caller has to free the string. */
 static char *s390_cpu_type_name(const char *model_name)
 {
@@ -1239,12 +1263,18 @@ static const TypeInfo qemu_s390_cpu_type_info = {
     .class_init = s390_qemu_cpu_model_class_init,
 };
 
+static const TypeInfo max_s390_cpu_type_info = {
+    .name = S390_CPU_TYPE_NAME("max"),
+    .parent = TYPE_S390_CPU,
+    .instance_init = s390_max_cpu_model_initfn,
+    .instance_finalize = s390_cpu_model_finalize,
+    .class_init = s390_max_cpu_model_class_init,
+};
+
 #ifdef CONFIG_KVM
 static const TypeInfo host_s390_cpu_type_info = {
     .name = S390_CPU_TYPE_NAME("host"),
-    .parent = TYPE_S390_CPU,
-    .instance_init = s390_host_cpu_model_initfn,
-    .instance_finalize = s390_cpu_model_finalize,
+    .parent = S390_CPU_TYPE_NAME("max"),
     .class_init = s390_host_cpu_model_class_init,
 };
 #endif
@@ -1326,6 +1356,7 @@ static void register_types(void)
     }
 
     type_register_static(&qemu_s390_cpu_type_info);
+    type_register_static(&max_s390_cpu_type_info);
 #ifdef CONFIG_KVM
     type_register_static(&host_s390_cpu_type_info);
 #endif
-- 
2.17.1

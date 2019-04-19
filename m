Received: from eggs.gnu.org ([209.51.188.92]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnF-0005gD-HS
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnE-00051G-7Y
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:14:23 -0300
Message-Id: <20190419061429.17695-2-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-1-ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] cpu: Change return type of
 cpu_class_by_name() to CPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>

The function always returns a CPU class.  Change the return type
to reflect that.

I'm not changing the return type of CPUClass::class_by_name()
yet, because many of its implementations will be eliminated by
the next commits.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
---
 include/qom/cpu.h         |  2 +-
 exec.c                    |  8 +++-----
 qom/cpu.c                 |  4 ++--
 target/s390x/cpu_models.c | 10 +++++-----
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index d28c690b27..fefd5c26b0 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -676,7 +676,7 @@ void cpu_reset(CPUState *cpu);
  *
  * Returns: A #CPUClass or %NULL if not matching class is found.
  */
-ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
+CPUClass *cpu_class_by_name(const char *typename, const char *cpu_model);
 
 /**
  * cpu_create:
diff --git a/exec.c b/exec.c
index efb1616ece..d303ac5f25 100644
--- a/exec.c
+++ b/exec.c
@@ -984,7 +984,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 
 const char *parse_cpu_option(const char *cpu_option)
 {
-    ObjectClass *oc;
     CPUClass *cc;
     gchar **model_pieces;
     const char *cpu_type;
@@ -995,15 +994,14 @@ const char *parse_cpu_option(const char *cpu_option)
         exit(1);
     }
 
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
-    if (oc == NULL) {
+    cc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    if (cc == NULL) {
         error_report("unable to find CPU model '%s'", model_pieces[0]);
         g_strfreev(model_pieces);
         exit(EXIT_FAILURE);
     }
 
-    cpu_type = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
+    cpu_type = object_class_get_name(OBJECT_CLASS(cc));
     cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
     g_strfreev(model_pieces);
     return cpu_type;
diff --git a/qom/cpu.c b/qom/cpu.c
index a8d2958956..b971a56242 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -283,12 +283,12 @@ static bool cpu_common_has_work(CPUState *cs)
     return false;
 }
 
-ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
+CPUClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
     CPUClass *cc = CPU_CLASS(object_class_by_name(typename));
 
     assert(cpu_model && cc->class_by_name);
-    return cc->class_by_name(cpu_model);
+    return CPU_CLASS(cc->class_by_name(cpu_model));
 }
 
 static void cpu_common_parse_features(const char *typename, char *features,
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index eb125d4d0d..391698595f 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -482,7 +482,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
     const QDict *qdict = NULL;
     const QDictEntry *e;
     Visitor *visitor;
-    ObjectClass *oc;
+    CPUClass *cc;
     S390CPU *cpu;
     Object *obj;
 
@@ -494,16 +494,16 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
         }
     }
 
-    oc = cpu_class_by_name(TYPE_S390_CPU, info->name);
-    if (!oc) {
+    cc = cpu_class_by_name(TYPE_S390_CPU, info->name);
+    if (!cc) {
         error_setg(errp, "The CPU definition \'%s\' is unknown.", info->name);
         return;
     }
-    if (S390_CPU_CLASS(oc)->kvm_required && !kvm_enabled()) {
+    if (S390_CPU_CLASS(cc)->kvm_required && !kvm_enabled()) {
         error_setg(errp, "The CPU definition '%s' requires KVM", info->name);
         return;
     }
-    obj = object_new(object_class_get_name(oc));
+    obj = object_new(object_class_get_name(OBJECT_CLASS(cc)));
     cpu = S390_CPU(obj);
 
     if (!cpu->model) {
-- 
2.18.0.rc1.1.g3f1ff2140

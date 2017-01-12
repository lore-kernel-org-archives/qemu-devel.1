Received: from eggs.gnu.org ([2001:4830:134:3::10]:42058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjen-0000iO-Cp
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjek-0000kN-E3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjek-0000k4-62
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:22 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:56 -0200
Message-Id: <20170112175356.21701-7-ehabkost@redhat.com>
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] qmp: Report QOM type name on
 query-cpu-definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The new typename attribute on query-cpu-definitions will be used
to help management software use device-list-properties to check
which properties can be set using -cpu or -global for the CPU
model.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1479320499-29818-1-git-send-email-ehabkost@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json            | 5 ++++-
 target/arm/helper.c         | 1 +
 target/i386/cpu.c           | 1 +
 target/ppc/translate_init.c | 1 +
 target/s390x/cpu_models.c   | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index e42998edec..ce20f16757 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3221,6 +3221,9 @@
 # @unavailable-features: #optional List of properties that prevent
 #                        the CPU model from running in the current
 #                        host. (since 2.8)
+# @typename: Type name that can be used as argument to @device-list-properties,
+#            to introspect properties configurable using -cpu or -global.
+#            (since 2.9)
 #
 # @unavailable-features is a list of QOM property names that
 # represent CPU model attributes that prevent the CPU from running.
@@ -3242,7 +3245,7 @@
 ##
 { 'struct': 'CpuDefinitionInfo',
   'data': { 'name': 'str', '*migration-safe': 'bool', 'static': 'bool',
-            '*unavailable-features': [ 'str' ] } }
+            '*unavailable-features': [ 'str' ], 'typename': 'str' } }
 
 ##
 # @query-cpu-definitions:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8dcabbf576..9f1a335e3f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5214,6 +5214,7 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
     info = g_malloc0(sizeof(*info));
     info->name = g_strndup(typename,
                            strlen(typename) - strlen("-" TYPE_ARM_CPU));
+    info->q_typename = g_strdup(typename);
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b0640f1e38..a149c8dc42 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2235,6 +2235,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     info->name = x86_cpu_class_get_model_name(cc);
     x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
     info->has_unavailable_features = true;
+    info->q_typename = g_strdup(object_class_get_name(oc));
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 626e03186c..19ef2505e4 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10305,6 +10305,7 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
 
         info = g_malloc0(sizeof(*info));
         info->name = g_strdup(alias->alias);
+        info->q_typename = g_strdup(object_class_get_name(oc));
 
         entry = g_malloc0(sizeof(*entry));
         entry->value = info;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c1e729df5e..5b66d3325d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -290,6 +290,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     info->has_migration_safe = true;
     info->migration_safe = scc->is_migration_safe;
     info->q_static = scc->is_static;
+    info->q_typename = g_strdup(object_class_get_name(klass));
 
 
     entry = g_malloc0(sizeof(*entry));
-- 
2.11.0.259.g40922b1

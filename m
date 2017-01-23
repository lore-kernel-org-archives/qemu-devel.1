Received: from eggs.gnu.org ([2001:4830:134:3::10]:38153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1q-0003ET-Fz
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1p-0005xn-HV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1p-0005xX-Bu
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:01 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:28 -0200
Message-Id: <20170123232738.20796-4-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/13] i386: Return migration-safe field on
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

Return the migration-safe field on query-cpu-definitions. All CPU
models in x86 are migration-safe except "host".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170116181212.31565-1-ehabkost@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu-qom.h | 2 ++
 target/i386/cpu.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 7c9a07ae65..8cd607e9a2 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -48,6 +48,7 @@ typedef struct X86CPUDefinition X86CPUDefinition;
  * X86CPUClass:
  * @cpu_def: CPU model definition
  * @kvm_required: Whether CPU model requires KVM to be enabled.
+ * @migration_safe: See CpuDefinitionInfo::migration_safe
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
  *
@@ -62,6 +63,7 @@ typedef struct X86CPUClass {
     X86CPUDefinition *cpu_def;
 
     bool kvm_required;
+    bool migration_safe;
 
     /* Optional description of CPU model.
      * If unavailable, cpu_def->model_id is used */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0e5ecb3a0f..cff23e129d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2209,6 +2209,8 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
     info->has_unavailable_features = true;
     info->q_typename = g_strdup(object_class_get_name(oc));
+    info->migration_safe = cc->migration_safe;
+    info->has_migration_safe = true;
 
     entry = g_malloc0(sizeof(*entry));
     entry->value = info;
@@ -2356,6 +2358,7 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
 
     xcc->cpu_def = cpudef;
+    xcc->migration_safe = true;
 }
 
 static void x86_register_cpudef_type(X86CPUDefinition *def)
-- 
2.11.0.259.g40922b1

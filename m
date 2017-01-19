Received: from eggs.gnu.org ([2001:4830:134:3::10]:34916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtD-0004dv-D6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtC-0001GP-Dk
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUJtC-0001FC-70
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:04:58 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 697A37FE87
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:04:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 19 Jan 2017 19:04:45 -0200
Message-Id: <20170119210449.11991-3-ehabkost@redhat.com>
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] i386: Add ordering field to CPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of using kvm_enabled to order the "-cpu help" list, use a
new "ordering" field for that.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu-qom.h | 2 ++
 target/i386/cpu.c     | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 8cd607e9a2..14abd0a8c1 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -48,6 +48,7 @@ typedef struct X86CPUDefinition X86CPUDefinition;
  * X86CPUClass:
  * @cpu_def: CPU model definition
  * @kvm_required: Whether CPU model requires KVM to be enabled.
+ * @ordering: Ordering on the "-cpu help" CPU model list.
  * @migration_safe: See CpuDefinitionInfo::migration_safe
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
@@ -63,6 +64,7 @@ typedef struct X86CPUClass {
     X86CPUDefinition *cpu_def;
 
     bool kvm_required;
+    int ordering;
     bool migration_safe;
 
     /* Optional description of CPU model.
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7947c8737c..0c6d8d605e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1550,6 +1550,7 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
     uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
 
     xcc->kvm_required = true;
+    xcc->ordering = 9;
 
     host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
     x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
@@ -2127,7 +2128,7 @@ static void listflags(FILE *f, fprintf_function print, const char **featureset)
     }
 }
 
-/* Sort alphabetically by type name, listing kvm_required models last. */
+/* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
 static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
     ObjectClass *class_a = (ObjectClass *)a;
@@ -2136,9 +2137,8 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
     X86CPUClass *cc_b = X86_CPU_CLASS(class_b);
     const char *name_a, *name_b;
 
-    if (cc_a->kvm_required != cc_b->kvm_required) {
-        /* kvm_required items go last */
-        return cc_a->kvm_required ? 1 : -1;
+    if (cc_a->ordering != cc_b->ordering) {
+        return cc_a->ordering - cc_b->ordering;
     } else {
         name_a = object_class_get_name(class_a);
         name_b = object_class_get_name(class_b);
-- 
2.11.0.259.g40922b1

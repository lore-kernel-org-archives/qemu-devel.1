Received: from eggs.gnu.org ([2001:4830:134:3::10]:43694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6p-0007rI-Jr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6o-0005BS-JP
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6o-0005Al-E6
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:10 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:52 -0300
Message-Id: <20170227162501.29280-3-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] i386: Add ordering field to CPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Instead of using kvm_enabled to order the "-cpu help" list, use a
new "ordering" field for that.

Message-Id: <20170119210449.11991-3-ehabkost@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
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
index 2adee42035..8efe4de89e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1550,6 +1550,7 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
     uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
 
     xcc->kvm_required = true;
+    xcc->ordering = 9;
 
     host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
     x86_cpu_vendor_words2str(host_cpudef.vendor, ebx, edx, ecx);
@@ -2126,7 +2127,7 @@ static void listflags(FILE *f, fprintf_function print, const char **featureset)
     }
 }
 
-/* Sort alphabetically by type name, listing kvm_required models last. */
+/* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
 static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
     ObjectClass *class_a = (ObjectClass *)a;
@@ -2135,9 +2136,8 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
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

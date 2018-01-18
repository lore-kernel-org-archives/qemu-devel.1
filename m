Received: from eggs.gnu.org ([2001:4830:134:3::10]:43398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWw-0002O4-QD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzWu-0003uu-VP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzWu-0003to-Kv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:01:52 -0200
Message-Id: <20180118020157.25401-4-ehabkost@redhat.com>
In-Reply-To: <20180118020157.25401-1-ehabkost@redhat.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] i386: Change X86CPUDefinition::model_id to
 const char*
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

It is valid to have a 48-character model ID on CPUID, however the
definition of X86CPUDefinition::model_id is char[48], which can
make the compiler drop the null terminator from the string.

If a CPU model happens to have 48 bytes on model_id, "-cpu help"
will print garbage and the object_property_set_str() call at
x86_cpu_load_def() will read data outside the model_id array.

We could increase the array size to 49, but this would mean the
compiler would not issue a warning if a 49-char string is used by
mistake for model_id.

To make things simpler, simply change model_id to be const char*,
and validate the string length using an assert() on
x86_register_cpudef_type().

Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180109154519.25634-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4385853646..0e26fa4ea7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -754,7 +754,7 @@ struct X86CPUDefinition {
     int model;
     int stepping;
     FeatureWordArray features;
-    char model_id[48];
+    const char *model_id;
 };
 
 static X86CPUDefinition builtin_x86_defs[] = {
@@ -923,6 +923,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             I486_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium",
@@ -934,6 +935,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium2",
@@ -945,6 +947,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM2_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium3",
@@ -956,6 +959,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM3_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "athlon",
@@ -2736,6 +2740,9 @@ static void x86_register_cpudef_type(X86CPUDefinition *def)
      * they shouldn't be set on the CPU model table.
      */
     assert(!(def->features[FEAT_8000_0001_EDX] & CPUID_EXT2_AMD_ALIASES));
+    /* catch mistakes instead of silently truncating model_id when too long */
+    assert(def->model_id && strlen(def->model_id) <= 48);
+
 
     type_register(&ti);
     g_free(typename);
-- 
2.14.3

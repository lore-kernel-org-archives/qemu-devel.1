Received: from eggs.gnu.org ([2001:4830:134:3::10]:42735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYy0I-0008N8-Uu
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYy0E-0008Ct-2z
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:48:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYy0D-0008CA-Px
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:47:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B0153C92
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 17:47:56 +0000 (UTC)
Date: Tue, 9 Jan 2018 15:47:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180109174754.GR6646@localhost.localdomain>
References: <20180109154519.25634-1-ehabkost@redhat.com>
	<20180109154519.25634-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109154519.25634-2-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! i386: Change X86CPUDefinition::model_id
 to const char*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jan 09, 2018 at 01:45:13PM -0200, Eduardo Habkost wrote:
> It is valid to have a 48-character model ID on CPUID, however the
> definition of X86CPUDefinition::model_id is char[48], which can
> make the compiler drop the null terminator from the string.
> 
> If a CPU model happens to have 48 bytes on model_id, "-cpu help"
> will print garbage and the object_property_set_str() call at
> x86_cpu_load_def() will read data outside the model_id array.
> 
> We could increase the array size to 49, but this would mean the
> compiler would not issue a warning if a 49-char string is used by
> mistake for model_id.
> 
> To make things simpler, simply change model_id to be const char*,
> and validate the string length using an assert() on
> x86_cpu_cpudef_class_init.
> 
> Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Oops, this patch makes 486, pentium, pentium2, pentium3 and
athlon crash because they don't have model_id explicitly set.

Fixup:
* Set model_id to "" explicitly on 486, pentium* and athlon (fix crash)
* Change assert() to ensure model_id is not NULL
* Move assert() to x86_register_cpudef_type() (closer to existing
  assert() that validates CPUID_EXT2_AMD_ALIASES)
---
 target/i386/cpu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ad79fbb111..170c0ecd43 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -939,6 +939,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             I486_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium",
@@ -950,6 +951,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium2",
@@ -961,6 +963,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM2_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "pentium3",
@@ -972,6 +975,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_EDX] =
             PENTIUM3_FEATURES,
         .xlevel = 0,
+        .model_id = "",
     },
     {
         .name = "athlon",
@@ -3160,9 +3164,6 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
     X86CPUDefinition *cpudef = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
 
-    /* catch mistakes instead of silently truncating model_id when too long */
-    assert(!cpudef->model_id || strlen(cpudef->model_id) <= 48);
-
     xcc->cpu_def = cpudef;
     xcc->migration_safe = true;
 }
@@ -3181,6 +3182,9 @@ static void x86_register_cpudef_type(X86CPUDefinition *def)
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

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw5z-0002qL-BE
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw5w-0003gy-8z
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYw5w-0003gT-33
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:45:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BADCC057F87
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 15:45:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  9 Jan 2018 13:45:13 -0200
Message-Id: <20180109154519.25634-2-ehabkost@redhat.com>
In-Reply-To: <20180109154519.25634-1-ehabkost@redhat.com>
References: <20180109154519.25634-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] i386: Change X86CPUDefinition::model_id to
 const char*
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
x86_cpu_cpudef_class_init.

Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3818d72831..9f4f949899 100644
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
@@ -2718,6 +2718,9 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
     X86CPUDefinition *cpudef = data;
     X86CPUClass *xcc = X86_CPU_CLASS(oc);
 
+    /* catch mistakes instead of silently truncating model_id when too long */
+    assert(!cpudef->model_id || strlen(cpudef->model_id) <= 48);
+
     xcc->cpu_def = cpudef;
     xcc->migration_safe = true;
 }
-- 
2.14.3

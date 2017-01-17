Received: from eggs.gnu.org ([2001:4830:134:3::10]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAG-0004od-I0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAD-0001U9-BK
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAD-0001U0-5P
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FD3AC04B302
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:01:56 -0200
Message-Id: <20170117010204.4909-2-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/9] target-i386: Move "host" properties to
 base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make the "pmu" and "host-cache-info" properties configurable on
all CPU model classes. This way, query-cpu-model-expansion will
be able to return the value of those properties when returning
expansion data using the "base" CPU model as base.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0b68c2d423..3b7fb331b6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1539,12 +1539,6 @@ static int cpu_x86_fill_model_id(char *str)
 
 static X86CPUDefinition host_cpudef;
 
-static Property host_x86_cpu_properties[] = {
-    DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
-    DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
-    DEFINE_PROP_END_OF_LIST()
-};
-
 /* class_init for the "host" CPU model
  *
  * This function may be called before KVM is initialized.
@@ -1575,7 +1569,6 @@ static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
      * instance_init, because they require KVM to be initialized.
      */
 
-    dc->props = host_x86_cpu_properties;
     /* Reason: host_x86_cpu_initfn() dies when !kvm_enabled() */
     dc->cannot_destroy_with_object_finalize_yet = true;
 }
@@ -3876,6 +3869,8 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
+    DEFINE_PROP_BOOL("host-cache-info", X86CPU, cache_info_passthrough, false),
+    DEFINE_PROP_BOOL("migratable", X86CPU, migratable, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.11.0.259.g40922b1

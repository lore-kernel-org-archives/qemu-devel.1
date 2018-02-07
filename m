Received: from eggs.gnu.org ([2001:4830:134:3::10]:57029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejQm2-0005E6-Lf
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ejQly-0005NW-Mt
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:32:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ejQly-0005NL-Id
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:32:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3189E40201A0
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 14:32:30 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  7 Feb 2018 15:30:57 +0100
Message-Id: <1518013857-4372-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20180207125710.GJ3291@localhost.localdomain>
References: <20180207125710.GJ3291@localhost.localdomain>
Subject: [Qemu-devel] [PATCH] cpu: drop unnecessary NULL check and
 cpu_common_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

both do nothing as for the first all callers
   parse_cpu_model() and qmp_query_cpu_model_()
should provide non NULL value, so just abort if it's not so.

While at it drop cpu_common_class_by_name() which is not need
any more as every target has CPUClass::class_by_name callback
by now, though abort in case a new arch will forget to define one.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
isn't really tested but it compiles and passes make check

 qom/cpu.c         | 14 ++------------
 target/i386/cpu.c |  8 +-------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index 60292df..92599f3 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -286,21 +286,12 @@ static bool cpu_common_has_work(CPUState *cs)
 
 ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
-    CPUClass *cc;
-
-    if (!cpu_model) {
-        return NULL;
-    }
-    cc = CPU_CLASS(object_class_by_name(typename));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(typename));
 
+    assert(cpu_model && cc->class_by_name);
     return cc->class_by_name(cpu_model);
 }
 
-static ObjectClass *cpu_common_class_by_name(const char *cpu_model)
-{
-    return NULL;
-}
-
 static void cpu_common_parse_features(const char *typename, char *features,
                                       Error **errp)
 {
@@ -418,7 +409,6 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     CPUClass *k = CPU_CLASS(klass);
 
-    k->class_by_name = cpu_common_class_by_name;
     k->parse_features = cpu_common_parse_features;
     k->reset = cpu_common_reset;
     k->get_arch_id = cpu_common_get_arch_id;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a49d222..61d915b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -740,13 +740,7 @@ static char *x86_cpu_type_name(const char *model_name)
 static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
-    char *typename;
-
-    if (cpu_model == NULL) {
-        return NULL;
-    }
-
-    typename = x86_cpu_type_name(cpu_model);
+    char *typename = x86_cpu_type_name(cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
     return oc;
-- 
2.7.4

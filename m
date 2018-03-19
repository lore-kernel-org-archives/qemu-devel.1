Received: from eggs.gnu.org ([2001:4830:134:3::10]:43284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19u-0002Ue-Qs
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ey19q-0006w3-0j
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ey19p-0006vb-Ql
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 16:13:25 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 19 Mar 2018 17:12:54 -0300
Message-Id: <20180319201255.9317-7-ehabkost@redhat.com>
In-Reply-To: <20180319201255.9317-1-ehabkost@redhat.com>
References: <20180319201255.9317-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v3 6/7] cpu: drop unnecessary NULL check and
 cpu_common_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Igor Mammedov <imammedo@redhat.com>

both do nothing as for the first all callers
   parse_cpu_model() and qmp_query_cpu_model_()
should provide non NULL value, so just abort if it's not so.

While at it drop cpu_common_class_by_name() which is not need
any more as every target has CPUClass::class_by_name callback
by now, though abort in case a new arch will forget to define one.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1518013857-4372-1-git-send-email-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/cpu.c         | 14 ++------------
 target/i386/cpu.c |  8 +-------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/qom/cpu.c b/qom/cpu.c
index 60292dfde9..92599f3541 100644
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
index 6bb4ce8719..30b4af897b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -781,13 +781,7 @@ static char *x86_cpu_type_name(const char *model_name)
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
2.14.3

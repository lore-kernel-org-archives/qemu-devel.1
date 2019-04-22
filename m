Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIimi-00058J-9N
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIifB-0005jO-L5
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIif9-0005ih-N9
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 22 Apr 2019 20:47:42 -0300
Message-Id: <20190422234742.15780-3-ehabkost@redhat.com>
In-Reply-To: <20190422234742.15780-1-ehabkost@redhat.com>
References: <20190422234742.15780-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] i386: "unavailable-features" QOM property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Add a "unavailable-features" QOM property to X86CPU objects that
have the same semantics of "unavailable-features" on
query-cpu-definitions.  The new property has the same goal of
"filtered-features", but is generic enough to let any kind of CPU
feature to be listed there without relying on low level details
like CPUID leaves or MSR numbers.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 23e55a9ef2..042d09a1bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3640,6 +3640,17 @@ static void x86_cpu_list_feature_names(FeatureWordArray features,
     }
 }
 
+static void x86_cpu_get_unavailable_features(Object *obj, Visitor *v,
+                                             const char *name, void *opaque,
+                                             Error **errp)
+{
+    X86CPU *xc = X86_CPU(obj);
+    strList *result = NULL;
+
+    x86_cpu_list_feature_names(xc->filtered_features, &result);
+    visit_type_strList(v, "unavailable-features", &result, errp);
+}
+
 /* Check for missing features that may prevent the CPU class from
  * running using the current machine and accelerator.
  */
@@ -5580,6 +5591,15 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features, NULL);
+    /*
+     * The "unavailable-features" property has the same semantics as
+     * CpuDefinitionInfo.unavailable-features on the "query-cpu-definitions"
+     * QMP command: they list the features that would have prevented the
+     * CPU from running if the "enforce" flag was set.
+     */
+    object_property_add(obj, "unavailable-features", "strList",
+                        x86_cpu_get_unavailable_features,
+                        NULL, NULL, NULL, &error_abort);
 
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
-- 
2.18.0.rc1.1.g3f1ff2140

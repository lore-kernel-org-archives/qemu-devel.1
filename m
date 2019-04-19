Received: from eggs.gnu.org ([209.51.188.92]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnN-0005pV-VV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnN-00055z-1O
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMnM-00055W-SC
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:14:27 -0300
Message-Id: <20190419061429.17695-6-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-1-ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/7] cpu: Let architectures set CPU class name
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

Instead of requiring every architecture to implement a
class_by_name function, let them set a format string at
CPUClass::class_name_format.

This will let us get rid of at least 16 class_by_name functions
in the next commits.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h | 12 ++++++++++++
 qom/cpu.c         | 18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index fefd5c26b0..eda6a46b82 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -163,7 +163,19 @@ typedef struct CPUClass {
     DeviceClass parent_class;
     /*< public >*/
 
+    /* The following fields configure CPU model name -> QOM type translation: */
+
+    /*
+     * arch-specific CPU model -> QOM type translation function.
+     * Optional if @class_name_format is set.
+     */
     ObjectClass *(*class_by_name)(const char *cpu_model);
+    /*
+     * Format string for g_strdup_printf(), used to generate the CPU
+     * class name.
+     */
+    const char *class_name_format;
+
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
     void (*reset)(CPUState *cpu);
diff --git a/qom/cpu.c b/qom/cpu.c
index b971a56242..1fa64941b6 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -286,9 +286,23 @@ static bool cpu_common_has_work(CPUState *cs)
 CPUClass *cpu_class_by_name(const char *typename, const char *cpu_model)
 {
     CPUClass *cc = CPU_CLASS(object_class_by_name(typename));
+    ObjectClass *oc;
+    char *class_name;
 
-    assert(cpu_model && cc->class_by_name);
-    return CPU_CLASS(cc->class_by_name(cpu_model));
+    assert(cpu_model);
+    if (cc->class_by_name) {
+        return CPU_CLASS(cc->class_by_name(cpu_model));
+    }
+
+    assert(cc->class_name_format);
+    class_name = g_strdup_printf(cc->class_name_format, cpu_model);
+    oc = object_class_by_name(class_name);
+    g_free(class_name);
+    if (!oc || !object_class_dynamic_cast(oc, typename) ||
+        object_class_is_abstract(oc)) {
+        return NULL;
+    }
+    return CPU_CLASS(oc);
 }
 
 static void cpu_common_parse_features(const char *typename, char *features,
-- 
2.18.0.rc1.1.g3f1ff2140

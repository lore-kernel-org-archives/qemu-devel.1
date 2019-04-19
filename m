Received: from eggs.gnu.org ([209.51.188.92]:59488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnM-0005nv-DT
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnL-00055F-BL
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:14:25 -0300
Message-Id: <20190419061429.17695-4-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-1-ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/7] arm: Don't split CPU model string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Greg Bellows <greg.bellows@linaro.org>, qemu-arm@nongnu.org

CPUClass::class_by_name is called after the CPU model name and
options were already split, there's no need to split the string
again.

Fixes: fb8d6c24b095 ("target-arm: Add CPU property to disable AArch64")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Greg Bellows <greg.bellows@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
---
 target/arm/cpu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4155782197..6848d9c94d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1212,22 +1212,17 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
     char *typename;
-    char **cpuname;
-    const char *cpunamestr;
 
-    cpuname = g_strsplit(cpu_model, ",", 1);
-    cpunamestr = cpuname[0];
 #ifdef CONFIG_USER_ONLY
     /* For backwards compatibility usermode emulation allows "-cpu any",
      * which has the same semantics as "-cpu max".
      */
-    if (!strcmp(cpunamestr, "any")) {
-        cpunamestr = "max";
+    if (!strcmp(cpu_model, "any")) {
+        cpu_model = "max";
     }
 #endif
-    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpunamestr);
+    typename = g_strdup_printf(ARM_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
-    g_strfreev(cpuname);
     g_free(typename);
     if (!oc || !object_class_dynamic_cast(oc, TYPE_ARM_CPU) ||
         object_class_is_abstract(oc)) {
-- 
2.18.0.rc1.1.g3f1ff2140

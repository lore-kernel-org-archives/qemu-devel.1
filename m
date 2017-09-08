Received: from eggs.gnu.org ([2001:4830:134:3::10]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeG-0002Id-G8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe7-0003OV-Ta
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:32 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:55 +1000
Message-Id: <20170908103558.31632-38-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 37/40] ppc: simplify cpu model lookup by PVR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 4092310c83..7c1d83b489 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -34,6 +34,7 @@
 #include "hw/ppc/ppc.h"
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
+#include "qemu/cutils.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10279,22 +10280,16 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
     char *cpu_model, *typename;
     ObjectClass *oc;
     const char *p;
-    int i, len;
-
-    /* Check if the given name is a PVR */
-    len = strlen(name);
-    if (len == 10 && name[0] == '0' && name[1] == 'x') {
-        p = name + 2;
-        goto check_pvr;
-    } else if (len == 8) {
-        p = name;
-    check_pvr:
-        for (i = 0; i < 8; i++) {
-            if (!qemu_isxdigit(*p++))
-                break;
-        }
-        if (i == 8) {
-            return OBJECT_CLASS(ppc_cpu_class_by_pvr(strtoul(name, NULL, 16)));
+    unsigned long pvr;
+
+    /* Lookup by PVR if cpu_model is valid 8 digit hex number
+     * (excl: 0x prefix if present)
+     */
+    if (!qemu_strtoul(name, &p, 16, &pvr)) {
+        int len = p - name;
+        len = (len == 10) && (name[1] == 'x') ? len - 2 : len;
+        if ((len == 8) && (*p == '\0')) {
+            return OBJECT_CLASS(ppc_cpu_class_by_pvr(pvr));
         }
     }
 
-- 
2.13.5

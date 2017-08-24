Received: from eggs.gnu.org ([2001:4830:134:3::10]:60388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dknOs-0008G2-Hw
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dknOr-0006ii-OM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:22:02 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 10:21:50 +0200
Message-Id: <1503562911-2776-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 5/6] ppc: simplify cpu model lookup by
 PVR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/ppc/translate_init.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index f1a559d..ca9f1e3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -34,6 +34,7 @@
 #include "hw/ppc/ppc.h"
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
+#include "qemu/cutils.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10203,22 +10204,16 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
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
+        if (len == 8) {
+            return OBJECT_CLASS(ppc_cpu_class_by_pvr(pvr));
         }
     }
 
-- 
2.7.4

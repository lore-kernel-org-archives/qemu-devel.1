Received: from eggs.gnu.org ([2001:4830:134:3::10]:50969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2z9-0001ow-TK
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dn2z8-0003Yw-Up
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:24:47 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 30 Aug 2017 15:24:33 +0200
Message-Id: <1504099475-241036-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/8] ppc: simplify cpu model lookup by PVR
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
v2:
  - if going PVR lookup routem check that cpu_model string consumed
    completely, as PVR number shouldn't have any stray symbol in it.
---
 target/ppc/translate_init.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index cf0d795..a803a7f 100644
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
+        if ((len == 8) && (*p == '\0')) {
+            return OBJECT_CLASS(ppc_cpu_class_by_pvr(pvr));
         }
     }
 
-- 
2.7.4

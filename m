Received: from eggs.gnu.org ([209.51.188.92]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmf-00059a-VO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMmf-0004n1-2T
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMme-0004me-TA
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:13:36 -0300
Message-Id: <20190419061349.17094-5-ehabkost@redhat.com>
In-Reply-To: <20190419061349.17094-1-ehabkost@redhat.com>
References: <20190419061349.17094-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 04/17] vl: Clean up after previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Since the previous commit, find_machine() and find_default_machine()
don't have to deallocate on return.  This permits further
simplifications.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190405064121.23662-4-richardw.yang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/vl.c b/vl.c
index 62f2656ccf..cb0f3f5856 100644
--- a/vl.c
+++ b/vl.c
@@ -1468,40 +1468,31 @@ MachineState *current_machine;
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
-    MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *temp = el->data;
+        MachineClass *mc = el->data;
 
-        if (!strcmp(temp->name, name)) {
-            mc = temp;
-            break;
-        }
-        if (temp->alias &&
-            !strcmp(temp->alias, name)) {
-            mc = temp;
-            break;
+        if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            return mc;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 static MachineClass *find_default_machine(GSList *machines)
 {
     GSList *el;
-    MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
-        MachineClass *temp = el->data;
+        MachineClass *mc = el->data;
 
-        if (temp->is_default) {
-            mc = temp;
-            break;
+        if (mc->is_default) {
+            return mc;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 MachineInfoList *qmp_query_machines(Error **errp)
-- 
2.18.0.rc1.1.g3f1ff2140

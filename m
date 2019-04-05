Received: from eggs.gnu.org ([209.51.188.92]:58164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY7-0003dr-84
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCIY6-0004VL-DW
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:40758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCIY6-0004O6-2b
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 02:42:02 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Fri,  5 Apr 2019 14:41:20 +0800
Message-Id: <20190405064121.23662-4-richardw.yang@linux.intel.com>
In-Reply-To: <20190405064121.23662-1-richardw.yang@linux.intel.com>
References: <20190405064121.23662-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/4] vl: Clean up after previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

Since the previous commit, find_machine() and find_default_machine()
don't have to deallocate on return.  This permits further
simplifications.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
---
 vl.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/vl.c b/vl.c
index cf08d96ce4..99f9cb2533 100644
--- a/vl.c
+++ b/vl.c
@@ -1421,40 +1421,31 @@ MachineState *current_machine;
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
2.19.1

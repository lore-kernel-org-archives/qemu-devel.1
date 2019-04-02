Received: from eggs.gnu.org ([209.51.188.92]:41542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJRH-0002yz-Jz
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJRG-0003Yq-F9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:26:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJRG-0003YA-6L
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:26:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:26:49 +0200
Message-Id: <20190402132650.23095-1-armbru@redhat.com>
In-Reply-To: <20190311060823.18360-1-richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
Subject: [Qemu-devel] [PATCH 3/4] vl: Clean up after previous commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richardw.yang@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

Since the previous commit, find_machine() and find_default_machine()
don't have to deallocate on return.  This permits further
simplifications.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/vl.c b/vl.c
index 126081f595..6a31e5bfac 100644
--- a/vl.c
+++ b/vl.c
@@ -1467,40 +1467,29 @@ MachineState *current_machine;
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
-
-        if (temp->is_default) {
-            mc = temp;
-            break;
+        if (((MachineClass *)el->data)->is_default) {
+            return el->data;
         }
     }
 
-    return mc;
+    return NULL;
 }
 
 MachineInfoList *qmp_query_machines(Error **errp)
-- 
2.17.2

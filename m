Received: from eggs.gnu.org ([2001:4830:134:3::10]:57155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fOm9k-00048b-CW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1fOm9g-00041Y-Ej
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:39:56 -0400
Received: from mail-ve1eur01on0111.outbound.protection.outlook.com
	([104.47.1.111]:57696
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ricardo.perez_blanco@nokia.com>)
	id 1fOm9f-00040K-Ql
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:39:52 -0400
From: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
Date: Fri,  1 Jun 2018 17:39:22 +0200
Message-Id: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "open list:All patches CC here" <qemu-devel@nongnu.org>

For debugging purposes it is very useful to:
 - See the description of the field. This information is already filled
   in but not shown in "qom-list" command.
 - Display value of the field.

Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
---
 hmp.c          | 13 +++++++++++--
 qapi/misc.json |  6 ++++--
 qmp.c          |  7 +++++++
 qom/object.c   |  8 +++-----
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/hmp.c b/hmp.c
index a25c7bd9a8..ff3a024cd0 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2490,8 +2490,17 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
         while (list != NULL) {
             ObjectPropertyInfo *value = list->value;
 
-            monitor_printf(mon, "%s (%s)\n",
-                           value->name, value->type);
+            monitor_printf(mon, "%s", value->name);
+            if (value->has_value) {
+                monitor_printf(mon, "=%s", value->value);
+            }
+            monitor_printf(mon, " (%s)", value->type);
+            if (value->has_description) {
+                monitor_printf(mon, "\r\t\t\t\t\t\t\t\t\t[Description: %s]",
+                               value->description);
+            }
+            monitor_printf(mon, "\n");
+
             list = list->next;
         }
         qapi_free_ObjectPropertyInfoList(start);
diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a149..b4bc472a37 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1328,10 +1328,12 @@
 #
 # @description: if specified, the description of the property.
 #
-# Since: 1.2
+# @value: if specified, the value of the property.
+#
+# Since: 2.13
 ##
 { 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
+  'data': { 'name': 'str', 'type': 'str', '*description': 'str', '*value': 'str' } }
 
 ##
 # @qom-list:
diff --git a/qmp.c b/qmp.c
index f72261667f..39cf656f97 100644
--- a/qmp.c
+++ b/qmp.c
@@ -237,6 +237,13 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
 
         entry->value->name = g_strdup(prop->name);
         entry->value->type = g_strdup(prop->type);
+        if (prop->description) {
+            entry->value->has_description = true;
+            entry->value->description = g_strdup(prop->description);
+        }
+        entry->value->has_value = true;
+        entry->value->value = g_strdup(object_property_print(obj,
+                                 entry->value->name, true, errp));
     }
 
     return props;
diff --git a/qom/object.c b/qom/object.c
index 467795189c..4d1606e5f9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1359,13 +1359,11 @@ char *object_property_print(Object *obj, const char *name, bool human,
     v = string_output_visitor_new(human, &string);
     object_property_get(obj, v, name, &local_err);
     if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
+        string = g_strdup("<Error reading value>");
+    } else {
+        visit_complete(v, &string);
     }
 
-    visit_complete(v, &string);
-
-out:
     visit_free(v);
     return string;
 }
-- 
2.16.3

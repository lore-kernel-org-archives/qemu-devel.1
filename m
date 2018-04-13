Received: from eggs.gnu.org ([2001:4830:134:3::10]:39782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1f6tiB-00054y-FA
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.perez_blanco@nokia.com>) id 1f6ti7-00012s-AF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:05:35 -0400
Received: from mail-db5eur01on0110.outbound.protection.outlook.com
	([104.47.2.110]:64416
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ricardo.perez_blanco@nokia.com>)
	id 1f6ti6-0000vf-KX
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:05:31 -0400
From: "Perez Blanco, Ricardo (Nokia - BE/Antwerp)"
	<ricardo.perez_blanco@nokia.com>
Date: Fri, 13 Apr 2018 08:05:26 +0000
Message-ID: <AM3PR07MB273186AEFA49A506BFC2D28B3B30@AM3PR07MB273.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>

Dear all,

Here you can find my first contribution to qemu. Please, do not hesitate to=
 do any kind of remark.

Based on ac4ba87ae0738d7a77708f8ce31ae2378ab99654

Kind regards,

Ricardo Perez Blanco

>From 65df20cef2846d764a8a821574f5f3643391aac5 Mon Sep 17 00:00:00 2001
From: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
Date: Wed, 11 Apr 2018 12:09:11 +0200
Subject: [PATCH] Show values and description when using "qom-list"

For debugging purposes it is very useful to:
 - See the description of the field. This information is already filled
   in but not shown in "qom-list" command.
 - Display value of the field. So far, only well known types are
   implemented (string, str, int, uint, bool).

Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
---
 hmp.c          | 13 +++++++++++--
 qapi/misc.json |  4 +++-
 qmp.c          | 26 ++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index a25c7bd..967e0b2 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2490,8 +2490,17 @@ void hmp_qom_list(Monitor *mon, const QDict *qdict)
         while (list !=3D NULL) {
             ObjectPropertyInfo *value =3D list->value;

-            monitor_printf(mon, "%s (%s)\n",
-                           value->name, value->type);
+            monitor_printf(mon, "%s", value->name);
+            if (value->value) {
+                monitor_printf(mon, "=3D%s", value->value);
+            }
+            monitor_printf(mon, " (%s)", value->type);
+            if (value->description) {
+                monitor_printf(mon, "\r\t\t\t\t\t\t\t\t\t[Description: %s]=
",
+                               value->description);
+            }
+            monitor_printf(mon, "\n");
+
             list =3D list->next;
         }
         qapi_free_ObjectPropertyInfoList(start);
diff --git a/qapi/misc.json b/qapi/misc.json
index 5636f4a..6b3b4de 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1328,10 +1328,12 @@
 #
 # @description: if specified, the description of the property.
 #
+# @value: if specified, the value of the property.
+#
 # Since: 1.2
 ##
 { 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
+  'data': { 'name': 'str', 'type': 'str', '*description':'str', '*value':'=
str' } }

 ##
 # @qom-list:
diff --git a/qmp.c b/qmp.c
index f722616..750b5d0 100644
--- a/qmp.c
+++ b/qmp.c
@@ -237,6 +237,32 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path,=
 Error **errp)

         entry->value->name =3D g_strdup(prop->name);
         entry->value->type =3D g_strdup(prop->type);
+        if (prop->description) {
+            entry->value->description =3D g_strdup(prop->description);
+        }
+        if ((g_ascii_strncasecmp(entry->value->type, "string", 6) =3D=3D 0=
) ||
+            (g_ascii_strncasecmp(entry->value->type, "str", 3) =3D=3D 0)) =
{
+            Error **errp =3D NULL;
+            entry->value->value =3D g_strdup_printf("\"%s\"",
+                object_property_get_str(obj, entry->value->name, errp));
+        }
+        if (g_ascii_strncasecmp(entry->value->type, "int", 3) =3D=3D 0) {
+            Error **errp =3D NULL;
+            entry->value->value =3D g_strdup_printf("%ld",
+                object_property_get_int(obj, entry->value->name, errp));
+        }
+        if (g_ascii_strncasecmp(entry->value->type, "uint", 4) =3D=3D 0) {
+            Error **errp =3D NULL;
+            entry->value->value =3D g_strdup_printf("%lu",
+                object_property_get_uint(obj, entry->value->name, errp));
+        }
+        if (g_ascii_strncasecmp(entry->value->type, "bool", 4) =3D=3D 0) {
+            Error **errp =3D NULL;
+            entry->value->value =3D g_strdup_printf("%s",
+               (object_property_get_bool(obj, entry->value->name, errp) =
=3D=3D true)
+                ? "true" : "false");
+        }
+
     }

     return props;
--
1.8.3.1

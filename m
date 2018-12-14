Received: from eggs.gnu.org ([2001:4830:134:3::10]:59356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm5-0005fp-66
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gXqm3-0002BD-52
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:17 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com
	([40.107.8.118]:22409
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gXqm2-0001B5-PI
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 11:57:15 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 14 Dec 2018 16:57:07 +0000
Message-ID: <20181214165657.749-3-rkagan@virtuozzo.com>
References: <20181214165657.749-1-rkagan@virtuozzo.com>
In-Reply-To: <20181214165657.749-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC PATCH 2/5] qmp: further consolidate listing of
 device and object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>

Take the approach of commit 35f63767dc77d85bebff6c6565aceaf74023776a
"qmp: Merge ObjectPropertyInfo and DevicePropertyInfo" one step further:
drop device property-specific code from qmp_device_list_properties and
consolidate the resulting common part with qmp_qom_list_properties.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 qmp.c | 92 ++++++++++++++---------------------------------------------
 1 file changed, 22 insertions(+), 70 deletions(-)

diff --git a/qmp.c b/qmp.c
index e7c0a2fd60..673dfa72ce 100644
--- a/qmp.c
+++ b/qmp.c
@@ -430,56 +430,22 @@ ObjectTypeInfoList *qmp_qom_list_types(bool has_imple=
ments,
     return ret;
 }
=20
-/* Return a DevicePropertyInfo for a qdev property.
- *
- * If a qdev property with the given name does not exist, use the given de=
fault
- * type.  If the qdev property info should not be shown, return NULL.
- *
- * The caller must free the return value.
- */
-static ObjectPropertyInfo *make_device_property_info(ObjectClass *klass,
-                                                  const char *name,
-                                                  const char *default_type=
,
-                                                  const char *description)
+static void push_property_info(ObjectPropertyInfoList **prop_list,
+                               ObjectProperty *prop)
 {
     ObjectPropertyInfo *info;
-    Property *prop;
-
-    do {
-        for (prop =3D DEVICE_CLASS(klass)->props; prop && prop->name; prop=
++) {
-            if (strcmp(name, prop->name) !=3D 0) {
-                continue;
-            }
-
-            /*
-             * TODO Properties without a parser are just for dirty hacks.
-             * qdev_prop_ptr is the only such PropertyInfo.  It's marked
-             * for removal.  This conditional should be removed along with
-             * it.
-             */
-            if (!prop->info->set && !prop->info->create) {
-                return NULL;           /* no way to set it, don't show */
-            }
-
-            info =3D g_malloc0(sizeof(*info));
-            info->name =3D g_strdup(prop->name);
-            info->type =3D default_type ? g_strdup(default_type)
-                                      : g_strdup(prop->info->name);
-            info->has_description =3D !!prop->info->description;
-            info->description =3D g_strdup(prop->info->description);
-            return info;
-        }
-        klass =3D object_class_get_parent(klass);
-    } while (klass !=3D object_class_by_name(TYPE_DEVICE));
-
-    /* Not a qdev property, use the default type */
-    info =3D g_malloc0(sizeof(*info));
-    info->name =3D g_strdup(name);
-    info->type =3D g_strdup(default_type);
-    info->has_description =3D !!description;
-    info->description =3D g_strdup(description);
-
-    return info;
+    ObjectPropertyInfoList *entry;
+
+    info =3D g_new0(ObjectPropertyInfo, 1);
+    info->name =3D g_strdup(prop->name);
+    info->type =3D g_strdup(prop->type);
+    info->has_description =3D !!prop->description;
+    info->description =3D g_strdup(prop->description);
+
+    entry =3D g_new0(ObjectPropertyInfoList, 1);
+    entry->value =3D info;
+    entry->next =3D *prop_list;
+    *prop_list =3D entry;
 }
=20
 ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
@@ -514,9 +480,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(cons=
t char *typename,
=20
     object_property_iter_init(&iter, obj);
     while ((prop =3D object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
-        ObjectPropertyInfoList *entry;
-
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") =3D=3D 0 ||
             strcmp(prop->name, "realized") =3D=3D 0 ||
@@ -533,16 +496,12 @@ ObjectPropertyInfoList *qmp_device_list_properties(co=
nst char *typename,
             continue;
         }
=20
-        info =3D make_device_property_info(klass, prop->name, prop->type,
-                                         prop->description);
-        if (!info) {
+        /* Skip readonly properties. */
+        if (!prop->set) {
             continue;
         }
=20
-        entry =3D g_malloc0(sizeof(*entry));
-        entry->value =3D info;
-        entry->next =3D prop_list;
-        prop_list =3D entry;
+        push_property_info(&prop_list, prop);
     }
=20
     object_unref(obj);
@@ -579,19 +538,12 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const=
 char *typename,
         object_property_iter_init(&iter, obj);
     }
     while ((prop =3D object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
-        ObjectPropertyInfoList *entry;
+        /* Skip readonly properties. */
+        if (!prop->set) {
+            continue;
+        }
=20
-        info =3D g_malloc0(sizeof(*info));
-        info->name =3D g_strdup(prop->name);
-        info->type =3D g_strdup(prop->type);
-        info->has_description =3D !!prop->description;
-        info->description =3D g_strdup(prop->description);
-
-        entry =3D g_malloc0(sizeof(*entry));
-        entry->value =3D info;
-        entry->next =3D prop_list;
-        prop_list =3D entry;
+        push_property_info(&prop_list, prop);
     }
=20
     object_unref(obj);
--=20
2.19.2

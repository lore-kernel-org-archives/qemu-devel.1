Received: from eggs.gnu.org ([2001:4830:134:3::10]:43396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dB6SC-000247-SP
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dB6S9-0007UT-ME
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dB6S9-0007Tn-Cn
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:25:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CA19C0467C5
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 21:25:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 18:25:47 -0300
Message-Id: <20170517212547.4767-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC] qmp: Return 'user_creatable' & 'hotpluggable'
 fields on qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Currently there's no way for QMP clients to get a list of device types
that are really usable with -device.  This information would be useful
for management software and test scripts (like the device-crash-test
script I have submitted recently).  Interestingly, the "info qdm" HMP
command provides this information, but no QMP command does.

Add two new fields to the return value of qom-list-types:
"user-creatable-device" and "hotpluggable-device".  Also, add extra
arguments for filtering the list of types based on the new fields.

I'm not sure about the naming of the new command arguments.  Maybe the
names are too long, but I believe that "user-creatable-devices-only=false"
would have more obvious semantics than "user-creatable-devices=false"
(the latter looks ambiguous: it could mean "return only
non-user-creatable devices" or "return all devices").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json | 25 +++++++++++++++++++++++--
 qmp.c            | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 80603cfc51..c0a56fc3a2 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3034,12 +3034,24 @@
 #
 # @name: the type name found in the search
 #
+# @user-creatable-device: If true, the type is a user-creatable device that
+#                         can be used with the "-device" command-line option.
+#                         Note that this does not guarantee that the device
+#                         is going to be accepted by all machine-types.
+#                         (since 2.10)
+#
+# @hotpluggable-device: If true, the type is a hotpluggable device that can
+#                       be plugged using the "device_add" monitor command.
+#                       Note that this does not guarantee that the device can
+#                       be hotplugged on any machine-type. (since 2.10)
+#
 # Since: 1.1
 #
 # Notes: This command is experimental and may change syntax in future releases.
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', 'user-creatable-device': 'bool',
+            'hotpluggable-device': 'bool' } }
 
 ##
 # @qom-list-types:
@@ -3050,12 +3062,21 @@
 #
 # @abstract: if true, include abstract types in the results
 #
+# @user-creatable-devices-only: If true, return only user-creatable device types
+#                               (See @ObjectTypeInfo.user-creatable-device)
+#                               (since 2.10)
+#
+# @hotpluggable-devices-only: If true, return only hotpluggable device types
+#                             (See @ObjectTypeInfo.hotpluggable-device)
+#                             (since 2.10)
+#
 # Returns: a list of @ObjectTypeInfo or an empty list if no results are found
 #
 # Since: 1.1
 ##
 { 'command': 'qom-list-types',
-  'data': { '*implements': 'str', '*abstract': 'bool' },
+  'data': { '*implements': 'str', '*abstract': 'bool',
+            '*user-creatable-devices-only': 'bool', '*hotpluggable-devices-only': 'bool' },
   'returns': [ 'ObjectTypeInfo' ] }
 
 ##
diff --git a/qmp.c b/qmp.c
index f656940769..4f350e4ea2 100644
--- a/qmp.c
+++ b/qmp.c
@@ -436,29 +436,58 @@ void qmp_change(const char *device, const char *target,
     }
 }
 
+typedef struct QOMListTypesArgs {
+    bool user_creatable_devices_only;
+    bool hotpluggable_devices_only;
+    ObjectTypeInfoList **pret;
+} QOMListTypesArgs;
+
 static void qom_list_types_tramp(ObjectClass *klass, void *data)
 {
-    ObjectTypeInfoList *e, **pret = data;
+    QOMListTypesArgs *args = data;
+    ObjectTypeInfoList *e;
     ObjectTypeInfo *info;
+    DeviceClass *dc = DEVICE_CLASS(object_class_dynamic_cast(klass,
+                                                             TYPE_DEVICE));
+    bool uc = dc ? dc->user_creatable : false;
+    bool hp = dc ? uc && dc->hotpluggable : false;
+
+    if ((args->user_creatable_devices_only && !uc) ||
+        (args->hotpluggable_devices_only && !hp)) {
+        return;
+    }
 
     info = g_malloc0(sizeof(*info));
     info->name = g_strdup(object_class_get_name(klass));
+    info->user_creatable_device = uc;
+    info->hotpluggable_device = hp;
 
     e = g_malloc0(sizeof(*e));
     e->value = info;
-    e->next = *pret;
-    *pret = e;
+    e->next = *args->pret;
+    *args->pret = e;
 }
 
 ObjectTypeInfoList *qmp_qom_list_types(bool has_implements,
                                        const char *implements,
                                        bool has_abstract,
                                        bool abstract,
+                                       bool has_user_creatable_devices_only,
+                                       bool user_creatable_devices_only,
+                                       bool has_hotpluggable_devices_only,
+                                       bool hotpluggable_devices_only,
                                        Error **errp)
 {
     ObjectTypeInfoList *ret = NULL;
-
-    object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
+    QOMListTypesArgs args = {
+        .pret = &ret,
+        .user_creatable_devices_only = has_user_creatable_devices_only &&
+                                      user_creatable_devices_only,
+        .hotpluggable_devices_only = has_hotpluggable_devices_only &&
+                                    hotpluggable_devices_only,
+    };
+
+    object_class_foreach(qom_list_types_tramp, implements, abstract, &args);
 
     return ret;
 }
-- 
2.11.0.259.g40922b1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx1-0004J0-9w
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxwz-00036v-SB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwxwz-00036j-MS
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 19:03:24 -0300
Message-Id: <20170926220326.12996-3-ehabkost@redhat.com>
In-Reply-To: <20170926220326.12996-1-ehabkost@redhat.com>
References: <20170926220326.12996-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] qmp: get_device_class() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <dgibson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>

Extract device type lookup code from qmp_device_list_properties()
to a get_device_class() helper.  It will be reused by other QMP
commands.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qmp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/qmp.c b/qmp.c
index dec4bd843b..5ec829c09b 100644
--- a/qmp.c
+++ b/qmp.c
@@ -517,14 +517,9 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
     return info;
 }
 
-DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
-                                                   Error **errp)
+static DeviceClass *get_device_class(const char *typename, Error **errp)
 {
     ObjectClass *klass;
-    Object *obj;
-    ObjectProperty *prop;
-    ObjectPropertyIterator iter;
-    DevicePropertyInfoList *prop_list = NULL;
 
     klass = object_class_by_name(typename);
     if (klass == NULL) {
@@ -539,6 +534,23 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
         return NULL;
     }
 
+    return DEVICE_CLASS(klass);
+}
+
+DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
+                                                   Error **errp)
+{
+    ObjectClass *klass;
+    Object *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+    DevicePropertyInfoList *prop_list = NULL;
+
+    klass = OBJECT_CLASS(get_device_class(typename, errp));
+    if (!klass) {
+        return NULL;
+    }
+
     if (object_class_is_abstract(klass)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "typename",
                    "non-abstract device type");
-- 
2.13.5

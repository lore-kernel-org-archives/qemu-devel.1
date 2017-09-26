Received: from eggs.gnu.org ([2001:4830:134:3::10]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx1-0004Iz-9p
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxwy-00036J-2J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwxwx-000369-SJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 19:03:23 -0300
Message-Id: <20170926220326.12996-2-ehabkost@redhat.com>
In-Reply-To: <20170926220326.12996-1-ehabkost@redhat.com>
References: <20170926220326.12996-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] qmp: qom_type_get_info() helper
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

Extract the code that fills ObjectTypeInfo fields to a
qom_type_get_info() helper.  It will be reused in other QMP
commands.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qmp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/qmp.c b/qmp.c
index e8c303116a..dec4bd843b 100644
--- a/qmp.c
+++ b/qmp.c
@@ -426,19 +426,25 @@ void qmp_change(const char *device, const char *target,
     }
 }
 
-static void qom_list_types_tramp(ObjectClass *klass, void *data)
+static void qom_type_get_info(ObjectClass *klass, ObjectTypeInfo *info)
 {
-    ObjectTypeInfoList *e, **pret = data;
-    ObjectTypeInfo *info;
     ObjectClass *parent = object_class_get_parent(klass);
 
-    info = g_malloc0(sizeof(*info));
     info->name = g_strdup(object_class_get_name(klass));
     info->has_abstract = info->abstract = object_class_is_abstract(klass);
     if (parent) {
         info->has_parent = true;
         info->parent = g_strdup(object_class_get_name(parent));
     }
+}
+
+static void qom_list_types_tramp(ObjectClass *klass, void *data)
+{
+    ObjectTypeInfoList *e, **pret = data;
+    ObjectTypeInfo *info;
+
+    info = g_malloc0(sizeof(*info));
+    qom_type_get_info(klass, info);
 
     e = g_malloc0(sizeof(*e));
     e->value = info;
-- 
2.13.5

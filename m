Received: from eggs.gnu.org ([2001:4830:134:3::10]:37158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmP-0003PR-16
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmN-0000PG-L3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmN-0000OY-Ex
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:09 +0200
Message-Id: <1503564371-26090-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 14/16] qapi: Convert indirect uses of
 FOO_lookup[...] to qapi_enum_lookup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties.c | 7 +++++--
 qapi/qapi-visit-core.c    | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 078fc5d..7512bd4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -72,7 +72,9 @@ static void set_enum(Object *obj, Visitor *v, const char *name, void *opaque,
 
 static void set_default_value_enum(Object *obj, const Property *prop)
 {
-    object_property_set_str(obj, prop->info->enum_table[prop->defval.i],
+    object_property_set_str(obj,
+                            qapi_enum_lookup(prop->info->enum_table,
+                                             prop->defval.i),
                             prop->name, &error_abort);
 }
 
@@ -1095,7 +1097,8 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
     Property *prop;
 
     prop = qdev_prop_find(dev, name);
-    object_property_set_str(OBJECT(dev), prop->info->enum_table[value],
+    object_property_set_str(OBJECT(dev),
+                            qapi_enum_lookup(prop->info->enum_table, value),
                             name, &error_abort);
 }
 
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index f285879..30dc85b 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -345,7 +345,7 @@ static void output_type_enum(Visitor *v, const char *name, int *obj,
         return;
     }
 
-    enum_str = (char *)strings[value];
+    enum_str = (char *)qapi_enum_lookup(strings, value);
     visit_type_str(v, name, &enum_str, errp);
 }
 
-- 
2.7.5

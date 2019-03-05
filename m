Received: from eggs.gnu.org ([209.51.188.92]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1DJJ-00032X-3T
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1DJH-0002fg-HQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:52:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1DJH-0002Yh-2d
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:52:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A3E0308338F
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:52:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-92.ams2.redhat.com
	[10.36.116.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E8860A9A
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 16:52:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  5 Mar 2019 17:52:36 +0100
Message-Id: <20190305165236.8389-8-armbru@redhat.com>
In-Reply-To: <20190305165236.8389-1-armbru@redhat.com>
References: <20190305165236.8389-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] qapi: Fix array first used in a different
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We generally put implicitly defined types in whatever module triggered
their definition.  This is wrong for array types, as the included test
case demonstrates.  Let's have a closer look at it.

Type 'Status' is defined sub-sub-module.json.  Array type ['Status']
occurs in main module qapi-schema-test.json and in
include/sub-module.json.  The main module's use is first, so the array
type gets put into the main module.

The generated C headers define StatusList in qapi-types.h.  But
include/qapi-types-sub-module.h uses it without including
qapi-types.h.  Oops.

To fix that, put the array type into its element type's module.

Now StatusList gets generated into qapi-types-sub-module.h, which all
its users include.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190301154051.23317-8-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                    | 9 +++++----
 tests/qapi-schema/include/sub-module.json | 2 ++
 tests/qapi-schema/qapi-schema-test.out    | 5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f51948364c..f07869ec73 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1089,6 +1089,9 @@ class QAPISchemaEntity(object):
             self.ifcond = typ.ifcond
         else:
             self.ifcond = listify_cond(self._ifcond)
+        if self.info:
+            self.module = os.path.relpath(self.info['file'],
+                                          os.path.dirname(schema.fname))
 
     def is_implicit(self):
         return not self.info
@@ -1262,6 +1265,7 @@ class QAPISchemaArrayType(QAPISchemaType):
         self.element_type = schema.lookup_type(self._element_type_name)
         assert self.element_type
         self.element_type.check(schema)
+        self.module = self.element_type.module
         self.ifcond = self.element_type.ifcond
 
     def is_implicit(self):
@@ -1603,7 +1607,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
 
 class QAPISchema(object):
     def __init__(self, fname):
-        self._fname = fname
+        self.fname = fname
         if sys.version_info[0] >= 3:
             f = open(fname, 'r', encoding='utf-8')
         else:
@@ -1626,9 +1630,6 @@ class QAPISchema(object):
         self._entity_list.append(ent)
         if ent.name is not None:
             self._entity_dict[ent.name] = ent
-        if ent.info:
-            ent.module = os.path.relpath(ent.info['file'],
-                                         os.path.dirname(self._fname))
 
     def lookup_entity(self, name, typ=None):
         ent = self._entity_dict.get(name)
diff --git a/tests/qapi-schema/include/sub-module.json b/tests/qapi-schema/include/sub-module.json
index f2bdbd3990..afdb267228 100644
--- a/tests/qapi-schema/include/sub-module.json
+++ b/tests/qapi-schema/include/sub-module.json
@@ -3,3 +3,5 @@
 # Sub-module of ../qapi-schema-test.json
 
 { 'include': '../sub-sub-module.json' }
+
+{ 'struct': 'SecondArrayRef', 'data': { 's': ['Status'] } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 38c1de70d8..77fb1e1aa9 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -144,7 +144,9 @@ object q_obj_sizeList-wrapper
     member data: sizeList optional=False
 object q_obj_anyList-wrapper
     member data: anyList optional=False
+module sub-sub-module.json
 array StatusList Status
+module qapi-schema-test.json
 object q_obj_StatusList-wrapper
     member data: StatusList optional=False
 enum UserDefListUnionKind
@@ -189,6 +191,9 @@ enum Status
     member good
     member bad
     member ugly
+module include/sub-module.json
+object SecondArrayRef
+    member s: StatusList optional=False
 module qapi-schema-test.json
 command user_def_cmd None -> None
    gen=True success_response=True boxed=False oob=False preconfig=False
-- 
2.17.2

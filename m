Received: from eggs.gnu.org ([2001:4830:134:3::10]:56711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO38-0000pr-BX
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fWO35-0000JM-TP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fWO35-0000IW-MI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:32:31 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 22 Jun 2018 17:32:23 +0200
Message-Id: <20180622153228.23594-6-armbru@redhat.com>
In-Reply-To: <20180622153228.23594-1-armbru@redhat.com>
References: <20180622153228.23594-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] qapi: allow empty branches in flat unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

It often happens that just a few discriminator values imply extra data in
a flat union. Existing checks did not make possible to leave other values
uncovered. Such cases had to be worked around by either stating a dummy
(empty) type or introducing another (subset) discriminator enumeration.

Both options create redundant entities in qapi files for little profit.

With this patch it is not necessary anymore to add designated union
fields for every possible value of a discriminator enumeration.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-Id: <1529311206-76847-2-git-send-email-anton.nefedov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt                  |  8 +++++---
 scripts/qapi/common.py                        | 15 ++++++++-------
 scripts/qapi/types.py                         |  2 ++
 scripts/qapi/visit.py                         | 19 ++++++++++++++-----
 tests/Makefile.include                        |  1 -
 .../flat-union-incomplete-branch.err          |  1 -
 .../flat-union-incomplete-branch.exit         |  1 -
 .../flat-union-incomplete-branch.json         |  9 ---------
 .../flat-union-incomplete-branch.out          |  0
 tests/qapi-schema/qapi-schema-test.json       |  6 ++++--
 tests/qapi-schema/qapi-schema-test.out        |  3 ++-
 11 files changed, 35 insertions(+), 30 deletions(-)
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.err
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.exit
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.json
 delete mode 100644 tests/qapi-schema/flat-union-incomplete-branch.out

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 1366228b2a..88a70e4d45 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -496,9 +496,11 @@ Resulting in these JSON objects:
 
 Notice that in a flat union, the discriminator name is controlled by
 the user, but because it must map to a base member with enum type, the
-code generator can ensure that branches exist for all values of the
-enum (although the order of the keys need not match the declaration of
-the enum).  In the resulting generated C data types, a flat union is
+code generator ensures that branches match the existing values of the
+enum. The order of the keys need not match the declaration of the enum.
+The keys need not cover all possible enum values. Omitted enum values
+are still valid branches that add no additional members to the data type.
+In the resulting generated C data types, a flat union is
 represented as a struct with the base members included directly, and
 then a union of structures for each branch of the struct.
 
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 2462fc0291..4b53f08627 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -779,13 +779,6 @@ def check_union(expr, info):
                                    "enum '%s'"
                                    % (key, enum_define['enum']))
 
-    # If discriminator is user-defined, ensure all values are covered
-    if enum_define:
-        for value in enum_define['data']:
-            if value not in members.keys():
-                raise QAPISemError(info, "Union '%s' data missing '%s' branch"
-                                   % (name, value))
-
 
 def check_alternate(expr, info):
     name = expr['alternate']
@@ -1357,6 +1350,14 @@ class QAPISchemaObjectTypeVariants(object):
             self.tag_member = seen[c_name(self._tag_name)]
             assert self._tag_name == self.tag_member.name
         assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+        if self._tag_name:    # flat union
+            # branches that are not explicitly covered get an empty type
+            cases = set([v.name for v in self.variants])
+            for val in self.tag_member.type.values:
+                if val.name not in cases:
+                    v = QAPISchemaObjectTypeVariant(val.name, 'q_empty')
+                    v.set_owner(self.tag_member.owner)
+                    self.variants.append(v)
         for v in self.variants:
             v.check(schema)
             # Union names must match enum values; alternate names are
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 64d9c0fb37..a599352e59 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -125,6 +125,8 @@ def gen_variants(variants):
                 c_name=c_name(variants.tag_member.name))
 
     for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
         ret += mcgen('''
         %(c_type)s %(c_name)s;
 ''',
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 3c5ea1289e..bdcafb64ee 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -81,15 +81,24 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
                      c_name=c_name(variants.tag_member.name))
 
         for var in variants.variants:
-            ret += mcgen('''
+            case_str = c_enum_const(variants.tag_member.type.name,
+                                    var.name,
+                                    variants.tag_member.type.prefix)
+            if var.type.name == 'q_empty':
+                # valid variant and nothing to do
+                ret += mcgen('''
+    case %(case)s:
+        break;
+''',
+                             case=case_str)
+            else:
+                ret += mcgen('''
     case %(case)s:
         visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, &err);
         break;
 ''',
-                         case=c_enum_const(variants.tag_member.type.name,
-                                           var.name,
-                                           variants.tag_member.type.prefix),
-                         c_type=var.type.c_name(), c_name=c_name(var.name))
+                             case=case_str,
+                             c_type=var.type.c_name(), c_name=c_name(var.name))
 
         ret += mcgen('''
     default:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7c48cfe14e..8b45f01d25 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -499,7 +499,6 @@ qapi-schema += flat-union-base-any.json
 qapi-schema += flat-union-base-union.json
 qapi-schema += flat-union-clash-member.json
 qapi-schema += flat-union-empty.json
-qapi-schema += flat-union-incomplete-branch.json
 qapi-schema += flat-union-inline.json
 qapi-schema += flat-union-int-branch.json
 qapi-schema += flat-union-invalid-branch-key.json
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err b/tests/qapi-schema/flat-union-incomplete-branch.err
deleted file mode 100644
index e826bf0789..0000000000
--- a/tests/qapi-schema/flat-union-incomplete-branch.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion' data missing 'value2' branch
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.exit b/tests/qapi-schema/flat-union-incomplete-branch.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/flat-union-incomplete-branch.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.json b/tests/qapi-schema/flat-union-incomplete-branch.json
deleted file mode 100644
index 25a411bc83..0000000000
--- a/tests/qapi-schema/flat-union-incomplete-branch.json
+++ /dev/null
@@ -1,9 +0,0 @@
-# we require all branches of the union to be covered
-{ 'enum': 'TestEnum',
-  'data': [ 'value1', 'value2' ] }
-{ 'struct': 'TestTypeA',
-  'data': { 'string': 'str' } }
-{ 'union': 'TestUnion',
-  'base': { 'type': 'TestEnum' },
-  'discriminator': 'type',
-  'data': { 'value1': 'TestTypeA' } }
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.out b/tests/qapi-schema/flat-union-incomplete-branch.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 46c7282945..7b59817f04 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -39,7 +39,7 @@
             '*enum1': 'EnumOne' } }   # intentional forward reference
 
 { 'enum': 'EnumOne',
-  'data': [ 'value1', 'value2', 'value3' ] }
+  'data': [ 'value1', 'value2', 'value3', 'value4' ] }
 
 { 'struct': 'UserDefZero',
   'data': { 'integer': 'int' } }
@@ -76,7 +76,9 @@
   'discriminator': 'enum1',
   'data': { 'value1' : 'UserDefA',
             'value2' : 'UserDefB',
-            'value3' : 'UserDefB' } }
+            'value3' : 'UserDefB'
+            # 'value4' defaults to empty
+  } }
 
 { 'struct': 'UserDefUnionBase',
   'base': 'UserDefZero',
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 542a19c407..0dbcdafa3c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -23,7 +23,7 @@ object UserDefOne
     base UserDefZero
     member string: str optional=False
     member enum1: EnumOne optional=True
-enum EnumOne ['value1', 'value2', 'value3']
+enum EnumOne ['value1', 'value2', 'value3', 'value4']
 object UserDefZero
     member integer: int optional=False
 object UserDefTwoDictDict
@@ -52,6 +52,7 @@ object UserDefFlatUnion
     case value1: UserDefA
     case value2: UserDefB
     case value3: UserDefB
+    case value4: q_empty
 object UserDefUnionBase
     base UserDefZero
     member string: str optional=False
-- 
2.17.1

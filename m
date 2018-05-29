Received: from eggs.gnu.org ([2001:4830:134:3::10]:47808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fNhh1-0002Wc-Ua
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1fNhgx-0003tF-FZ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:41:51 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:7424
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1fNhgx-0003qD-87
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:41:47 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 29 May 2018 19:41:31 +0300
Message-Id: <1527612092-65980-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1527612092-65980-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1527612092-65980-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/2] qapi: allow empty branches in flat
 unions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

It often happens that just a few discriminator values imply extra data in
a flat union. Existing checks did not make possible to leave other values
uncovered. Such cases had to be worked around by either stating a dummy
(empty) type or introducing another (subset) discriminator enumeration.

Both options create redundant entities in qapi files for little profit.

With this patch it is not necessary anymore to add designated union
fields for every possible value of a discriminator enumeration.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 docs/devel/qapi-code-gen.txt                        |  7 ++++---
 scripts/qapi/common.py                              | 11 ++++-------
 scripts/qapi/types.py                               |  4 +++-
 scripts/qapi/visit.py                               | 17 +++++++++++++----
 tests/qapi-schema/flat-union-incomplete-branch.err  |  1 -
 tests/qapi-schema/flat-union-incomplete-branch.exit |  2 +-
 tests/qapi-schema/flat-union-incomplete-branch.out  | 14 ++++++++++++++
 7 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index b9b6eab..a3ea450 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -496,9 +496,10 @@ Resulting in these JSON objects:
 
 Notice that in a flat union, the discriminator name is controlled by
 the user, but because it must map to a base member with enum type, the
-code generator can ensure that branches exist for all values of the
-enum (although the order of the keys need not match the declaration of
-the enum).  In the resulting generated C data types, a flat union is
+code generator ensures that branches match the existing values of the
+enum. The order of the keys need not match the declaration of the enum.
+The keys need not cover all possible enum values.
+In the resulting generated C data types, a flat union is
 represented as a struct with the base members included directly, and
 then a union of structures for each branch of the struct.
 
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index a032cec..df6190a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -782,13 +782,6 @@ def check_union(expr, info):
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
@@ -1644,6 +1637,10 @@ class QAPISchema(object):
         if tag_name:
             variants = [self._make_variant(key, value)
                         for (key, value) in data.items()]
+            # branches that are not explicitly covered get an empty type
+            variants += [self._make_variant(key, 'q_empty')
+                         for key in discriminator_find_enum_define(expr)['data']
+                         if key not in data.keys()]
             members = []
         else:
             variants = [self._make_simple_variant(key, value, info)
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 64d9c0f..1fb2b6d 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -124,7 +124,9 @@ def gen_variants(variants):
 ''',
                 c_name=c_name(variants.tag_member.name))
 
-    for var in variants.variants:
+    # filter out the empty types
+    for var in filter(lambda var: var.type.name != 'q_empty',
+                      variants.variants):
         ret += mcgen('''
         %(c_type)s %(c_name)s;
 ''',
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 5d72d89..96bd32c 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -81,14 +81,23 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
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
+                         case=case_str,
                          c_type=var.type.c_name(), c_name=c_name(var.name))
 
         ret += mcgen('''
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.err b/tests/qapi-schema/flat-union-incomplete-branch.err
index e826bf0..e69de29 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.err
+++ b/tests/qapi-schema/flat-union-incomplete-branch.err
@@ -1 +0,0 @@
-tests/qapi-schema/flat-union-incomplete-branch.json:6: Union 'TestUnion' data missing 'value2' branch
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.exit b/tests/qapi-schema/flat-union-incomplete-branch.exit
index d00491f..573541a 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.exit
+++ b/tests/qapi-schema/flat-union-incomplete-branch.exit
@@ -1 +1 @@
-1
+0
diff --git a/tests/qapi-schema/flat-union-incomplete-branch.out b/tests/qapi-schema/flat-union-incomplete-branch.out
index e69de29..4e774bc 100644
--- a/tests/qapi-schema/flat-union-incomplete-branch.out
+++ b/tests/qapi-schema/flat-union-incomplete-branch.out
@@ -0,0 +1,14 @@
+object q_empty
+enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
+    prefix QTYPE
+module flat-union-incomplete-branch.json
+enum TestEnum ['value1', 'value2']
+object TestTypeA
+    member string: str optional=False
+object q_obj_TestUnion-base
+    member type: TestEnum optional=False
+object TestUnion
+    base q_obj_TestUnion-base
+    tag type
+    case value1: TestTypeA
+    case value2: q_empty
-- 
2.7.4

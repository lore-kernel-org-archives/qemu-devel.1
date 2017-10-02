Received: from eggs.gnu.org ([2001:4830:134:3::10]:38771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007yO-DD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007wE-P6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2ba-0007v7-DX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:37 +0200
Message-Id: <20171002152552.27999-18-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 17/32] qapi: Fix simple union lowering with
 multiple schemas
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

If more than one schema uses the same built-in type T for a simple
union member, they all generate the same q_obj_T_wrapper into their
qapi-types.h.  They clash when you include more than one schema's
qapi-types.h.

Fix by generating them into builtin-qapi-types.h instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi-types.py                   | 12 ++++++++----
 scripts/qapi.py                         |  2 ++
 tests/qapi-schema/builtins.out          | 30 ++++++++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.json |  3 +--
 tests/qapi-schema/qapi-schema-test.out  |  5 ++---
 5 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 18fd2a98c0..c058540e4d 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -53,7 +53,10 @@ def gen_struct_members(members):
     return ret
 
 
-def gen_object(name, base, members, variants):
+def gen_object(name, info, base, members, variants):
+    # TODO use something cleaner than existence of info
+    if not info and args.schema:
+        return ''               # suppress built-in
     if name in objects_seen:
         return ''
     objects_seen.add(name)
@@ -62,7 +65,7 @@ def gen_object(name, base, members, variants):
     if variants:
         for v in variants.variants:
             if isinstance(v.type, QAPISchemaObjectType):
-                ret += gen_object(v.type.name, v.type.base,
+                ret += gen_object(v.type.name, v.type.info, v.type.base,
                                   v.type.local_members, v.type.variants)
 
     ret += mcgen('''
@@ -200,7 +203,7 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
         if name == 'q_empty':
             return
         self._fwdecl += gen_fwd_object_or_array(name)
-        self.decl += gen_object(name, base, members, variants)
+        self.decl += gen_object(name, info, base, members, variants)
         if base and not base.is_implicit():
             self.decl += gen_upcast(name, base)
         # TODO Worth changing the visitor signature, so we could
@@ -211,7 +214,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaVisitor):
 
     def visit_alternate_type(self, name, info, variants):
         self._fwdecl += gen_fwd_object_or_array(name)
-        self.decl += gen_object(name, None, [variants.tag_member], variants)
+        self.decl += gen_object(name, info, None,
+                                [variants.tag_member], variants)
         self._gen_type_cleanup(name)
 
 argparser = common_argument_parser(builtins=True)
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 4871eb7740..477402b7f8 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1499,6 +1499,8 @@ class QAPISchema(object):
         # would be to use lazy instantiation, while figuring out how to
         # avoid compilation issues with multiple qapi-types.h.
         self._make_array_type(name, None)
+        # TODO same for wrapper types
+        self._make_implicit_wrapper_type(name, None)
 
     def _def_predefineds(self):
         for t in [('str',    'string',  'char' + pointer_suffix),
diff --git a/tests/qapi-schema/builtins.out b/tests/qapi-schema/builtins.out
index 40b886ddae..d289bfe919 100644
--- a/tests/qapi-schema/builtins.out
+++ b/tests/qapi-schema/builtins.out
@@ -1,3 +1,33 @@
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
 object q_empty
+object q_obj_any-wrapper
+    member data: any optional=False
+object q_obj_bool-wrapper
+    member data: bool optional=False
+object q_obj_int-wrapper
+    member data: int optional=False
+object q_obj_int16-wrapper
+    member data: int16 optional=False
+object q_obj_int32-wrapper
+    member data: int32 optional=False
+object q_obj_int64-wrapper
+    member data: int64 optional=False
+object q_obj_int8-wrapper
+    member data: int8 optional=False
+object q_obj_null-wrapper
+    member data: null optional=False
+object q_obj_number-wrapper
+    member data: number optional=False
+object q_obj_size-wrapper
+    member data: size optional=False
+object q_obj_str-wrapper
+    member data: str optional=False
+object q_obj_uint16-wrapper
+    member data: uint16 optional=False
+object q_obj_uint32-wrapper
+    member data: uint32 optional=False
+object q_obj_uint64-wrapper
+    member data: uint64 optional=False
+object q_obj_uint8-wrapper
+    member data: uint8 optional=False
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index c091626635..ac8aefc924 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -84,8 +84,7 @@
 
 { 'union': 'UserDefSimpleUnion',
   'data': { 'value1': 'UserDefA',
-# FIXME generated q_obj_int_wrapper clashes with qapi-schema.json's
-#           'value2': 'int',
+            'value2': 'int',
             'value3': 'UserDefB' } }
 
 # this variant of UserDefFlatUnion defaults to a union that uses members with
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 97bb02f2fd..fff25e26d0 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -112,8 +112,9 @@ object UserDefSimpleUnion
     member type: UserDefSimpleUnionKind optional=False
     tag type
     case value1: q_obj_UserDefA-wrapper
+    case value2: q_obj_int-wrapper
     case value3: q_obj_UserDefB-wrapper
-enum UserDefSimpleUnionKind ['value1', 'value3']
+enum UserDefSimpleUnionKind ['value1', 'value2', 'value3']
 object UserDefTwo
     member string0: str optional=False
     member dict1: UserDefTwoDict optional=False
@@ -211,8 +212,6 @@ object q_obj_numberList-wrapper
     member data: numberList optional=False
 object q_obj_sizeList-wrapper
     member data: sizeList optional=False
-object q_obj_str-wrapper
-    member data: str optional=False
 object q_obj_strList-wrapper
     member data: strList optional=False
 object q_obj_uint16List-wrapper
-- 
2.13.6

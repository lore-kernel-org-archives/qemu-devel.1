Received: from eggs.gnu.org ([2001:4830:134:3::10]:40628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6w-0000w8-P9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6u-0007i8-Ru
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6u-0007h3-J5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:24 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:32 -0600
Message-Id: <20180301194245.29854-18-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/30] qapi: Record 'include' directives in
 intermediate representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Markus Armbruster <armbru@redhat.com>

The include directive permits modular QAPI schemata, but the generated
code is monolithic all the same.  To permit generating modular code,
the front end needs to pass more information on inclusions to the back
ends.  The commit before last added the necessary information to the
parse tree.  This commit adds it to the intermediate representation
and its QAPISchemaVisitor.  A later commit will use this to to
generate modular code.

New entity QAPISchemaInclude represents inclusions.  Call new visitor
method visit_include() for it, so visitors can see the sub-modules a
module includes.

Note that unlike other entities, QAPISchemaInclude has no name, and is
therefore not added to entity_dict.

New QAPISchemaEntity attribute @module names the entity's source file.
Call new visitor method visit_module() when it changes during a visit,
so visitors can keep track of the module being visited.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180211093607.27351-18-armbru@redhat.com>
[eblake: avoid accidental deletion of self._predefining]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py                   | 43 ++++++++++++++++++++++++++=
+++---
 tests/qapi-schema/comments.out           |  1 +
 tests/qapi-schema/doc-bad-section.out    |  1 +
 tests/qapi-schema/doc-good.out           |  1 +
 tests/qapi-schema/event-case.out         |  1 +
 tests/qapi-schema/ident-with-escape.out  |  1 +
 tests/qapi-schema/include-relpath.out    |  5 ++++
 tests/qapi-schema/include-repetition.out | 10 ++++++++
 tests/qapi-schema/include-simple.out     |  3 +++
 tests/qapi-schema/indented-expr.out      |  1 +
 tests/qapi-schema/qapi-schema-test.out   |  1 +
 tests/qapi-schema/test-qapi.py           |  7 ++++++
 12 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 1aa1cd3b9bd..2c5c40ec0a9 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -984,8 +984,9 @@ def check_exprs(exprs):

 class QAPISchemaEntity(object):
     def __init__(self, name, info, doc):
-        assert isinstance(name, str)
+        assert name is None or isinstance(name, str)
         self.name =3D name
+        self.module =3D None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
         # For implicitly defined entities, info points to a place that
@@ -1014,10 +1015,16 @@ class QAPISchemaVisitor(object):
     def visit_end(self):
         pass

+    def visit_module(self, fname):
+        pass
+
     def visit_needed(self, entity):
         # Default to visiting everything
         return True

+    def visit_include(self, fname, info):
+        pass
+
     def visit_builtin_type(self, name, info, json_type):
         pass

@@ -1044,6 +1051,16 @@ class QAPISchemaVisitor(object):
         pass


+class QAPISchemaInclude(QAPISchemaEntity):
+
+    def __init__(self, fname, info):
+        QAPISchemaEntity.__init__(self, None, info, None)
+        self.fname =3D fname
+
+    def visit(self, visitor):
+        visitor.visit_include(self.fname, self.info)
+
+
 class QAPISchemaType(QAPISchemaEntity):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
@@ -1471,6 +1488,7 @@ class QAPISchemaEvent(QAPISchemaEntity):

 class QAPISchema(object):
     def __init__(self, fname):
+        self._fname =3D fname
         parser =3D QAPISchemaParser(open(fname, 'r'))
         exprs =3D check_exprs(parser.exprs)
         self.docs =3D parser.docs
@@ -1485,9 +1503,13 @@ class QAPISchema(object):
     def _def_entity(self, ent):
         # Only the predefined types are allowed to not have info
         assert ent.info or self._predefining
-        assert ent.name not in self._entity_dict
+        assert ent.name is None or ent.name not in self._entity_dict
         self._entity_list.append(ent)
-        self._entity_dict[ent.name] =3D ent
+        if ent.name is not None:
+            self._entity_dict[ent.name] =3D ent
+        if ent.info:
+            ent.module =3D os.path.relpath(ent.info['file'],
+                                         os.path.dirname(self._fname))

     def lookup_entity(self, name, typ=3DNone):
         ent =3D self._entity_dict.get(name)
@@ -1498,6 +1520,15 @@ class QAPISchema(object):
     def lookup_type(self, name):
         return self.lookup_entity(name, QAPISchemaType)

+    def _def_include(self, expr, info, doc):
+        include =3D expr['include']
+        assert doc is None
+        main_info =3D info
+        while main_info['parent']:
+            main_info =3D main_info['parent']
+        fname =3D os.path.relpath(include, os.path.dirname(main_info['fi=
le']))
+        self._def_entity(QAPISchemaInclude(fname, info))
+
     def _def_builtin_type(self, name, json_type, c_type):
         self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
         # TODO As long as we have QAPI_TYPES_BUILTIN to share multiple
@@ -1680,7 +1711,7 @@ class QAPISchema(object):
             elif 'event' in expr:
                 self._def_event(expr, info, doc)
             elif 'include' in expr:
-                pass
+                self._def_include(expr, info, doc)
             else:
                 assert False

@@ -1690,8 +1721,12 @@ class QAPISchema(object):

     def visit(self, visitor):
         visitor.visit_begin(self)
+        module =3D None
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
+                if entity.module !=3D module:
+                    module =3D entity.module
+                    visitor.visit_module(module)
                 entity.visit(visitor)
         visitor.visit_end()

diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 0261ddf202c..8d2f1ce8a2e 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,4 +1,5 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module comments.json
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index 23bf8c71aba..cd287215689 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module doc-bad-section.json
 enum Enum ['one', 'two']
 doc symbol=3DEnum
     body=3D
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 0c07301f07a..430b5a87db3 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module doc-good.json
 enum Enum ['one', 'two']
 object Base
     member base1: Enum optional=3DFalse
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 110571b793c..88c0964917a 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,5 +1,6 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module event-case.json
 event oops None
    boxed=3DFalse
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 8336aa7629d..ee3b34e623e 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
 command fooA q_obj_fooA-arg -> None
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index 0261ddf202c..ebbabd7a186 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,4 +1,9 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module include-relpath.json
+include include/relpath.json
+module include/relpath.json
+include include-relpath-sub.json
+module include-relpath-sub.json
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 0261ddf202c..7235e055bc1 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,4 +1,14 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module include-repetition.json
+include comments.json
+module comments.json
 enum Status ['good', 'bad', 'ugly']
+module include-repetition.json
+include include-repetition-sub.json
+module include-repetition-sub.json
+include comments.json
+include comments.json
+module include-repetition.json
+include comments.json
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 0261ddf202c..006f723eebc 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,4 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module include-simple.json
+include include-simple-sub.json
+module include-simple-sub.json
 enum Status ['good', 'bad', 'ugly']
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index 34de8be4262..a79935e8c32 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module indented-expr.json
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 command zwei None -> None
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 50706b01369..012e7fc06a5 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,6 +1,7 @@
 object q_empty
 enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
     prefix QTYPE
+module qapi-schema-test.json
 object TestStruct
     member integer: int optional=3DFalse
     member boolean: bool optional=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 4da14b43af6..67e417e2980 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -16,6 +16,13 @@ from qapi.common import QAPIError, QAPISchema, QAPISch=
emaVisitor


 class QAPISchemaTestVisitor(QAPISchemaVisitor):
+
+    def visit_module(self, name):
+        print('module %s' % name)
+
+    def visit_include(self, name, info):
+        print('include %s' % name)
+
     def visit_enum_type(self, name, info, values, prefix):
         print('enum %s %s' % (name, values))
         if prefix:
--=20
2.14.3

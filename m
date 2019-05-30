Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA2C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDC4257E9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDC4257E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIxo-0007lJ-Ei
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:11:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIqC-0001oY-FV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIqA-0003pM-8J
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWIq5-0003aS-3j; Thu, 30 May 2019 07:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DADAE36883;
	Thu, 30 May 2019 11:03:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-119.ams2.redhat.com
	[10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C1ED76FC0D;
	Thu, 30 May 2019 11:03:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 30 May 2019 13:02:50 +0200
Message-Id: <20190530110255.16225-2-kwolf@redhat.com>
In-Reply-To: <20190530110255.16225-1-kwolf@redhat.com>
References: <20190530110255.16225-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 30 May 2019 11:03:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 1/6] qapi: Add feature flags to struct types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes, the behaviour of QEMU changes without a change in the QMP
syntax (usually by allowing values or operations that previously
resulted in an error). QMP clients may still need to know whether
they can rely on the changed behavior.

Let's add feature flags to the QAPI schema language, so that we can make
such changes visible with schema introspection.

An example for a schema definition using feature flags looks like this:

    { 'struct': 'TestType',
      'data': { 'number': 'int' },
      'features': [ 'allow-negative-numbers' ] }

Introspection information then looks like this:

    { "name": "TestType", "meta-type": "object",
      "members": [
          { "name": "number", "type": "int" } ],
      "features": [ "allow-negative-numbers" ] }

This patch implements feature flags only for struct types. We'll
implement them more widely as needed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/introspect.json                   |  6 ++-
 docs/devel/qapi-code-gen.txt           | 38 +++++++++++++++
 scripts/qapi/common.py                 | 66 ++++++++++++++++++++++----
 scripts/qapi/doc.py                    |  3 +-
 scripts/qapi/introspect.py             |  6 ++-
 scripts/qapi/types.py                  |  3 +-
 scripts/qapi/visit.py                  |  3 +-
 tests/qapi-schema/double-type.err      |  2 +-
 tests/qapi-schema/test-qapi.py         |  3 +-
 tests/qapi-schema/unknown-expr-key.err |  2 +-
 10 files changed, 114 insertions(+), 18 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 3d22166b2b..1843c1cb17 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -174,6 +174,9 @@
 #            and may even differ from the order of the values of the
 #            enum type of the @tag.
 #
+# @features: names of features associated with the type, in no particula=
r
+#            order. (since: 4.1)
+#
 # Values of this type are JSON object on the wire.
 #
 # Since: 2.5
@@ -181,7 +184,8 @@
 { 'struct': 'SchemaInfoObject',
   'data': { 'members': [ 'SchemaInfoObjectMember' ],
             '*tag': 'str',
-            '*variants': [ 'SchemaInfoObjectVariant' ] } }
+            '*variants': [ 'SchemaInfoObjectVariant' ],
+            '*features': [ 'str' ] } }
=20
 ##
 # @SchemaInfoObjectMember:
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index b517b0cfbf..e8ec8ac1de 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -719,6 +719,34 @@ any non-empty complex type (struct, union, or altern=
ate), and a
 pointer to that QAPI type is passed as a single argument.
=20
=20
+=3D=3D=3D Features =3D=3D=3D
+
+Sometimes, the behaviour of QEMU changes compatibly, but without a
+change in the QMP syntax (usually by allowing values or operations that
+previously resulted in an error). QMP clients may still need to know
+whether the extension is available.
+
+For this purpose, a list of features can be specified for a struct type.
+This is exposed to the client as a list of string, where each string
+signals that this build of QEMU shows a certain behaviour.
+
+In the schema, features can be specified as simple strings, for example:
+
+{ 'struct': 'TestType',
+  'data': { 'number': 'int' },
+  'features': [ 'allow-negative-numbers' ] }
+
+Another option is to specify features as dictionaries, where the key
+'name' specifies the feature string to be exposed to clients:
+
+{ 'struct': 'TestType',
+  'data': { 'number': 'int' },
+  'features': [ { 'name': 'allow-negative-numbers' } ] }
+
+This expanded form is necessary if you want to make the feature
+conditional (see below in "Configuring the schema").
+
+
 =3D=3D=3D Downstream extensions =3D=3D=3D
=20
 QAPI schema names that are externally visible, say in the Client JSON
@@ -771,6 +799,16 @@ Example: a conditional 'bar' enum member.
   [ 'foo',
     { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
=20
+Similarly, features can be specified as a dictionary with a 'name' and
+an 'if' key.
+
+Example: a conditional 'allow-negative-numbers' feature
+
+{ 'struct': 'TestType',
+  'data': { 'number': 'int' },
+  'features': [ { 'name': 'allow-negative-numbers',
+                  'if' 'defined(IFCOND)' } ] }
+
 Please note that you are responsible to ensure that the C code will
 compile with an arbitrary combination of conditions, since the
 generators are unable to check it at this point.
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index f07869ec73..9e4b6c00b5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -886,12 +886,26 @@ def check_enum(expr, info):
 def check_struct(expr, info):
     name =3D expr['struct']
     members =3D expr['data']
+    features =3D expr.get('features')
=20
     check_type(info, "'data' for struct '%s'" % name, members,
                allow_dict=3DTrue, allow_optional=3DTrue)
     check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
                allow_metas=3D['struct'])
=20
+    if features:
+        if not isinstance(features, list):
+            raise QAPISemError(info,
+                               "Struct '%s' requires an array for 'featu=
res'" %
+                               name)
+        for f in features:
+            assert isinstance(f, dict)
+            check_known_keys(info, "feature of struct %s" % name, f,
+                             ['name'], ['if'])
+
+            check_if(f, info)
+            check_name(info, "Feature of struct %s" % name, f['name'])
+
=20
 def check_known_keys(info, source, keys, required, optional):
=20
@@ -948,6 +962,12 @@ def normalize_members(members):
             members[key] =3D {'type': arg}
=20
=20
+def normalize_features(features):
+    if isinstance(features, list):
+        features[:] =3D [f if isinstance(f, dict) else {'name': f}
+                       for f in features]
+
+
 def check_exprs(exprs):
     global all_names
=20
@@ -986,8 +1006,10 @@ def check_exprs(exprs):
             normalize_members(expr['data'])
         elif 'struct' in expr:
             meta =3D 'struct'
-            check_keys(expr_elem, 'struct', ['data'], ['base', 'if'])
+            check_keys(expr_elem, 'struct', ['data'],
+                       ['base', 'if', 'features'])
             normalize_members(expr['data'])
+            normalize_features(expr.get('features'))
             struct_types[expr[meta]] =3D expr
         elif 'command' in expr:
             meta =3D 'command'
@@ -1126,10 +1148,12 @@ class QAPISchemaVisitor(object):
     def visit_array_type(self, name, info, ifcond, element_type):
         pass
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
+                          features):
         pass
=20
-    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
+    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts,
+                               features):
         pass
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
@@ -1290,7 +1314,7 @@ class QAPISchemaArrayType(QAPISchemaType):
=20
 class QAPISchemaObjectType(QAPISchemaType):
     def __init__(self, name, info, doc, ifcond,
-                 base, local_members, variants):
+                 base, local_members, variants, features):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
@@ -1302,11 +1326,15 @@ class QAPISchemaObjectType(QAPISchemaType):
         if variants is not None:
             assert isinstance(variants, QAPISchemaObjectTypeVariants)
             variants.set_owner(name)
+        for f in features:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_owner(name)
         self._base_name =3D base
         self.base =3D None
         self.local_members =3D local_members
         self.variants =3D variants
         self.members =3D None
+        self.features =3D features
=20
     def check(self, schema):
         QAPISchemaType.check(self, schema)
@@ -1332,6 +1360,12 @@ class QAPISchemaObjectType(QAPISchemaType):
             self.variants.check(schema, seen)
             assert self.variants.tag_member in self.members
             self.variants.check_clash(self.info, seen)
+
+        # Features are in a name space separate from members
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
         if self.doc:
             self.doc.check()
=20
@@ -1368,12 +1402,15 @@ class QAPISchemaObjectType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_object_type(self.name, self.info, self.ifcond,
-                                  self.base, self.local_members, self.va=
riants)
+                                  self.base, self.local_members, self.va=
riants,
+                                  self.features)
         visitor.visit_object_type_flat(self.name, self.info, self.ifcond=
,
-                                       self.members, self.variants)
+                                       self.members, self.variants,
+                                       self.features)
=20
=20
 class QAPISchemaMember(object):
+    """ Represents object members, enum members and features """
     role =3D 'member'
=20
     def __init__(self, name, ifcond=3DNone):
@@ -1419,6 +1456,10 @@ class QAPISchemaMember(object):
         return "'%s' %s" % (self.name, self._pretty_owner())
=20
=20
+class QAPISchemaFeature(QAPISchemaMember):
+    role =3D 'feature'
+
+
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
     def __init__(self, name, typ, optional, ifcond=3DNone):
         QAPISchemaMember.__init__(self, name, ifcond)
@@ -1675,7 +1716,7 @@ class QAPISchema(object):
                   ('null',   'null',    'QNull' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type =3D QAPISchemaObjectType(
-            'q_empty', None, None, None, None, [], None)
+            'q_empty', None, None, None, None, [], None, [])
         self._def_entity(self.the_empty_object_type)
=20
         qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
,
@@ -1685,6 +1726,9 @@ class QAPISchema(object):
         self._def_entity(QAPISchemaEnumType('QType', None, None, None,
                                             qtype_values, 'QTYPE'))
=20
+    def _make_features(self, features):
+        return [QAPISchemaFeature(f['name'], f.get('if')) for f in featu=
res]
+
     def _make_enum_members(self, values):
         return [QAPISchemaMember(v['name'], v.get('if')) for v in values=
]
=20
@@ -1721,7 +1765,7 @@ class QAPISchema(object):
             assert ifcond =3D=3D typ._ifcond # pylint: disable=3Dprotect=
ed-access
         else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
-                                                  None, members, None))
+                                                  None, members, None, [=
]))
         return name
=20
     def _def_enum_type(self, expr, info, doc):
@@ -1752,9 +1796,11 @@ class QAPISchema(object):
         base =3D expr.get('base')
         data =3D expr['data']
         ifcond =3D expr.get('if')
+        features =3D expr.get('features', [])
         self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, b=
ase,
                                               self._make_members(data, i=
nfo),
-                                              None))
+                                              None,
+                                              self._make_features(featur=
es)))
=20
     def _make_variant(self, case, typ, ifcond):
         return QAPISchemaObjectTypeVariant(case, typ, ifcond)
@@ -1795,7 +1841,7 @@ class QAPISchema(object):
             QAPISchemaObjectType(name, info, doc, ifcond, base, members,
                                  QAPISchemaObjectTypeVariants(tag_name,
                                                               tag_member=
,
-                                                              variants))=
)
+                                                              variants),=
 []))
=20
     def _def_alternate_type(self, expr, info, doc):
         name =3D expr['alternate']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 5c8c136899..433e9fcbfb 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -220,7 +220,8 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
                                body=3Dtexi_entity(doc, 'Values', ifcond,
                                                 member_func=3Dtexi_enum_=
value)))
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
+                          features):
         doc =3D self.cur_doc
         if base and base.is_implicit():
             base =3D None
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f7f2ca07e4..f62cf0a2e1 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -188,11 +188,15 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
                        ifcond)
=20
-    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
+    def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts,
+                               features):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
+        if features:
+            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in fea=
tures]
+
         self._gen_qlit(name, 'object', obj, ifcond)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 2bd6fcd44f..3edd9374aa 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -227,7 +227,8 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisi=
tor):
             self._genh.add(gen_array(name, element_type))
             self._gen_type_cleanup(name)
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
+                          features):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 826b8066e1..c1cd675c95 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -326,7 +326,8 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_list(name, element_type))
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
+                          features):
         # Nothing to do for the special empty builtin
         if name =3D=3D 'q_empty':
             return
diff --git a/tests/qapi-schema/double-type.err b/tests/qapi-schema/double=
-type.err
index 799193dba1..69457173a7 100644
--- a/tests/qapi-schema/double-type.err
+++ b/tests/qapi-schema/double-type.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/double-type.json:2: Unknown key 'command' in struct 'b=
ar'
-Valid keys are 'base', 'data', 'if', 'struct'.
+Valid keys are 'base', 'data', 'features', 'if', 'struct'.
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index d21fca01fc..f2d6815c86 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -38,7 +38,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('array %s %s' % (name, element_type.name))
         self._print_if(ifcond)
=20
-    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
+    def visit_object_type(self, name, info, ifcond, base, members, varia=
nts,
+                          features):
         print('object %s' % name)
         if base:
             print('    base %s' % base.name)
diff --git a/tests/qapi-schema/unknown-expr-key.err b/tests/qapi-schema/u=
nknown-expr-key.err
index 6ff8bb99c5..4340eaf894 100644
--- a/tests/qapi-schema/unknown-expr-key.err
+++ b/tests/qapi-schema/unknown-expr-key.err
@@ -1,2 +1,2 @@
 tests/qapi-schema/unknown-expr-key.json:2: Unknown keys 'bogus', 'phony'=
 in struct 'bar'
-Valid keys are 'base', 'data', 'if', 'struct'.
+Valid keys are 'base', 'data', 'features', 'if', 'struct'.
--=20
2.20.1



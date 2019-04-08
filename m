Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B23C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA7A20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA7A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVRf-0001RV-Dq
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:40:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO1-0007Kn-1C
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNx-0000Sn-FP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDVNq-0000Lk-CC; Mon, 08 Apr 2019 10:36:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0EACC074128;
	Mon,  8 Apr 2019 14:36:23 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7209317ADF;
	Mon,  8 Apr 2019 14:36:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 16:35:40 +0200
Message-Id: <20190408143543.3982-2-kwolf@redhat.com>
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 08 Apr 2019 14:36:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] qapi: Support features for structs
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408143540.yH8PqtXUrFL3RKk5wGuurGX-kceD2TXm9SaWpXNtSwQ@z>

Sometimes, the behaviour of QEMU changes compatibly, but without a
change in the QMP syntax (usually by allowing values or operations that
previously resulted in an error). QMP clients may still need to know
whether the extension is available.

This allows to add a list of features to struct definitions that will be
made visible to QMP clients through schema introspection.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/introspect.json                   |  8 ++++-
 docs/devel/qapi-code-gen.txt           | 38 ++++++++++++++++++++
 scripts/qapi/common.py                 | 49 ++++++++++++++++++++------
 scripts/qapi/doc.py                    |  3 +-
 scripts/qapi/introspect.py             |  6 +++-
 scripts/qapi/types.py                  |  3 +-
 scripts/qapi/visit.py                  |  3 +-
 tests/qapi-schema/double-type.err      |  2 +-
 tests/qapi-schema/test-qapi.py         |  3 +-
 tests/qapi-schema/unknown-expr-key.err |  2 +-
 10 files changed, 99 insertions(+), 18 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index 3d22166b2b..3cb6c1aca4 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -174,6 +174,11 @@
 #            and may even differ from the order of the values of the
 #            enum type of the @tag.
 #
+# @features: names of features that are supported by this version and bu=
ild and
+#            aren't othervise visible through schema introspection (e.g.=
 change
+#            of behaviour related to an object type that didn't come wit=
h a
+#            syntactic change in the schema of the object type) (since: =
4.1)
+#
 # Values of this type are JSON object on the wire.
 #
 # Since: 2.5
@@ -181,7 +186,8 @@
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
index f07869ec73..692d787f04 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -886,12 +886,29 @@ def check_enum(expr, info):
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
+            check_known_keys(info, "feature of struct %s" % (name), f,
+                             ['name'], ['if'])
+
+            check_if(f, info)
+            f['if'] =3D listify_cond(f.get('if'))
+
+            if not isinstance(f['name'], str):
+                raise QAPISemError(info, "Feature names for struct '%s' =
must "
+                                         "be strings" % name)
=20
 def check_known_keys(info, source, keys, required, optional):
=20
@@ -947,6 +964,10 @@ def normalize_members(members):
                 continue
             members[key] =3D {'type': arg}
=20
+def normalize_features(features):
+    if isinstance(features, list):
+        features[:] =3D [f if isinstance(f, dict) else {'name': f}
+                       for f in features]
=20
 def check_exprs(exprs):
     global all_names
@@ -986,8 +1007,10 @@ def check_exprs(exprs):
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
@@ -1126,10 +1149,12 @@ class QAPISchemaVisitor(object):
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
@@ -1290,7 +1315,7 @@ class QAPISchemaArrayType(QAPISchemaType):
=20
 class QAPISchemaObjectType(QAPISchemaType):
     def __init__(self, name, info, doc, ifcond,
-                 base, local_members, variants):
+                 base, local_members, variants, features):
         # struct has local_members, optional base, and no variants
         # flat union has base, variants, and no local_members
         # simple union has local_members, variants, and no base
@@ -1307,6 +1332,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         self.local_members =3D local_members
         self.variants =3D variants
         self.members =3D None
+        self.features =3D features
=20
     def check(self, schema):
         QAPISchemaType.check(self, schema)
@@ -1368,9 +1394,11 @@ class QAPISchemaObjectType(QAPISchemaType):
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
@@ -1675,7 +1703,7 @@ class QAPISchema(object):
                   ('null',   'null',    'QNull' + pointer_suffix)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type =3D QAPISchemaObjectType(
-            'q_empty', None, None, None, None, [], None)
+            'q_empty', None, None, None, None, [], None, [])
         self._def_entity(self.the_empty_object_type)
=20
         qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
,
@@ -1721,7 +1749,7 @@ class QAPISchema(object):
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
@@ -1752,9 +1780,10 @@ class QAPISchema(object):
         base =3D expr.get('base')
         data =3D expr['data']
         ifcond =3D expr.get('if')
+        features =3D expr.get('features')
         self._def_entity(QAPISchemaObjectType(name, info, doc, ifcond, b=
ase,
                                               self._make_members(data, i=
nfo),
-                                              None))
+                                              None, features))
=20
     def _make_variant(self, case, typ, ifcond):
         return QAPISchemaObjectTypeVariant(case, typ, ifcond)
@@ -1795,7 +1824,7 @@ class QAPISchema(object):
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
index f7f2ca07e4..8909cecde4 100644
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
+            obj['features'] =3D [ (f['name'], f) for f in features ]
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



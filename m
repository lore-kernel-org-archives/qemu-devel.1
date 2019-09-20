Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC993207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC993207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKCV-0002tY-L8
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iBJs4-0002LS-G3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iBJs2-00032v-FW
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iBJs2-00032e-6v
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:26:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7CF9DA26660;
 Fri, 20 Sep 2019 14:26:49 +0000 (UTC)
Received: from angien.brq.redhat.com (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B49F196AE;
 Fri, 20 Sep 2019 14:26:48 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] qapi: Add feature flags to commands in qapi
 introspection
Date: Fri, 20 Sep 2019 16:26:44 +0200
Message-Id: <96cc954e1cba111a4565123badb42c36e534a5d3.1568989362.git.pkrempa@redhat.com>
In-Reply-To: <cover.1568989362.git.pkrempa@redhat.com>
References: <cover.1568989362.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 20 Sep 2019 14:26:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to features for struct types introduce the feature flags also
for commands. This will allow notifying management layers of fixes and
compatible changes in the behaviour of a command which may not be
detectable any other way.

The changes were heavily inspired by commit 6a8c0b51025.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 docs/devel/qapi-code-gen.txt   |  4 ++--
 qapi/introspect.json           |  6 ++++-
 scripts/qapi/commands.py       |  3 ++-
 scripts/qapi/common.py         | 40 +++++++++++++++++++++++++++++-----
 scripts/qapi/doc.py            |  3 ++-
 scripts/qapi/introspect.py     |  7 +++++-
 tests/qapi-schema/test-qapi.py |  7 +++++-
 7 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index e8ec8ac1de..d465cc6330 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -726,8 +726,8 @@ change in the QMP syntax (usually by allowing values =
or operations that
 previously resulted in an error). QMP clients may still need to know
 whether the extension is available.

-For this purpose, a list of features can be specified for a struct type.
-This is exposed to the client as a list of string, where each string
+For this purpose, a list of features can be specified for a command or s=
truct
+type. This is exposed to the client as a list of strings, where each str=
ing
 signals that this build of QEMU shows a certain behaviour.

 In the schema, features can be specified as simple strings, for example:
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 1843c1cb17..031a954fa9 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -266,13 +266,17 @@
 # @allow-oob: whether the command allows out-of-band execution,
 #             defaults to false (Since: 2.12)
 #
+# @features: names of features associated with the command, in no partic=
ular
+#            order. (since 4.2)
+#
 # TODO: @success-response (currently irrelevant, because it's QGA, not Q=
MP)
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str',
-            '*allow-oob': 'bool' } }
+            '*allow-oob': 'bool',
+            '*features': [ 'str' ] } }

 ##
 # @SchemaInfoEvent:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index b929e07be4..6cfe6cdd9e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -276,7 +276,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
         genc.add(gen_registry(self._regy.get_content(), self._prefix))

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d61bfdc526..1502820f46 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -838,6 +838,7 @@ def check_type(info, source, value, allow_array=3DFal=
se,
 def check_command(expr, info):
     name =3D expr['command']
     boxed =3D expr.get('boxed', False)
+    features =3D expr.get('features')

     args_meta =3D ['struct']
     if boxed:
@@ -852,6 +853,19 @@ def check_command(expr, info):
                expr.get('returns'), allow_array=3DTrue,
                allow_optional=3DTrue, allow_metas=3Dreturns_meta)

+    if features:
+        if not isinstance(features, list):
+            raise QAPISemError(info,
+                               "Command '%s' requires an array for 'feat=
ures'" %
+                               name)
+        for f in features:
+            assert isinstance(f, dict)
+            check_known_keys(info, "feature of command %s" % name, f,
+                             ['name'], ['if'])
+
+            check_if(f, info)
+            check_name(info, "Feature of command %s" % name, f['name'])
+

 def check_event(expr, info):
     name =3D expr['event']
@@ -1138,8 +1152,10 @@ def check_exprs(exprs):
             meta =3D 'command'
             check_keys(expr_elem, 'command', [],
                        ['data', 'returns', 'gen', 'success-response',
-                        'boxed', 'allow-oob', 'allow-preconfig', 'if'])
+                        'boxed', 'allow-oob', 'allow-preconfig', 'if',
+                        'features'])
             normalize_members(expr.get('data'))
+            normalize_features(expr.get('features'))
         elif 'event' in expr:
             meta =3D 'event'
             check_keys(expr_elem, 'event', [], ['data', 'boxed', 'if'])
@@ -1283,7 +1299,8 @@ class QAPISchemaVisitor(object):
         pass

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         pass

     def visit_event(self, name, info, ifcond, arg_type, boxed):
@@ -1697,10 +1714,14 @@ class QAPISchemaAlternateType(QAPISchemaType):

 class QAPISchemaCommand(QAPISchemaEntity):
     def __init__(self, name, info, doc, ifcond, arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfi=
g):
+                 gen, success_response, boxed, allow_oob, allow_preconfi=
g,
+                 features):
         QAPISchemaEntity.__init__(self, name, info, doc, ifcond)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
+        for f in features:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_owner(name)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
         self._ret_type_name =3D ret_type
@@ -1710,6 +1731,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
+        self.features =3D features

     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -1731,12 +1753,18 @@ class QAPISchemaCommand(QAPISchemaEntity):
             self.ret_type =3D schema.lookup_type(self._ret_type_name)
             assert isinstance(self.ret_type, QAPISchemaType)

+        # Features are in a name space separate from members
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
     def visit(self, visitor):
         visitor.visit_command(self.name, self.info, self.ifcond,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
-                              self.allow_preconfig)
+                              self.allow_preconfig,
+                              self.features)


 class QAPISchemaEvent(QAPISchemaEntity):
@@ -1989,6 +2017,7 @@ class QAPISchema(object):
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
+        features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
@@ -1997,7 +2026,8 @@ class QAPISchema(object):
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data=
, rets,
                                            gen, success_response,
-                                           boxed, allow_oob, allow_preco=
nfig))
+                                           boxed, allow_oob, allow_preco=
nfig,
+                                           self._make_features(features)=
))

     def _def_event(self, expr, info, doc):
         name =3D expr['event']
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 5fc0fc7e06..aa4c557244 100755
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -249,7 +249,8 @@ class QAPISchemaGenDocVisitor(qapi.common.QAPISchemaV=
isitor):
                                body=3Dtexi_entity(doc, 'Members', ifcond=
)))

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         doc =3D self.cur_doc
         if boxed:
             body =3D texi_body(doc)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index f62cf0a2e1..36a5b195e5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -206,13 +206,18 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                            for m in variants.variants]}, ifcond)

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         arg_type =3D arg_type or self._schema.the_empty_object_type
         ret_type =3D ret_type or self._schema.the_empty_object_type
         obj =3D {'arg-type': self._use_type(arg_type),
                'ret-type': self._use_type(ret_type)}
         if allow_oob:
             obj['allow-oob'] =3D allow_oob
+
+        if features:
+            obj['features'] =3D [(f.name, {'if': f.ifcond}) for f in fea=
tures]
+
         self._gen_qlit(name, 'command', obj, ifcond)

     def visit_event(self, name, info, ifcond, arg_type, boxed):
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index b0f770b9bd..def34aa489 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -60,13 +60,18 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)

     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
         print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pre=
config=3D%s'
               % (gen, success_response, boxed, allow_oob, allow_preconfi=
g))
         self._print_if(ifcond)
+        if features:
+            for f in features:
+                print('    feature %s' % f.name)
+                self._print_if(f.ifcond, 8)

     def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
--=20
2.21.0



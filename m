Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84DC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEDE2190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEDE2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqg5-0007jl-1x
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIqd6-0003Mp-I3
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIqd4-0005hy-GM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIqd4-0005ha-7z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1667418C4262
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:50:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE0B010013D9;
 Fri, 11 Oct 2019 08:50:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F7EE1133034; Fri, 11 Oct 2019 10:50:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] qapi: Add feature flags to commands in qapi
Date: Fri, 11 Oct 2019 10:50:25 +0200
Message-Id: <20191011085027.28606-3-armbru@redhat.com>
In-Reply-To: <20191011085027.28606-1-armbru@redhat.com>
References: <20191011085027.28606-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 11 Oct 2019 08:50:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, pkrempa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Krempa <pkrempa@redhat.com>

Similarly to features for struct types introduce the feature flags also
for commands. This will allow notifying management layers of fixes and
compatible changes in the behaviour of a command which may not be
detectable any other way.

The changes were heavily inspired by commit 6a8c0b51025.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt   |  7 ++++---
 qapi/introspect.json           |  6 +++++-
 scripts/qapi/commands.py       |  3 ++-
 scripts/qapi/doc.py            |  3 ++-
 scripts/qapi/expr.py           | 35 +++++++++++++++++++---------------
 scripts/qapi/introspect.py     |  7 ++++++-
 scripts/qapi/schema.py         | 22 +++++++++++++++++----
 tests/qapi-schema/test-qapi.py |  3 ++-
 8 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 64d9e4c6a9..637fa49977 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -640,9 +640,10 @@ change in the QMP syntax (usually by allowing values=
 or operations
 that previously resulted in an error).  QMP clients may still need to
 know whether the extension is available.
=20
-For this purpose, a list of features can be specified for a struct type.
-This is exposed to the client as a list of string, where each string
-signals that this build of QEMU shows a certain behaviour.
+For this purpose, a list of features can be specified for a command or
+struct type.  This is exposed to the client as a list of strings,
+where each string signals that this build of QEMU shows a certain
+behaviour.
=20
 Each member of the 'features' array defines a feature.  It can either
 be { 'name': STRING, '*if': COND }, or STRING, which is shorthand for
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
=20
 ##
 # @SchemaInfoEvent:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 898516b086..ab98e504f3 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -277,7 +277,8 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
         genc.add(gen_registry(self._regy.get_content(), self._prefix))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         if not gen:
             return
         # FIXME: If T is a user-defined type, the user is responsible
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index dc8919bab7..8278ccbc43 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -249,7 +249,8 @@ class QAPISchemaGenDocVisitor(QAPISchemaVisitor):
                                body=3Dtexi_entity(doc, 'Members', ifcond=
)))
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         doc =3D self.cur_doc
         if boxed:
             body =3D texi_body(doc)
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index da23063f57..5a7e548899 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -184,6 +184,22 @@ def normalize_features(features):
                        for f in features]
=20
=20
+def check_features(features, info):
+    if features is None:
+        return
+    if not isinstance(features, list):
+        raise QAPISemError(info, "'features' must be an array")
+    for f in features:
+        source =3D "'features' member"
+        assert isinstance(f, dict)
+        check_keys(f, info, source, ['name'], ['if'])
+        check_name_is_str(f['name'], info, source)
+        source =3D "%s '%s'" % (source, f['name'])
+        check_name_str(f['name'], info, source)
+        check_if(f, info, source)
+        normalize_if(f)
+
+
 def normalize_enum(expr):
     if isinstance(expr['data'], list):
         expr['data'] =3D [m if isinstance(m, dict) else {'name': m}
@@ -216,23 +232,10 @@ def check_enum(expr, info):
 def check_struct(expr, info):
     name =3D expr['struct']
     members =3D expr['data']
-    features =3D expr.get('features')
=20
     check_type(members, info, "'data'", allow_dict=3Dname)
     check_type(expr.get('base'), info, "'base'")
-
-    if features:
-        if not isinstance(features, list):
-            raise QAPISemError(info, "'features' must be an array")
-        for f in features:
-            source =3D "'features' member"
-            assert isinstance(f, dict)
-            check_keys(f, info, source, ['name'], ['if'])
-            check_name_is_str(f['name'], info, source)
-            source =3D "%s '%s'" % (source, f['name'])
-            check_name_str(f['name'], info, source)
-            check_if(f, info, source)
-            normalize_if(f)
+    check_features(expr.get('features'), info)
=20
=20
 def check_union(expr, info):
@@ -282,6 +285,7 @@ def check_command(expr, info):
         raise QAPISemError(info, "'boxed': true requires 'data'")
     check_type(args, info, "'data'", allow_dict=3Dnot boxed)
     check_type(rets, info, "'returns'", allow_array=3DTrue)
+    check_features(expr.get('features'), info)
=20
=20
 def check_event(expr, info):
@@ -357,10 +361,11 @@ def check_exprs(exprs):
         elif meta =3D=3D 'command':
             check_keys(expr, info, meta,
                        ['command'],
-                       ['data', 'returns', 'boxed', 'if',
+                       ['data', 'returns', 'boxed', 'if', 'features',
                         'gen', 'success-response', 'allow-oob',
                         'allow-preconfig'])
             normalize_members(expr.get('data'))
+            normalize_features(expr.get('features'))
             check_command(expr, info)
         elif meta =3D=3D 'event':
             check_keys(expr, info, meta,
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index d1c1ad346d..739b35ae8f 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -209,13 +209,18 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                            for m in variants.variants]}, ifcond)
=20
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
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 38041098bd..8a48231766 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -109,7 +109,8 @@ class QAPISchemaVisitor(object):
         pass
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         pass
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
@@ -658,10 +659,14 @@ class QAPISchemaCommand(QAPISchemaEntity):
     meta =3D 'command'
=20
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
+            f.set_defined_in(name)
         self._arg_type_name =3D arg_type
         self.arg_type =3D None
         self._ret_type_name =3D ret_type
@@ -671,6 +676,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
         self.allow_oob =3D allow_oob
         self.allow_preconfig =3D allow_preconfig
+        self.features =3D features
=20
     def check(self, schema):
         QAPISchemaEntity.check(self, schema)
@@ -700,13 +706,19 @@ class QAPISchemaCommand(QAPISchemaEntity):
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
=20
+        # Features are in a name space separate from members
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
     def visit(self, visitor):
         QAPISchemaEntity.visit(self, visitor)
         visitor.visit_command(self.name, self.info, self.ifcond,
                               self.arg_type, self.ret_type,
                               self.gen, self.success_response,
                               self.boxed, self.allow_oob,
-                              self.allow_preconfig)
+                              self.allow_preconfig,
+                              self.features)
=20
=20
 class QAPISchemaEvent(QAPISchemaEntity):
@@ -983,6 +995,7 @@ class QAPISchema(object):
         allow_oob =3D expr.get('allow-oob', False)
         allow_preconfig =3D expr.get('allow-preconfig', False)
         ifcond =3D expr.get('if')
+        features =3D expr.get('features', [])
         if isinstance(data, OrderedDict):
             data =3D self._make_implicit_object_type(
                 name, info, doc, ifcond, 'arg', self._make_members(data,=
 info))
@@ -991,7 +1004,8 @@ class QAPISchema(object):
             rets =3D self._make_array_type(rets[0], info)
         self._def_entity(QAPISchemaCommand(name, info, doc, ifcond, data=
, rets,
                                            gen, success_response,
-                                           boxed, allow_oob, allow_preco=
nfig))
+                                           boxed, allow_oob, allow_preco=
nfig,
+                                           self._make_features(features,=
 info)))
=20
     def _def_event(self, expr, info, doc):
         name =3D expr['event']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 29d9435bf7..d31ac4bbb7 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -72,7 +72,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         self._print_if(ifcond)
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type, gen,
-                      success_response, boxed, allow_oob, allow_preconfi=
g):
+                      success_response, boxed, allow_oob, allow_preconfi=
g,
+                      features):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
--=20
2.21.0



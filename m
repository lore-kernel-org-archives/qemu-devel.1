Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F87C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15B720578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHxfDZ5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15B720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDV8w-0001B5-UM
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXx-0005sQ-AT
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXv-0003aW-BT
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXv-0003Xg-5q
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMSh3qb3tLisebzojkYKMYeIYUT68jvj+8lhSXCabhQ=;
 b=DHxfDZ5SxyRjcwuxEcg3/aOrvMBvCO22dB8re+MQgfbzAd9n1IH7UU1d2E2MZ4RBqeylkp
 lzpnSuuddDWxn4xQphkgutseGi7E9dVZJpoc28KTZgZL4G+bjV4YPNKzqGx7MsE1oN/9X8
 1+lgHNiIwKMzVqdr6iqzTiCoLGZdvHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-WrzXTEqBOgm7vzlL2Ygnjg-1; Sun, 15 Mar 2020 10:46:59 -0400
X-MC-Unique: WrzXTEqBOgm7vzlL2Ygnjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F9731005512;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17E509CA3;
 Sun, 15 Mar 2020 14:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B4BEC1135A70; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/34] qapi: Add feature flags to struct members
Date: Sun, 15 Mar 2020 15:46:39 +0100
Message-Id: <20200315144653.22660-21-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt            |  4 +++-
 tests/qapi-schema/doc-good.texi         |  2 ++
 qapi/introspect.json                    |  6 +++++-
 scripts/qapi/expr.py                    |  3 ++-
 scripts/qapi/introspect.py              |  2 +-
 scripts/qapi/schema.py                  | 25 ++++++++++++++++++++-----
 tests/qapi-schema/doc-good.json         |  5 ++++-
 tests/qapi-schema/doc-good.out          |  3 +++
 tests/qapi-schema/qapi-schema-test.json |  2 +-
 tests/qapi-schema/qapi-schema-test.out  |  1 +
 tests/qapi-schema/test-qapi.py          |  7 ++++---
 11 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 9fce78dcad..a1ef1cfd61 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -234,7 +234,9 @@ Syntax:
                '*features': FEATURES }
     MEMBERS =3D { MEMBER, ... }
     MEMBER =3D STRING : TYPE-REF
-           | STRING : { 'type': TYPE-REF, '*if': COND }
+           | STRING : { 'type': TYPE-REF,
+                        '*if': COND,
+                        '*features': FEATURES }
=20
 Member 'struct' names the struct type.
=20
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.t=
exi
index 76b396dae6..7f28fb7a0f 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -132,6 +132,8 @@ Not documented
 @table @asis
 @item @code{variant1-feat}
 a feature
+@item @code{member-feat}
+a member feature
 @end table
=20
 @end deftp
diff --git a/qapi/introspect.json b/qapi/introspect.json
index da3e176899..b1aabd4cfd 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -206,11 +206,15 @@
 #           Future extension: if present and non-null, the parameter
 #           is optional, and defaults to this value.
 #
+# @features: names of features associated with the member, in no
+#            particular order.  (since 5.0)
+#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoObjectMember',
-  'data': { 'name': 'str', 'type': 'str', '*default': 'any' } }
+  'data': { 'name': 'str', 'type': 'str', '*default': 'any',
 # @default's type must be null or match @type
+            '*features': [ 'str' ] } }
=20
 ##
 # @SchemaInfoObjectVariant:
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index f9c4448980..2942520399 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -167,8 +167,9 @@ def check_type(value, info, source,
                        allow_optional=3DTrue, permit_upper=3Dpermit_upper)
         if c_name(key, False) =3D=3D 'u' or c_name(key, False).startswith(=
'has_'):
             raise QAPISemError(info, "%s uses reserved name" % key_source)
-        check_keys(arg, info, key_source, ['type'], ['if'])
+        check_keys(arg, info, key_source, ['type'], ['if', 'features'])
         check_if(arg, info, key_source)
+        check_features(arg.get('features'), info)
         check_type(arg['type'], info, key_source, allow_array=3DTrue)
=20
=20
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index a3fa9865db..23652be810 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -173,7 +173,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         obj =3D {'name': member.name, 'type': self._use_type(member.type)}
         if member.optional:
             obj['default'] =3D None
-        return _make_tree(obj, member.ifcond, None)
+        return _make_tree(obj, member.ifcond, member.features)
=20
     def _gen_variants(self, tag_name, variants):
         return {'tag': tag_name,
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 59e1f5a395..6ee3677215 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -668,18 +668,31 @@ class QAPISchemaFeature(QAPISchemaMember):
=20
=20
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, info, typ, optional, ifcond=3DNone):
+    def __init__(self, name, info, typ, optional, ifcond=3DNone, features=
=3DNone):
         super().__init__(name, info, ifcond)
         assert isinstance(typ, str)
         assert isinstance(optional, bool)
+        for f in features or []:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_defined_in(name)
         self._type_name =3D typ
         self.type =3D None
         self.optional =3D optional
+        self.features =3D features or []
=20
     def check(self, schema):
         assert self.defined_in
         self.type =3D schema.resolve_type(self._type_name, self.info,
                                         self.describe)
+        seen =3D {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
+    def connect_doc(self, doc):
+        super().connect_doc(doc)
+        if doc:
+            for f in self.features:
+                doc.connect_feature(f)
=20
=20
 class QAPISchemaVariant(QAPISchemaObjectTypeMember):
@@ -962,7 +975,7 @@ class QAPISchema:
             name, info, doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
=20
-    def _make_member(self, name, typ, ifcond, info):
+    def _make_member(self, name, typ, ifcond, features, info):
         optional =3D False
         if name.startswith('*'):
             name =3D name[1:]
@@ -970,10 +983,12 @@ class QAPISchema:
         if isinstance(typ, list):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
-        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifcon=
d)
+        return QAPISchemaObjectTypeMember(name, info, typ, optional, ifcon=
d,
+                                          self._make_features(features, in=
fo))
=20
     def _make_members(self, data, info):
-        return [self._make_member(key, value['type'], value.get('if'), inf=
o)
+        return [self._make_member(key, value['type'], value.get('if'),
+                                  value.get('features'), info)
                 for (key, value) in data.items()]
=20
     def _def_struct_type(self, expr, info, doc):
@@ -996,7 +1011,7 @@ class QAPISchema:
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
             typ, info, self.lookup_type(typ),
-            'wrapper', [self._make_member('data', typ, None, info)])
+            'wrapper', [self._make_member('data', typ, None, None, info)])
         return QAPISchemaVariant(case, info, typ, ifcond)
=20
     def _def_union_type(self, expr, info, doc):
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.j=
son
index 457b8b2cdf..ddd89d1233 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -78,10 +78,13 @@
 #
 # Features:
 # @variant1-feat: a feature
+# @member-feat: a member feature
 ##
 { 'struct': 'Variant1',
   'features': [ 'variant1-feat' ],
-  'data': { 'var1': { 'type': 'str', 'if': 'defined(IFSTR)' } } }
+  'data': { 'var1': { 'type': 'str',
+                      'features': [ 'member-feat' ],
+                      'if': 'defined(IFSTR)' } } }
=20
 ##
 # @Variant2:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.ou=
t
index 9bcb2b3e91..6757dd26a2 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -21,6 +21,7 @@ object Base
 object Variant1
     member var1: str optional=3DFalse
         if ['defined(IFSTR)']
+        feature member-feat
     feature variant1-feat
 object Variant2
 object Object
@@ -135,6 +136,8 @@ Another paragraph (but no @var: line)
=20
     feature=3Dvariant1-feat
 a feature
+    feature=3Dmember-feat
+a member feature
 doc symbol=3DVariant2
     body=3D
=20
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index fa4f3a15da..f576c337af 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -258,7 +258,7 @@
   'data': { 'foo': 'int' },
   'features': [] }
 { 'struct': 'FeatureStruct1',
-  'data': { 'foo': 'int' },
+  'data': { 'foo': { 'type': 'int', 'features': [ 'member-feature1' ] } },
   'features': [ 'feature1' ] }
 { 'struct': 'FeatureStruct2',
   'data': { 'foo': 'int' },
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index 1cbd0802b3..cd863ae966 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -359,6 +359,7 @@ object FeatureStruct0
     member foo: int optional=3DFalse
 object FeatureStruct1
     member foo: int optional=3DFalse
+        feature member-feature1
     feature feature1
 object FeatureStruct2
     member foo: int optional=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.p=
y
index 8e09e54edb..f396b471eb 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -55,6 +55,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('    member %s: %s optional=3D%s'
                   % (m.name, m.type.name, m.optional))
             self._print_if(m.ifcond, 8)
+            self._print_features(m.features, indent=3D8)
         self._print_variants(variants)
         self._print_if(ifcond)
         self._print_features(features)
@@ -96,11 +97,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             print('%sif %s' % (' ' * indent, ifcond))
=20
     @classmethod
-    def _print_features(cls, features):
+    def _print_features(cls, features, indent=3D4):
         if features:
             for f in features:
-                print('    feature %s' % f.name)
-                cls._print_if(f.ifcond, 8)
+                print('%sfeature %s' % (' ' * indent, f.name))
+                cls._print_if(f.ifcond, indent + 4)
=20
=20
 def test_frontend(fname):
--=20
2.21.1



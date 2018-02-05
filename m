Received: from eggs.gnu.org ([2001:4830:134:3::10]:59214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsq-0001SY-8q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eipsp-0006Ss-8E
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eipsp-0006Qz-0d
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 18:09:07 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  5 Feb 2018 21:08:41 -0200
Message-Id: <20180205230900.11344-3-ehabkost@redhat.com>
In-Reply-To: <20180205230900.11344-1-ehabkost@redhat.com>
References: <20180205230900.11344-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/21] qapi: use items()/values() intead of
 iteritems()/itervalues()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The iteritems()/itervalues() methods are gone in py3, but the
items()/values() methods are still around. The latter are less
efficient than the former in py2, but this has unmeasurably
small impact on QEMU build time, so taking portability over
efficiency is a net win.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180116134217.8725-3-berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/qapi.py                | 12 ++++++------
 scripts/qapi2texi.py           |  2 +-
 tests/qapi-schema/test-qapi.py |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 64fde4b6c5..98d7123d27 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -245,7 +245,7 @@ class QAPIDoc(object):
                                "'Returns:' is only valid for commands")
=20
     def check(self):
-        bogus =3D [name for name, section in self.args.iteritems()
+        bogus =3D [name for name, section in self.args.items()
                  if not section.member]
         if bogus:
             raise QAPISemError(
@@ -300,7 +300,7 @@ class QAPISchemaParser(object):
                 if not isinstance(pragma, dict):
                     raise QAPISemError(
                         info, "Value of 'pragma' must be a dictionary")
-                for name, value in pragma.iteritems():
+                for name, value in pragma.items():
                     self._pragma(name, value, info)
             else:
                 expr_elem =3D {'expr': expr,
@@ -1566,7 +1566,7 @@ class QAPISchema(object):
=20
     def _make_members(self, data, info):
         return [self._make_member(key, value, info)
-                for (key, value) in data.iteritems()]
+                for (key, value) in data.items()]
=20
     def _def_struct_type(self, expr, info, doc):
         name =3D expr['struct']
@@ -1598,11 +1598,11 @@ class QAPISchema(object):
                 name, info, doc, 'base', self._make_members(base, info))=
)
         if tag_name:
             variants =3D [self._make_variant(key, value)
-                        for (key, value) in data.iteritems()]
+                        for (key, value) in data.items()]
             members =3D []
         else:
             variants =3D [self._make_simple_variant(key, value, info)
-                        for (key, value) in data.iteritems()]
+                        for (key, value) in data.items()]
             typ =3D self._make_implicit_enum_type(name, info,
                                                 [v.name for v in variant=
s])
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
@@ -1617,7 +1617,7 @@ class QAPISchema(object):
         name =3D expr['alternate']
         data =3D expr['data']
         variants =3D [self._make_variant(key, value)
-                    for (key, value) in data.iteritems()]
+                    for (key, value) in data.items()]
         tag_member =3D QAPISchemaObjectTypeMember('type', 'QType', False=
)
         self._def_entity(
             QAPISchemaAlternateType(name, info, doc,
diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 70e1fe76ef..bf1c57b2e2 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -146,7 +146,7 @@ def texi_member(member, suffix=3D''):
 def texi_members(doc, what, base, variants, member_func):
     """Format the table of members"""
     items =3D ''
-    for section in doc.args.itervalues():
+    for section in doc.args.values():
         # TODO Drop fallbacks when undocumented members are outlawed
         if section.text:
             desc =3D texi_format(section.text)
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index a43fa873e1..ac43d3458e 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -63,7 +63,7 @@ for doc in schema.docs:
     else:
         print('doc freeform')
     print('    body=3D\n%s' % doc.body.text)
-    for arg, section in doc.args.iteritems():
+    for arg, section in doc.args.items():
         print('    arg=3D%s\n%s' % (arg, section.text))
     for section in doc.sections:
         print('    section=3D%s\n%s' % (section.name, section.text))
--=20
2.14.3

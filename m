Received: from eggs.gnu.org ([2001:4830:134:3::10]:59567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabC-0003xZ-LF
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabA-0003o3-RD
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVabA-0003nj-JA
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:40 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:42 +0400
Message-Id: <20181208111606.8505-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 03/27] qapi: rename
 QAPISchemaEnumType.values to .members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Rename QAPISchemaEnumType.values and related variables to members.
Makes sense ever since commit 93bda4dd4 changed .values from list of
string to list of QAPISchemaMember. Obvious no-op.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 7ea0cf5139..55c914ec44 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1161,22 +1161,22 @@ class QAPISchemaBuiltinType(QAPISchemaType):
=20
=20
 class QAPISchemaEnumType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond, values, prefix):
+    def __init__(self, name, info, doc, ifcond, members, prefix):
         QAPISchemaType.__init__(self, name, info, doc, ifcond)
-        for v in values:
-            assert isinstance(v, QAPISchemaMember)
-            v.set_owner(name)
+        for m in members:
+            assert isinstance(m, QAPISchemaMember)
+            m.set_owner(name)
         assert prefix is None or isinstance(prefix, str)
-        self.values =3D values
+        self.members =3D members
         self.prefix =3D prefix
=20
     def check(self, schema):
         QAPISchemaType.check(self, schema)
         seen =3D {}
-        for v in self.values:
-            v.check_clash(self.info, seen)
+        for m in self.members:
+            m.check_clash(self.info, seen)
             if self.doc:
-                self.doc.connect_member(v)
+                self.doc.connect_member(m)
=20
     def is_implicit(self):
         # See QAPISchema._make_implicit_enum_type() and ._def_predefined=
s()
@@ -1186,7 +1186,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         return c_name(self.name)
=20
     def member_names(self):
-        return [v.name for v in self.values]
+        return [m.name for m in self.members]
=20
     def json_type(self):
         return 'string'
@@ -1403,9 +1403,9 @@ class QAPISchemaObjectTypeVariants(object):
         if self._tag_name:    # flat union
             # branches that are not explicitly covered get an empty type
             cases =3D set([v.name for v in self.variants])
-            for val in self.tag_member.type.values:
-                if val.name not in cases:
-                    v =3D QAPISchemaObjectTypeVariant(val.name, 'q_empty=
')
+            for m in self.tag_member.type.members:
+                if m.name not in cases:
+                    v =3D QAPISchemaObjectTypeVariant(m.name, 'q_empty')
                     v.set_owner(self.tag_member.owner)
                     self.variants.append(v)
         for v in self.variants:
--=20
2.20.0.rc1

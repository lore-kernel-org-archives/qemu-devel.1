Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQM-0003Ky-Ev
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYDQJ-00030h-W0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYDQJ-0002zz-Qr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:36:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Jun 2018 18:35:40 +0200
Message-Id: <20180627163551.31610-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180627163551.31610-1-marcandre.lureau@redhat.com>
References: <20180627163551.31610-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 04/15] qapi: leave the ifcond attribute
 undefined until check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, eblake@redhat.com, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

We commonly initialize attributes to None in .init(), then set their
real value in .check().  Accessing the attribute before .check()
yields None.  If we're lucky, the code that accesses the attribute
prematurely chokes on None.

It won't for .ifcond, because None is a legitimate value.

Leave the ifcond attribute undefined until check().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4f4014b387..46e33e23e4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1021,13 +1021,19 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
-        self.ifcond =3D listify_cond(ifcond)
+        self._ifcond =3D ifcond  # self.ifcond is set only after .check(=
)
=20
     def c_name(self):
         return c_name(self.name)
=20
     def check(self, schema):
-        pass
+        if isinstance(self._ifcond, QAPISchemaType):
+            # inherit the condition from a type
+            typ =3D self._ifcond
+            typ.check(schema)
+            self.ifcond =3D typ.ifcond
+        else:
+            self.ifcond =3D listify_cond(self._ifcond)
=20
     def is_implicit(self):
         return not self.info
@@ -1164,6 +1170,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         self.prefix =3D prefix
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         seen =3D {}
         for v in self.values:
             v.check_clash(self.info, seen)
@@ -1196,8 +1203,10 @@ class QAPISchemaArrayType(QAPISchemaType):
         self.element_type =3D None
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         self.element_type =3D schema.lookup_type(self._element_type_name=
)
         assert self.element_type
+        self.element_type.check(schema)
         self.ifcond =3D self.element_type.ifcond
=20
     def is_implicit(self):
@@ -1240,6 +1249,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         self.members =3D None
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         if self.members is False:               # check for cycles
             raise QAPISemError(self.info,
                                "Object %s contains itself" % self.name)
@@ -1430,6 +1440,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
         self.variants =3D variants
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         self.variants.tag_member.check(schema)
         # Not calling self.variants.check_clash(), because there's nothi=
ng
         # to clash with
@@ -1474,6 +1485,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.allow_preconfig =3D allow_preconfig
=20
     def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert (isinstance(self.arg_type, QAPISchemaObjectType) or
@@ -1509,6 +1521,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
         self.boxed =3D boxed
=20
     def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert (isinstance(self.arg_type, QAPISchemaObjectType) or
@@ -1642,7 +1655,7 @@ class QAPISchema(object):
             # But it's not tight: the disjunction need not imply it.  We
             # may end up compiling useless wrapper types.
             # TODO kill simple unions or implement the disjunction
-            assert ifcond =3D=3D typ.ifcond
+            assert ifcond =3D=3D typ._ifcond # pylint: disable=3Dprotect=
ed-access
         else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
                                                   None, members, None))
@@ -1688,7 +1701,7 @@ class QAPISchema(object):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
-            typ, info, None, self.lookup_type(typ).ifcond,
+            typ, info, None, self.lookup_type(typ),
             'wrapper', [self._make_member('data', typ, info)])
         return QAPISchemaObjectTypeVariant(case, typ)
=20
--=20
2.18.0.rc1

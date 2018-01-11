Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUN-0005go-Mg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkUK-0001nj-HC
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkUK-0001mn-7c
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:34:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:06 +0100
Message-Id: <20180111213250.16511-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/51] qapi: leave the ifcond attribute
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

We commonly initialize attributes to None in .init(), then set their
real value in .check().  Accessing the attribute before .check()
yields None.  If we're lucky, the code that accesses the attribute
prematurely chokes on None.

It won't for .ifcond, because None is a legitimate value.

Leave the ifcond attribute undefined until check().

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 8f54dead8d..4d2c214f19 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1011,13 +1011,19 @@ class QAPISchemaEntity(object):
         # such place).
         self.info =3D info
         self.doc =3D doc
-        self.ifcond =3D listify_cond(ifcond)
+        self._ifcond =3D ifcond  # self.ifcond is set after check()
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
@@ -1138,6 +1144,7 @@ class QAPISchemaEnumType(QAPISchemaType):
         self.prefix =3D prefix
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         seen =3D {}
         for v in self.values:
             v.check_clash(self.info, seen)
@@ -1170,8 +1177,10 @@ class QAPISchemaArrayType(QAPISchemaType):
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
@@ -1214,6 +1223,7 @@ class QAPISchemaObjectType(QAPISchemaType):
         self.members =3D None
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         if self.members is False:               # check for cycles
             raise QAPISemError(self.info,
                                "Object %s contains itself" % self.name)
@@ -1396,6 +1406,7 @@ class QAPISchemaAlternateType(QAPISchemaType):
         self.variants =3D variants
=20
     def check(self, schema):
+        QAPISchemaType.check(self, schema)
         self.variants.tag_member.check(schema)
         # Not calling self.variants.check_clash(), because there's nothi=
ng
         # to clash with
@@ -1438,6 +1449,7 @@ class QAPISchemaCommand(QAPISchemaEntity):
         self.boxed =3D boxed
=20
     def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert (isinstance(self.arg_type, QAPISchemaObjectType) or
@@ -1471,6 +1483,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
         self.boxed =3D boxed
=20
     def check(self, schema):
+        QAPISchemaEntity.check(self, schema)
         if self._arg_type_name:
             self.arg_type =3D schema.lookup_type(self._arg_type_name)
             assert (isinstance(self.arg_type, QAPISchemaObjectType) or
@@ -1589,7 +1602,7 @@ class QAPISchema(object):
             # But it's not tight: the disjunction need not imply it.  We
             # may end up compiling useless wrapper types.
             # TODO kill simple unions or implement the disjunction
-            assert ifcond =3D=3D typ.ifcond
+            assert ifcond =3D=3D typ._ifcond
         else:
             self._def_entity(QAPISchemaObjectType(name, info, doc, ifcon=
d,
                                                   None, members, None))
@@ -1635,7 +1648,7 @@ class QAPISchema(object):
             assert len(typ) =3D=3D 1
             typ =3D self._make_array_type(typ[0], info)
         typ =3D self._make_implicit_object_type(
-            typ, info, None, self.lookup_type(typ).ifcond,
+            typ, info, None, self.lookup_type(typ),
             'wrapper', [self._make_member('data', typ, info)])
         return QAPISchemaObjectTypeVariant(case, typ)
=20
--=20
2.16.0.rc1.1.gef27df75a1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVf-0006pF-M0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVd-0002ze-Ug
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVd-0002yB-MR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:37 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:18 +0100
Message-Id: <20180111213250.16511-20-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 19/51] qapi: change enum visitor to take
 QAPISchemaMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This will allow to add and access more properties associated with enum
values/members, like the associated 'if' condition. We may want to
have a specialized type QAPISchemaEnumMember, for now this will do.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py                | 12 ++++++------
 scripts/qapi-event.py          |  2 +-
 scripts/qapi-introspect.py     |  3 ++-
 tests/qapi-schema/test-qapi.py |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index c7cd98a890..f8c711b81b 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1166,7 +1166,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_enum_type(self.name, self.info, self.ifcond,
-                                self.member_names(), self.prefix)
+                                self.members, self.prefix)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
@@ -1966,11 +1966,11 @@ const QEnumLookup %(c_name)s_lookup =3D {
 ''',
                 c_name=3Dc_name(name))
     for m in members:
-        index =3D c_enum_const(name, m, prefix)
+        index =3D c_enum_const(name, m.name, prefix)
         ret +=3D mcgen('''
-        [%(index)s] =3D "%(value)s",
+        [%(index)s] =3D "%(name)s",
 ''',
-                     index=3Dindex, value=3Dm)
+                     index=3Dindex, name=3Dm.name)
=20
     ret +=3D mcgen('''
     },
@@ -1983,7 +1983,7 @@ const QEnumLookup %(c_name)s_lookup =3D {
=20
 def gen_enum(name, members, prefix=3DNone):
     # append automatically generated _MAX value
-    enum_members =3D members + ['_MAX']
+    enum_members =3D members + [QAPISchemaMember('_MAX')]
=20
     ret =3D mcgen('''
=20
@@ -1995,7 +1995,7 @@ typedef enum %(c_name)s {
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
-                     c_enum=3Dc_enum_const(name, m, prefix))
+                     c_enum=3Dc_enum_const(name, m.name, prefix))
=20
     ret +=3D mcgen('''
 } %(c_name)s;
diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
index bef301dfe9..38f4264817 100644
--- a/scripts/qapi-event.py
+++ b/scripts/qapi-event.py
@@ -168,7 +168,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaVisitor):
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         self.decl +=3D gen_event_send_decl(name, arg_type, boxed)
         self.defn +=3D gen_event_send(name, arg_type, boxed)
-        self._event_names.append(name)
+        self._event_names.append(QAPISchemaMember(name))
=20
=20
 (input_file, output_dir, do_c, do_h, prefix, dummy) =3D parse_command_li=
ne()
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 9fcb342c91..868d12f504 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -154,7 +154,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
=20
     def visit_enum_type(self, name, info, ifcond, members, prefix):
-        self._gen_qlit(name, 'enum', {'values': members}, ifcond)
+        self._gen_qlit(name, 'enum',
+                       {'values': [m.name for m in members]}, ifcond)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 1c4f9e0dac..2ab79230c2 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -18,7 +18,7 @@ import sys
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
     def visit_enum_type(self, name, info, ifcond, members, prefix):
-        print 'enum %s %s' % (name, members)
+        print 'enum %s %s' % (name, [m.name for m in members])
         if prefix:
             print '    prefix %s' % prefix
         self._print_if(ifcond)
--=20
2.16.0.rc1.1.gef27df75a1

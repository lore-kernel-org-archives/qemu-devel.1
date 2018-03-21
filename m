Received: from eggs.gnu.org ([2001:4830:134:3::10]:48512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIf-0005IY-Jx
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIe-0007xa-Gw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIe-0007xF-CH
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D855A4068035
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:39 +0100
Message-Id: <20180321115211.17937-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 17/49] qapi: change enum visitor to take
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will allow to add and access more properties associated with enum
values/members, like the associated 'if' condition. We may want to
have a specialized type QAPISchemaEnumMember, for now this will do.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py         | 12 ++++++------
 scripts/qapi/events.py         |  2 +-
 scripts/qapi/introspect.py     |  3 ++-
 tests/qapi-schema/test-qapi.py |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index ea5cdfe3be..4d19146064 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1198,7 +1198,7 @@ class QAPISchemaEnumType(QAPISchemaType):
=20
     def visit(self, visitor):
         visitor.visit_enum_type(self.name, self.info, self.ifcond,
-                                self.member_names(), self.prefix)
+                                self.members, self.prefix)
=20
=20
 class QAPISchemaArrayType(QAPISchemaType):
@@ -2007,11 +2007,11 @@ const QEnumLookup %(c_name)s_lookup =3D {
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
@@ -2024,7 +2024,7 @@ const QEnumLookup %(c_name)s_lookup =3D {
=20
 def gen_enum(name, members, prefix=3DNone):
     # append automatically generated _MAX value
-    enum_members =3D members + ['_MAX']
+    enum_members =3D members + [QAPISchemaMember('_MAX')]
=20
     ret =3D mcgen('''
=20
@@ -2036,7 +2036,7 @@ typedef enum %(c_name)s {
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
-                     c_enum=3Dc_enum_const(name, m, prefix))
+                     c_enum=3Dc_enum_const(name, m.name, prefix))
=20
     ret +=3D mcgen('''
 } %(c_name)s;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index dae03e3d88..233c27a6c8 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -188,7 +188,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_event_send_decl(name, arg_type, boxed))
             self._genc.add(gen_event_send(name, arg_type, boxed, self._e=
num_name))
-        self._event_names.append(name)
+        self._event_names.append(QAPISchemaMember(name))
=20
=20
 def gen_events(schema, output_dir, prefix):
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 66f7fd00a9..d62fca84de 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -164,7 +164,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
index f4b8feb9bc..3623deae62 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -24,7 +24,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('include %s' % name)
=20
     def visit_enum_type(self, name, info, ifcond, members, prefix):
-        print('enum %s %s' % (name, members))
+        print('enum %s %s' % (name, [m.name for m in members]))
         if prefix:
             print('    prefix %s' % prefix)
         self._print_if(ifcond)
--=20
2.16.2.521.g9aa15f885a

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWJ-0007Rm-Hy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkWG-0004Ej-Mi
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkWG-0004Ck-E3
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:36:16 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:30 +0100
Message-Id: <20180111213250.16511-32-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 31/51] qapi: add #if conditions to generated
 code
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

Wrap generated enum/struct members and code with #if/#endif, using the
.ifcond members added in the previous patches.

Some types generate both enum and struct members for example, so a
step-by-step is unnecessarily complicated to deal with (it would
easily generate invalid intermediary code).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py            |  4 ++++
 scripts/qapi-introspect.py | 13 +++++++++----
 scripts/qapi-types.py      |  4 ++++
 scripts/qapi-visit.py      |  8 +++++++-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index f24cf8bda6..1668a6da6c 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -2043,11 +2043,13 @@ const QEnumLookup %(c_name)s_lookup =3D {
 ''',
                 c_name=3Dc_name(name))
     for m in members:
+        ret +=3D gen_if(m.ifcond)
         index =3D c_enum_const(name, m.name, prefix)
         ret +=3D mcgen('''
         [%(index)s] =3D "%(name)s",
 ''',
                      index=3Dindex, name=3Dm.name)
+        ret +=3D gen_endif(m.ifcond)
=20
     ret +=3D mcgen('''
     },
@@ -2069,10 +2071,12 @@ typedef enum %(c_name)s {
                 c_name=3Dc_name(name))
=20
     for m in enum_members:
+        ret +=3D gen_if(m.ifcond)
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
                      c_enum=3Dc_enum_const(name, m.name, prefix))
+        ret +=3D gen_endif(m.ifcond)
=20
     ret +=3D mcgen('''
 } %(c_name)s;
diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 868d12f504..6a66047243 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -141,6 +141,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
         if member.optional:
             ret['default'] =3D None
+        if member.ifcond:
+            ret =3D (ret, member.ifcond)
         return ret
=20
     def _gen_variants(self, tag_name, variants):
@@ -148,14 +150,16 @@ const QLitObject %(c_name)s =3D %(c_string)s;
                 'variants': [self._gen_variant(v) for v in variants]}
=20
     def _gen_variant(self, variant):
-        return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
+        return ({'case': variant.name, 'type': self._use_type(variant.ty=
pe)},
+                variant.ifcond)
=20
     def visit_builtin_type(self, name, info, json_type):
         self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
=20
     def visit_enum_type(self, name, info, ifcond, members, prefix):
         self._gen_qlit(name, 'enum',
-                       {'values': [m.name for m in members]}, ifcond)
+                       {'values': [(m.name, m.ifcond) for m in members]}=
,
+                       ifcond)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
@@ -171,8 +175,9 @@ const QLitObject %(c_name)s =3D %(c_string)s;
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         self._gen_qlit(name, 'alternate',
-                       {'members': [{'type': self._use_type(m.type)}
-                                    for m in variants.variants]}, ifcond=
)
+                       {'members': [
+                           ({'type': self._use_type(m.type)}, m.ifcond)
+                           for m in variants.variants]}, ifcond)
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed):
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 75c1823e44..312685c295 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -41,6 +41,7 @@ struct %(c_name)s {
 def gen_struct_members(members):
     ret =3D ''
     for memb in members:
+        ret +=3D gen_if(memb.ifcond)
         if memb.optional:
             ret +=3D mcgen('''
     bool has_%(c_name)s;
@@ -50,6 +51,7 @@ def gen_struct_members(members):
     %(c_type)s %(c_name)s;
 ''',
                      c_type=3Dmemb.type.c_type(), c_name=3Dc_name(memb.n=
ame))
+        ret +=3D gen_endif(memb.ifcond)
     return ret
=20
=20
@@ -129,11 +131,13 @@ def gen_variants(variants):
                 c_name=3Dc_name(variants.tag_member.name))
=20
     for var in variants.variants:
+        ret +=3D gen_if(var.ifcond)
         ret +=3D mcgen('''
         %(c_type)s %(c_name)s;
 ''',
                      c_type=3Dvar.type.c_unboxed_type(),
                      c_name=3Dc_name(var.name))
+        ret +=3D gen_endif(var.ifcond)
=20
     ret +=3D mcgen('''
     } u;
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e816ae98e..48ac1c9a42 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -53,6 +53,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                      c_type=3Dbase.c_name())
=20
     for memb in members:
+        ret +=3D gen_if(memb.ifcond)
         if memb.optional:
             ret +=3D mcgen('''
     if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
@@ -72,6 +73,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
             ret +=3D mcgen('''
     }
 ''')
+        ret +=3D gen_endif(memb.ifcond)
=20
     if variants:
         ret +=3D mcgen('''
@@ -80,6 +82,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                      c_name=3Dc_name(variants.tag_member.name))
=20
         for var in variants.variants:
+            ret +=3D gen_if(var.ifcond)
             ret +=3D mcgen('''
     case %(case)s:
         visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, &err);
@@ -90,6 +93,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                                            variants.tag_member.type.pref=
ix),
                          c_type=3Dvar.type.c_name(), c_name=3Dc_name(var=
.name))
=20
+            ret +=3D gen_endif(var.ifcond)
         ret +=3D mcgen('''
     default:
         abort();
@@ -177,9 +181,10 @@ void visit_type_%(c_name)s(Visitor *v, const char *n=
ame, %(c_name)s **obj, Error
     }
     switch ((*obj)->type) {
 ''',
-                 c_name=3Dc_name(name))
+                c_name=3Dc_name(name))
=20
     for var in variants.variants:
+        ret +=3D gen_if(var.ifcond)
         ret +=3D mcgen('''
     case %(case)s:
 ''',
@@ -207,6 +212,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
         ret +=3D mcgen('''
         break;
 ''')
+        ret +=3D gen_endif(var.ifcond)
=20
     ret +=3D mcgen('''
     case QTYPE_NONE:
--=20
2.16.0.rc1.1.gef27df75a1

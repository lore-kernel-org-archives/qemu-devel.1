Received: from eggs.gnu.org ([2001:4830:134:3::10]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIN-00054M-I7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIM-0007oI-Do
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIM-0007o4-8H
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C357BEB70F
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:32 +0100
Message-Id: <20180321115211.17937-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/49] qapi-introspect: add preprocessor
 conditions to generated QLit
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

The generator will take (obj, condition) tuples to wrap generated QLit
objects for 'obj' with #if/#endif conditions.

This commit adds 'ifcond' condition to top-level QLit objects.

See generated tests/test-qmp-introspect.c. Example diff after this patch:

    --- before	2018-01-08 11:55:24.757083654 +0100
    +++ tests/test-qmp-introspect.c	2018-01-08 13:08:44.477641629 +0100
    @@ -51,6 +51,8 @@
             { "name", QLIT_QSTR("EVENT_F"), },
             {}
         })),
    +#if defined(TEST_IF_CMD)
    +#if defined(TEST_IF_STRUCT)
         QLIT_QDICT(((QLitDictEntry[]) {
             { "arg-type", QLIT_QSTR("5"), },
             { "meta-type", QLIT_QSTR("command"), },
    @@ -58,12 +60,16 @@
             { "ret-type", QLIT_QSTR("0"), },
             {}
         })),
    +#endif /* defined(TEST_IF_STRUCT) */
    +#endif /* defined(TEST_IF_CMD) */

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 1a8eb9e33e..cb4825f134 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -18,6 +18,15 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFa=
lse):
     def indent(level):
         return level * 4 * ' '
=20
+    if isinstance(obj, tuple):
+        ifobj, ifcond =3D obj
+        ret =3D gen_if(ifcond)
+        ret +=3D to_qlit(ifobj, level)
+        endif =3D gen_endif(ifcond)
+        if endif:
+            ret +=3D '\n' + endif
+        return ret
+
     ret =3D ''
     if not suppress_first_indent:
         ret +=3D indent(level)
@@ -26,7 +35,7 @@ def to_qlit(obj, level=3D0, suppress_first_indent=3DFal=
se):
     elif isinstance(obj, str):
         ret +=3D 'QLIT_QSTR(' + to_c_string(obj) + ')'
     elif isinstance(obj, list):
-        elts =3D [to_qlit(elt, level + 1)
+        elts =3D [to_qlit(elt, level + 1).strip('\n')
                 for elt in obj]
         elts.append(indent(level + 1) + "{}")
         ret +=3D 'QLIT_QLIST(((QLitObject[]) {\n'
@@ -131,12 +140,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
             return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
=20
-    def _gen_qlit(self, name, mtype, obj):
+    def _gen_qlit(self, name, mtype, obj, ifcond):
         if mtype not in ('command', 'event', 'builtin', 'array'):
             name =3D self._name(name)
         obj['name'] =3D name
         obj['meta-type'] =3D mtype
-        self._qlits.append(obj)
+        self._qlits.append((obj, ifcond))
=20
     def _gen_member(self, member):
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
@@ -152,26 +161,27 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
=20
     def visit_builtin_type(self, name, info, json_type):
-        self._gen_qlit(name, 'builtin', {'json-type': json_type})
+        self._gen_qlit(name, 'builtin', {'json-type': json_type}, [])
=20
     def visit_enum_type(self, name, info, ifcond, values, prefix):
-        self._gen_qlit(name, 'enum', {'values': values})
+        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
=20
     def visit_array_type(self, name, info, ifcond, element_type):
         element =3D self._use_type(element_type)
-        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
+        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
+                       ifcond)
=20
     def visit_object_type_flat(self, name, info, ifcond, members, varian=
ts):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
-        self._gen_qlit(name, 'object', obj)
+        self._gen_qlit(name, 'object', obj, ifcond)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
-                                    for m in variants.variants]})
+                                    for m in variants.variants]}, ifcond=
)
=20
     def visit_command(self, name, info, ifcond, arg_type, ret_type,
                       gen, success_response, boxed, allow_oob):
@@ -180,11 +190,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
                         'ret-type': self._use_type(ret_type),
-                        'allow-oob': allow_oob})
+                        'allow-oob': allow_oob}, ifcond)
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         arg_type =3D arg_type or self._schema.the_empty_object_type
-        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
+        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
+                       ifcond)
=20
=20
 def gen_introspect(schema, output_dir, prefix, opt_unmask):
--=20
2.16.2.521.g9aa15f885a

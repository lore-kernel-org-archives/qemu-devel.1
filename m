Received: from eggs.gnu.org ([2001:4830:134:3::10]:55329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JW-0008AK-2B
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JQ-00074a-4Y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JP-00073P-Rs
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:44 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:23 +0200
Message-Id: <20170822132255.23945-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 22/54] qapi-introspect: add preprocessor
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Add 'ifcond' condition to QLit objects.

to_qlit() handles the (obj, ifcond) tuples.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-introspect.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 9ef6f271d4..5e736a06df 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -125,12 +125,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
@@ -146,26 +146,27 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         return {'case': variant.name, 'type': self._use_type(variant.typ=
e)}
=20
     def visit_builtin_type(self, name, info, json_type):
-        self._gen_qlit(name, 'builtin', {'json-type': json_type})
+        self._gen_qlit(name, 'builtin', {'json-type': json_type}, None)
=20
     def visit_enum_type(self, name, info, values, prefix, ifcond):
-        self._gen_qlit(name, 'enum', {'values': values})
+        self._gen_qlit(name, 'enum', {'values': values}, ifcond)
=20
     def visit_array_type(self, name, info, element_type, ifcond):
         element =3D self._use_type(element_type)
-        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement})
+        self._gen_qlit('[' + element + ']', 'array', {'element-type': el=
ement},
+                       ifcond)
=20
     def visit_object_type_flat(self, name, info, members, variants, ifco=
nd):
         obj =3D {'members': [self._gen_member(m) for m in members]}
         if variants:
             obj.update(self._gen_variants(variants.tag_member.name,
                                           variants.variants))
-        self._gen_qlit(name, 'object', obj)
+        self._gen_qlit(name, 'object', obj, ifcond)
=20
     def visit_alternate_type(self, name, info, variants, ifcond):
         self._gen_qlit(name, 'alternate',
                        {'members': [{'type': self._use_type(m.type)}
-                                    for m in variants.variants]})
+                                    for m in variants.variants]}, ifcond=
)
=20
     def visit_command(self, name, info, arg_type, ret_type,
                       gen, success_response, boxed, ifcond):
@@ -173,11 +174,12 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         ret_type =3D ret_type or self._schema.the_empty_object_type
         self._gen_qlit(name, 'command',
                        {'arg-type': self._use_type(arg_type),
-                        'ret-type': self._use_type(ret_type)})
+                        'ret-type': self._use_type(ret_type)}, ifcond)
=20
     def visit_event(self, name, info, arg_type, boxed, ifcond):
         arg_type =3D arg_type or self._schema.the_empty_object_type
-        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)})
+        self._gen_qlit(name, 'event', {'arg-type': self._use_type(arg_ty=
pe)},
+                       ifcond)
=20
 # Debugging aid: unmask QAPI schema's type names
 # We normally mask them, because they're not QMP wire ABI
--=20
2.14.1.146.gd35faa819

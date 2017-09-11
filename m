Received: from eggs.gnu.org ([2001:4830:134:3::10]:43339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ8-0005zy-4c
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMZ2-0006mc-43
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMZ1-0006m5-Sd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:40 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:06:00 +0200
Message-Id: <20170911110623.24981-28-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 27/50] qapi: add #if conditions to generated
 variants
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-introspect.py | 3 ++-
 scripts/qapi-types.py      | 2 ++
 scripts/qapi-visit.py      | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 0e43e470bb..ef2d5577db 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -148,7 +148,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
         self._gen_qlit(name, 'builtin', {'json-type': json_type}, None)
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 7e6df21f53..312685c295 100644
--- a/scripts/qapi-types.py
+++ b/scripts/qapi-types.py
@@ -131,11 +131,13 @@ def gen_variants(variants):
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
index 6a3a52e39d..369e1f927d 100644
--- a/scripts/qapi-visit.py
+++ b/scripts/qapi-visit.py
@@ -82,6 +82,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
)s *obj, Error **errp)
                      c_name=3Dc_name(variants.tag_member.name))
=20
         for var in variants.variants:
+            ret +=3D gen_if(var.ifcond)
             ret +=3D mcgen('''
     case %(case)s:
         visit_type_%(c_type)s_members(v, &obj->u.%(c_name)s, &err);
@@ -92,6 +93,7 @@ void visit_type_%(c_name)s_members(Visitor *v, %(c_name=
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
@@ -182,6 +184,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
                  c_name=3Dc_name(name))
=20
     for var in variants.variants:
+        ret +=3D gen_if(var.ifcond)
         ret +=3D mcgen('''
     case %(case)s:
 ''',
@@ -209,6 +212,7 @@ void visit_type_%(c_name)s(Visitor *v, const char *na=
me, %(c_name)s **obj, Error
         ret +=3D mcgen('''
         break;
 ''')
+        ret +=3D gen_endif(var.ifcond)
=20
     ret +=3D mcgen('''
     case QTYPE_NONE:
--=20
2.14.1.146.gd35faa819

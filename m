Received: from eggs.gnu.org ([2001:4830:134:3::10]:43219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYy-0005r6-Rd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYu-0006hV-T5
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYu-0006h5-Ne
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:32 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:58 +0200
Message-Id: <20170911110623.24981-26-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 25/50] qapi: add #if conditions to generated
 struct members
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
 scripts/qapi-introspect.py | 2 ++
 scripts/qapi-types.py      | 2 ++
 scripts/qapi-visit.py      | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 32a58cf879..0e43e470bb 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -139,6 +139,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
         ret =3D {'name': member.name, 'type': self._use_type(member.type=
)}
         if member.optional:
             ret['default'] =3D None
+        if member.ifcond:
+            ret =3D (ret, member.ifcond)
         return ret
=20
     def _gen_variants(self, tag_name, variants):
diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
index 75c1823e44..7e6df21f53 100644
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
diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
index 7e816ae98e..6a3a52e39d 100644
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
--=20
2.14.1.146.gd35faa819

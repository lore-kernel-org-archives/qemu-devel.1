Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HN-0006HY-SX
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9HK-0005d3-2g
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9HJ-0005cV-Rl
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:31:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:35 +0200
Message-Id: <20170822132255.23945-35-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 34/54] qapi: add #if conditions to generated
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi-introspect.py | 2 ++
 scripts/qapi-types.py      | 2 ++
 scripts/qapi-visit.py      | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
index 5e736a06df..b379c7c170 100644
--- a/scripts/qapi-introspect.py
+++ b/scripts/qapi-introspect.py
@@ -136,6 +136,8 @@ const QLitObject %(c_name)s =3D %(c_string)s;
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
index c1316312ac..b7f4773fe1 100644
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
index bb18c9edee..25914f71b0 100644
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

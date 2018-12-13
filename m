Received: from eggs.gnu.org ([2001:4830:134:3::10]:47126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQG4-0000YS-Ik
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQG3-0006w3-32
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXQG2-00067A-OH
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:38:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 264F18831D
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:38:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 16:37:10 +0400
Message-Id: <20181213123724.4866-9-marcandre.lureau@redhat.com>
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 08/22] qapi: simplify make_enum_members()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

The function only receives the dictionary form of enum expressions
now, so we can make it shorter.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 569e397147..510b177e6a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1656,14 +1656,7 @@ class QAPISchema(object):
                                             qtype_values, 'QTYPE'))
=20
     def _make_enum_members(self, values):
-        enum =3D []
-        for v in values:
-            if isinstance(v, dict):
-                name =3D v['name']
-            else:
-                name =3D v
-            enum.append(QAPISchemaMember(name))
-        return enum
+        return [QAPISchemaMember(v['name']) for v in values]
=20
     def _make_implicit_enum_type(self, name, info, ifcond, values):
         # See also QAPISchemaObjectTypeMember._pretty_owner()
@@ -1763,8 +1756,8 @@ class QAPISchema(object):
         else:
             variants =3D [self._make_simple_variant(key, value, info)
                         for (key, value) in data.items()]
-            typ =3D self._make_implicit_enum_type(name, info, ifcond,
-                                                [v.name for v in variant=
s])
+            enum =3D [{'name': v.name} for v in variants]
+            typ =3D self._make_implicit_enum_type(name, info, ifcond, en=
um)
             tag_member =3D QAPISchemaObjectTypeMember('type', typ, False=
)
             members =3D [tag_member]
         self._def_entity(
--=20
2.20.0

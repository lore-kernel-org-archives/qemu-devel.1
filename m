Received: from eggs.gnu.org ([2001:4830:134:3::10]:54837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hr-0006hn-QG
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hm-00066g-1n
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hl-00065Y-Rw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:31 +0200
Message-Id: <20170822132255.23945-31-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 30/54] qapi: add #if conditions on generated
 enum values
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
 scripts/qapi.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 9c7c01c11d..201e425842 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1967,13 +1967,16 @@ static const char *const %(c_name)s_array[] =3D {
 ''',
                 c_name=3Dc_name(name))
     for value in values:
+        ifcond =3D None
         if isinstance(value, tuple):
             value, ifcond =3D value
+        ret +=3D gen_if(ifcond)
         index =3D c_enum_const(name, value, prefix)
         ret +=3D mcgen('''
     [%(index)s] =3D "%(value)s",
 ''',
                      index=3Dindex, value=3Dvalue)
+        ret +=3D gen_endif(ifcond)
=20
     max_index =3D c_enum_const(name, '_MAX', prefix)
     ret +=3D mcgen('''
@@ -1999,12 +2002,15 @@ typedef enum %(c_name)s {
                 c_name=3Dc_name(name))
=20
     for value in enum_values:
+        ifcond =3D None
         if isinstance(value, tuple):
             value, ifcond =3D value
+        ret +=3D gen_if(ifcond)
         ret +=3D mcgen('''
     %(c_enum)s,
 ''',
                      c_enum=3Dc_enum_const(name, value, prefix))
+        ret +=3D gen_endif(ifcond)
=20
     ret +=3D mcgen('''
 } %(c_name)s;
--=20
2.14.1.146.gd35faa819

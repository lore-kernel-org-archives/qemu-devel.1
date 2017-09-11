Received: from eggs.gnu.org ([2001:4830:134:3::10]:43130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYo-0005e0-6a
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1drMYj-0006X4-UU
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1drMYj-0006WX-P7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:07:21 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Sep 2017 13:05:54 +0200
Message-Id: <20170911110623.24981-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170911110623.24981-1-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/50] qapi: add #if conditions on generated
 enum members
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
 scripts/qapi.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 1535de9ce7..df2a304e8f 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1989,11 +1989,13 @@ const QEnumLookup %(c_name)s_lookup =3D {
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
@@ -2015,10 +2017,12 @@ typedef enum %(c_name)s {
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
--=20
2.14.1.146.gd35faa819

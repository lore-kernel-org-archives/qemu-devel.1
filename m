Received: from eggs.gnu.org ([2001:4830:134:3::10]:50529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVS-0006g5-TS
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkVO-0002fW-Bx
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eZkVO-0002es-2y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:35:22 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:16 +0100
Message-Id: <20180111213250.16511-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/51] qapi: do not define enumeration value
 explicitely
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

The C standard has the initial value at 0 and the subsequent values
incremented by 1. No need to set this explicitely.

This will prevent from artificial "gaps" when compiling out some enum
values and having unnecessarily large MAX values & enums arrays.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 71f28fc6d8..ee759489cb 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1991,14 +1991,11 @@ typedef enum %(c_name)s {
 ''',
                 c_name=3Dc_name(name))
=20
-    i =3D 0
     for value in enum_values:
         ret +=3D mcgen('''
-    %(c_enum)s =3D %(i)d,
+    %(c_enum)s,
 ''',
-                     c_enum=3Dc_enum_const(name, value, prefix),
-                     i=3Di)
-        i +=3D 1
+                     c_enum=3Dc_enum_const(name, value, prefix))
=20
     ret +=3D mcgen('''
 } %(c_name)s;
--=20
2.16.0.rc1.1.gef27df75a1

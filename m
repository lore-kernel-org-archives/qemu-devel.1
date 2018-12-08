Received: from eggs.gnu.org ([2001:4830:134:3::10]:59555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVab6-0003v9-Ty
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVab3-0003mf-Db
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVab3-0003kb-7P
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:33 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:41 +0400
Message-Id: <20181208111606.8505-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 02/27] qapi: do not define
 enumeration value explicitly
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

The C standard has the initial value at 0 and the subsequent values
incremented by 1. No need to set this explicitely.

This will prevent from artificial "gaps" when compiling out some enum
values and having unnecessarily large MAX values & enums arrays, or
simplifying iterating over valid enum values.

Whenever config-host.h is changed, all the enum/types are recompiled.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 7b62a4c7b0..7ea0cf5139 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2045,14 +2045,11 @@ typedef enum %(c_name)s {
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
2.20.0.rc1

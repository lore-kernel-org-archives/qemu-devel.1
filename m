Received: from eggs.gnu.org ([2001:4830:134:3::10]:46731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQFG-0008KP-1A
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQFC-0004Pa-Qe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXQFC-0004ND-KV
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:37:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 033FE3002F55
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:37:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 16:37:03 +0400
Message-Id: <20181213123724.4866-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 01/22] qapi: Do not define enumeration value
 explicitly
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

The generated C enumeration types explicitly set the enumeration
constants to 0, 1, 2, ...  That's exactly what you get when you don't
supply values.

Drop the explicit values.  No change now, but it will avoid gaps in
the values when we later add support for 'if' conditions.  Avoiding
such gaps will save us the trouble of changing the ENUM_lookup[]
tables to work without a sentinel.

We'll have to take care to ensure the headers required by the 'if'
conditions get always included before the generated QAPI code.
Fortunately, our convention to include "qemu/osdep.h" first in any .c
ensures that's the case for our CONFIG_FOO macros.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 046b7e5681..55c914ec44 100644
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
2.20.0

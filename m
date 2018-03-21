Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycId-0005Fz-BO
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIa-0007vP-MA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIa-0007v9-HG
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:52:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E7E280AD20C
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:52:56 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:37 +0100
Message-Id: <20180321115211.17937-16-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/49] qapi: do not define enumeration value
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
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The C standard has the initial value at 0 and the subsequent values
incremented by 1. No need to set this explicitely.

This will prevent from artificial "gaps" when compiling out some enum
values and having unnecessarily large MAX values & enums arrays.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 60c1d0a783..68a567f53f 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2032,14 +2032,11 @@ typedef enum %(c_name)s {
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
2.16.2.521.g9aa15f885a

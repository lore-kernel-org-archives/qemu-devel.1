Received: from eggs.gnu.org ([2001:4830:134:3::10]:58325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORE-00088d-55
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORC-0007MB-GR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORC-0007Kd-9e
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4A76E9007
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:32 +0200
Message-Id: <20180706105753.26700-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 06/27] qapi: do not define enumeration value
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
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The C standard has the initial value at 0 and the subsequent values
incremented by 1. No need to set this explicitely.

This will prevent from artificial "gaps" when compiling out some enum
values and having unnecessarily large MAX values & enums arrays, or
simplifying iterating over valid enum values.

Whenever config-host.h is changed, all the enum/types are recompiled.

(a subsequent patch will split the schema. Target-specific poisoined
conditionals will be added. They cannot be mixed with the common
schema: it is not possible to end up with enums of different values in
common and target builds)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/common.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 02c5c6767a..6f9498566e 100644
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
2.18.0.rc1

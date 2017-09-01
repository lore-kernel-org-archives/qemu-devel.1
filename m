Received: from eggs.gnu.org ([2001:4830:134:3::10]:54124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUs-0000Te-UR
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0007PV-8l
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUk-0007OJ-WF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED1F3C056819
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:56:11 +0200
Message-Id: <20170901125611.29295-48-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 47/47] qapi: drop the sentinel in enum array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Now that all usages have been converted to user lookup helpers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170822132255.23945-14-marcandre.lureau@redhat.com>
[Rebased, superfluous local variable dropped, missing
check-qom-proplist.c update added]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503564371-26090-17-git-send-email-armbru@redhat.com>
---
 block/parallels.c          | 1 -
 scripts/qapi.py            | 4 +---
 tests/check-qom-proplist.c | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index cce7336cac..2b6c6e5709 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -72,7 +72,6 @@ static QEnumLookup prealloc_mode_lookup =3D {
     .array =3D (const char *const[]) {
         "falloc",
         "truncate",
-        NULL,
     },
     .size =3D PRL_PREALLOC_MODE__MAX
 };
diff --git a/scripts/qapi.py b/scripts/qapi.py
index 39a67270fc..62dc52ed6e 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -1860,14 +1860,12 @@ const QEnumLookup %(c_name)s_lookup =3D {
 ''',
                      index=3Dindex, value=3Dvalue)
=20
-    max_index =3D c_enum_const(name, '_MAX', prefix)
     ret +=3D mcgen('''
-        [%(max_index)s] =3D NULL,
     },
     .size =3D %(max_index)s
 };
 ''',
-                 max_index=3Dmax_index)
+                 max_index=3Dc_enum_const(name, '_MAX', prefix))
     return ret
=20
=20
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 07e351f950..92898e1520 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -51,7 +51,6 @@ const QEnumLookup dummy_animal_map =3D {
         [DUMMY_FROG] =3D "frog",
         [DUMMY_ALLIGATOR] =3D "alligator",
         [DUMMY_PLATYPUS] =3D "platypus",
-        [DUMMY_LAST] =3D NULL,
     },
     .size =3D DUMMY_LAST
 };
--=20
2.13.5

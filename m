Received: from eggs.gnu.org ([2001:4830:134:3::10]:51465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1K-0006cF-UJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1J-0001fn-LH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1J-0001ei-FG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A88E806C1
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:18 +0200
Message-Id: <20170901153758.8628-8-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 07/47] qlit: Change compound literals to
 initializers
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

The QLIT_QFOO() macros expand into compound literals.  Sadly, gcc
doesn't recognizes these as constant expressions (clang does), which
makes the macros useless for initializing objects with static storage
duration.

There is a gcc bug about it:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D71713

Change the macros to expand into initializers.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170825105913.4060-5-marcandre.lureau@redhat.com>
[Commit message improved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index a4ad91321b..f1d6eed317 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -36,13 +36,13 @@ struct QLitDictEntry {
 };
=20
 #define QLIT_QNUM(val) \
-    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
+    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
 #define QLIT_QSTR(val) \
-    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
+    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
 #define QLIT_QDICT(val) \
-    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
+    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
 #define QLIT_QLIST(val) \
-    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
+    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
=20
 int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
=20
--=20
2.13.5

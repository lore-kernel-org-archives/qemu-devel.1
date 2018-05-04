Received: from eggs.gnu.org ([2001:4830:134:3::10]:49610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViK-00058C-D7
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEViC-0001WF-BM
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEViC-0001Ur-1T
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:05:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 249018182D1E
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:04:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A5B83B88
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:04:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  4 May 2018 10:04:45 +0200
Message-Id: <20180504080454.11014-2-armbru@redhat.com>
In-Reply-To: <20180504080454.11014-1-armbru@redhat.com>
References: <20180504080454.11014-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/10] qobject: Use qobject_to() instead of type
 cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The proper way to convert from (abstract) QObject to a (concrete)
subtype is qobject_to().  Look for offenders that type cast instead:

    $ git-grep '(Q[A-Z][a-z]* \*)'
    hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
    include/qapi/qmp/qobject.h:        return (QObject *)obj;
    qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) =3D =
{
    tests/check-qdict.c:    dst =3D (QDict *)qdict_crumple(src, &error_ab=
ort);

The first two cast away const, the third isn't a type cast.  Fix the
fourth.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180426152805.8469-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/check-qdict.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index 2e73c2f86e..08d4303e6a 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -657,7 +657,7 @@ static void qdict_crumple_test_empty(void)
=20
     src =3D qdict_new();
=20
-    dst =3D (QDict *)qdict_crumple(src, &error_abort);
+    dst =3D qobject_to(QDict, qdict_crumple(src, &error_abort));
=20
     g_assert_cmpint(qdict_size(dst), =3D=3D, 0);
=20
--=20
2.13.6

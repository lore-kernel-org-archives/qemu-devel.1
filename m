Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUn-0000JV-Ga
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUi-0007Ko-5Q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUh-0007Jx-Ub
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1EEFC047B95
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:36 +0200
Message-Id: <20170901125611.29295-13-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/47] qlit: Replace open-coded qnum_get_int()
 by call
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

Bonus: rids us of a side effect in an assertion.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170825105913.4060-10-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/qlit.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/qobject/qlit.c b/qobject/qlit.c
index 07ad6b05e8..b1d9146220 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -43,8 +43,6 @@ static void compare_helper(QObject *obj, void *opaque)
=20
 bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
 {
-    int64_t val;
-
     if (!rhs || lhs->type !=3D qobject_type(rhs)) {
         return false;
     }
@@ -53,8 +51,7 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QO=
bject *rhs)
     case QTYPE_QBOOL:
         return lhs->value.qbool =3D=3D qbool_get_bool(qobject_to_qbool(r=
hs));
     case QTYPE_QNUM:
-        g_assert(qnum_get_try_int(qobject_to_qnum(rhs), &val));
-        return lhs->value.qnum =3D=3D val;
+        return lhs->value.qnum =3D=3D  qnum_get_int(qobject_to_qnum(rhs)=
);
     case QTYPE_QSTRING:
         return (strcmp(lhs->value.qstr,
                        qstring_get_str(qobject_to_qstring(rhs))) =3D=3D =
0);
--=20
2.13.5

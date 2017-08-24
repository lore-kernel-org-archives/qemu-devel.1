Received: from eggs.gnu.org ([2001:4830:134:3::10]:58835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpSx-00075W-Ha
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpSw-00046W-BJ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkpSw-00046M-59
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 294DB4ACA5
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 10:34:21 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Aug 2017 12:33:44 +0200
Message-Id: <20170824103350.16400-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170824103350.16400-1-marcandre.lureau@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/14] qlit: add QLIT_QNULL and QLIT_BOOL
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

As they are going to be used in the following patches.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qlit.h | 5 +++++
 qobject/qlit.c          | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index 8882016199..7118fc9e32 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -23,6 +23,7 @@ typedef struct QLitObject QLitObject;
 struct QLitObject {
     int type;
     union {
+        bool qbool;
         int64_t qnum;
         const char *qstr;
         QLitDictEntry *qdict;
@@ -35,6 +36,10 @@ struct QLitDictEntry {
     QLitObject value;
 };
=20
+#define QLIT_QNULL \
+    { .type =3D QTYPE_QNULL }
+#define QLIT_QBOOL(val) \
+    { .type =3D QTYPE_QBOOL, .value.qbool =3D (val) }
 #define QLIT_QNUM(val) \
     { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
 #define QLIT_QSTR(val) \
diff --git a/qobject/qlit.c b/qobject/qlit.c
index ae2787ef35..07ad6b05e8 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -50,6 +50,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QO=
bject *rhs)
     }
=20
     switch (lhs->type) {
+    case QTYPE_QBOOL:
+        return lhs->value.qbool =3D=3D qbool_get_bool(qobject_to_qbool(r=
hs));
     case QTYPE_QNUM:
         g_assert(qnum_get_try_int(qobject_to_qnum(rhs), &val));
         return lhs->value.qnum =3D=3D val;
@@ -81,6 +83,8 @@ bool qlit_equal_qobject(const QLitObject *lhs, const QO=
bject *rhs)
=20
         return helper.result;
     }
+    case QTYPE_QNULL:
+        return true;
     default:
         break;
     }
--=20
2.14.1.146.gd35faa819

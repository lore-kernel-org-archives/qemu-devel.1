Received: from eggs.gnu.org ([2001:4830:134:3::10]:42573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBu-00033K-Pr
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBs-0001KI-SY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55897
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBs-0001Jv-LL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbYG007165
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:32 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm3h0yv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:31 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:31 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:26 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-33-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 32/67] qmp: fix object-add assert() without
 props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since commit ad739706bbadee49, user_creatable_add_type() expects to be
given a qdict. However, if object-add is called without props, you reach
the assert: "qemu/qom/object_interfaces.c:115: user_creatable_add_type:
Assertion `qdict' failed.", because the qdict isn't created in this
case (it's optional).

Furthermore, qmp_input_visitor_new() is not meant to be called without a
dict, and a further commit will assert in this situation.

If none given, create an empty qdict in qmp to avoid the
user_creatable_add_type() assert(qdict).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20160922203927.28241-2-marcandre.lureau@redhat.com>
Tested-by: Xiao Long Jiang <zxiaol@linux.vnet.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/qmp.c b/qmp.c
index b6d531e..c485abe 100644
--- a/qmp.c
+++ b/qmp.c
@@ -654,7 +654,7 @@ void qmp_add_client(const char *protocol, const char =
*fdname,
 void qmp_object_add(const char *type, const char *id,
                     bool has_props, QObject *props, Error **errp)
 {
-    const QDict *pdict =3D NULL;
+    QDict *pdict;
     Visitor *v;
     Object *obj;
=20
@@ -664,14 +664,18 @@ void qmp_object_add(const char *type, const char *i=
d,
             error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict=
");
             return;
         }
+        QINCREF(pdict);
+    } else {
+        pdict =3D qdict_new();
     }
=20
-    v =3D qmp_input_visitor_new(props, true);
+    v =3D qmp_input_visitor_new(QOBJECT(pdict), true);
     obj =3D user_creatable_add_type(type, id, pdict, v, errp);
     visit_free(v);
     if (obj) {
         object_unref(obj);
     }
+    QDECREF(pdict);
 }
=20
 void qmp_object_del(const char *id, Error **errp)
--=20
1.9.1

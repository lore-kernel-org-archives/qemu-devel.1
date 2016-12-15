Received: from eggs.gnu.org ([2001:4830:134:3::10]:42602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBv-00036c-IK
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBu-0001LP-O2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBu-0001Ky-F0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jtZZ060451
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:33 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm90w8y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:33 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:32 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:27 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-34-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 33/67] qapi: Fix crash when 'any' or 'null'
 parameter is missing
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

Unlike the other visit methods, visit_type_any() and visit_type_null()
neglect to check whether qmp_input_get_object() succeeded.  They crash
when it fails.  Reproducer:

{ "execute": "qom-set",
  "arguments": { "path": "/machine", "property": "rtc-time" } }

Will crash with:

qapi/qapi-visit-core.c:277: visit_type_any: Assertion `!err !=3D !*obj'
failed

Broken in commit 5c678ee.  Fix by adding the missing error checks.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20160922203927.28241-3-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message rephrased]
Signed-off-by: Markus Armbruster <armbru@redhat.com>

(cherry picked from commit c489780203f9b22aca5539ec7589b7140bdc951f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qapi/qmp-input-visitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qapi/qmp-input-visitor.c b/qapi/qmp-input-visitor.c
index 64dd392..fc91e74 100644
--- a/qapi/qmp-input-visitor.c
+++ b/qapi/qmp-input-visitor.c
@@ -338,6 +338,12 @@ static void qmp_input_type_any(Visitor *v, const cha=
r *name, QObject **obj,
     QmpInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qmp_input_get_object(qiv, name, true);
=20
+    if (!qobj) {
+        error_setg(errp, QERR_MISSING_PARAMETER, name ? name : "null");
+        *obj =3D NULL;
+        return;
+    }
+
     qobject_incref(qobj);
     *obj =3D qobj;
 }
@@ -347,6 +353,11 @@ static void qmp_input_type_null(Visitor *v, const ch=
ar *name, Error **errp)
     QmpInputVisitor *qiv =3D to_qiv(v);
     QObject *qobj =3D qmp_input_get_object(qiv, name, true);
=20
+    if (!qobj) {
+        error_setg(errp, QERR_MISSING_PARAMETER, name ? name : "null");
+        return;
+    }
+
     if (qobject_type(qobj) !=3D QTYPE_QNULL) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "nul=
l",
                    "null");
--=20
1.9.1

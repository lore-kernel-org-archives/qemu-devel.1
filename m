Received: from eggs.gnu.org ([2001:4830:134:3::10]:44912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT6-0004DC-Ly
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dNIT5-00029Z-LF
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dNIT5-000296-F0
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CA2561D3B
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 12:41:14 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 20 Jun 2017 14:40:32 +0200
Message-Id: <1497962468-22936-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1497962468-22936-1-git-send-email-armbru@redhat.com>
References: <1497962468-22936-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 05/41] qapi: Clean up
 qobject_input_type_number() control flow
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

Use the more common pattern to error out.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170607163635.17635-6-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qobject-input-visitor.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index eac40f6..26ef49a 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -547,13 +547,13 @@ static void qobject_input_type_number(Visitor *v, c=
onst char *name, double *obj,
     }
=20
     qfloat =3D qobject_to_qfloat(qobj);
-    if (qfloat) {
-        *obj =3D qfloat_get_double(qobject_to_qfloat(qobj));
+    if (!qfloat) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
+                   full_name(qiv, name), "number");
         return;
     }
=20
-    error_setg(errp, QERR_INVALID_PARAMETER_TYPE,
-               full_name(qiv, name), "number");
+    *obj =3D qfloat_get_double(qobject_to_qfloat(qobj));
 }
=20
 static void qobject_input_type_number_keyval(Visitor *v, const char *nam=
e,
--=20
2.7.5

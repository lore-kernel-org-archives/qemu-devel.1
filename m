Received: from eggs.gnu.org ([2001:4830:134:3::10]:37818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsib-00033W-Fm
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsia-0007cf-Lk
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsia-0007cT-Fy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:12 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3BB6274875
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:15 +0400
Message-Id: <20170118160332.13390-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/25] qapi: ignore top-level 'id' field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

'id' is documented as part of qmp-spec, it is valid at top-level entry.

The following patch copies the 'id' to the reply, without touching the
original request (which should eventually be const later) so it must
pass the check function without error.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 26f0a674ae..d5c8670a4f 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -48,6 +48,8 @@ static QDict *qmp_dispatch_check_obj(const QObject *req=
uest, Error **errp)
                 return NULL;
             }
             has_exec_key =3D true;
+        } else if (!strcmp(arg_name, "id")) {
+            /* top-level 'id' is accepted */
         } else if (strcmp(arg_name, "arguments")) {
             error_setg(errp, QERR_QMP_EXTRA_MEMBER, arg_name);
             return NULL;
--=20
2.11.0.295.gd7dffce1c

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsii-00038C-W0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsif-0007es-2O
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsie-0007eV-TL
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:17 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C3997AE72
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:16 +0400
Message-Id: <20170118160332.13390-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/25] qmp: take 'id' from request
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

Copy 'id' from request to reply dict. This can be done earlier, such as
done currently by the monitor (because the qemu monitor.c may reply
directly without qmp_dispatch), but is now done as well in
qmp_dispatch() as convenience for other users such as QGA and
tests. Later patches will remove "id" manipulation from monitor.c.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index d5c8670a4f..b6b0aed1b8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -202,7 +202,8 @@ void qmp_dispatch(QmpClient *client, QObject *request=
, QDict *rsp)
 {
     Error *err =3D NULL;
     QmpReturn *qret =3D g_new0(QmpReturn, 1);
-    QObject *ret;
+    QObject *ret, *id;
+    QDict *req;
=20
     assert(client);
=20
@@ -210,6 +211,13 @@ void qmp_dispatch(QmpClient *client, QObject *reques=
t, QDict *rsp)
     qret->client =3D client;
     QLIST_INSERT_HEAD(&client->pending, qret, link);
=20
+    req =3D qobject_to_qdict(request);
+    id =3D qdict_get(req, "id");
+    if (id) {
+        qobject_incref(id);
+        qdict_put_obj(qret->rsp, "id", id);
+    }
+
     ret =3D do_qmp_dispatch(request, qret, &err);
=20
     if (err) {
--=20
2.11.0.295.gd7dffce1c

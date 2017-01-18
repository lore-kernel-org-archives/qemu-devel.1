Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiX-0002zT-Dn
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiT-0007ZX-Gf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiT-0007ZI-BO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:05 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8198B3D968
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:13 +0400
Message-Id: <20170118160332.13390-7-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/25] qmp: add qmp_return_is_cancelled()
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

If the client is gone, no need to return. The async handler can use this
information to avoid unnecessary work and exit earlier.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  8 ++++++++
 qapi/qmp-dispatch.c         | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 32876764f3..bc64d4ed15 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -78,4 +78,12 @@ void qmp_for_each_command(qmp_cmd_callback_fn fn, void=
 *opaque);
 void qmp_return(QmpReturn *qret, QObject *cmd_rsp);
 void qmp_return_error(QmpReturn *qret, Error *err);
=20
+/*
+ * qmp_return_is_cancelled:
+ *
+ * Return true if the QmpReturn is cancelled, and free the QmpReturn
+ * in this case.
+ */
+bool qmp_return_is_cancelled(QmpReturn *qret);
+
 #endif
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 31227ce6e9..6ceece5ef0 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -155,6 +155,16 @@ void qmp_return_error(QmpReturn *qret, Error *err)
     do_qmp_return(qret);
 }
=20
+bool qmp_return_is_cancelled(QmpReturn *qret)
+{
+    if (!qret->client) {
+        qmp_return_free(qret);
+        return true;
+    }
+
+    return false;
+}
+
 void qmp_client_init(QmpClient *client, QmpDispatchReturn *return_cb)
 {
     assert(!client->return_cb);
--=20
2.11.0.295.gd7dffce1c

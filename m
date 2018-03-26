Received: from eggs.gnu.org ([2001:4830:134:3::10]:55344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tln-0006Ky-5I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlm-0003Q1-1S
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tll-0003Po-Sz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:45 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:09 +0200
Message-Id: <20180326150916.9602-32-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 31/38] qmp: add qmp_return_is_cancelled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

If the client is gone, and the session finished, no need to
return. The async handler can use this information to avoid
unnecessary work and exit earlier.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  8 ++++++++
 qapi/qmp-dispatch.c         | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index e426317346..6ee82371a2 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -91,6 +91,14 @@ void qmp_return_free(QmpReturn *qret);
 void qmp_return(QmpReturn *qret, QObject *rsp);
 void qmp_return_error(QmpReturn *qret, Error *err);
=20
+/*
+ * @qmp_return_is_cancelled:
+ *
+ * Return true if the QmpReturn is cancelled, and free the QmpReturn
+ * in this case.
+ */
+bool qmp_return_is_cancelled(QmpReturn *qret);
+
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options)=
;
 void qmp_register_async_command(QmpCommandList *cmds, const char *name,
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index f7d9931734..99f5128170 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -63,6 +63,16 @@ void qmp_return_free(QmpReturn *qret)
     }
 }
=20
+bool qmp_return_is_cancelled(QmpReturn *qret)
+{
+    if (!qret->session) {
+        qmp_return_free(qret);
+        return true;
+    }
+
+    return false;
+}
+
 static void qmp_return_orderly(QmpReturn *qret)
 {
     QmpSession *session =3D qret->session;
--=20
2.17.0.rc1.1.g4c4f2b46a3

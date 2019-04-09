Received: from eggs.gnu.org ([209.51.188.92]:55781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLf-0003Gm-UT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLe-00058l-Kr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLe-00057d-9G
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:09:59 +0200
Message-Id: <20190409161009.6322-11-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 10/20] QmpSession: keep a queue of pending
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following commit will introduce asynchronous commands. Let's keep
the session aware of the pending commands, so we can do interesting
things like order the replies, or cancel pending operations when the
client is gone.

The queue needs a lock, since QmpReturn may be called from any thread.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  4 ++++
 qapi/qmp-dispatch.c         | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 6c0d21968e..7c9de9780d 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -16,6 +16,7 @@
=20
 #include "qemu/queue.h"
 #include "qapi/qmp/json-parser.h"
+#include "qemu/thread.h"
=20
 typedef struct QmpReturn QmpReturn;
=20
@@ -47,11 +48,14 @@ struct QmpSession {
     const QmpCommandList *cmds;
     JSONMessageParser parser;
     QmpDispatchReturn *return_cb;
+    QemuMutex pending_lock;
+    QTAILQ_HEAD(, QmpReturn) pending;
 };
=20
 struct QmpReturn {
     QmpSession *session;
     QDict *rsp;
+    QTAILQ_ENTRY(QmpReturn) entry;
 };
=20
 /**
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 5f75dc27bd..4699a6715b 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -32,11 +32,24 @@ QmpReturn *qmp_return_new(QmpSession *session, const =
QObject *request)
         qdict_put_obj(qret->rsp, "id", id);
     }
=20
+    qemu_mutex_lock(&session->pending_lock);
+    QTAILQ_INSERT_TAIL(&session->pending, qret, entry);
+    qemu_mutex_unlock(&session->pending_lock);
+
     return qret;
 }
=20
 void qmp_return_free(QmpReturn *qret)
 {
+    QmpSession *session =3D qret->session;
+
+    if (session) {
+        qemu_mutex_lock(&session->pending_lock);
+    }
+    QTAILQ_REMOVE(&session->pending, qret, entry);
+    if (session) {
+        qemu_mutex_unlock(&session->pending_lock);
+    }
     qobject_unref(qret->rsp);
     g_free(qret);
 }
@@ -44,7 +57,9 @@ void qmp_return_free(QmpReturn *qret)
 void qmp_return(QmpReturn *qret, QObject *rsp)
 {
     qdict_put_obj(qret->rsp, "return", rsp ?: QOBJECT(qdict_new()));
-    qret->session->return_cb(qret->session, qret->rsp);
+    if (qret->session) {
+        qret->session->return_cb(qret->session, qret->rsp);
+    }
     qmp_return_free(qret);
 }
=20
@@ -55,7 +70,9 @@ void qmp_return_error(QmpReturn *qret, Error *err)
     qdict_put_str(qdict, "desc", error_get_pretty(err));
     qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
-    qret->session->return_cb(qret->session, qret->rsp);
+    if (qret->session) {
+        qret->session->return_cb(qret->session, qret->rsp);
+    }
     qmp_return_free(qret);
 }
=20
@@ -219,17 +236,28 @@ void qmp_session_init(QmpSession *session,
                              session, NULL);
     session->cmds =3D cmds;
     session->return_cb =3D return_cb;
+    qemu_mutex_init(&session->pending_lock);
+    QTAILQ_INIT(&session->pending);
 }
=20
 void qmp_session_destroy(QmpSession *session)
 {
+    QmpReturn *ret, *next;
+
     if (!session->return_cb) {
         return;
     }
=20
+    qemu_mutex_lock(&session->pending_lock);
+    QTAILQ_FOREACH_SAFE(ret, &session->pending, entry, next) {
+        ret->session =3D NULL;
+        QTAILQ_REMOVE(&session->pending, ret, entry);
+    }
+    qemu_mutex_unlock(&session->pending_lock);
     session->cmds =3D NULL;
     session->return_cb =3D NULL;
     json_message_parser_destroy(&session->parser);
+    qemu_mutex_destroy(&session->pending_lock);
 }
=20
 void qmp_dispatch(QmpSession *session, QObject *request, bool allow_oob)
--=20
2.21.0.196.g041f5ea1cf

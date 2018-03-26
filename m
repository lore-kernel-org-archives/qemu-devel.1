Received: from eggs.gnu.org ([2001:4830:134:3::10]:55244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlc-00068Z-Ps
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tla-0003Hm-98
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0TlZ-0003HU-W1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:05 +0200
Message-Id: <20180326150916.9602-28-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 27/38] QmpSession: keep a queue of pending
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following commit will introduce asynchronous commands. Let's keep
the client aware of the pending commands, so we can do interesting
things like order the replies, or cancel pending operations when the
client is gone.

The queue needs a lock, since QmpSession may be used from multiple
threads.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  4 ++++
 qapi/qmp-dispatch.c         | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index c5ac3bd41e..94a272a5fb 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -15,6 +15,7 @@
 #define QAPI_QMP_DISPATCH_H
=20
 #include "qemu/queue.h"
+#include "qemu/thread.h"
 #include "qapi/qmp/json-streamer.h"
=20
 typedef struct QmpReturn QmpReturn;
@@ -48,11 +49,14 @@ struct QmpSession {
     QmpDispatch *dispatch_cb;
     QmpDispatchReturn *return_cb;
     QmpCommandList *cmds;
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
 /*
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 4a73cf88b3..2c162642cb 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -31,11 +31,24 @@ QmpReturn *qmp_return_new(QmpSession *session, const =
QDict *req)
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
     QDECREF(qret->rsp);
     g_free(qret);
 }
@@ -43,7 +56,9 @@ void qmp_return_free(QmpReturn *qret)
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
@@ -220,16 +237,27 @@ void qmp_session_init(QmpSession *session,
     session->cmds =3D cmds;
     session->dispatch_cb =3D dispatch_cb;
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
     session->dispatch_cb =3D NULL;
     session->return_cb =3D NULL;
     json_message_parser_destroy(&session->parser);
+    qemu_mutex_destroy(&session->pending_lock);
 }
--=20
2.17.0.rc1.1.g4c4f2b46a3

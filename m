Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tld-00069Y-R3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tlc-0003JC-Dk
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tlc-0003IV-2T
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:06 +0200
Message-Id: <20180326150916.9602-29-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 28/38] QmpSession: return orderly
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

QEMU will gain support for asynchronous commands, and may thus finish
commands in various order. However, the clients expect replies in
order. Let's enforce ordering of replies in QmpReturn: starting from
the older command, process each pending QmpReturn, and return until
reaching one that is unfinished.

Or if the command is OOB, it should return immediately.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  1 +
 qapi/qmp-dispatch.c         | 59 ++++++++++++++++++++++++++++++-------
 tests/test-qmp-cmds.c       | 36 ++++++++++++++++++++++
 3 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 94a272a5fb..f6db06c164 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -56,6 +56,7 @@ struct QmpSession {
 struct QmpReturn {
     QmpSession *session;
     QDict *rsp;
+    bool oob;
     QTAILQ_ENTRY(QmpReturn) entry;
 };
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 2c162642cb..aa8b71a2c0 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -24,6 +24,7 @@ QmpReturn *qmp_return_new(QmpSession *session, const QD=
ict *req)
     QmpReturn *qret =3D g_new0(QmpReturn, 1);
     QObject *id =3D req ? qdict_get(req, "id") : NULL;
=20
+    qret->oob =3D req ? qmp_is_oob(req) : false;
     qret->session =3D session;
     qret->rsp =3D qdict_new();
     if (id) {
@@ -38,6 +39,15 @@ QmpReturn *qmp_return_new(QmpSession *session, const Q=
Dict *req)
     return qret;
 }
=20
+static void qmp_return_free_with_lock(QmpReturn *qret)
+{
+    if (qret->session) {
+        QTAILQ_REMOVE(&qret->session->pending, qret, entry);
+    }
+    QDECREF(qret->rsp);
+    g_free(qret);
+}
+
 void qmp_return_free(QmpReturn *qret)
 {
     QmpSession *session =3D qret->session;
@@ -45,21 +55,51 @@ void qmp_return_free(QmpReturn *qret)
     if (session) {
         qemu_mutex_lock(&session->pending_lock);
     }
-    QTAILQ_REMOVE(&session->pending, qret, entry);
+
+    qmp_return_free_with_lock(qret);
+
     if (session) {
         qemu_mutex_unlock(&session->pending_lock);
     }
-    QDECREF(qret->rsp);
-    g_free(qret);
+}
+
+static void qmp_return_orderly(QmpReturn *qret)
+{
+    QmpSession *session =3D qret->session;
+    QmpReturn *ret, *next;
+
+    if (!session) {
+        /* the client was destroyed before return, discard */
+        qmp_return_free(qret);
+        return;
+    }
+    if (qret->oob) {
+        session->return_cb(session, qret->rsp);
+        qmp_return_free(qret);
+        return;
+    }
+
+    /* mark as finished */
+    qret->session =3D NULL;
+
+    qemu_mutex_lock(&session->pending_lock);
+    /* process the list of pending and return until reaching an unfinshe=
d */
+    QTAILQ_FOREACH_SAFE(ret, &session->pending, entry, next) {
+        if (ret->session) {
+            goto end;
+        }
+        session->return_cb(session, ret->rsp);
+        ret->session =3D session;
+        qmp_return_free_with_lock(ret);
+    }
+end:
+    qemu_mutex_unlock(&session->pending_lock);
 }
=20
 void qmp_return(QmpReturn *qret, QObject *rsp)
 {
     qdict_put_obj(qret->rsp, "return", rsp ?: QOBJECT(qdict_new()));
-    if (qret->session) {
-        qret->session->return_cb(qret->session, qret->rsp);
-    }
-    qmp_return_free(qret);
+    qmp_return_orderly(qret);
 }
=20
 void qmp_return_error(QmpReturn *qret, Error *err)
@@ -70,10 +110,7 @@ void qmp_return_error(QmpReturn *qret, Error *err)
     qdict_put_str(qdict, "desc", error_get_pretty(err));
     qdict_put_obj(qret->rsp, "error", QOBJECT(qdict));
     error_free(err);
-    if (qret->session) {
-        qret->session->return_cb(qret->session, qret->rsp);
-    }
-    qmp_return_free(qret);
+    qmp_return_orderly(qret);
 }
=20
 QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 5246650f71..eeaac03d50 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -309,6 +309,41 @@ static void test_dispatch_cmd_id(void)
     qmp_session_destroy(&session);
 }
=20
+typedef struct QmpReturnOrderly {
+    QmpSession session;
+    int returns;
+} QmpReturnOrderly;
+
+static void dispatch_return_orderly(QmpSession *session, QDict *resp)
+{
+    QmpReturnOrderly *o =3D container_of(session, QmpReturnOrderly, sess=
ion);
+
+    o->returns++;
+}
+
+static void test_qmp_return_orderly(void)
+{
+    QDict *dict =3D qdict_new();
+    QDict *ctrl =3D qdict_new();
+    QmpReturnOrderly o =3D { 0, };
+    QmpReturn *r1, *r2, *r3;
+
+    qmp_session_init(&o.session, &qmp_commands,
+                     qmp_dispatch, dispatch_return_orderly);
+    r1 =3D qmp_return_new(&o.session, NULL);
+    qdict_put_bool(ctrl, "run-oob", true);
+    qdict_put_obj(dict, "control", QOBJECT(ctrl));
+    r2 =3D qmp_return_new(&o.session, dict);
+    r3 =3D qmp_return_new(&o.session, NULL);
+    qmp_return(r3, NULL);
+    g_assert_cmpint(o.returns, =3D=3D, 0);
+    qmp_return(r2, NULL);
+    g_assert_cmpint(o.returns, =3D=3D, 1);
+    qmp_return(r1, NULL);
+    g_assert_cmpint(o.returns, =3D=3D, 3);
+    qmp_session_destroy(&o.session);
+    QDECREF(dict);
+}
=20
 int main(int argc, char **argv)
 {
@@ -322,6 +357,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd_id", test_dispatch_cmd_id);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
+    g_test_add_func("/qmp/return_orderly", test_qmp_return_orderly);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
--=20
2.17.0.rc1.1.g4c4f2b46a3

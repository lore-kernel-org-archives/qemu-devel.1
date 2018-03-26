Received: from eggs.gnu.org ([2001:4830:134:3::10]:55022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0TlB-0005dX-5d
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tl7-0002xr-UB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tl7-0002xe-Og
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:05 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:54 +0200
Message-Id: <20180326150916.9602-17-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 16/38] qmp: move 'id' copy to qmp_dispatch()
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

This is convenient for other QMP users such as QGA and tests and
simplifies a bit the qemu monitor code, and avoids modifying the
request.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c             | 23 ++++++-----------------
 qapi/qmp-dispatch.c   |  5 +++++
 tests/test-qmp-cmds.c | 17 +++++++++++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/monitor.c b/monitor.c
index 471c57e88c..ddcc3a5748 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3899,16 +3899,9 @@ static int monitor_can_read(void *opaque)
     return !atomic_mb_read(&mon->suspend_cnt);
 }
=20
-/* take the ownership of rsp & id */
-static void monitor_qmp_respond(Monitor *mon, QDict *rsp, QObject *id)
+/* take the ownership of rsp */
+static void monitor_qmp_respond(Monitor *mon, QDict *rsp)
 {
-    if (!rsp) {
-        return;
-    }
-
-    if (id) {
-        qdict_put_obj(rsp, "id", id);
-    }
     if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
         QDict *qdict =3D qdict_get_qdict(rsp, "error");
         if (qdict
@@ -3941,11 +3934,9 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
eq_obj)
 {
     Monitor *mon, *old_mon;
     QDict *req, *rsp =3D NULL;
-    QObject *id;
=20
     req =3D req_obj->req;
     mon =3D req_obj->mon;
-    id =3D req_obj->id;
=20
     g_free(req_obj);
=20
@@ -3963,7 +3954,9 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     cur_mon =3D old_mon;
=20
     /* Respond if necessary */
-    monitor_qmp_respond(mon, rsp, id);
+    if (rsp) {
+        monitor_qmp_respond(mon, rsp);
+    }
=20
=20
     QDECREF(req);
@@ -4060,9 +4053,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         goto err;
     }
=20
-    qobject_incref(id);
-    qdict_del(qdict, "id");
-
     req_obj =3D g_new0(QMPRequest, 1);
     req_obj->mon =3D mon;
     req_obj->id =3D id;
@@ -4094,7 +4084,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
             qapi_event_send_command_dropped(id,
                                             COMMAND_DROP_REASON_QUEUE_FU=
LL,
                                             &error_abort);
-            qobject_decref(id);
             qobject_decref(req);
             g_free(req_obj);
             return;
@@ -4117,7 +4106,7 @@ err:
     qdict =3D qdict_new();
     qdict_put_obj(qdict, "error", qmp_build_error_object(err));
     error_free(err);
-    monitor_qmp_respond(mon, qdict, id);
+    monitor_qmp_respond(mon, qdict);
     qobject_decref(req);
 }
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 66596b66a0..4be0648809 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -151,10 +151,15 @@ QDict *qmp_dispatch(QmpCommandList *cmds, QDict *re=
q)
     Error *err =3D NULL;
     QObject *ret;
     QDict *rsp;
+    QObject *id =3D qdict_get(req, "id");
=20
     ret =3D do_qmp_dispatch(cmds, req, &err);
=20
     rsp =3D qdict_new();
+    if (id) {
+        qobject_incref(id);
+        qdict_put_obj(rsp, "id", id);
+    }
     if (err) {
         qdict_put_obj(rsp, "error", qmp_build_error_object(err));
         error_free(err);
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 52e2738a93..58d948b01f 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -277,6 +277,22 @@ static void test_dealloc_partial(void)
     qapi_free_UserDefTwo(ud2);
 }
=20
+static void test_dispatch_cmd_id(void)
+{
+    QDict *resp, *req =3D qdict_new();
+
+    qdict_put_str(req, "execute", "user_def_cmd");
+    qdict_put_str(req, "id", "ID42");
+
+    resp =3D qmp_dispatch(&qmp_commands, req);
+    assert(resp !=3D NULL);
+    assert(!qdict_haskey(resp, "error"));
+    assert(!strcmp(qdict_get_str(resp, "id"), "ID42"));
+
+    QDECREF(resp);
+    QDECREF(req);
+}
+
=20
 int main(int argc, char **argv)
 {
@@ -287,6 +303,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dispatch_cmd_success_response",
                     test_dispatch_cmd_success_response);
+    g_test_add_func("/qmp/dispatch_cmd_id", test_dispatch_cmd_id);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3

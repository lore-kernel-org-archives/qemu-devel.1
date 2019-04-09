Received: from eggs.gnu.org ([209.51.188.92]:55734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLb-0003CM-5w
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLZ-00054R-Nd
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLZ-000541-CS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:10:03 +0200
Message-Id: <20190409161009.6322-15-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 14/20] qmp: add qmp_return_is_cancelled()
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

If the client is gone, and the session finished, no need to
return. The async handler can use this information to avoid
unnecessary work and exit earlier.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/dispatch.h |  8 ++++++++
 qapi/qmp-dispatch.c         | 10 ++++++++++
 tests/test-qmp-cmds.c       | 39 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 6aef0abc70..6673902e95 100644
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
index 1f493af67a..8653c17901 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -64,6 +64,16 @@ void qmp_return_free(QmpReturn *qret)
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
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 58cd09ab08..97958a9d78 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -36,17 +36,29 @@ void qmp_cmd_success_response(Error **errp)
 {
 }
=20
+static GMainLoop *loop;
+
 static gboolean cmd_async_idle(gpointer user_data)
 {
     QmpReturn *qret =3D user_data;
=20
-    qmp_cmd_async_return(qret, g_new0(Empty2, 1));
+    if (!qret->session) {
+        g_assert(qmp_return_is_cancelled(qret));
+        g_main_loop_quit(loop);
+        g_main_loop_unref(loop);
+        loop =3D NULL;
+    } else {
+        qmp_cmd_async_return(qret, g_new0(Empty2, 1));
+    }
=20
     return G_SOURCE_REMOVE;
 }
=20
 void qmp_cmd_async(const char *filename, QmpReturn *qret)
 {
+    if (g_str_equal(filename, "cancel")) {
+        qmp_session_destroy(qret->session);
+    }
     g_idle_add(cmd_async_idle, qret);
 }
=20
@@ -419,6 +431,30 @@ static void test_qmp_return_async(void)
     qobject_unref(req);
 }
=20
+static void test_qmp_return_async_cancel(void)
+{
+    QmpReturnAsync a =3D { 0, };
+    QDict *args =3D qdict_new();
+    QDict *req =3D qdict_new();
+
+    a.loop =3D g_main_loop_new(NULL, TRUE);
+    qmp_session_init(&a.session, &qmp_commands,
+                     NULL, dispatch_return_async);
+
+    qdict_put_str(args, "filename", "cancel");
+    qdict_put_str(req, "execute", "cmd-async");
+    qdict_put(req, "arguments", args);
+    qmp_dispatch(&a.session, QOBJECT(req), false);
+    g_assert(a.loop);
+
+    loop =3D a.loop;
+    g_main_loop_run(loop);
+    g_assert(!loop);
+
+    qmp_session_destroy(&a.session);
+    qobject_unref(req);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -433,6 +469,7 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
     g_test_add_func("/qmp/return_orderly", test_qmp_return_orderly);
     g_test_add_func("/qmp/return_async", test_qmp_return_async);
+    g_test_add_func("/qmp/return_async_cancel", test_qmp_return_async_ca=
ncel);
=20
     test_qmp_init_marshal(&qmp_commands);
     g_test_run();
--=20
2.21.0.196.g041f5ea1cf

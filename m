Received: from eggs.gnu.org ([2001:4830:134:3::10]:37929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsit-0003HX-0B
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiq-0007kr-Su
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsiq-0007kZ-LT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:28 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8E6EC04F468
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:19 +0400
Message-Id: <20170118160332.13390-13-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/25] tests: add dispatch async tests
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

Add a few tests to check:
- async dispatch
- async command without "id" failure
- destroying the client with pending requests

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-qmp-commands.c               | 132 ++++++++++++++++++++++++++=
++++++
 tests/qapi-schema/qapi-schema-test.json |   6 ++
 tests/qapi-schema/qapi-schema-test.out  |   6 ++
 3 files changed, 144 insertions(+)

diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index a3c7c590d1..4613a9a4c8 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -85,6 +85,36 @@ __org_qemu_x_Union1 *qmp___org_qemu_x_command(__org_qe=
mu_x_EnumList *a,
     return ret;
 }
=20
+static GMainLoop *loop;
+
+typedef struct AsyncRet {
+    QmpReturn *qret;
+    UserDefB *ret;
+} AsyncRet;
+
+static gboolean qmp_user_async_idle(gpointer data)
+{
+    struct AsyncRet *async =3D (struct AsyncRet *)data;
+
+    qmp_user_async_return(async->qret, async->ret);
+    g_free(async);
+
+    g_main_loop_quit(loop);
+
+    return FALSE;
+}
+
+void qmp_user_async(int64_t a, bool has_b, int64_t b, QmpReturn *qret)
+{
+    AsyncRet *async =3D g_new0(AsyncRet, 1);
+
+    async->ret =3D g_new0(UserDefB, 1);
+    async->ret->intb =3D a + (has_b ? b : 0);
+    async->qret =3D qret;
+
+    g_idle_add(qmp_user_async_idle, async);
+}
+
 static void dispatch_cmd_return(QmpClient *client, QObject *resp)
 {
     assert(resp !=3D NULL);
@@ -142,14 +172,19 @@ static void test_dispatch_cmd_failure(void)
 }
=20
 static QObject *dispatch_ret;
+static char *ret_id;
=20
 static void qmp_dispatch_return(QmpClient *client, QObject *resp_obj)
 {
     QDict *resp =3D qobject_to_qdict(resp_obj);
+
     assert(resp && !qdict_haskey(resp, "error"));
     dispatch_ret =3D qdict_get(resp, "return");
     assert(dispatch_ret);
     qobject_incref(dispatch_ret);
+
+    g_free(ret_id);
+    ret_id =3D g_strdup(qdict_get_try_str(resp, "id"));
 }
=20
 static QObject *test_qmp_dispatch(QDict *req)
@@ -216,6 +251,97 @@ static void test_dispatch_cmd_io(void)
     QDECREF(req);
 }
=20
+static void test_dispatch_cmd_async(void)
+{
+    QmpClient client =3D { .has_async =3D true };
+    QDict *dret, *req =3D qdict_new();
+    QDict *args =3D qdict_new();
+
+    loop =3D g_main_loop_new(NULL, FALSE);
+    qmp_client_init(&client, qmp_dispatch_return);
+
+    qdict_put(args, "a", qint_from_int(99));
+    qdict_put(req, "arguments", args);
+    qdict_put(req, "id", qstring_from_str("foo99"));
+    qdict_put(req, "execute", qstring_from_str("user-async"));
+
+    qmp_dispatch(&client, QOBJECT(req), NULL);
+    assert(!dispatch_ret);
+
+    g_main_loop_run(loop);
+    g_main_loop_unref(loop);
+
+    g_assert_cmpstr(ret_id, =3D=3D, "foo99");
+    dret =3D qobject_to_qdict(dispatch_ret);
+    assert(qdict_get_int(dret, "intb") =3D=3D 99);
+    QDECREF(dret);
+    dispatch_ret =3D NULL;
+
+    qmp_client_destroy(&client);
+    QDECREF(req);
+}
+
+static void test_dispatch_cmd_async_no_id(void)
+{
+    QmpClient client =3D { .has_async =3D true };
+    QDict *req =3D qdict_new();
+    QDict *args =3D qdict_new();
+
+    qmp_client_init(&client, dispatch_cmd_error_return);
+
+    qdict_put(args, "a", qint_from_int(99));
+    qdict_put(req, "arguments", args);
+    qdict_put(req, "execute", qstring_from_str("user-async"));
+
+    qmp_dispatch(&client, QOBJECT(req), NULL);
+
+    assert(!dispatch_ret);
+    assert(QLIST_EMPTY(&client.pending));
+
+    qmp_client_destroy(&client);
+    QDECREF(req);
+}
+
+static void test_destroy_pending_async(void)
+{
+    QmpClient client =3D { .has_async =3D true };
+    QDict *req =3D qdict_new();
+    QDict *args =3D qdict_new();
+    QmpReturn *r;
+    int npending =3D 0;
+
+    loop =3D g_main_loop_new(NULL, FALSE);
+    qmp_client_init(&client, qmp_dispatch_return);
+
+    qdict_put(args, "a", qint_from_int(99));
+    qdict_put(req, "arguments", args);
+    qdict_put(req, "id", qstring_from_str("foo99"));
+    qdict_put(req, "execute", qstring_from_str("user-async"));
+
+    qmp_dispatch(&client, QOBJECT(req), NULL);
+    qmp_dispatch(&client, QOBJECT(req), NULL);
+    assert(!dispatch_ret);
+    QDECREF(req);
+
+    npending =3D 0;
+    QLIST_FOREACH(r, &client.pending, link) {
+        npending++;
+    }
+
+    g_assert_cmpint(npending, =3D=3D, 2);
+
+    /* destroy with pending async */
+    qmp_client_destroy(&client);
+
+    while (g_main_context_pending(NULL)) {
+        g_main_loop_run(loop);
+        /* no return since the client is gone */
+        assert(!dispatch_ret);
+    }
+
+    g_main_loop_unref(loop);
+}
+
 /* test generated dealloc functions for generated types */
 static void test_dealloc_types(void)
 {
@@ -287,11 +413,17 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
     g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failu=
re);
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
+    g_test_add_func("/qmp/dispatch_cmd_async", test_dispatch_cmd_async);
+    g_test_add_func("/qmp/dispatch_cmd_async_no_id",
+                    test_dispatch_cmd_async_no_id);
+    g_test_add_func("/qmp/destroy_pending_async", test_destroy_pending_a=
sync);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
     module_call_init(MODULE_INIT_QAPI);
     g_test_run();
=20
+    g_free(ret_id);
+
     return 0;
 }
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index f4d8cc4230..6fe35bae77 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -292,6 +292,12 @@
 { 'command': 'boxed-union', 'data': 'UserDefNativeListUnion', 'boxed': t=
rue }
=20
 ##
+# @user-async:
+##
+{ 'command': 'user-async', 'data': { 'a': 'int', '*b': 'int' },
+  'returns': 'UserDefB', 'async': true  }
+
+##
 # @UserDefOptions:
 #
 # For testing integer range flattening in opts-visitor. The following sc=
hema
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index bc8d496ff4..5b97906aae 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -219,11 +219,16 @@ object q_obj_uint64List-wrapper
     member data: uint64List optional=3DFalse
 object q_obj_uint8List-wrapper
     member data: uint8List optional=3DFalse
+object q_obj_user-async-arg
+    member a: int optional=3DFalse
+    member b: int optional=3DTrue
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=3DFalse
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=3DFalse
     member ud1b: UserDefOne optional=3DTrue
+command user-async q_obj_user-async-arg -> UserDefB
+   gen=3DTrue success_response=3DTrue boxed=3DFalse async=3DTrue
 command user_def_cmd None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse
 command user_def_cmd0 Empty2 -> Empty2
@@ -337,6 +342,7 @@ returns something
 doc symbol=3Dguest-sync expr=3D('command', 'guest-sync')
 doc symbol=3Dboxed-struct expr=3D('command', 'boxed-struct')
 doc symbol=3Dboxed-union expr=3D('command', 'boxed-union')
+doc symbol=3Duser-async expr=3D('command', 'user-async')
 doc symbol=3DUserDefOptions expr=3D('struct', 'UserDefOptions')
     body=3D
 For testing integer range flattening in opts-visitor. The following sche=
ma
--=20
2.11.0.295.gd7dffce1c

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tl2-0005VK-Pr
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkw-0002sV-JD
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkw-0002sH-Dg
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:54 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:50 +0200
Message-Id: <20180326150916.9602-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/38] tests: add a qmp success-response test
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

Verify the usage of this schema feature and the API behaviour.  This
should be the only case where qmp_dispatch() returns NULL without
error.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-qmp-cmds.c                   | 17 +++++++++++++++++
 tests/qapi-schema/qapi-schema-test.json |  2 ++
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index b49e9dd029..02cbaf41a2 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -16,6 +16,10 @@ void qmp_user_def_cmd(Error **errp)
 {
 }
=20
+void qmp_cmd_success_response(Error **errp)
+{
+}
+
 Empty2 *qmp_user_def_cmd0(Error **errp)
 {
     return g_new0(Empty2, 1);
@@ -137,6 +141,17 @@ static void test_dispatch_cmd_failure(void)
     QDECREF(req);
 }
=20
+static void test_dispatch_cmd_success_response(void)
+{
+    QDict *req =3D qdict_new();
+    QObject *resp;
+
+    qdict_put_str(req, "execute", "cmd-success-response");
+    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req));
+    assert(resp =3D=3D NULL);
+    QDECREF(req);
+}
+
 static QObject *test_qmp_dispatch(QDict *req)
 {
     QObject *resp_obj;
@@ -276,6 +291,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
     g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failu=
re);
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
+    g_test_add_func("/qmp/dispatch_cmd_success_response",
+                    test_dispatch_cmd_success_response);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index c72dbd8050..96ff3a8e47 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -132,6 +132,8 @@
   'data': {'ud1a': 'UserDefOne', '*ud1b': 'UserDefOne'},
   'returns': 'UserDefTwo' }
=20
+{ 'command': 'cmd-success-response', 'data': {}, 'success-response': fal=
se }
+
 # Returning a non-dictionary requires a name from the whitelist
 { 'command': 'guest-get-time', 'data': {'a': 'int', '*b': 'int' },
   'returns': 'int' }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 012e7fc06a..cd3642be34 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -153,6 +153,8 @@ object q_obj_user_def_cmd2-arg
     member ud1b: UserDefOne optional=3DTrue
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
    gen=3DTrue success_response=3DTrue boxed=3DFalse
+command cmd-success-response None -> None
+   gen=3DTrue success_response=3DFalse boxed=3DFalse
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
--=20
2.17.0.rc1.1.g4c4f2b46a3

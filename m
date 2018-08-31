Received: from eggs.gnu.org ([2001:4830:134:3::10]:39315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvf3e-0000r7-0V
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvexj-0007W2-DS
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52012 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvexj-0007Vw-5p
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:27 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 31 Aug 2018 10:38:58 +0200
Message-Id: <1535704738-8986-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1535704738-8986-1-git-send-email-thuth@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] tests: add a qmp success-response test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Verify the usage of this schema feature and the API behaviour.  This
should be the only case where qmp_dispatch() returns NULL.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json |  2 ++
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 tests/test-qmp-cmds.c                   | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 11aa4c8..fb03163 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -137,6 +137,8 @@
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
index 0da9245..218ac7d 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -156,6 +156,8 @@ object q_obj_user_def_cmd2-arg
     member ud1b: UserDefOne optional=3DTrue
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+command cmd-success-response None -> None
+   gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index ab414fa..4ab2b6e 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -32,6 +32,10 @@ void qmp_test_flags_command(Error **errp)
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
@@ -153,6 +157,17 @@ static void test_dispatch_cmd_failure(void)
     qobject_unref(req);
 }
=20
+static void test_dispatch_cmd_success_response(void)
+{
+    QDict *req =3D qdict_new();
+    QDict *resp;
+
+    qdict_put_str(req, "execute", "cmd-success-response");
+    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), false);
+    g_assert_null(resp);
+    qobject_unref(req);
+}
+
 static QObject *test_qmp_dispatch(QDict *req)
 {
     QDict *resp;
@@ -289,6 +304,8 @@ int main(int argc, char **argv)
     g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
     g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failu=
re);
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
+    g_test_add_func("/qmp/dispatch_cmd_success_response",
+                    test_dispatch_cmd_success_response);
     g_test_add_func("/qmp/dealloc_types", test_dealloc_types);
     g_test_add_func("/qmp/dealloc_partial", test_dealloc_partial);
=20
--=20
1.8.3.1

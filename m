Received: from eggs.gnu.org ([2001:4830:134:3::10]:50300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0in-00084u-MR
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0il-0000Rm-T5
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60996 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fv0il-0000RJ-KH
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E569F5A74E
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 13:41:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Aug 2018 15:40:41 +0200
Message-Id: <20180829134043.31706-9-marcandre.lureau@redhat.com>
In-Reply-To: <20180829134043.31706-1-marcandre.lureau@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 08/10] tests: add a qmp success-response test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
index ab414fa0c9..8d5100a324 100644
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
+    assert(resp =3D=3D NULL);
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
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 11aa4c8f8d..fb03163430 100644
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
index 0da92455da..218ac7d556 100644
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
--=20
2.19.0.rc0.48.gb9dfa238d5

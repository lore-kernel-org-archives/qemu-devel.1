Received: from eggs.gnu.org ([2001:4830:134:3::10]:37693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVL-00031M-3X
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHZVH-0005ql-Jn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHZVH-0005kI-D4
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 002AD3001E5C
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 19:16:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 30 Oct 2018 20:16:18 +0100
Message-Id: <20181030191620.32168-7-armbru@redhat.com>
In-Reply-To: <20181030191620.32168-1-armbru@redhat.com>
References: <20181030191620.32168-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] tests: add oob functional test for
 test-qmp-cmds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Straightforward test just to let the test-qmp-cmds be complete.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20181009062718.1914-6-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 4ab2b6e5ce..481cb069ca 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -126,6 +126,21 @@ static void test_dispatch_cmd(void)
     qobject_unref(req);
 }
=20
+static void test_dispatch_cmd_oob(void)
+{
+    QDict *req =3D qdict_new();
+    QDict *resp;
+
+    qdict_put_str(req, "exec-oob", "test-flags-command");
+
+    resp =3D qmp_dispatch(&qmp_commands, QOBJECT(req), true);
+    assert(resp !=3D NULL);
+    assert(!qdict_haskey(resp, "error"));
+
+    qobject_unref(resp);
+    qobject_unref(req);
+}
+
 /* test commands that return an error due to invalid parameters */
 static void test_dispatch_cmd_failure(void)
 {
@@ -302,6 +317,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     g_test_add_func("/qmp/dispatch_cmd", test_dispatch_cmd);
+    g_test_add_func("/qmp/dispatch_cmd_oob", test_dispatch_cmd_oob);
     g_test_add_func("/qmp/dispatch_cmd_failure", test_dispatch_cmd_failu=
re);
     g_test_add_func("/qmp/dispatch_cmd_io", test_dispatch_cmd_io);
     g_test_add_func("/qmp/dispatch_cmd_success_response",
--=20
2.17.2

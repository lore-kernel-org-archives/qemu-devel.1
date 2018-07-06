Received: from eggs.gnu.org ([2001:4830:134:3::10]:59546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPcw-0006kn-Ec
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbPcv-0005r3-KI
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:14:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbPcv-0005qx-FR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:14:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 191A172651
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 12:14:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 14:13:51 +0200
Message-Id: <20180706121354.2021-10-marcandre.lureau@redhat.com>
In-Reply-To: <20180706121354.2021-1-marcandre.lureau@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 09/12] tests: add a few qemu-qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

These 2 tests exhibited two qmp bugs that were fixed in 2.7
(series from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6 to
commit 1382d4abdf9619985e4078e37e49e487cea9935e)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index ceaf4a6789..084c5edff0 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -249,7 +249,39 @@ static void test_qmp_oob(void)
     recv_cmd_id(qts, "blocks-2");
     recv_cmd_id(qts, "err-2");
     cleanup_blocking_cmd();
+}
+
+static void test_object_add_without_props(void)
+{
+    QTestState *qts;
+    QDict *ret;
+
+    qts =3D qtest_init(common_args);
+
+    ret =3D qtest_qmp(qts, "{'execute': 'object-add',"
+          " 'arguments': { 'qom-type': 'memory-backend-ram', 'id': 'ram1=
' } }");
+    g_assert_nonnull(ret);
+
+    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
+
+    qobject_unref(ret);
+    qtest_quit(qts);
+}
+
+static void test_qom_set_without_value(void)
+{
+    QTestState *qts;
+    QDict *ret;
+
+    qts =3D qtest_init(common_args);
=20
+    ret =3D qtest_qmp(qts, "{'execute': 'qom-set',"
+              " 'arguments': { 'path': '/machine', 'property': 'rtc-time=
' } }");
+    g_assert_nonnull(ret);
+
+    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
+
+    qobject_unref(ret);
     qtest_quit(qts);
 }
=20
@@ -479,8 +511,13 @@ int main(int argc, char *argv[])
=20
     g_test_init(&argc, &argv, NULL);
=20
+    qtest_add_func("qmp/object-add-without-props",
+                   test_object_add_without_props);
+    qtest_add_func("qmp/qom-set-without-value",
+                   test_qom_set_without_value);
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qtest_add_func("qmp/oob", test_qmp_oob);
+
     qmp_schema_init(&schema);
     add_query_tests(&schema);
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
@@ -488,5 +525,6 @@ int main(int argc, char *argv[])
     ret =3D g_test_run();
=20
     qmp_schema_cleanup(&schema);
+
     return ret;
 }
--=20
2.18.0.rc1

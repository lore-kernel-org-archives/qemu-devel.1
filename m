Received: from eggs.gnu.org ([2001:4830:134:3::10]:38121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjH-0003bY-9J
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjG-0007rw-B1
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsjG-0007rh-2E
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:54 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BB2C19DE98
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:54 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:26 +0400
Message-Id: <20170118160332.13390-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 19/25] tests: add tests for async and
 non-async clients
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

Add two tests to check async and non-async client behaviour:
- an async client can see out of order replies
- an non-async client has commands processed in order

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 480ff28339..f383d5d6f6 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -58,6 +58,61 @@ static void test_qom_set_without_value(void)
     QDECREF(ret);
 }
=20
+static void test_no_async(void)
+{
+    QDict *ret;
+    int64_t id;
+
+    /* check that only one async command is being processed */
+    qmp_async("{'execute': 'qtest-timeout', 'id': 42, "
+              " 'arguments': { 'duration': 1 } }");
+    qmp_async("{'execute': 'qtest-timeout', 'id': 43, "
+              " 'arguments': { 'duration': 0 } }");
+
+    /* check that the second command didn't execute immediately */
+    ret =3D qtest_qmp_receive(global_qtest);
+    g_assert_nonnull(ret);
+    id =3D qdict_get_try_int(ret, "id", -1);
+    g_assert_cmpint(id, =3D=3D, 42);
+    QDECREF(ret);
+
+    /* check that the second command executes after */
+    ret =3D qtest_qmp_receive(global_qtest);
+    g_assert_nonnull(ret);
+    id =3D qdict_get_try_int(ret, "id", -1);
+    g_assert_cmpint(id, =3D=3D, 43);
+    QDECREF(ret);
+}
+
+static void test_async(void)
+{
+    QDict *ret;
+    int64_t id;
+    QTestState *qtest;
+
+    qtest =3D qtest_init_qmp_caps("-machine none", "'async'");
+
+    /* check that async are concurrent */
+    qtest_async_qmp(qtest, "{'execute': 'qtest-timeout', 'id': 42, "
+              " 'arguments': { 'duration': 1 } }");
+    qtest_async_qmp(qtest, "{'execute': 'qtest-timeout', 'id': 43, "
+              " 'arguments': { 'duration': 0 } }");
+
+    ret =3D qtest_qmp_receive(qtest);
+    g_assert_nonnull(ret);
+    id =3D qdict_get_try_int(ret, "id", -1);
+    g_assert_cmpint(id, =3D=3D, 43);
+    QDECREF(ret);
+
+    ret =3D qtest_qmp_receive(qtest);
+    g_assert_nonnull(ret);
+    id =3D qdict_get_try_int(ret, "id", -1);
+    g_assert_cmpint(id, =3D=3D, 42);
+    QDECREF(ret);
+
+    qtest_quit(qtest);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -70,6 +125,10 @@ int main(int argc, char **argv)
                    test_object_add_without_props);
     qtest_add_func("/qemu-qmp/qom-set-without-value",
                    test_qom_set_without_value);
+    qtest_add_func("/qemu-qmp/no-async",
+                   test_no_async);
+    qtest_add_func("/qemu-qmp/async",
+                   test_async);
=20
     ret =3D g_test_run();
=20
--=20
2.11.0.295.gd7dffce1c

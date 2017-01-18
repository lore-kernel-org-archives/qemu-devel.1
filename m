Received: from eggs.gnu.org ([2001:4830:134:3::10]:38232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjc-0003yF-Bd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsjY-0007z7-DD
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsjY-0007yx-82
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:05:12 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BFDA7FB68
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:05:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:31 +0400
Message-Id: <20170118160332.13390-25-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 24/25] qtest: add /qemu-qmp/screendump test
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

Check that screendump works with and without client async support.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
 1 file changed, 53 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index f383d5d6f6..22b7315ca7 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -113,6 +113,57 @@ static void test_async(void)
     qtest_quit(qtest);
 }
=20
+static void test_screendump(void)
+{
+    QDict *ret;
+    QTestState *qtest;
+    gchar *fname =3D NULL;
+    int64_t id;
+    int fd;
+    char *buf =3D NULL;
+    gsize len =3D 0;
+
+    fd =3D g_file_open_tmp("qemu-test-screendump.XXXXXX", &fname, NULL);
+    g_assert(fd >=3D 0);
+    g_assert_nonnull(fname);
+
+    /* without async */
+    qtest =3D qtest_init("-machine none");
+    qtest_async_qmp(qtest, "{'execute': 'screendump',"
+                    " 'arguments': { 'filename': %s } }", fname);
+
+    ret =3D qtest_qmp_receive(qtest);
+    g_assert_nonnull(ret);
+    QDECREF(ret);
+    qtest_quit(qtest);
+
+    g_file_get_contents(fname, &buf, &len, NULL);
+    g_assert_cmpint(len, >, 0);
+    g_assert_nonnull(buf);
+    g_free(buf);
+
+    /* with async */
+    qtest =3D qtest_init_qmp_caps("-machine none", "'async'");
+    qtest_async_qmp(qtest, "{'execute': 'screendump', 'id': 42,"
+                    " 'arguments': { 'filename': %s } }", fname);
+
+    ret =3D qtest_qmp_receive(qtest);
+    id =3D qdict_get_try_int(ret, "id", -1);
+    g_assert_cmpint(id, =3D=3D, 42);
+    g_assert_nonnull(ret);
+    QDECREF(ret);
+    qtest_quit(qtest);
+
+    g_file_get_contents(fname, &buf, &len, NULL);
+    g_assert_cmpint(len, >, 0);
+    g_assert_nonnull(buf);
+    g_free(buf);
+
+    close(fd);
+    unlink(fname);
+    g_free(fname);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -129,6 +180,8 @@ int main(int argc, char **argv)
                    test_no_async);
     qtest_add_func("/qemu-qmp/async",
                    test_async);
+    qtest_add_func("/qemu-qmp/screendump",
+                   test_screendump);
=20
     ret =3D g_test_run();
=20
--=20
2.11.0.295.gd7dffce1c

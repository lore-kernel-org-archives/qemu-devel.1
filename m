Received: from eggs.gnu.org ([2001:4830:134:3::10]:55255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH8z2-0001g1-Sz
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gH8yz-0005vH-5l
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gH8yx-0005q7-PW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:57:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A07830DD2BA
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 14:57:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Oct 2018 18:57:09 +0400
Message-Id: <20181029145709.26359-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: add qmp/missing-any-arg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>

test_qmp_missing_any_arg() is about a bug in infrastructure used by
the QMP core, fixed in commit c489780203.  We covered the bug in
infrastructure unit tests (commit bce3035a44).  I wrote that test
earlier, to cover QMP level as well, the test could go into qmp-test.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qmp-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 6c419f6023..7517be4654 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -318,6 +318,19 @@ static void test_qmp_preconfig(void)
     qtest_quit(qs);
 }
=20
+static void test_qmp_missing_any_arg(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    qts =3D qtest_init(common_args);
+    resp =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
+                     " { 'path': '/machine', 'property': 'rtc-time' } }"=
);
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -325,6 +338,7 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qtest_add_func("qmp/oob", test_qmp_oob);
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
+    qtest_add_func("qmp/missing-any-arg", test_qmp_missing_any_arg);
=20
     return g_test_run();
 }
--=20
2.19.0.271.gfe8321ec05

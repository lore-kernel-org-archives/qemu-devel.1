Received: from eggs.gnu.org ([2001:4830:134:3::10]:46657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eY-00066y-Cb
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eU-00088Y-1G
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gP3eT-00086G-Qj
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Nov 2018 11:52:21 +0100
Message-Id: <1542711143-1946-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1542711143-1946-1-git-send-email-thuth@redhat.com>
References: <1542711143-1946-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] tests: add qmp/missing-any-arg test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

test_qmp_missing_any_arg() is about a bug in infrastructure used by
the QMP core, fixed in commit c489780203.  We covered the bug in
infrastructure unit tests (commit bce3035a44).  Let's test
it at the QMP level as well.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[thuth: Tweaked the commit message according to Markus' suggestion]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qmp-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 6c419f6..7517be4 100644
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
1.8.3.1

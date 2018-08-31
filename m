Received: from eggs.gnu.org ([2001:4830:134:3::10]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvf3h-00017Y-Eb
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvexd-0007Tm-M4
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fvexd-0007S8-Gm
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 04:39:21 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 31 Aug 2018 10:38:56 +0200
Message-Id: <1535704738-8986-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1535704738-8986-1-git-send-email-thuth@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] tests: add qmp/object-add-without-props test
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

test_object_add_without_props() tests a bug in qmp_object_add() we
fixed in commit e64c75a975.  Sadly, we don't have systematic
object-add tests.  This lone test can go into qmp-cmd-test for want of
a better home.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qmp-cmd-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
index c5b70df..d12cac5 100644
--- a/tests/qmp-cmd-test.c
+++ b/tests/qmp-cmd-test.c
@@ -197,6 +197,19 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
=20
+static void test_object_add_without_props(void)
+{
+    QTestState *qts;
+    QDict *resp;
+
+    qts =3D qtest_init(common_args);
+    resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } =
}");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     QmpSchema schema;
@@ -206,6 +219,11 @@ int main(int argc, char *argv[])
=20
     qmp_schema_init(&schema);
     add_query_tests(&schema);
+
+    qtest_add_func("qmp/object-add-without-props",
+                   test_object_add_without_props);
+    /* TODO: add coverage of generic object-add failure modes */
+
     ret =3D g_test_run();
=20
     qmp_schema_cleanup(&schema);
--=20
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKv-0000w0-BQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKu-0002PR-Kr
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvPKu-0002PH-G7
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:20 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 17:58:08 +0200
Message-Id: <20180830155810.17629-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180830155810.17629-1-marcandre.lureau@redhat.com>
References: <20180830155810.17629-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/4] tests: add qmp/object-add-without-props
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

test_object_add_without_props() tests a bug in qmp_object_add() we
fixed in commit e64c75a975.  Sadly, we don't have systematic
object-add tests.  This lone test can go into qmp-cmd-test for want of
a better home.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-cmd-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
index c5b70df974..d12cac539c 100644
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
2.19.0.rc0.48.gb9dfa238d5

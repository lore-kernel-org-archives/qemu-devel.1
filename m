Received: from eggs.gnu.org ([2001:4830:134:3::10]:49454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4V-0001HW-C2
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ftZ4U-0003Bg-IP
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53916 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ftZ4U-0003B7-Ce
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:57:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Aug 2018 15:57:21 +0200
Message-Id: <20180825135724.8981-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180825135724.8981-1-marcandre.lureau@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/9] tests: add a few qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

test_object_add_without_props() tests a bug in qmp_object_add() we
fixed in commit e64c75a975.  Sadly, we don't have systematic
object-add tests.  This lone test can go into qmp-cmd-test for want of
a better home.

test_qom_set_without_value() is about a bug in infrastructure used by
the QMP core, fixed in commit c489780203.  We covered the bug in
infrastructure unit tests (commit bce3035a44).  I wrote that test
earlier, to cover QMP level as well, the test could go into qmp-test.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-cmd-test.c | 31 +++++++++++++++++++++++++++++++
 tests/qmp-test.c     | 18 ++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
index c5b70df974..3ba8f68476 100644
--- a/tests/qmp-cmd-test.c
+++ b/tests/qmp-cmd-test.c
@@ -19,6 +19,15 @@
=20
 const char common_args[] =3D "-nodefaults -machine none";
=20
+static const char *get_error_class(QDict *resp)
+{
+    QDict *error =3D qdict_get_qdict(resp, "error");
+    const char *desc =3D qdict_get_try_str(error, "desc");
+
+    g_assert(desc);
+    return error ? qdict_get_try_str(error, "class") : NULL;
+}
+
 /* Query smoke tests */
=20
 static int query_error_class(const char *cmd)
@@ -197,6 +206,24 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
=20
+static void test_object_add_without_props(void)
+{
+    QTestState *qts;
+    QDict *ret;
+
+    qts =3D qtest_init(common_args);
+
+    ret =3D qtest_qmp(qts,
+                    "{'execute': 'object-add', 'arguments':"
+                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } =
}");
+    g_assert_nonnull(ret);
+
+    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
+
+    qobject_unref(ret);
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     QmpSchema schema;
@@ -206,6 +233,10 @@ int main(int argc, char *argv[])
=20
     qmp_schema_init(&schema);
     add_query_tests(&schema);
+
+    qtest_add_func("qmp/object-add-without-props",
+                   test_object_add_without_props);
+
     ret =3D g_test_run();
=20
     qmp_schema_cleanup(&schema);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 4ae2245484..fdfe73b6d2 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -348,6 +348,23 @@ static void test_qmp_preconfig(void)
     qtest_quit(qs);
 }
=20
+static void test_qom_set_without_value(void)
+{
+    QTestState *qts;
+    QDict *ret;
+
+    qts =3D qtest_init(common_args);
+
+    ret =3D qtest_qmp(qts, "{'execute': 'qom-set', 'arguments':"
+                    " { 'path': '/machine', 'property': 'rtc-time' } }")=
;
+    g_assert_nonnull(ret);
+
+    g_assert_cmpstr(get_error_class(ret), =3D=3D, "GenericError");
+
+    qobject_unref(ret);
+    qtest_quit(qts);
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
@@ -355,6 +372,7 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qtest_add_func("qmp/oob", test_qmp_oob);
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
+    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_val=
ue);
=20
     return g_test_run();
 }
--=20
2.18.0.547.g1d89318c48

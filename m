Received: from eggs.gnu.org ([2001:4830:134:3::10]:58608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKx-0000yL-Ig
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvPKw-0002QK-PV
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvPKw-0002Q9-Kd
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:58:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 17:58:09 +0200
Message-Id: <20180830155810.17629-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180830155810.17629-1-marcandre.lureau@redhat.com>
References: <20180830155810.17629-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/4] tests: add qmp/qom-set-without-value
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

test_qom_set_without_value() is about a bug in infrastructure used by
the QMP core, fixed in commit c489780203.  We covered the bug in
infrastructure unit tests (commit bce3035a44).  I wrote that test
earlier, to cover QMP level as well, the test could go into qmp-test.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index b3472281ae..2b923f02db 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -321,6 +321,19 @@ static void test_qmp_preconfig(void)
     qtest_quit(qs);
 }
=20
+static void test_qom_set_without_value(void)
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
@@ -328,6 +341,7 @@ int main(int argc, char *argv[])
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qtest_add_func("qmp/oob", test_qmp_oob);
     qtest_add_func("qmp/preconfig", test_qmp_preconfig);
+    qtest_add_func("qmp/qom-set-without-value", test_qom_set_without_val=
ue);
=20
     return g_test_run();
 }
--=20
2.19.0.rc0.48.gb9dfa238d5

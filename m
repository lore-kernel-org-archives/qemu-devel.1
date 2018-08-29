Received: from eggs.gnu.org ([2001:4830:134:3::10]:50302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0in-00084y-N9
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0ik-0000R4-GG
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fv0ik-0000QX-8u
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91B40738F1
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 13:41:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Aug 2018 15:40:40 +0200
Message-Id: <20180829134043.31706-8-marcandre.lureau@redhat.com>
In-Reply-To: <20180829134043.31706-1-marcandre.lureau@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/10] tests: add qmp/qom-set-without-value
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
Cc: armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

test_qom_set_without_value() is about a bug in infrastructure used by
the QMP core, fixed in commit c489780203.  We covered the bug in
infrastructure unit tests (commit bce3035a44).  I wrote that test
earlier, to cover QMP level as well, the test could go into qmp-test.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

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
2.19.0.rc0.48.gb9dfa238d5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0if-0007zg-NY
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0ie-0000O0-T5
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fv0ie-0000NQ-MB
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED23F40216E8
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 13:41:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Aug 2018 15:40:39 +0200
Message-Id: <20180829134043.31706-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180829134043.31706-1-marcandre.lureau@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/10] tests: add
 qmp/object-add-without-props test
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

test_object_add_without_props() tests a bug in qmp_object_add() we
fixed in commit e64c75a975.  Sadly, we don't have systematic
object-add tests.  This lone test can go into qmp-cmd-test for want of
a better home.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-cmd-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

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
--=20
2.19.0.rc0.48.gb9dfa238d5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkp-0005I5-NN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tko-0002o8-Pz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tko-0002nv-LA
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:46 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:48 +0200
Message-Id: <20180326150916.9602-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 10/38] tests: add a few qemu-qmp tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

These 2 tests exhibited two qmp bugs that were fixed in 2.7
(series from commit e64c75a9752c5d0fd64eb2e684c656a5ea7d03c6 to
commit 1382d4abdf9619985e4078e37e49e487cea9935e)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 07c0b87e27..642f46a332 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -224,7 +224,50 @@ static void test_qmp_oob(void)
         }
         QDECREF(resp);
     }
+    qtest_end();
+}
+
+static void test_object_add_without_props(void)
+{
+    QDict *ret, *error;
+    const gchar *klass, *desc;
+
+    qtest_start("-machine none");
=20
+    ret =3D qmp("{'execute': 'object-add',"
+              " 'arguments': { 'qom-type': 'memory-backend-ram', 'id': '=
ram1' } }");
+    g_assert_nonnull(ret);
+
+    error =3D qdict_get_qdict(ret, "error");
+    klass =3D qdict_get_try_str(error, "class");
+    desc =3D qdict_get_try_str(error, "desc");
+
+    g_assert_cmpstr(klass, =3D=3D, "GenericError");
+    g_assert_cmpstr(desc, =3D=3D, "can't create backend with size 0");
+
+    QDECREF(ret);
+    qtest_end();
+}
+
+static void test_qom_set_without_value(void)
+{
+    QDict *ret, *error;
+    const gchar *klass, *desc;
+
+    qtest_start("-machine none");
+
+    ret =3D qmp("{'execute': 'qom-set',"
+              " 'arguments': { 'path': '/machine', 'property': 'rtc-time=
' } }");
+    g_assert_nonnull(ret);
+
+    error =3D qdict_get_qdict(ret, "error");
+    klass =3D qdict_get_try_str(error, "class");
+    desc =3D qdict_get_try_str(error, "desc");
+
+    g_assert_cmpstr(klass, =3D=3D, "GenericError");
+    g_assert_cmpstr(desc, =3D=3D, "Parameter 'value' is missing");
+
+    QDECREF(ret);
     qtest_end();
 }
=20
@@ -411,13 +454,19 @@ int main(int argc, char *argv[])
=20
     g_test_init(&argc, &argv, NULL);
=20
+    qtest_add_func("qmp/object-add-without-props",
+                   test_object_add_without_props);
+    qtest_add_func("qmp/qom-set-without-value",
+                   test_qom_set_without_value);
     qtest_add_func("qmp/protocol", test_qmp_protocol);
     qtest_add_func("qmp/oob", test_qmp_oob);
+
     qmp_schema_init(&schema);
     add_query_tests(&schema);
=20
     ret =3D g_test_run();
=20
     qmp_schema_cleanup(&schema);
+
     return ret;
 }
--=20
2.17.0.rc1.1.g4c4f2b46a3

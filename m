Received: from eggs.gnu.org ([2001:4830:134:3::10]:55308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JU-000887-6k
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9JQ-00074H-1I
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9JP-00073O-Rb
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BACB9883DA
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:27:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:49 +0200
Message-Id: <20170822132255.23945-49-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 48/54] tests/qmp-test: add query-qmp-schema
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

The following patch is going to make qmp introspection per-target, and
test-qobject-input-visitor.c can no longer link with
qmp_schema_qlit. Use a run-time QMP test instead to validate the
query-qmp-schema schema.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qmp-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 5d0260b2be..1fd37092b5 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -129,11 +129,32 @@ static void test_qmp_protocol(void)
     qtest_end();
 }
=20
+static void test_qmp_query_schema(void)
+{
+    SchemaInfoList *schema;
+    QDict *resp;
+    Visitor *v;
+
+    qtest_start(common_args);
+
+    resp =3D qmp("{'execute': 'query-qmp-schema'}");
+    v =3D qobject_input_visitor_new(qdict_get(resp, "return"));
+    visit_type_SchemaInfoList(v, NULL, &schema, &error_abort);
+    g_assert(schema);
+
+    qapi_free_SchemaInfoList(schema);
+    visit_free(v);
+    QDECREF(resp);
+
+    qtest_end();
+}
+
 int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
=20
     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/query-schema", test_qmp_query_schema);
=20
     return g_test_run();
 }
--=20
2.14.1.146.gd35faa819

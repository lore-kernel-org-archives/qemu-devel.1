Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal1W-0005AZ-3c
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dal1V-0004PO-2z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dal1U-0004Oq-Sj
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D0711287
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 15:42:27 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Jul 2017 17:41:20 +0200
Message-Id: <20170727154126.11339-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170727154126.11339-1-marcandre.lureau@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/26] tests/qmp-test: add query-qmp-schema test
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
2.14.0.rc0.1.g40ca67566

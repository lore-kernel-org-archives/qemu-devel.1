Received: from eggs.gnu.org ([209.51.188.92]:49356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV5-00046q-K9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmV4-0002vY-NC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:03 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  9 Apr 2019 10:52:43 +0200
Message-Id: <20190409085245.31548-4-thuth@redhat.com>
In-Reply-To: <20190409085245.31548-1-thuth@redhat.com>
References: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 3/5] tests/qmp-cmd-test: Use
 qtest_init() instead of qtest_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Hannes Reinecke <hare@suse.com>

qtest_start() + qtest_end() should be avoided, since they use the
global_qtest variable that we want to get rid of in the long run
(since global_qtest can not be used in tests that have to track
multiple QEMU states, like migration tests). Use qtest_init() and
qtest_quit() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qmp-cmd-test.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
index d12cac539c..9f5228cd99 100644
--- a/tests/qmp-cmd-test.c
+++ b/tests/qmp-cmd-test.c
@@ -61,10 +61,11 @@ static void test_query(const void *data)
     int expected_error_class =3D query_error_class(cmd);
     QDict *resp, *error;
     const char *error_class;
+    QTestState *qts;
=20
-    qtest_start(common_args);
+    qts =3D qtest_init(common_args);
=20
-    resp =3D qmp("{ 'execute': %s }", cmd);
+    resp =3D qtest_qmp(qts, "{ 'execute': %s }", cmd);
     error =3D qdict_get_qdict(resp, "error");
     error_class =3D error ? qdict_get_str(error, "class") : NULL;
=20
@@ -78,7 +79,7 @@ static void test_query(const void *data)
     }
     qobject_unref(resp);
=20
-    qtest_end();
+    qtest_quit(qts);
 }
=20
 static bool query_is_blacklisted(const char *cmd)
@@ -118,16 +119,18 @@ static void qmp_schema_init(QmpSchema *schema)
     QDict *resp;
     Visitor *qiv;
     SchemaInfoList *tail;
+    QTestState *qts;
=20
-    qtest_start(common_args);
-    resp =3D qmp("{ 'execute': 'query-qmp-schema' }");
+    qts =3D qtest_init(common_args);
+
+    resp =3D qtest_qmp(qts, "{ 'execute': 'query-qmp-schema' }");
=20
     qiv =3D qobject_input_visitor_new(qdict_get(resp, "return"));
     visit_type_SchemaInfoList(qiv, NULL, &schema->list, &error_abort);
     visit_free(qiv);
=20
     qobject_unref(resp);
-    qtest_end();
+    qtest_quit(qts);
=20
     schema->hash =3D g_hash_table_new(g_str_hash, g_str_equal);
=20
--=20
2.21.0

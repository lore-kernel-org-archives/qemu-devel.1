Received: from eggs.gnu.org ([2001:4830:134:3::10]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRy6o-0002rd-GD
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRy6k-0002gx-AA
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:34:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRy6k-0002g3-2z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:34:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 825F7307DABD
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:34:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Nov 2018 12:33:33 +0100
Message-Id: <20181128113337.7238-2-quintela@redhat.com>
In-Reply-To: <20181128113337.7238-1-quintela@redhat.com>
References: <20181128113337.7238-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 1/5] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 06ca5068d8..d18e9b3709 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -584,6 +584,17 @@ static void deprecated_set_speed(QTestState *who, lo=
ng long value)
     migrate_check_parameter(who, "max-bandwidth", value);
 }
=20
+static void deprecated_set_cache_size(QTestState *who, long long value)
+{
+    QDict *rsp;
+
+    rsp =3D qtest_qmp(who, "{ 'execute': 'migrate-set-cache-size',"
+                         "'arguments': { 'value': %lld } }", value);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+    migrate_check_parameter(who, "xbzrle-cache-size", value);
+}
+
 static void test_deprecated(void)
 {
     QTestState *from;
@@ -592,6 +603,7 @@ static void test_deprecated(void)
=20
     deprecated_set_downtime(from, 0.12345);
     deprecated_set_speed(from, 12345);
+    deprecated_set_cache_size(from, 4096);
=20
     qtest_quit(from);
 }
@@ -781,6 +793,56 @@ static void test_precopy_unix(void)
     g_free(uri);
 }
=20
+static void test_xbzrle(const char *uri)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, false)) {
+        return;
+    }
+
+    /* We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter(from, "max-bandwidth", 1000000000);
+
+    migrate_set_parameter(from, "xbzrle-cache-size", 33554432);
+
+    migrate_set_capability(from, "xbzrle", "true");
+    migrate_set_capability(to, "xbzrle", "true");
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300ms should converge */
+    migrate_set_parameter(from, "downtime-limit", 300);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to, true);
+}
+
+static void test_xbzrle_unix(void)
+{
+    char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    test_xbzrle(uri);
+    g_free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -832,6 +894,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
+    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
=20
     ret =3D g_test_run();
=20
--=20
2.19.1

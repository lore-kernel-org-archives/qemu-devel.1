Received: from eggs.gnu.org ([209.51.188.92]:49926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcE-0001DB-Jq
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcC-0001va-Sa
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Ec9-0001qr-G9
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:29 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:50 +0000
Message-Id: <20190305181602.9051-10-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/21] tests: Add migration xbzrle test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190227105128.1655-2-quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  dgilbert: Fixup for class with Yury's series
---
 tests/migration-test.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 336b6e20cd..4d2302079d 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -629,6 +629,17 @@ static void deprecated_set_speed(QTestState *who, lo=
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
@@ -637,6 +648,7 @@ static void test_deprecated(void)
=20
     deprecated_set_downtime(from, 0.12345);
     deprecated_set_speed(from, 12345);
+    deprecated_set_cache_size(from, 4096);
=20
     qtest_quit(from);
 }
@@ -864,6 +876,57 @@ static void test_ignore_shared(void)
 }
 #endif
=20
+static void test_xbzrle(const char *uri)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, false, false)) {
+        return;
+    }
+
+    /*
+     * We want to pick a speed slow enough that the test completes
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
@@ -916,6 +979,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); *=
/
+    qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
=20
     ret =3D g_test_run();
=20
--=20
2.20.1

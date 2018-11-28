Received: from eggs.gnu.org ([2001:4830:134:3::10]:47039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRy6y-0002yj-Te
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gRy6u-0002lw-FF
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:34:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gRy6u-0002le-AV
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:34:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3D39CD162
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 11:34:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 28 Nov 2018 12:33:36 +0100
Message-Id: <20181128113337.7238-5-quintela@redhat.com>
In-Reply-To: <20181128113337.7238-1-quintela@redhat.com>
References: <20181128113337.7238-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 4/5] tests: Add migration multifd test
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

We set the x-multifd-page-count and x-multifd-channels.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 4557704d17..010fe8b74d 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -940,6 +940,55 @@ static void test_precopy_tcp(void)
     g_free(uri);
 }
=20
+static void test_multifd_tcp(void)
+{
+    char *uri;
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", false)) {
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
+    migrate_set_parameter(from, "x-multifd-channels", 4);
+    migrate_set_parameter(to, "x-multifd-channels", 4);
+
+    migrate_set_parameter(from, "x-multifd-page-count", 64);
+    migrate_set_parameter(to, "x-multifd-page-count", 64);
+
+    migrate_set_capability(from, "x-multifd", "true");
+    migrate_set_capability(to, "x-multifd", "true");
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    uri =3D migrate_get_socket_address(to, "socket-address");
+
+    migrate(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300ms it should converge */
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
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -993,6 +1042,7 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/precopy/unix", test_precopy_unix);
     qtest_add_func("/migration/precopy/tcp", test_precopy_tcp);
     qtest_add_func("/migration/xbzrle/unix", test_xbzrle_unix);
+    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
=20
     ret =3D g_test_run();
=20
--=20
2.19.1

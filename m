Received: from eggs.gnu.org ([2001:4830:134:3::10]:46905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cxu-0004en-GG
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e7cxt-0007yr-Ea
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27153)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e7cxt-0007yC-6W
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 313F780B2A
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:52:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 26 Oct 2017 09:52:15 +0200
Message-Id: <20171026075222.27798-4-quintela@redhat.com>
In-Reply-To: <20171026075222.27798-1-quintela@redhat.com>
References: <20171026075222.27798-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/10] tests: Factorize out
 migrate_test_start/end
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

We fix global_test users left and right

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration-test.c | 86 ++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 19a1445076..91fb0277d6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -301,7 +301,7 @@ static void wait_for_migration_pass(void)
     } while (pass == initial_pass && !got_stop);
 }
 
-static void check_guests_ram(void)
+static void check_guests_ram(QTestState *who)
 {
     /* Our ASM test will have been incrementing one byte from each page from
      * 1MB to <100MB in order.
@@ -316,13 +316,13 @@ static void check_guests_ram(void)
     bool hit_edge = false;
     bool bad = false;
 
-    qtest_memread(global_qtest, start_address, &first_byte, 1);
+    qtest_memread(who, start_address, &first_byte, 1);
     last_byte = first_byte;
 
     for (address = start_address + 4096; address < end_address; address += 4096)
     {
         uint8_t b;
-        qtest_memread(global_qtest, address, &b, 1);
+        qtest_memread(who, address, &b, 1);
         if (b != last_byte) {
             if (((b + 1) % 256) == last_byte && !hit_edge) {
                 /* This is OK, the guest stopped at the point of
@@ -408,14 +408,10 @@ static void migrate(QTestState *who, const char *uri)
     QDECREF(rsp);
 }
 
-static void test_migrate(void)
+static void test_migrate_start(QTestState **from, QTestState **to,
+                               const char *uri)
 {
-    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *global = global_qtest, *from, *to;
-    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
     gchar *cmd_src, *cmd_dst;
-    QDict *rsp;
-
     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     const char *arch = qtest_get_arch();
 
@@ -456,11 +452,51 @@ static void test_migrate(void)
 
     g_free(bootpath);
 
-    from = qtest_start(cmd_src);
+    *from = qtest_start(cmd_src);
     g_free(cmd_src);
 
-    to = qtest_init(cmd_dst);
+    *to = qtest_init(cmd_dst);
     g_free(cmd_dst);
+}
+
+static void test_migrate_end(QTestState *from, QTestState *to)
+{
+    unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
+
+    qtest_quit(from);
+
+    qtest_memread(to, start_address, &dest_byte_a, 1);
+
+    /* Destination still running, wait for a byte to change */
+    do {
+        qtest_memread(to, start_address, &dest_byte_b, 1);
+        usleep(10 * 1000);
+    } while (dest_byte_a == dest_byte_b);
+
+    qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
+    /* With it stopped, check nothing changes */
+    qtest_memread(to, start_address, &dest_byte_c, 1);
+    sleep(1);
+    qtest_memread(to, start_address, &dest_byte_d, 1);
+    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
+
+    check_guests_ram(to);
+
+    qtest_quit(to);
+
+    cleanup("bootsect");
+    cleanup("migsocket");
+    cleanup("src_serial");
+    cleanup("dest_serial");
+}
+
+static void test_migrate(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *global = global_qtest, *from, *to;
+    QDict *rsp;
+
+    test_migrate_start(&from, &to, uri);
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
@@ -495,36 +531,10 @@ static void test_migrate(void)
     global_qtest = from;
     wait_for_migration_complete();
 
-    qtest_quit(from);
-
-    global_qtest = to;
-
-    qtest_memread(to, start_address, &dest_byte_a, 1);
-
-    /* Destination still running, wait for a byte to change */
-    do {
-        qtest_memread(to, start_address, &dest_byte_b, 1);
-        usleep(10 * 1000);
-    } while (dest_byte_a == dest_byte_b);
-
-    qmp_discard_response("{ 'execute' : 'stop'}");
-    /* With it stopped, check nothing changes */
-    qtest_memread(to, start_address, &dest_byte_c, 1);
-    sleep(1);
-    qtest_memread(to, start_address, &dest_byte_d, 1);
-    g_assert_cmpint(dest_byte_c, ==, dest_byte_d);
-
-    check_guests_ram();
-
-    qtest_quit(to);
     g_free(uri);
-
     global_qtest = global;
 
-    cleanup("bootsect");
-    cleanup("migsocket");
-    cleanup("src_serial");
-    cleanup("dest_serial");
+    test_migrate_end(from, to);
 }
 
 int main(int argc, char **argv)
-- 
2.13.6

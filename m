Received: from eggs.gnu.org ([2001:4830:134:3::10]:56099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIn-0007PZ-1G
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnqIh-0001rD-Sj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dnqIh-0001qN-Kk
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 14:04:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B384E81E0C
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 18:04:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Sep 2017 13:03:30 -0500
Message-Id: <20170901180340.30009-20-eblake@redhat.com>
In-Reply-To: <20170901180340.30009-1-eblake@redhat.com>
References: <20170901180340.30009-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 19/29] postcopy-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com

Managing parallel connections to two different monitors via
the implicit global_qtest makes it hard to copy-and-paste code
to tests that are not aware of the implicit state.  We are
already half-using the explicit APIs, so fix the remaining
spots to also be explicit about which connection is in use,
and avoid global_qtest.

We can assert that the conversion is correct by checking that
global_qtest remains NULL throughout the test (a later patch
that changes global_qtest to not be a public global variable
will drop the assertions).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/postcopy-test.c | 84 ++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2ab90..0e5fe20a83 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -223,7 +223,7 @@ static void wait_for_serial(const char *side)
 /*
  * Events can get in the way of responses we are actually waiting for.
  */
-static QDict *return_or_event(QDict *response)
+static QDict *return_or_event(QTestState *qts, QDict *response)
 {
     const char *event_string;
     if (!qdict_haskey(response, "event")) {
@@ -236,7 +236,7 @@ static QDict *return_or_event(QDict *response)
         got_stop = true;
     }
     QDECREF(response);
-    return return_or_event(qtest_qmp_receive(global_qtest));
+    return return_or_event(qts, qtest_qmp_receive(qts));
 }


@@ -247,12 +247,13 @@ static QDict *return_or_event(QDict *response)
  * going postcopy.
  */

-static uint64_t get_migration_pass(void)
+static uint64_t get_migration_pass(QTestState *qts)
 {
     QDict *rsp, *rsp_return, *rsp_ram;
     uint64_t result;

-    rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+    rsp = return_or_event(qts,
+                          qtest_qmp(qts, "{ 'execute': 'query-migrate' }"));
     rsp_return = qdict_get_qdict(rsp, "return");
     if (!qdict_haskey(rsp_return, "ram")) {
         /* Still in setup */
@@ -265,7 +266,7 @@ static uint64_t get_migration_pass(void)
     return result;
 }

-static void wait_for_migration_complete(void)
+static void wait_for_migration_complete(QTestState *qts)
 {
     QDict *rsp, *rsp_return;
     bool completed;
@@ -273,7 +274,8 @@ static void wait_for_migration_complete(void)
     do {
         const char *status;

-        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+        rsp = return_or_event(qts,
+                              qtest_qmp(qts, "{ 'execute': 'query-migrate' }"));
         rsp_return = qdict_get_qdict(rsp, "return");
         status = qdict_get_str(rsp_return, "status");
         completed = strcmp(status, "completed") == 0;
@@ -283,14 +285,14 @@ static void wait_for_migration_complete(void)
     } while (!completed);
 }

-static void wait_for_migration_pass(void)
+static void wait_for_migration_pass(QTestState *qts)
 {
-    uint64_t initial_pass = get_migration_pass();
+    uint64_t initial_pass = get_migration_pass(qts);
     uint64_t pass;

     /* Wait for the 1st sync */
     do {
-        initial_pass = get_migration_pass();
+        initial_pass = get_migration_pass(qts);
         if (got_stop || initial_pass) {
             break;
         }
@@ -299,11 +301,11 @@ static void wait_for_migration_pass(void)

     do {
         usleep(1000 * 100);
-        pass = get_migration_pass();
+        pass = get_migration_pass(qts);
     } while (pass == initial_pass && !got_stop);
 }

-static void check_guests_ram(void)
+static void check_guests_ram(QTestState *qts)
 {
     /* Our ASM test will have been incrementing one byte from each page from
      * 1MB to <100MB in order.
@@ -318,13 +320,13 @@ static void check_guests_ram(void)
     bool hit_edge = false;
     bool bad = false;

-    qtest_memread(global_qtest, start_address, &first_byte, 1);
+    qtest_memread(qts, start_address, &first_byte, 1);
     last_byte = first_byte;

     for (address = start_address + 4096; address < end_address; address += 4096)
     {
         uint8_t b;
-        qtest_memread(global_qtest, address, &b, 1);
+        qtest_memread(qts, address, &b, 1);
         if (b != last_byte) {
             if (((b + 1) % 256) == last_byte && !hit_edge) {
                 /* This is OK, the guest stopped at the point of
@@ -356,9 +358,9 @@ static void cleanup(const char *filename)
 static void test_migrate(void)
 {
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    QTestState *global = global_qtest, *from, *to;
+    QTestState *from, *to;
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
-    gchar *cmd, *cmd_src, *cmd_dst;
+    gchar *cmd_src, *cmd_dst;
     QDict *rsp;

     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
@@ -401,24 +403,24 @@ static void test_migrate(void)

     g_free(bootpath);

-    from = qtest_start(cmd_src);
+    from = qtest_init(cmd_src);
     g_free(cmd_src);

     to = qtest_init(cmd_dst);
     g_free(cmd_dst);

-    global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
-                  "'arguments': { "
+    assert(!global_qtest);
+
+    rsp = qtest_qmp(from, "{ 'execute': 'migrate-set-capabilities',"
+                    "'arguments': { "
                       "'capabilities': [ {"
                           "'capability': 'postcopy-ram',"
                           "'state': true } ] } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-    global_qtest = to;
-    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
-                  "'arguments': { "
+    rsp = qtest_qmp(to, "{ 'execute': 'migrate-set-capabilities',"
+                    "'arguments': { "
                       "'capabilities': [ {"
                           "'capability': 'postcopy-ram',"
                           "'state': true } ] } }");
@@ -429,15 +431,14 @@ static void test_migrate(void)
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
      */
-    global_qtest = from;
-    rsp = qmp("{ 'execute': 'migrate_set_speed',"
-              "'arguments': { 'value': 100000000 } }");
+    rsp = qtest_qmp(from, "{ 'execute': 'migrate_set_speed',"
+                    "'arguments': { 'value': 100000000 } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

     /* 1ms downtime - it should never finish precopy */
-    rsp = qmp("{ 'execute': 'migrate_set_downtime',"
-              "'arguments': { 'value': 0.001 } }");
+    rsp = qtest_qmp(from, "{ 'execute': 'migrate_set_downtime',"
+                    "'arguments': { 'value': 0.001 } }");
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

@@ -445,35 +446,30 @@ static void test_migrate(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");

-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
-                          "'arguments': { 'uri': '%s' } }",
-                          uri);
-    rsp = qmp(cmd);
-    g_free(cmd);
+    rsp = qtest_qmp(from,
+                    "{'execute': 'migrate', 'arguments': { 'uri': %s}}", uri);
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

-    wait_for_migration_pass();
+    wait_for_migration_pass(from);

-    rsp = return_or_event(qmp("{ 'execute': 'migrate-start-postcopy' }"));
+    rsp = return_or_event(from,
+                          qtest_qmp(from,
+                                    "{ 'execute': 'migrate-start-postcopy' }"));
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);

     if (!got_stop) {
-        qmp_eventwait("STOP");
+        qtest_qmp_eventwait(from, "STOP");
     }

-    global_qtest = to;
-    qmp_eventwait("RESUME");
+    qtest_qmp_eventwait(to, "RESUME");

     wait_for_serial("dest_serial");
-    global_qtest = from;
-    wait_for_migration_complete();
+    wait_for_migration_complete(from);

     qtest_quit(from);

-    global_qtest = to;
-
     qtest_memread(to, start_address, &dest_byte_a, 1);

     /* Destination still running, wait for a byte to change */
@@ -482,19 +478,19 @@ static void test_migrate(void)
         usleep(10 * 1000);
     } while (dest_byte_a == dest_byte_b);

-    qmp_discard_response("{ 'execute' : 'stop'}");
+    qtest_qmp_discard_response(to, "{ 'execute' : 'stop'}");
     /* With it stopped, check nothing changes */
     qtest_memread(to, start_address, &dest_byte_c, 1);
     sleep(1);
     qtest_memread(to, start_address, &dest_byte_d, 1);
     g_assert_cmpint(dest_byte_c, ==, dest_byte_d);

-    check_guests_ram();
+    check_guests_ram(to);

     qtest_quit(to);
     g_free(uri);

-    global_qtest = global;
+    assert(!global_qtest);

     cleanup("bootsect");
     cleanup("migsocket");
-- 
2.13.5

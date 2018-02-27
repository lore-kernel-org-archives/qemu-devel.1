Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rpalethorpe@suse.com>) id 1eqdss-0000P2-IG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rpalethorpe@suse.com>) id 1eqdsr-0000C7-5m
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 06:57:26 -0500
From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 27 Feb 2018 12:56:51 +0100
Message-Id: <20180227115651.30762-3-rpalethorpe@suse.com>
In-Reply-To: <20180227115651.30762-1-rpalethorpe@suse.com>
References: <20180227115651.30762-1-rpalethorpe@suse.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] migrate: Tests for migrating to an
 already used QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, eblake@redhat.com, quintela@redhat.com, mreitz@redhat.com, Richard Palethorpe <rpalethorpe@suse.com>

Currently this appears to work for X86_64, but PPC64 fails due to some
unexpected data on the serial port after migration. This probably requires
quite a bit more work.
---
 tests/migration-test.c | 113 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 28 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 74f9361bdd..8217d2e83e 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -125,19 +125,17 @@ static void init_bootfile_ppc(const char *bootpath)
  * we get an 'A' followed by an endless string of 'B's
  * but on the destination we won't have the A.
  */
-static void wait_for_serial(const char *side)
+static void wait_for_serial(const char *side, gboolean started)
 {
     char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
     FILE *serialfile = fopen(serialpath, "r");
     const char *arch = qtest_get_arch();
-    int started = (strcmp(side, "src_serial") == 0 &&
-                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
 
     g_free(serialpath);
     do {
         int readvalue = fgetc(serialfile);
 
-        if (!started) {
+        if (!started && !strcmp(arch, "ppc64")) {
             /* SLOF prints its banner before starting test,
              * to ignore it, mark the start of the test with '_',
              * ignore all characters until this marker
@@ -358,16 +356,21 @@ static void migrate_set_capability(QTestState *who, const char *capability,
     QDECREF(rsp);
 }
 
-static void migrate(QTestState *who, const char *uri)
+static void migrate(QTestState *who, const char *uri, gboolean incoming)
 {
     QDict *rsp;
+    const gchar *cmd_name = incoming ? "migrate-incoming" : "migrate";
     gchar *cmd;
 
-    cmd = g_strdup_printf("{ 'execute': 'migrate',"
+    cmd = g_strdup_printf("{ 'execute': '%s',"
                           "'arguments': { 'uri': '%s' } }",
-                          uri);
+                          cmd_name, uri);
     rsp = qtest_qmp(who, cmd);
     g_free(cmd);
+    while (qdict_haskey(rsp, "event")) {
+        QDECREF(rsp);
+        rsp = qtest_qmp_receive(who);
+    }
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 }
@@ -382,15 +385,22 @@ static void migrate_start_postcopy(QTestState *who)
 }
 
 static void test_migrate_start(QTestState **from, QTestState **to,
-                               const char *uri)
+                               const char *uri, gboolean incoming)
 {
-    gchar *cmd_src, *cmd_dst;
+    gchar *cmd_src;
+    GString *cmd_dst = g_string_new(NULL);
     char *bootpath = g_strdup_printf("%s/bootsect", tmpfs);
+    char *bootpath_dst;
     const char *arch = qtest_get_arch();
     const char *accel = "kvm:tcg";
 
     got_stop = false;
 
+    if (incoming)
+        bootpath_dst = bootpath;
+    else
+        bootpath_dst = g_strdup_printf("%s/bootsect_dst", tmpfs);
+
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         init_bootfile_x86(bootpath);
         cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
@@ -398,12 +408,14 @@ static void test_migrate_start(QTestState **from, QTestState **to,
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
                                   accel, tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
-                                  " -name target,debug-threads=on"
-                                  " -serial file:%s/dest_serial"
-                                  " -drive file=%s,format=raw"
-                                  " -incoming %s",
-                                  accel, tmpfs, bootpath, uri);
+        if (!incoming)
+            init_bootfile_x86(bootpath_dst);
+
+        g_string_printf(cmd_dst, "-machine accel=%s -m 150M"
+                        " -name target,debug-threads=on"
+                        " -serial file:%s/dest_serial"
+                        " -drive file=%s,format=raw",
+                        accel, tmpfs, bootpath_dst);
     } else if (strcmp(arch, "ppc64") == 0) {
 
         /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
@@ -416,22 +428,29 @@ static void test_migrate_start(QTestState **from, QTestState **to,
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,if=pflash,format=raw",
                                   accel, tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
-                                  " -name target,debug-threads=on"
-                                  " -serial file:%s/dest_serial"
-                                  " -incoming %s",
-                                  accel, tmpfs, uri);
+        g_string_printf(cmd_dst, "-machine accel=%s -m 256M"
+                        " -name target,debug-threads=on"
+                        " -serial file:%s/dest_serial",
+                        accel, tmpfs);
+        if (!incoming) {
+            g_string_append_printf(cmd_dst,
+                                   " -drive file=%s,if=pflash,format=raw",
+                                   bootpath);
+        }
     } else {
         g_assert_not_reached();
     }
 
+    if (incoming)
+        g_string_append_printf(cmd_dst, " -incoming %s", uri);
+
     g_free(bootpath);
 
     *from = qtest_start(cmd_src);
     g_free(cmd_src);
 
-    *to = qtest_init(cmd_dst);
-    g_free(cmd_dst);
+    *to = qtest_init(cmd_dst->str);
+    g_string_free(cmd_dst, TRUE);
 }
 
 static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
@@ -518,7 +537,7 @@ static void test_migrate(void)
     char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    test_migrate_start(&from, &to, uri);
+    test_migrate_start(&from, &to, uri, TRUE);
 
     migrate_set_capability(from, "postcopy-ram", "true");
     migrate_set_capability(to, "postcopy-ram", "true");
@@ -531,9 +550,9 @@ static void test_migrate(void)
     migrate_set_parameter(from, "downtime-limit", "1");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial("src_serial", FALSE);
 
-    migrate(from, uri);
+    migrate(from, uri, FALSE);
 
     wait_for_migration_pass(from);
 
@@ -545,7 +564,7 @@ static void test_migrate(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial("dest_serial", TRUE);
     wait_for_migration_complete(from);
 
     g_free(uri);
@@ -560,8 +579,8 @@ static void test_baddest(void)
     const char *status;
     bool failed;
 
-    test_migrate_start(&from, &to, "tcp:0:0");
-    migrate(from, "tcp:0:0");
+    test_migrate_start(&from, &to, "tcp:0:0", TRUE);
+    migrate(from, "tcp:0:0", FALSE);
     do {
         rsp = wait_command(from, "{ 'execute': 'query-migrate' }");
         rsp_return = qdict_get_qdict(rsp, "return");
@@ -584,6 +603,43 @@ static void test_baddest(void)
     test_migrate_end(from, to, false);
 }
 
+static void test_migrate_to_used(void)
+{
+    char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+
+    test_migrate_start(&from, &to, uri, FALSE);
+
+    migrate_set_capability(from, "postcopy-ram", "true");
+    migrate_set_capability(to, "postcopy-ram", "true");
+
+    migrate_set_parameter(from, "max-bandwidth", "100000000");
+    migrate_set_parameter(from, "downtime-limit", "1");
+
+    wait_for_serial("dest_serial", FALSE);
+    migrate(to, uri, TRUE);
+
+    wait_for_serial("src_serial", FALSE);
+    migrate(from, uri, FALSE);
+
+    wait_for_migration_pass(from);
+
+    migrate_start_postcopy(from);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial", TRUE);
+    wait_for_migration_complete(from);
+
+    g_free(uri);
+
+    test_migrate_end(from, to, true);
+}
+
 int main(int argc, char **argv)
 {
     char template[] = "/tmp/migration-test-XXXXXX";
@@ -604,6 +660,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     qtest_add_func("/migration/postcopy/unix", test_migrate);
+    qtest_add_func("/migration/postcopy/to_used", test_migrate_to_used);
     qtest_add_func("/migration/deprecated", test_deprecated);
     qtest_add_func("/migration/bad_dest", test_baddest);
 
-- 
2.16.2

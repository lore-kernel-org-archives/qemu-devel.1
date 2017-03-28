Received: from eggs.gnu.org ([2001:4830:134:3::10]:40455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst35-0007lz-4H
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cst33-00076d-SC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cst33-000768-Jv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5E655A5D
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 15:28:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 28 Mar 2017 16:27:45 +0100
Message-Id: <20170328152745.28186-7-dgilbert@redhat.com>
In-Reply-To: <20170328152745.28186-1-dgilbert@redhat.com>
References: <20170328152745.28186-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] migration/announce: Add test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: kashyap@redhat.com, germano@redhat.com, armbru@redhat.com, jasowang@redhat.com, jdenemar@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a test for the basic RARP announce.
Testing the ARP would need a reasonably complex guest.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/Makefile.include |   2 +
 tests/announce-test.c  | 165 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 tests/announce-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f3de81f..460223b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -258,6 +258,7 @@ endif
 check-qtest-i386-y += tests/test-netfilter$(EXESUF)
 check-qtest-i386-y += tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-y += tests/test-filter-redirector$(EXESUF)
+check-qtest-i386-y += tests/announce-test$(EXESUF)
 check-qtest-i386-y += tests/postcopy-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
@@ -285,6 +286,7 @@ check-qtest-ppc64-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-ppc64-y += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/drive_del-test$(EXESUF)
+check-qtest-ppc64-y += tests/announce-test$(EXESUF)
 check-qtest-ppc64-y += tests/postcopy-test$(EXESUF)
 check-qtest-ppc64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-ppc64-y += tests/rtas-test$(EXESUF)
diff --git a/tests/announce-test.c b/tests/announce-test.c
new file mode 100644
index 0000000..042d091
--- /dev/null
+++ b/tests/announce-test.c
@@ -0,0 +1,165 @@
+/*
+ * QTest testcase for migration announce packets
+ *
+ * Copyright (c) 2017 Red Hat, Inc. and/or its affiliates
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qemu/option.h"
+#include "qemu/range.h"
+#include "qemu/sockets.h"
+#include "sysemu/char.h"
+#include "sysemu/sysemu.h"
+
+static const char *tmpfs;
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+static QDict *return_or_event(QDict *response)
+{
+    if (!qdict_haskey(response, "event")) {
+        return response;
+    }
+
+    /* OK, it was an event */
+    QDECREF(response);
+    return return_or_event(qtest_qmp_receive(global_qtest));
+}
+
+
+static void wait_for_migration_complete(void)
+{
+    QDict *rsp, *rsp_return;
+    bool completed;
+
+    do {
+        const char *status;
+
+        rsp = return_or_event(qmp("{ 'execute': 'query-migrate' }"));
+        rsp_return = qdict_get_qdict(rsp, "return");
+        status = qdict_get_str(rsp_return, "status");
+        completed = strcmp(status, "completed") == 0;
+        g_assert_cmpstr(status, !=,  "failed");
+        QDECREF(rsp);
+        usleep(1000 * 100);
+    } while (!completed);
+}
+
+static void cleanup(const char *filename)
+{
+    char *path = g_strdup_printf("%s/%s", tmpfs, filename);
+
+    unlink(path);
+    g_free(path);
+}
+
+static void test_migrate(void)
+{
+    QTestState *global = global_qtest, *from, *to;
+    gchar *cmd, *cmd_dst;
+    QDict *rsp;
+    struct stat packet_stat;
+    char *migpath = g_strdup_printf("%s/migstream", tmpfs);
+    char *packetpath = g_strdup_printf("%s/packets", tmpfs);
+
+    from = qtest_start("-m 2M -name source,debug-threads=on "
+                       "-nographic -nodefaults "
+                      "-netdev user,id=netuser "
+                       " -device e1000,netdev=netuser,mac=00:11:22:33:44:55");
+
+    global_qtest = from;
+    cmd = g_strdup_printf("{ 'execute': 'migrate',"
+                          "'arguments': { 'uri': 'exec:cat > %s' } }",
+                          migpath);
+    rsp = qmp(cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    wait_for_migration_complete();
+
+    cmd_dst = g_strdup_printf("-m 2M -name dest,debug-threads=on "
+                      "-nographic -nodefaults "
+                      "-netdev user,id=netuser "
+                      "-object filter-dump,id=dump,netdev=netuser,file=%s "
+                      "-device e1000,netdev=netuser,mac=00:11:22:33:44:55 "
+                      " -incoming defer",
+                      packetpath);
+
+    to = qtest_start(cmd_dst);
+    g_free(cmd_dst);
+
+    rsp = qmp("{ 'execute': 'migrate-set-parameters',"
+                  "'arguments': { "
+                      " 'announce-rounds': 6, "
+                      " 'announce-initial': 10, "
+                      " 'announce-max': 100, "
+                      " 'announce-step': 40 } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    cmd_dst = g_strdup_printf("{ 'execute': 'migrate-incoming',"
+                  "'arguments': { 'uri': 'exec:cat %s' } }",
+                  migpath);
+    rsp = return_or_event(qmp(cmd_dst));
+    g_free(cmd_dst);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+
+    qmp_eventwait("RESUME");
+
+    /* Sleep for a while to let that announce happens,
+     * it should be <p> 10ms <p> 50ms <p> 90ms <p> 100ms <p> 100ms <p>
+     * so that's at least 350ms but lets assume we're on a bit of a
+     * loaded host and give it a bit longer
+     */
+    sleep(2);
+    qtest_quit(from);
+    qtest_quit(to);
+
+    g_assert_cmpint(stat(packetpath, &packet_stat), ==, 0);
+    /* 480 bytes for 6 packets */
+    g_assert_cmpint(packet_stat.st_size, ==, 480);
+
+    global_qtest = global;
+
+    cleanup("packetpath");
+    cleanup("migpath");
+}
+
+int main(int argc, char **argv)
+{
+    char template[] = "/tmp/announce-test-XXXXXX";
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    tmpfs = mkdtemp(template);
+    if (!tmpfs) {
+        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
+    }
+    g_assert(tmpfs);
+
+    module_call_init(MODULE_INIT_QOM);
+
+    qtest_add_func("/announce", test_migrate);
+
+    ret = g_test_run();
+
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = rmdir(tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s\n",
+                       tmpfs, strerror(errno));
+    }
+
+    return ret;
+}
-- 
2.9.3

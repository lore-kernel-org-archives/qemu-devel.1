Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richiejp@f-m.fm>) id 1eYA0F-0005ut-Kf
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richiejp@f-m.fm>) id 1eYA0C-0006tt-Eo
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:24:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richiejp@f-m.fm>) id 1eYA0C-0006ss-7E
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:24:36 -0500
From: Richard Palethorpe <richiejp@f-m.fm>
Date: Sun,  7 Jan 2018 13:23:36 +0100
Message-Id: <20180107122336.29333-2-richiejp@f-m.fm>
In-Reply-To: <20180107122336.29333-1-richiejp@f-m.fm>
References: <20180107122336.29333-1-richiejp@f-m.fm>
Subject: [Qemu-devel] [PATCH 2/2] Add test cases for saving,
 loading and deleting snapshots using QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com, rpalethorpe@suse.com, Richard Palethorpe <richiejp@f-m.fm>

Signed-off-by: Richard Palethorpe <richiejp@f-m.fm>
---
 tests/.gitignore       |  1 +
 tests/Makefile.include |  2 ++
 tests/test-snapshot.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 tests/test-snapshot.c

diff --git a/tests/.gitignore b/tests/.gitignore
index 74e55d7264..9b5ab4a9be 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -80,6 +80,7 @@ test-qobject-output-visitor
 test-rcu-list
 test-replication
 test-shift128
+test-snapshot
 test-string-input-visitor
 test-string-output-visitor
 test-thread-pool
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 77f8183117..754728e975 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -376,6 +376,7 @@ check-qtest-s390x-y += tests/virtio-serial-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
+check-qtest-generic-y += tests/test-snapshot$(EXESUF)
 
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
@@ -809,6 +810,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
+tests/test-snapshot$(EXESUF): tests/test-snapshot.o $(libqos-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/test-snapshot.c b/tests/test-snapshot.c
new file mode 100644
index 0000000000..3b33f94fd2
--- /dev/null
+++ b/tests/test-snapshot.c
@@ -0,0 +1,93 @@
+/*
+ * QTest testcase for loading, saving and deleting snapshots
+ *
+ * Copyright (c) 2017 Richard Palethorpe <richiejp@f-m.fm>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/libqos.h"
+
+#define SS_EXEC_FMT "{ 'execute': '%s', 'arguments': { 'name': '%s' } }"
+
+static void ss_op(const char *op, const char *name)
+{
+    char *qmp_cmd = NULL;
+
+    qmp_cmd = g_strdup_printf(SS_EXEC_FMT, op, name);
+    qmp_async(qmp_cmd);
+    g_free(qmp_cmd);
+}
+
+static void save_snapshot(void)
+{
+    QDict *rsp;
+
+    ss_op("save-snapshot", "test");
+    qmp_eventwait("STOP");
+    qmp_eventwait("RESUME");
+    rsp = qmp_receive();
+    g_assert(!qdict_haskey(rsp, "error"));
+    QDECREF(rsp);
+}
+
+static void load_snapshot(void)
+{
+    QDict *rsp;
+
+    ss_op("load-snapshot", "test");
+    qmp_eventwait("STOP");
+    qmp_eventwait("RESUME");
+    rsp = qmp_receive();
+    g_assert(!qdict_haskey(rsp, "error"));
+    QDECREF(rsp);
+
+    ss_op("load-snapshot", "does-not-exist");
+    qmp_eventwait("STOP");
+    rsp = qmp_receive();
+    g_assert(qdict_haskey(rsp, "error"));
+    QDECREF(rsp);
+}
+
+static void delete_snapshot(void)
+{
+    QDict *rsp;
+
+    ss_op("delete-snapshot", "test");
+    rsp = qmp_receive();
+    g_assert(!qdict_haskey(rsp, "error"));
+    QDECREF(rsp);
+}
+
+int main(int argc, char **argv)
+{
+    char timg[] = "/tmp/qtest-snapshot.XXXXXX";
+    int ret, fd;
+
+    if (!have_qemu_img()) {
+        g_test_message("QTEST_QEMU_IMG not set or qemu-img missing");
+        return 0;
+    }
+
+    fd = mkstemp(timg);
+    g_assert(fd >= 0);
+    mkqcow2(timg, 11);
+    close(fd);
+
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/snapshot/save", save_snapshot);
+    qtest_add_func("/snapshot/load", load_snapshot);
+    qtest_add_func("/snapshot/delete", delete_snapshot);
+
+    global_qtest = qtest_start(timg);
+    ret = g_test_run();
+
+    qtest_end();
+
+    unlink(timg);
+
+    return ret;
+}
-- 
2.15.1

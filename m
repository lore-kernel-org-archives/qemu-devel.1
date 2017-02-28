Received: from eggs.gnu.org ([2001:4830:134:3::10]:36339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIu-0007au-Cg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipIs-0000zc-Fc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:27:28 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:27:03 +0100
Message-Id: <1488317230-26248-18-git-send-email-armbru@redhat.com>
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/24] test-qapi-util: New,
 covering qapi/qapi-util.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/.gitignore       |  1 +
 tests/Makefile.include |  3 +++
 tests/test-qapi-util.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 tests/test-qapi-util.c

diff --git a/tests/.gitignore b/tests/.gitignore
index 30b7740..a966740 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -53,6 +53,7 @@ test-mul64
 test-opts-visitor
 test-qapi-event.[ch]
 test-qapi-types.[ch]
+test-qapi-util
 test-qapi-visit.[ch]
 test-qdev-global-props
 test-qemu-opts
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e3b4f27..4b09fcd 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -128,6 +128,8 @@ gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
+check-unit-y += tests/test-qapi-util$(EXESUF)
+gcov-files-test-qapi-util-y = qapi/qapi-util.c
 
 check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 
@@ -732,6 +734,7 @@ tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libvhost-user/libvhost-user.o $(test-util-obj-y)
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
+tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/test-qapi-util.c b/tests/test-qapi-util.c
new file mode 100644
index 0000000..39db8bf
--- /dev/null
+++ b/tests/test-qapi-util.c
@@ -0,0 +1,51 @@
+/*
+ * Unit tests for QAPI utility functions
+ *
+ * Copyright (C) 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/util.h"
+#include "test-qapi-types.h"
+
+static void test_qapi_enum_parse(void)
+{
+    Error *err = NULL;
+    int ret;
+
+    ret = qapi_enum_parse(QType_lookup, NULL, QTYPE__MAX, QTYPE_NONE,
+                          &error_abort);
+    g_assert_cmpint(ret, ==, QTYPE_NONE);
+
+    ret = qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
+                          NULL);
+    g_assert_cmpint(ret, ==, -1);
+
+    ret = qapi_enum_parse(QType_lookup, "junk", QTYPE__MAX, -1,
+                          &err);
+    error_free_or_abort(&err);
+
+    ret = qapi_enum_parse(QType_lookup, "none", QTYPE__MAX, -1,
+                          &error_abort);
+    g_assert_cmpint(ret, ==, QTYPE_NONE);
+
+    ret = qapi_enum_parse(QType_lookup, QType_lookup[QTYPE__MAX - 1],
+                          QTYPE__MAX, QTYPE__MAX - 1,
+                          &error_abort);
+    g_assert_cmpint(ret, ==, QTYPE__MAX - 1);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/qapi/util/qapi_enum_parse", test_qapi_enum_parse);
+    g_test_run();
+    return 0;
+}
-- 
2.7.4

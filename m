Received: from eggs.gnu.org ([2001:4830:134:3::10]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkE-0003cy-Js
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilkB-0005PQ-Ep
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilkB-0005Oy-6c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:23 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 427F7C054939
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:39:23 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 18:38:57 +0100
Message-Id: <1488303560-18803-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1488303560-18803-1-git-send-email-armbru@redhat.com>
References: <1488303560-18803-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/26] qmp-test: New,
 covering basic QMP protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 MAINTAINERS            |   1 +
 tests/Makefile.include |   5 +-
 tests/libqtest.c       |  17 ++++--
 tests/libqtest.h       |   8 +++
 tests/qmp-test.c       | 139 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 6 deletions(-)
 create mode 100644 tests/qmp-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index be79f68..d0ded4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1393,6 +1393,7 @@ F: qmp.c
 F: monitor.c
 F: docs/*qmp-*
 F: scripts/qmp/
+F: tests/qmp-test.c
 T: git git://repo.or.cz/qemu/armbru.git qapi-next
 
 Register API
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e60bb6c..b212150 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -133,7 +133,9 @@ check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
 
-check-qtest-generic-y = tests/device-introspect-test$(EXESUF)
+check-qtest-generic-y = tests/qmp-test$(EXESUF)
+gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
+check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 gcov-files-generic-y = qdev-monitor.c qmp.c
 
 gcov-files-ipack-y += hw/ipack/ipack.c
@@ -654,6 +656,7 @@ libqos-imx-obj-y = $(libqos-obj-y) tests/libqos/i2c-imx.o
 libqos-usb-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/usb.o
 libqos-virtio-obj-y = $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos/virtio.o tests/libqos/virtio-pci.o tests/libqos/virtio-mmio.o tests/libqos/malloc-generic.o
 
+tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
diff --git a/tests/libqtest.c b/tests/libqtest.c
index ad23ce9..cf27afc 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -149,7 +149,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data)
     g_hook_prepend(&abrt_hooks, hook);
 }
 
-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -204,10 +204,6 @@ QTestState *qtest_init(const char *extra_args)
         s->irq_level[i] = false;
     }
 
-    /* Read the QMP greeting and then do the handshake */
-    qtest_qmp_discard_response(s, "");
-    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
-
     if (getenv("QTEST_STOP")) {
         kill(s->qemu_pid, SIGSTOP);
     }
@@ -219,6 +215,17 @@ QTestState *qtest_init(const char *extra_args)
     return s;
 }
 
+QTestState *qtest_init(const char *extra_args)
+{
+    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+
+    /* Read the QMP greeting and then do the handshake */
+    qtest_qmp_discard_response(s, "");
+    qtest_qmp_discard_response(s, "{ 'execute': 'qmp_capabilities' }");
+
+    return s;
+}
+
 void qtest_quit(QTestState *s)
 {
     qtest_instances = g_list_remove(qtest_instances, s);
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 90f182e..2c9962d 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -32,6 +32,14 @@ extern QTestState *global_qtest;
 QTestState *qtest_init(const char *extra_args);
 
 /**
+ * qtest_init_without_qmp_handshake:
+ * @extra_args: other arguments to pass to QEMU.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
+
+/**
  * qtest_quit:
  * @s: #QTestState instance to operate on.
  *
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
new file mode 100644
index 0000000..405e49e
--- /dev/null
+++ b/tests/qmp-test.c
@@ -0,0 +1,139 @@
+/*
+ * QMP protocol test cases
+ *
+ * Copyright (c) 2017 Red Hat Inc.
+ *
+ * Authors:
+ *  Markus Armbruster <armbru@redhat.com>,
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qapi-visit.h"
+#include "qapi/error.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/visitor.h"
+
+const char common_args[] = "-nodefaults -machine none";
+
+static const char *get_error_class(QDict *resp)
+{
+    QDict *error = qdict_get_qdict(resp, "error");
+    const char *desc = qdict_get_try_str(error, "desc");
+
+    g_assert(desc);
+    return error ? qdict_get_try_str(error, "class") : NULL;
+}
+
+static void test_version(QObject *version)
+{
+    Visitor *v;
+    VersionInfo *vinfo;
+
+    g_assert(version);
+    v = qobject_input_visitor_new(version, true);
+    visit_type_VersionInfo(v, "version", &vinfo, &error_abort);
+    qapi_free_VersionInfo(vinfo);
+    visit_free(v);
+}
+
+static void test_malformed(void)
+{
+    QDict *resp;
+
+    /* Not even a dictionary */
+    resp = qmp("null");
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    QDECREF(resp);
+
+    /* No "execute" key */
+    resp = qmp("{}");
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    QDECREF(resp);
+
+    /* "execute" isn't a string */
+    resp = qmp("{ 'execute': true }");
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    QDECREF(resp);
+
+    /* "arguments" isn't a dictionary */
+    resp = qmp("{ 'execute': 'no-such-cmd', 'arguments': [] }");
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    QDECREF(resp);
+
+    /* extra key */
+    resp = qmp("{ 'execute': 'no-such-cmd', 'extra': true }");
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    QDECREF(resp);
+}
+
+static void test_qmp_protocol(void)
+{
+    QDict *resp, *q, *ret;
+    QList *capabilities;
+
+    global_qtest = qtest_init_without_qmp_handshake(common_args);
+
+    /* Test greeting */
+    resp = qmp_receive();
+    q = qdict_get_qdict(resp, "QMP");
+    g_assert(q);
+    test_version(qdict_get(q, "version"));
+    capabilities = qdict_get_qlist(q, "capabilities");
+    g_assert(capabilities && qlist_empty(capabilities));
+    QDECREF(resp);
+
+    /* Test valid command before handshake */
+    resp = qmp("{ 'execute': 'query-version' }");
+    g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
+    QDECREF(resp);
+
+    /* Test malformed commands before handshake */
+    test_malformed();
+
+    /* Test handshake */
+    resp = qmp("{ 'execute': 'qmp_capabilities' }");
+    ret = qdict_get_qdict(resp, "return");
+    g_assert(ret && !qdict_size(ret));
+    QDECREF(resp);
+
+    /* Test repeated handshake */
+    resp = qmp("{ 'execute': 'qmp_capabilities' }");
+    g_assert_cmpstr(get_error_class(resp), ==, "CommandNotFound");
+    QDECREF(resp);
+
+    /* Test valid command */
+    resp = qmp("{ 'execute': 'query-version' }");
+    test_version(qdict_get(resp, "return"));
+    QDECREF(resp);
+
+    /* Test malformed commands */
+    test_malformed();
+
+    /* Test 'id' */
+    resp = qmp("{ 'execute': 'query-name', 'id': 'cookie#1' }");
+    ret = qdict_get_qdict(resp, "return");
+    g_assert(ret);
+    g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
+    QDECREF(resp);
+
+    /* Test command failure with 'id' */
+    resp = qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
+    g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
+    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
+    QDECREF(resp);
+
+    qtest_end();
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("qmp/protocol", test_qmp_protocol);
+
+    return g_test_run();
+}
-- 
2.7.4

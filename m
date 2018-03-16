Received: from eggs.gnu.org ([2001:4830:134:3::10]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewyiJ-0008JK-IG
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 19:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewyiE-0003rh-NF
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 19:24:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58454
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ewyiE-0003qv-GF
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 19:24:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GNNndv112310
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 19:24:37 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2grhkg48jp-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 19:24:37 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 17:24:36 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 19:24:25 -0400
In-Reply-To: <1521242665-15807-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521242665-15807-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1521242665-15807-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5.1 for 2.13 4/4] tpm: Add test cases that
 uses the external swtpm with CRB interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Add a test program for testing the CRB with the external swtpm.

The 1st test case extends a PCR and reads back the value and compares
it against an expected return packet.

The 2nd test case repeats the 1st test case and then migrates the
external swtpm's state along with the VM state to a destination
QEMU and swtpm and checks that the PCR has the expected value now.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/Makefile.include     |   3 +
 tests/tpm-crb-swtpm-test.c | 244 +++++++++++++++++++++++++++++++++++++++++++++
 tests/tpm-util.c           | 135 +++++++++++++++++++++++++
 tests/tpm-util.h           |  36 +++++++
 4 files changed, 418 insertions(+)
 create mode 100644 tests/tpm-crb-swtpm-test.c
 create mode 100644 tests/tpm-util.c
 create mode 100644 tests/tpm-util.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 42fd426..bd4f56f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -297,6 +297,7 @@ check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EX
 ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
 check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
 endif
+check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) += tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) += tests/tpm-tis-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
@@ -719,6 +720,8 @@ tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
+tests/tpm-crb-swtpm-test$(EXESUF): tests/tpm-crb-swtpm-test.o tests/tpm-emu.o \
+	tests/tpm-util.o $(test-io-obj-y)
 tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test-io-obj-y)
 tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
diff --git a/tests/tpm-crb-swtpm-test.c b/tests/tpm-crb-swtpm-test.c
new file mode 100644
index 0000000..b2f6068
--- /dev/null
+++ b/tests/tpm-crb-swtpm-test.c
@@ -0,0 +1,244 @@
+/*
+ * QTest testcase for TPM CRB talking to external swtpm and swtpm migration
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *  with parts borrowed from migration-test.c that is:
+ *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "hw/acpi/tpm.h"
+#include "io/channel-socket.h"
+#include "libqtest.h"
+#include "tpm-util.h"
+#include "sysemu/tpm.h"
+#include "qapi/qmp/qdict.h"
+
+typedef struct TestState {
+    char *src_tpm_path;
+    char *dst_tpm_path;
+    char *uri;
+} TestState;
+
+bool got_stop;
+
+static void migrate(QTestState *who, const char *uri)
+{
+    QDict *rsp;
+    gchar *cmd;
+
+    cmd = g_strdup_printf("{ 'execute': 'migrate',"
+                          "'arguments': { 'uri': '%s' } }",
+                          uri);
+    rsp = qtest_qmp(who, cmd);
+    g_free(cmd);
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+}
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+static QDict *wait_command(QTestState *who, const char *command)
+{
+    const char *event_string;
+    QDict *response;
+
+    response = qtest_qmp(who, command);
+
+    while (qdict_haskey(response, "event")) {
+        /* OK, it was an event */
+        event_string = qdict_get_str(response, "event");
+        if (!strcmp(event_string, "STOP")) {
+            got_stop = true;
+        }
+        QDECREF(response);
+        response = qtest_qmp_receive(who);
+    }
+    return response;
+}
+
+static void wait_for_migration_complete(QTestState *who)
+{
+    while (true) {
+        QDict *rsp, *rsp_return;
+        bool completed;
+        const char *status;
+
+        rsp = wait_command(who, "{ 'execute': 'query-migrate' }");
+        rsp_return = qdict_get_qdict(rsp, "return");
+        status = qdict_get_str(rsp_return, "status");
+        completed = strcmp(status, "completed") == 0;
+        g_assert_cmpstr(status, !=,  "failed");
+        QDECREF(rsp);
+        if (completed) {
+            return;
+        }
+        usleep(1000);
+    }
+}
+
+static void migration_start_qemu(QTestState **src_qemu, QTestState **dst_qemu,
+                                 SocketAddress *src_tpm_addr,
+                                 SocketAddress *dst_tpm_addr,
+                                 const char *miguri)
+{
+    char *src_qemu_args, *dst_qemu_args;
+
+    src_qemu_args = g_strdup_printf(
+        "-chardev socket,id=chr,path=%s "
+        "-tpmdev emulator,id=dev,chardev=chr "
+        "-device tpm-crb,tpmdev=dev ",
+        src_tpm_addr->u.q_unix.path);
+
+    *src_qemu = qtest_init(src_qemu_args);
+
+    dst_qemu_args = g_strdup_printf(
+        "-chardev socket,id=chr,path=%s "
+        "-tpmdev emulator,id=dev,chardev=chr "
+        "-device tpm-crb,tpmdev=dev "
+        "-incoming %s",
+        dst_tpm_addr->u.q_unix.path,
+        miguri);
+
+    *dst_qemu = qtest_init(dst_qemu_args);
+
+    free(src_qemu_args);
+    free(dst_qemu_args);
+}
+static void tpm_crb_swtpm_test(const void *data)
+{
+    char *args = NULL;
+    QTestState *s;
+    SocketAddress *addr = NULL;
+    gboolean succ;
+    GPid swtpm_pid;
+    GError *error = NULL;
+    const TestState *ts = data;
+
+    succ = tpm_util_swtpm_start(ts->src_tpm_path, &swtpm_pid, &addr, &error);
+    /* succ may be false if swtpm is not available */
+    if (!succ) {
+        return;
+    }
+
+    args = g_strdup_printf(
+        "-chardev socket,id=chr,path=%s "
+        "-tpmdev emulator,id=dev,chardev=chr "
+        "-device tpm-crb,tpmdev=dev",
+        addr->u.q_unix.path);
+
+    s = qtest_start(args);
+
+    tpm_util_startup(s, tpm_util_crb_transfer);
+    tpm_util_pcrextend(s, tpm_util_crb_transfer);
+
+    unsigned char tpm_pcrread_resp[] =
+        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
+        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
+        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
+        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
+    tpm_util_pcrread(s, tpm_util_crb_transfer, tpm_pcrread_resp,
+                     sizeof(tpm_pcrread_resp));
+
+    qtest_end();
+    tpm_util_swtpm_kill(swtpm_pid);
+
+    if (addr) {
+        g_unlink(addr->u.q_unix.path);
+        qapi_free_SocketAddress(addr);
+    }
+}
+
+static void tpm_crb_swtpm_migration_test(const void *data)
+{
+    const TestState *ts = data;
+    gboolean succ;
+    GPid src_tpm_pid, dst_tpm_pid;
+    SocketAddress *src_tpm_addr = NULL, *dst_tpm_addr = NULL;
+    GError *error = NULL;
+    QTestState *src_qemu, *dst_qemu;
+
+    succ = tpm_util_swtpm_start(ts->src_tpm_path, &src_tpm_pid,
+                                &src_tpm_addr, &error);
+    /* succ may be false if swtpm is not available */
+    if (!succ) {
+        return;
+    }
+
+    succ = tpm_util_swtpm_start(ts->dst_tpm_path, &dst_tpm_pid,
+                                &dst_tpm_addr, &error);
+    /* succ may be false if swtpm is not available */
+    if (!succ) {
+        goto err_src_tpm_kill;
+    }
+
+    migration_start_qemu(&src_qemu, &dst_qemu, src_tpm_addr, dst_tpm_addr,
+                         ts->uri);
+
+    tpm_util_startup(src_qemu, tpm_util_crb_transfer);
+    tpm_util_pcrextend(src_qemu, tpm_util_crb_transfer);
+
+    unsigned char tpm_pcrread_resp[] =
+        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
+        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
+        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
+        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
+    tpm_util_pcrread(src_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
+                     sizeof(tpm_pcrread_resp));
+
+    migrate(src_qemu, ts->uri);
+    wait_for_migration_complete(src_qemu);
+
+    tpm_util_pcrread(dst_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
+                     sizeof(tpm_pcrread_resp));
+
+    qtest_quit(dst_qemu);
+    qtest_quit(src_qemu);
+
+    tpm_util_swtpm_kill(dst_tpm_pid);
+    if (dst_tpm_addr) {
+        g_unlink(dst_tpm_addr->u.q_unix.path);
+        qapi_free_SocketAddress(dst_tpm_addr);
+    }
+
+err_src_tpm_kill:
+    tpm_util_swtpm_kill(src_tpm_pid);
+    if (src_tpm_addr) {
+        g_unlink(src_tpm_addr->u.q_unix.path);
+        qapi_free_SocketAddress(src_tpm_addr);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    TestState ts = { 0 };
+
+    ts.src_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
+    ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-crb-swtpm-test.XXXXXX", NULL);
+    ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/tpm/crb-swtpm/test", &ts, tpm_crb_swtpm_test);
+    qtest_add_data_func("/tpm/crb-swtpm-migration/test", &ts,
+                        tpm_crb_swtpm_migration_test);
+    ret = g_test_run();
+
+    g_rmdir(ts.dst_tpm_path);
+    g_free(ts.dst_tpm_path);
+    g_rmdir(ts.src_tpm_path);
+    g_free(ts.src_tpm_path);
+
+    return ret;
+}
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
new file mode 100644
index 0000000..5a411e9
--- /dev/null
+++ b/tests/tpm-util.c
@@ -0,0 +1,135 @@
+/*
+ * QTest TPM utilities
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/acpi/tpm.h"
+#include "libqtest.h"
+#include "tpm-util.h"
+
+void tpm_util_crb_transfer(QTestState *s,
+                           const unsigned char *req, size_t req_size,
+                           unsigned char *rsp, size_t rsp_size)
+{
+    uint64_t caddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
+    uint64_t raddr = qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+
+    qtest_memwrite(s, caddr, req, req_size);
+
+    uint32_t sts, start = 1;
+    uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+    qtest_writel(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
+    do {
+        start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
+        if ((start & 1) == 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+    start = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
+    g_assert_cmpint(start & 1, ==, 0);
+    sts = qtest_readl(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    g_assert_cmpint(sts & 1, ==, 0);
+
+    qtest_memread(s, raddr, rsp, rsp_size);
+}
+
+void tpm_util_startup(QTestState *s, tx_func *tx)
+{
+    unsigned char buffer[1024];
+    unsigned char tpm_startup[] =
+        "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
+    unsigned char tpm_startup_resp[] =
+        "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
+
+    tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
+
+    g_assert_cmpmem(buffer, sizeof(tpm_startup_resp),
+                    tpm_startup_resp, sizeof(tpm_startup_resp));
+}
+
+void tpm_util_pcrextend(QTestState *s, tx_func *tx)
+{
+    unsigned char buffer[1024];
+    unsigned char tpm_pcrextend[] =
+        "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
+        "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
+        "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+        "\x00";
+
+    unsigned char tpm_pcrextend_resp[] =
+        "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
+        "\x01\x00\x00";
+
+    tx(s, tpm_pcrextend, sizeof(tpm_pcrextend), buffer, sizeof(buffer));
+
+    g_assert_cmpmem(buffer, sizeof(tpm_pcrextend_resp),
+                    tpm_pcrextend_resp, sizeof(tpm_pcrextend_resp));
+}
+
+void tpm_util_pcrread(QTestState *s, tx_func *tx,
+                      const unsigned char *exp_resp, size_t exp_resp_size)
+{
+    unsigned char buffer[1024];
+    unsigned char tpm_pcrread[] =
+        "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
+        "\x03\x00\x04\x00";
+
+    tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
+
+    g_assert_cmpmem(buffer, exp_resp_size, exp_resp, exp_resp_size);
+}
+
+gboolean tpm_util_swtpm_start(const char *path, GPid *pid, SocketAddress **addr, GError **error)
+{
+    char *swtpm_argv_tpmstate = g_strdup_printf("dir=%s", path);
+    char *swtpm_argv_ctrl = g_strdup_printf("type=unixio,path=%s/sock",
+                                            path);
+    gchar *swtpm_argv[] = {
+        g_strdup("swtpm"), g_strdup("socket"),
+        g_strdup("--tpmstate"), swtpm_argv_tpmstate,
+        g_strdup("--ctrl"), swtpm_argv_ctrl,
+        g_strdup("--tpm2"),
+        NULL
+    };
+    gboolean succ;
+    unsigned i;
+
+    *addr = g_new0(SocketAddress, 1);
+    (*addr)->type = SOCKET_ADDRESS_TYPE_UNIX;
+    (*addr)->u.q_unix.path = g_build_filename(path, "sock", NULL);
+
+    succ = g_spawn_async(NULL, swtpm_argv, NULL, G_SPAWN_SEARCH_PATH,
+                         NULL, NULL, pid, error);
+
+    for (i = 0; swtpm_argv[i]; i++)
+        g_free(swtpm_argv[i]);
+
+    return succ;
+}
+
+void tpm_util_swtpm_kill(GPid pid)
+{
+    int n;
+
+    if (!pid)
+        return;
+
+    g_spawn_close_pid(pid);
+
+    n = kill(pid, 0);
+    if (n < 0) {
+        return;
+    }
+
+    kill(pid, SIGKILL);
+}
diff --git a/tests/tpm-util.h b/tests/tpm-util.h
new file mode 100644
index 0000000..d155d99
--- /dev/null
+++ b/tests/tpm-util.h
@@ -0,0 +1,36 @@
+/*
+ * QTest TPM utilities
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TESTS_TPM_UTIL_H
+#define TESTS_TPM_UTIL_H
+
+#include "qemu/osdep.h"
+#include "io/channel-socket.h"
+
+typedef void (tx_func)(QTestState *s,
+                       const unsigned char *req, size_t req_size,
+                       unsigned char *rsp, size_t rsp_size);
+
+void tpm_util_crb_transfer(QTestState *s,
+                           const unsigned char *req, size_t req_size,
+                           unsigned char *rsp, size_t rsp_size);
+
+void tpm_util_startup(QTestState *s, tx_func *tx);
+void tpm_util_pcrextend(QTestState *s, tx_func *tx);
+void tpm_util_pcrread(QTestState *s, tx_func *tx,
+                      const unsigned char *exp_resp, size_t exp_resp_size);
+
+gboolean tpm_util_swtpm_start(const char *path, GPid *pid,
+                              SocketAddress **addr, GError **error);
+void tpm_util_swtpm_kill(GPid pid);
+
+#endif /* TESTS_TPM_UTIL_H */
-- 
2.5.5

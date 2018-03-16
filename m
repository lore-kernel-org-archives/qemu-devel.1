Received: from eggs.gnu.org ([2001:4830:134:3::10]:36936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewxBd-000382-H0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewxBa-0003ax-Cz
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48308
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ewxBa-0003aY-6p
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GLiVOb095080
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:46:49 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grkejdj12-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:46:48 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 15:46:48 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 17:46:36 -0400
In-Reply-To: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1521236796-24551-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 for 2.13 4/4] tpm: Add test cases that uses
 the external swtpm with CRB interface
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
 tests/tpm-crb-swtpm-test.c | 243 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+)
 create mode 100644 tests/tpm-crb-swtpm-test.c

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
index 0000000..844d52d
--- /dev/null
+++ b/tests/tpm-crb-swtpm-test.c
@@ -0,0 +1,243 @@
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
+    g_assert_cmpint(succ, !=, false);
+    if (!succ) {
+        return;
+    }
+
+    succ = tpm_util_swtpm_start(ts->dst_tpm_path, &dst_tpm_pid,
+                                &dst_tpm_addr, &error);
+    g_assert_cmpint(succ, !=, false);
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
-- 
2.5.5

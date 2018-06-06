Received: from eggs.gnu.org ([2001:4830:134:3::10]:49154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZf-0008By-0H
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZb-0002C5-S1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40906
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fQeZb-0002BX-L7
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:23 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w56JobC0059984
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 15:58:23 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jej41u9ew-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 15:58:22 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 6 Jun 2018 13:58:22 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  6 Jun 2018 15:58:05 -0400
In-Reply-To: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
References: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180606195805.185833-5-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 4/4] test: Add swtpm migration test for the
 TPM TIS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Add a test case for testing swtpm migration with the TPM TIS
interface.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include     |  3 +++
 tests/tpm-tis-swtpm-test.c | 66 ++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/tpm-util.c           | 48 +++++++++++++++++++++++++++++++++
 tests/tpm-util.h           |  3 +++
 4 files changed, 120 insertions(+)
 create mode 100644 tests/tpm-tis-swtpm-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 392273317f..0eaa835b8a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -299,6 +299,7 @@ check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_6=
4) +=3D tests/vhost-user-test
 endif
 check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-crb-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-crb-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-tis-swtpm-test$(EXESUF)
 check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-tis-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
@@ -726,6 +727,8 @@ tests/test-io-channel-socket$(EXESUF): tests/test-io-=
channel-socket.o \
 tests/tpm-crb-swtpm-test$(EXESUF): tests/tpm-crb-swtpm-test.o tests/tpm-=
emu.o \
 	tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
 tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test=
-io-obj-y)
+tests/tpm-tis-swtpm-test$(EXESUF): tests/tpm-tis-swtpm-test.o tests/tpm-=
emu.o \
+	tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
 tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test=
-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
diff --git a/tests/tpm-tis-swtpm-test.c b/tests/tpm-tis-swtpm-test.c
new file mode 100644
index 0000000000..7dcd1d3912
--- /dev/null
+++ b/tests/tpm-tis-swtpm-test.c
@@ -0,0 +1,66 @@
+/*
+ * QTest testcase for TPM TIS talking to external swtpm and swtpm migrat=
ion
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *  with parts borrowed from migration-test.c that is:
+ *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "libqtest.h"
+#include "tpm-tests.h"
+
+typedef struct TestState {
+    char *src_tpm_path;
+    char *dst_tpm_path;
+    char *uri;
+} TestState;
+
+static void tpm_tis_swtpm_test(const void *data)
+{
+    const TestState *ts =3D data;
+
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_tis_transfer, "tpm-ti=
s");
+}
+
+static void tpm_tis_swtpm_migration_test(const void *data)
+{
+    const TestState *ts =3D data;
+
+    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts=
->uri,
+                                  tpm_util_tis_transfer, "tpm-tis");
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    TestState ts =3D { 0 };
+
+    ts.src_tpm_path =3D g_dir_make_tmp("qemu-tpm-tis-swtpm-test.XXXXXX",=
 NULL);
+    ts.dst_tpm_path =3D g_dir_make_tmp("qemu-tpm-tis-swtpm-test.XXXXXX",=
 NULL);
+    ts.uri =3D g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
+                        tpm_tis_swtpm_migration_test);
+    ret =3D g_test_run();
+
+    g_rmdir(ts.dst_tpm_path);
+    g_free(ts.dst_tpm_path);
+    g_rmdir(ts.src_tpm_path);
+    g_free(ts.src_tpm_path);
+    g_free(ts.uri);
+
+    return ret;
+}
diff --git a/tests/tpm-util.c b/tests/tpm-util.c
index e1ac4d1bd5..672cedf905 100644
--- a/tests/tpm-util.c
+++ b/tests/tpm-util.c
@@ -19,6 +19,9 @@
 #include "tpm-util.h"
 #include "qapi/qmp/qdict.h"
=20
+#define TIS_REG(LOCTY, REG) \
+    (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
+
 static bool got_stop;
=20
 void tpm_util_crb_transfer(QTestState *s,
@@ -52,6 +55,51 @@ void tpm_util_crb_transfer(QTestState *s,
     qtest_memread(s, raddr, rsp, rsp_size);
 }
=20
+void tpm_util_tis_transfer(QTestState *s,
+                           const unsigned char *req, size_t req_size,
+                           unsigned char *rsp, size_t rsp_size)
+{
+    uint32_t sts;
+    uint16_t bcount;
+    size_t i;
+
+    /* request use of locality 0 */
+    qtest_writeb(s, TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUE=
ST_USE);
+    qtest_writel(s, TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_COMMAND_REA=
DY);
+
+    sts =3D qtest_readl(s, TIS_REG(0, TPM_TIS_REG_STS));
+    bcount =3D (sts >> 8) & 0xffff;
+    g_assert_cmpint(bcount, >=3D, req_size);
+
+    /* transmit command */
+    for (i =3D 0; i < req_size; i++) {
+        qtest_writeb(s, TIS_REG(0, TPM_TIS_REG_DATA_FIFO), req[i]);
+    }
+
+    /* start processing */
+    qtest_writeb(s, TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_TPM_GO);
+
+    uint64_t end_time =3D g_get_monotonic_time() + 50 * G_TIME_SPAN_SECO=
ND;
+    do {
+        sts =3D qtest_readl(s, TIS_REG(0, TPM_TIS_REG_STS));
+        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) !=3D 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+
+    sts =3D qtest_readl(s, TIS_REG(0, TPM_TIS_REG_STS));
+    bcount =3D (sts >> 8) & 0xffff;
+
+    memset(rsp, 0, rsp_size);
+    for (i =3D 0; i < bcount; i++) {
+        rsp[i] =3D qtest_readb(s, TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
+    }
+
+    /* relinquish use of locality 0 */
+    qtest_writeb(s, TIS_REG(0, TPM_TIS_REG_ACCESS),
+                 TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+}
+
 void tpm_util_startup(QTestState *s, tx_func *tx)
 {
     unsigned char buffer[1024];
diff --git a/tests/tpm-util.h b/tests/tpm-util.h
index bb128360dd..330b9657fe 100644
--- a/tests/tpm-util.h
+++ b/tests/tpm-util.h
@@ -23,6 +23,9 @@ typedef void (tx_func)(QTestState *s,
 void tpm_util_crb_transfer(QTestState *s,
                            const unsigned char *req, size_t req_size,
                            unsigned char *rsp, size_t rsp_size);
+void tpm_util_tis_transfer(QTestState *s,
+                           const unsigned char *req, size_t req_size,
+                           unsigned char *rsp, size_t rsp_size);
=20
 void tpm_util_startup(QTestState *s, tx_func *tx);
 void tpm_util_pcrextend(QTestState *s, tx_func *tx);
--=20
2.14.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZb-00089Z-NH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fQeZY-000293-H6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45946
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fQeZY-00028I-8n
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:58:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w56Jmrbo000731
	for <qemu-devel@nongnu.org>; Wed, 6 Jun 2018 15:58:19 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jek4vgquq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 15:58:19 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 6 Jun 2018 13:58:18 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  6 Jun 2018 15:58:03 -0400
In-Reply-To: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
References: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180606195805.185833-3-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 2/4] test: Move common TPM test functions to
 tpm-tests.c
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

Move common TPM test functions from tpm-crb-swtpm-test.c to tpm-tests.c
so that for example test cases with the TPM TIS interface can use the
same code. Prefix all funcions with 'tpm_test_'.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include     |   2 +-
 tests/tpm-crb-swtpm-test.c |  99 ++----------------------------------
 tests/tpm-tests.c          | 124 +++++++++++++++++++++++++++++++++++++++=
++++++
 tests/tpm-tests.h          |  24 +++++++++
 4 files changed, 153 insertions(+), 96 deletions(-)
 create mode 100644 tests/tpm-tests.c
 create mode 100644 tests/tpm-tests.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9854e7794b..392273317f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -724,7 +724,7 @@ tests/test-io-task$(EXESUF): tests/test-io-task.o $(t=
est-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
 tests/tpm-crb-swtpm-test$(EXESUF): tests/tpm-crb-swtpm-test.o tests/tpm-=
emu.o \
-	tests/tpm-util.o $(test-io-obj-y)
+	tests/tpm-util.o tests/tpm-tests.o $(test-io-obj-y)
 tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test=
-io-obj-y)
 tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test=
-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
diff --git a/tests/tpm-crb-swtpm-test.c b/tests/tpm-crb-swtpm-test.c
index 2a22b032ca..4acffff568 100644
--- a/tests/tpm-crb-swtpm-test.c
+++ b/tests/tpm-crb-swtpm-test.c
@@ -16,7 +16,7 @@
 #include <glib/gstdio.h>
=20
 #include "libqtest.h"
-#include "tpm-util.h"
+#include "tpm-tests.h"
=20
 typedef struct TestState {
     char *src_tpm_path;
@@ -26,108 +26,17 @@ typedef struct TestState {
=20
 static void tpm_crb_swtpm_test(const void *data)
 {
-    char *args =3D NULL;
-    QTestState *s;
-    SocketAddress *addr =3D NULL;
-    gboolean succ;
-    GPid swtpm_pid;
-    GError *error =3D NULL;
     const TestState *ts =3D data;
=20
-    succ =3D tpm_util_swtpm_start(ts->src_tpm_path, &swtpm_pid, &addr, &=
error);
-    /* succ may be false if swtpm is not available */
-    if (!succ) {
-        return;
-    }
-
-    args =3D g_strdup_printf(
-        "-chardev socket,id=3Dchr,path=3D%s "
-        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
-        "-device tpm-crb,tpmdev=3Ddev",
-        addr->u.q_unix.path);
-
-    s =3D qtest_start(args);
-    g_free(args);
-
-    tpm_util_startup(s, tpm_util_crb_transfer);
-    tpm_util_pcrextend(s, tpm_util_crb_transfer);
-
-    unsigned char tpm_pcrread_resp[] =3D
-        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
-        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
-        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
-        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
-    tpm_util_pcrread(s, tpm_util_crb_transfer, tpm_pcrread_resp,
-                     sizeof(tpm_pcrread_resp));
-
-    qtest_end();
-    tpm_util_swtpm_kill(swtpm_pid);
-
-    if (addr) {
-        g_unlink(addr->u.q_unix.path);
-        qapi_free_SocketAddress(addr);
-    }
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_util_crb_transfer);
 }
=20
 static void tpm_crb_swtpm_migration_test(const void *data)
 {
     const TestState *ts =3D data;
-    gboolean succ;
-    GPid src_tpm_pid, dst_tpm_pid;
-    SocketAddress *src_tpm_addr =3D NULL, *dst_tpm_addr =3D NULL;
-    GError *error =3D NULL;
-    QTestState *src_qemu, *dst_qemu;
-
-    succ =3D tpm_util_swtpm_start(ts->src_tpm_path, &src_tpm_pid,
-                                &src_tpm_addr, &error);
-    /* succ may be false if swtpm is not available */
-    if (!succ) {
-        return;
-    }
-
-    succ =3D tpm_util_swtpm_start(ts->dst_tpm_path, &dst_tpm_pid,
-                                &dst_tpm_addr, &error);
-    /* succ may be false if swtpm is not available */
-    if (!succ) {
-        goto err_src_tpm_kill;
-    }
-
-    tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
-                                  src_tpm_addr, dst_tpm_addr,
-                                  ts->uri);
-
-    tpm_util_startup(src_qemu, tpm_util_crb_transfer);
-    tpm_util_pcrextend(src_qemu, tpm_util_crb_transfer);
-
-    unsigned char tpm_pcrread_resp[] =3D
-        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
-        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
-        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
-        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
-    tpm_util_pcrread(src_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
-                     sizeof(tpm_pcrread_resp));
-
-    tpm_util_migrate(src_qemu, ts->uri);
-    tpm_util_wait_for_migration_complete(src_qemu);
-
-    tpm_util_pcrread(dst_qemu, tpm_util_crb_transfer, tpm_pcrread_resp,
-                     sizeof(tpm_pcrread_resp));
-
-    qtest_quit(dst_qemu);
-    qtest_quit(src_qemu);
-
-    tpm_util_swtpm_kill(dst_tpm_pid);
-    if (dst_tpm_addr) {
-        g_unlink(dst_tpm_addr->u.q_unix.path);
-        qapi_free_SocketAddress(dst_tpm_addr);
-    }
=20
-err_src_tpm_kill:
-    tpm_util_swtpm_kill(src_tpm_pid);
-    if (src_tpm_addr) {
-        g_unlink(src_tpm_addr->u.q_unix.path);
-        qapi_free_SocketAddress(src_tpm_addr);
-    }
+    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path, ts=
->uri,
+                                  tpm_util_crb_transfer);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/tpm-tests.c b/tests/tpm-tests.c
new file mode 100644
index 0000000000..adf2c618c8
--- /dev/null
+++ b/tests/tpm-tests.c
@@ -0,0 +1,124 @@
+/*
+ * QTest TPM commont test code
+ *
+ * Copyright (c) 2018 IBM Corporation
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
+void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx)
+{
+    char *args =3D NULL;
+    QTestState *s;
+    SocketAddress *addr =3D NULL;
+    gboolean succ;
+    GPid swtpm_pid;
+    GError *error =3D NULL;
+
+    succ =3D tpm_util_swtpm_start(src_tpm_path, &swtpm_pid, &addr, &erro=
r);
+    /* succ may be false if swtpm is not available */
+    if (!succ) {
+        return;
+    }
+
+    args =3D g_strdup_printf(
+        "-chardev socket,id=3Dchr,path=3D%s "
+        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
+        "-device tpm-crb,tpmdev=3Ddev",
+        addr->u.q_unix.path);
+
+    s =3D qtest_start(args);
+    g_free(args);
+
+    tpm_util_startup(s, tx);
+    tpm_util_pcrextend(s, tx);
+
+    unsigned char tpm_pcrread_resp[] =3D
+        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
+        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
+        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
+        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
+    tpm_util_pcrread(s, tx, tpm_pcrread_resp,
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
+void tpm_test_swtpm_migration_test(const char *src_tpm_path,
+                                   const char *dst_tpm_path,
+                                   const char *uri, tx_func *tx)
+{
+    gboolean succ;
+    GPid src_tpm_pid, dst_tpm_pid;
+    SocketAddress *src_tpm_addr =3D NULL, *dst_tpm_addr =3D NULL;
+    GError *error =3D NULL;
+    QTestState *src_qemu, *dst_qemu;
+
+    succ =3D tpm_util_swtpm_start(src_tpm_path, &src_tpm_pid,
+                                &src_tpm_addr, &error);
+    /* succ may be false if swtpm is not available */
+    if (!succ) {
+        return;
+    }
+
+    succ =3D tpm_util_swtpm_start(dst_tpm_path, &dst_tpm_pid,
+                                &dst_tpm_addr, &error);
+    /* succ may be false if swtpm is not available */
+    if (!succ) {
+        goto err_src_tpm_kill;
+    }
+
+    tpm_util_migration_start_qemu(&src_qemu, &dst_qemu,
+                                  src_tpm_addr, dst_tpm_addr, uri);
+
+    tpm_util_startup(src_qemu, tx);
+    tpm_util_pcrextend(src_qemu, tx);
+
+    unsigned char tpm_pcrread_resp[] =3D
+        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x0=
0"
+        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x8=
5"
+        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x8=
9"
+        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
+    tpm_util_pcrread(src_qemu, tx, tpm_pcrread_resp,
+                     sizeof(tpm_pcrread_resp));
+
+    tpm_util_migrate(src_qemu, uri);
+    tpm_util_wait_for_migration_complete(src_qemu);
+
+    tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
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
diff --git a/tests/tpm-tests.h b/tests/tpm-tests.h
new file mode 100644
index 0000000000..377f184c77
--- /dev/null
+++ b/tests/tpm-tests.h
@@ -0,0 +1,24 @@
+/*
+ * QTest TPM commont test code
+ *
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TESTS_TPM_TESTS_H
+#define TESTS_TPM_TESTS_H
+
+#include "tpm-util.h"
+
+void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx);
+
+void tpm_test_swtpm_migration_test(const char *src_tpm_path,
+                                   const char *dst_tpm_path,
+                                   const char *uri, tx_func *tx);
+
+#endif /* TESTS_TPM_TESTS_H */
--=20
2.14.4

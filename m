Received: from eggs.gnu.org ([2001:4830:134:3::10]:45807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqfub-0005Ny-Pj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eqfuU-0002U1-Ru
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:07:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56754
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eqfuU-0002Tx-LH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:07:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RE3p7Z054962
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:07:14 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd8kqgq5g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:07:13 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 09:07:12 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 09:07:04 -0500
In-Reply-To: <1519740425-11270-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519740425-11270-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1519740425-11270-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/2] tests: Move common TPM test code into
 tpm-emu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Move threads and other common TPM test code into tpm-emu.c.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/Makefile.include |   2 +-
 tests/tpm-crb-test.c   | 174 +------------------------------------------=
------
 tests/tpm-emu.c        | 167 +++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/tpm-emu.h        |  38 +++++++++++
 4 files changed, 209 insertions(+), 172 deletions(-)
 create mode 100644 tests/tpm-emu.c
 create mode 100644 tests/tpm-emu.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index a1bcbff..ff44264 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -714,7 +714,7 @@ tests/test-crypto-tlssession$(EXESUF): tests/test-cry=
pto-tlssession.o \
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
-tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o $(test-io-obj-y)
+tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test=
-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
index 8bf1507..e1513cb 100644
--- a/tests/tpm-crb-test.c
+++ b/tests/tpm-crb-test.c
@@ -14,177 +14,9 @@
 #include <glib/gstdio.h>
=20
 #include "hw/acpi/tpm.h"
-#include "hw/tpm/tpm_ioctl.h"
 #include "io/channel-socket.h"
 #include "libqtest.h"
-#include "qapi/error.h"
-
-#define TPM_RC_FAILURE 0x101
-#define TPM2_ST_NO_SESSIONS 0x8001
-
-struct tpm_hdr {
-    uint16_t tag;
-    uint32_t len;
-    uint32_t code; /*ordinal/error */
-    char buffer[];
-} QEMU_PACKED;
-
-typedef struct TestState {
-    CompatGMutex data_mutex;
-    CompatGCond data_cond;
-    SocketAddress *addr;
-    QIOChannel *tpm_ioc;
-    GThread *emu_tpm_thread;
-    struct tpm_hdr *tpm_msg;
-} TestState;
-
-static void test_wait_cond(TestState *s)
-{
-    gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
-
-    g_mutex_lock(&s->data_mutex);
-    if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
-        g_assert_not_reached();
-    }
-    g_mutex_unlock(&s->data_mutex);
-}
-
-static void *emu_tpm_thread(void *data)
-{
-    TestState *s =3D data;
-    QIOChannel *ioc =3D s->tpm_ioc;
-
-    s->tpm_msg =3D g_new(struct tpm_hdr, 1);
-    while (true) {
-        int minhlen =3D sizeof(s->tpm_msg->tag) + sizeof(s->tpm_msg->len=
);
-
-        if (!qio_channel_read(ioc, (char *)s->tpm_msg, minhlen, &error_a=
bort)) {
-            break;
-        }
-        s->tpm_msg->tag =3D be16_to_cpu(s->tpm_msg->tag);
-        s->tpm_msg->len =3D be32_to_cpu(s->tpm_msg->len);
-        g_assert_cmpint(s->tpm_msg->len, >=3D, minhlen);
-        g_assert_cmpint(s->tpm_msg->tag, =3D=3D, TPM2_ST_NO_SESSIONS);
-
-        s->tpm_msg =3D g_realloc(s->tpm_msg, s->tpm_msg->len);
-        qio_channel_read(ioc, (char *)&s->tpm_msg->code,
-                         s->tpm_msg->len - minhlen, &error_abort);
-        s->tpm_msg->code =3D be32_to_cpu(s->tpm_msg->code);
-
-        /* reply error */
-        s->tpm_msg->tag =3D cpu_to_be16(TPM2_ST_NO_SESSIONS);
-        s->tpm_msg->len =3D cpu_to_be32(sizeof(struct tpm_hdr));
-        s->tpm_msg->code =3D cpu_to_be32(TPM_RC_FAILURE);
-        qio_channel_write(ioc, (char *)s->tpm_msg, be32_to_cpu(s->tpm_ms=
g->len),
-                          &error_abort);
-    }
-
-    g_free(s->tpm_msg);
-    s->tpm_msg =3D NULL;
-    object_unref(OBJECT(s->tpm_ioc));
-    return NULL;
-}
-
-static void *emu_ctrl_thread(void *data)
-{
-    TestState *s =3D data;
-    QIOChannelSocket *lioc =3D qio_channel_socket_new();
-    QIOChannel *ioc;
-
-    qio_channel_socket_listen_sync(lioc, s->addr, &error_abort);
-    g_cond_signal(&s->data_cond);
-
-    qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
-    ioc =3D QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
-    g_assert(ioc);
-
-    {
-        uint32_t cmd =3D 0;
-        struct iovec iov =3D { .iov_base =3D &cmd, .iov_len =3D sizeof(c=
md) };
-        int *pfd =3D NULL;
-        size_t nfd =3D 0;
-
-        qio_channel_readv_full(ioc, &iov, 1, &pfd, &nfd, &error_abort);
-        cmd =3D be32_to_cpu(cmd);
-        g_assert_cmpint(cmd, =3D=3D, CMD_SET_DATAFD);
-        g_assert_cmpint(nfd, =3D=3D, 1);
-        s->tpm_ioc =3D QIO_CHANNEL(qio_channel_socket_new_fd(*pfd, &erro=
r_abort));
-        g_free(pfd);
-
-        cmd =3D 0;
-        qio_channel_write(ioc, (char *)&cmd, sizeof(cmd), &error_abort);
-
-        s->emu_tpm_thread =3D g_thread_new(NULL, emu_tpm_thread, s);
-    }
-
-    while (true) {
-        uint32_t cmd;
-        ssize_t ret;
-
-        ret =3D qio_channel_read(ioc, (char *)&cmd, sizeof(cmd), NULL);
-        if (ret <=3D 0) {
-            break;
-        }
-
-        cmd =3D be32_to_cpu(cmd);
-        switch (cmd) {
-        case CMD_GET_CAPABILITY: {
-            ptm_cap cap =3D cpu_to_be64(0x3fff);
-            qio_channel_write(ioc, (char *)&cap, sizeof(cap), &error_abo=
rt);
-            break;
-        }
-        case CMD_INIT: {
-            ptm_init init;
-            qio_channel_read(ioc, (char *)&init.u.req, sizeof(init.u.req=
),
-                              &error_abort);
-            init.u.resp.tpm_result =3D 0;
-            qio_channel_write(ioc, (char *)&init.u.resp, sizeof(init.u.r=
esp),
-                              &error_abort);
-            break;
-        }
-        case CMD_SHUTDOWN: {
-            ptm_res res =3D 0;
-            qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
-            qio_channel_close(s->tpm_ioc, &error_abort);
-            g_thread_join(s->emu_tpm_thread);
-            break;
-        }
-        case CMD_STOP: {
-            ptm_res res =3D 0;
-            qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
-            break;
-        }
-        case CMD_SET_BUFFERSIZE: {
-            ptm_setbuffersize sbs;
-            qio_channel_read(ioc, (char *)&sbs.u.req, sizeof(sbs.u.req),
-                             &error_abort);
-            sbs.u.resp.buffersize =3D sbs.u.req.buffersize ?: cpu_to_be3=
2(4096);
-            sbs.u.resp.tpm_result =3D 0;
-            sbs.u.resp.minsize =3D cpu_to_be32(128);
-            sbs.u.resp.maxsize =3D cpu_to_be32(4096);
-            qio_channel_write(ioc, (char *)&sbs.u.resp, sizeof(sbs.u.res=
p),
-                              &error_abort);
-            break;
-        }
-        case CMD_SET_LOCALITY: {
-            ptm_loc loc;
-            /* Note: this time it's not u.req / u.resp... */
-            qio_channel_read(ioc, (char *)&loc, sizeof(loc), &error_abor=
t);
-            g_assert_cmpint(loc.u.req.loc, =3D=3D, 0);
-            loc.u.resp.tpm_result =3D 0;
-            qio_channel_write(ioc, (char *)&loc, sizeof(loc), &error_abo=
rt);
-            break;
-        }
-        default:
-            g_debug("unimplemented %u", cmd);
-            g_assert_not_reached();
-        }
-    }
-
-    object_unref(OBJECT(ioc));
-    object_unref(OBJECT(lioc));
-    return NULL;
-}
+#include "tpm-emu.h"
=20
 #define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
=20
@@ -250,8 +82,8 @@ int main(int argc, char **argv)
     g_mutex_init(&test.data_mutex);
     g_cond_init(&test.data_cond);
=20
-    thread =3D g_thread_new(NULL, emu_ctrl_thread, &test);
-    test_wait_cond(&test);
+    thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
+    tpm_emu_test_wait_cond(&test);
=20
     args =3D g_strdup_printf(
         "-chardev socket,id=3Dchr,path=3D%s "
diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
new file mode 100644
index 0000000..cbb92af
--- /dev/null
+++ b/tests/tpm-emu.c
@@ -0,0 +1,167 @@
+/*
+ * Minimal TPM emulator for TPM test cases
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
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
+#include "hw/tpm/tpm_ioctl.h"
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+#include "tpm-emu.h"
+
+void tpm_emu_test_wait_cond(TestState *s)
+{
+    gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+
+    g_mutex_lock(&s->data_mutex);
+    if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
+        g_assert_not_reached();
+    }
+    g_mutex_unlock(&s->data_mutex);
+}
+
+static void *tpm_emu_tpm_thread(void *data)
+{
+    TestState *s =3D data;
+    QIOChannel *ioc =3D s->tpm_ioc;
+
+    s->tpm_msg =3D g_new(struct tpm_hdr, 1);
+    while (true) {
+        int minhlen =3D sizeof(s->tpm_msg->tag) + sizeof(s->tpm_msg->len=
);
+
+        if (!qio_channel_read(ioc, (char *)s->tpm_msg, minhlen, &error_a=
bort)) {
+            break;
+        }
+        s->tpm_msg->tag =3D be16_to_cpu(s->tpm_msg->tag);
+        s->tpm_msg->len =3D be32_to_cpu(s->tpm_msg->len);
+        g_assert_cmpint(s->tpm_msg->len, >=3D, minhlen);
+        g_assert_cmpint(s->tpm_msg->tag, =3D=3D, TPM2_ST_NO_SESSIONS);
+
+        s->tpm_msg =3D g_realloc(s->tpm_msg, s->tpm_msg->len);
+        qio_channel_read(ioc, (char *)&s->tpm_msg->code,
+                         s->tpm_msg->len - minhlen, &error_abort);
+        s->tpm_msg->code =3D be32_to_cpu(s->tpm_msg->code);
+
+        /* reply error */
+        s->tpm_msg->tag =3D cpu_to_be16(TPM2_ST_NO_SESSIONS);
+        s->tpm_msg->len =3D cpu_to_be32(sizeof(struct tpm_hdr));
+        s->tpm_msg->code =3D cpu_to_be32(TPM_RC_FAILURE);
+        qio_channel_write(ioc, (char *)s->tpm_msg, be32_to_cpu(s->tpm_ms=
g->len),
+                          &error_abort);
+    }
+
+    g_free(s->tpm_msg);
+    s->tpm_msg =3D NULL;
+    object_unref(OBJECT(s->tpm_ioc));
+    return NULL;
+}
+
+void *tpm_emu_ctrl_thread(void *data)
+{
+    TestState *s =3D data;
+    QIOChannelSocket *lioc =3D qio_channel_socket_new();
+    QIOChannel *ioc;
+
+    qio_channel_socket_listen_sync(lioc, s->addr, &error_abort);
+    g_cond_signal(&s->data_cond);
+
+    qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    ioc =3D QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
+    g_assert(ioc);
+
+    {
+        uint32_t cmd =3D 0;
+        struct iovec iov =3D { .iov_base =3D &cmd, .iov_len =3D sizeof(c=
md) };
+        int *pfd =3D NULL;
+        size_t nfd =3D 0;
+
+        qio_channel_readv_full(ioc, &iov, 1, &pfd, &nfd, &error_abort);
+        cmd =3D be32_to_cpu(cmd);
+        g_assert_cmpint(cmd, =3D=3D, CMD_SET_DATAFD);
+        g_assert_cmpint(nfd, =3D=3D, 1);
+        s->tpm_ioc =3D QIO_CHANNEL(qio_channel_socket_new_fd(*pfd, &erro=
r_abort));
+        g_free(pfd);
+
+        cmd =3D 0;
+        qio_channel_write(ioc, (char *)&cmd, sizeof(cmd), &error_abort);
+
+        s->emu_tpm_thread =3D g_thread_new(NULL, tpm_emu_tpm_thread, s);
+    }
+
+    while (true) {
+        uint32_t cmd;
+        ssize_t ret;
+
+        ret =3D qio_channel_read(ioc, (char *)&cmd, sizeof(cmd), NULL);
+        if (ret <=3D 0) {
+            break;
+        }
+
+        cmd =3D be32_to_cpu(cmd);
+        switch (cmd) {
+        case CMD_GET_CAPABILITY: {
+            ptm_cap cap =3D cpu_to_be64(0x3fff);
+            qio_channel_write(ioc, (char *)&cap, sizeof(cap), &error_abo=
rt);
+            break;
+        }
+        case CMD_INIT: {
+            ptm_init init;
+            qio_channel_read(ioc, (char *)&init.u.req, sizeof(init.u.req=
),
+                              &error_abort);
+            init.u.resp.tpm_result =3D 0;
+            qio_channel_write(ioc, (char *)&init.u.resp, sizeof(init.u.r=
esp),
+                              &error_abort);
+            break;
+        }
+        case CMD_SHUTDOWN: {
+            ptm_res res =3D 0;
+            qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
+            qio_channel_close(s->tpm_ioc, &error_abort);
+            g_thread_join(s->emu_tpm_thread);
+            break;
+        }
+        case CMD_STOP: {
+            ptm_res res =3D 0;
+            qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
+            break;
+        }
+        case CMD_SET_BUFFERSIZE: {
+            ptm_setbuffersize sbs;
+            qio_channel_read(ioc, (char *)&sbs.u.req, sizeof(sbs.u.req),
+                             &error_abort);
+            sbs.u.resp.buffersize =3D sbs.u.req.buffersize ?: cpu_to_be3=
2(4096);
+            sbs.u.resp.tpm_result =3D 0;
+            sbs.u.resp.minsize =3D cpu_to_be32(128);
+            sbs.u.resp.maxsize =3D cpu_to_be32(4096);
+            qio_channel_write(ioc, (char *)&sbs.u.resp, sizeof(sbs.u.res=
p),
+                              &error_abort);
+            break;
+        }
+        case CMD_SET_LOCALITY: {
+            ptm_loc loc;
+            /* Note: this time it's not u.req / u.resp... */
+            qio_channel_read(ioc, (char *)&loc, sizeof(loc), &error_abor=
t);
+            g_assert_cmpint(loc.u.req.loc, =3D=3D, 0);
+            loc.u.resp.tpm_result =3D 0;
+            qio_channel_write(ioc, (char *)&loc, sizeof(loc), &error_abo=
rt);
+            break;
+        }
+        default:
+            g_debug("unimplemented %u", cmd);
+            g_assert_not_reached();
+        }
+    }
+
+    object_unref(OBJECT(ioc));
+    object_unref(OBJECT(lioc));
+    return NULL;
+}
diff --git a/tests/tpm-emu.h b/tests/tpm-emu.h
new file mode 100644
index 0000000..ef4bfa8
--- /dev/null
+++ b/tests/tpm-emu.h
@@ -0,0 +1,38 @@
+/*
+ * Minimal TPM emulator for TPM test cases
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TESTS_TPM_EMU_H
+#define TESTS_TPM_EMU_H
+
+#define TPM_RC_FAILURE 0x101
+#define TPM2_ST_NO_SESSIONS 0x8001
+
+struct tpm_hdr {
+    uint16_t tag;
+    uint32_t len;
+    uint32_t code; /*ordinal/error */
+    char buffer[];
+} QEMU_PACKED;
+
+typedef struct TestState {
+    CompatGMutex data_mutex;
+    CompatGCond data_cond;
+    SocketAddress *addr;
+    QIOChannel *tpm_ioc;
+    GThread *emu_tpm_thread;
+    struct tpm_hdr *tpm_msg;
+} TestState;
+
+void tpm_emu_test_wait_cond(TestState *s);
+void *tpm_emu_ctrl_thread(void *data);
+
+#endif /* TEST_TPM_EMU_H */
--=20
2.5.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBjPU-0000fm-GD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBjPN-0002d6-Sw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBjPN-0002co-Jv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:33:53 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  6 Nov 2017 15:33:42 +0000
Message-Id: <20171106153342.24147-3-berrange@redhat.com>
In-Reply-To: <20171106153342.24147-1-berrange@redhat.com>
References: <20171106153342.24147-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 2/2] tests: Add test-listen - a stress test
 for QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Knut Omang <knut.omang@oracle.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Knut Omang <knut.omang@oracle.com>

There's a potential race condition between multiple bind()'s
attempting to bind to the same port, which occasionally
allows more than one bind to succeed against the same port.

When a subsequent listen() call is made with the same socket
only one will succeed.

The current QEMU code does however not take this situation into account
and the listen will cause the code to break out and fail even
when there are actually available ports to use.

This test exposes two subtests:

/socket/listen-serial
/socket/listen-compete

The "compete" subtest creates a number of threads and have them all trying to bind
to the same port with a large enough offset input to
allow all threads to get it's own port.
The "serial" subtest just does the same, except in series in a
single thread.

The serial version passes, probably in most versions of QEMU.

The parallel version exposes the problem in a relatively reliable way,
eg. it fails a majority of times, but not with a 100% rate, occasional
passes can be seen. Nevertheless this is quite good given that
the bug was tricky to reproduce and has been left undetected for
a while.

The problem seems to be present in all versions of QEMU.

The original failure scenario occurred with VNC port allocation
in a traditional Xen based build, in different code
but with similar functionality.

Reported-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/Makefile.include |   2 +
 tests/test-listen.c    | 253 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 tests/test-listen.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 434a2ce868..e4bb88bd3d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -154,6 +154,7 @@ gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
+check-unit-y += tests/test-listen$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
 
@@ -804,6 +805,7 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
+tests/test-listen$(EXESUF): tests/test-listen.o $(test-util-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/test-listen.c b/tests/test-listen.c
new file mode 100644
index 0000000000..03c4c8f03b
--- /dev/null
+++ b/tests/test-listen.c
@@ -0,0 +1,253 @@
+/*
+ * Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
+ *    Author: Knut Omang <knut.omang@oracle.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or later
+ * as published by the Free Software Foundation.
+ *
+ * Test parallel port listen configuration with
+ * dynamic port allocation
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu-common.h"
+#include "qemu/thread.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+
+#define NAME_LEN 1024
+#define PORT_LEN 16
+
+struct thr_info {
+    QemuThread thread;
+    int to_port;
+    bool ipv4;
+    bool ipv6;
+    int got_port;
+    int eno;
+    int fd;
+    const char *errstr;
+    char hostname[NAME_LEN + 1];
+    char port[PORT_LEN + 1];
+};
+
+
+/* These two functions taken from test-io-channel-socket.c */
+static int check_bind(const char *hostname, bool *has_proto)
+{
+    int fd = -1;
+    struct addrinfo ai, *res = NULL;
+    int rc;
+    int ret = -1;
+
+    memset(&ai, 0, sizeof(ai));
+    ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG;
+    ai.ai_family = AF_UNSPEC;
+    ai.ai_socktype = SOCK_STREAM;
+
+    /* lookup */
+    rc = getaddrinfo(hostname, NULL, &ai, &res);
+    if (rc != 0) {
+        if (rc == EAI_ADDRFAMILY ||
+            rc == EAI_FAMILY) {
+            *has_proto = false;
+            goto done;
+        }
+        goto cleanup;
+    }
+
+    fd = qemu_socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+    if (fd < 0) {
+        goto cleanup;
+    }
+
+    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
+        if (errno == EADDRNOTAVAIL) {
+            *has_proto = false;
+            goto done;
+        }
+        goto cleanup;
+    }
+
+    *has_proto = true;
+ done:
+    ret = 0;
+
+ cleanup:
+    if (fd != -1) {
+        close(fd);
+    }
+    if (res) {
+        freeaddrinfo(res);
+    }
+    return ret;
+}
+
+static int check_protocol_support(bool *has_ipv4, bool *has_ipv6)
+{
+    if (check_bind("127.0.0.1", has_ipv4) < 0) {
+        return -1;
+    }
+    if (check_bind("::1", has_ipv6) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static void *listener_thread(void *arg)
+{
+    struct thr_info *thr = (struct thr_info *)arg;
+    SocketAddress addr = {
+        .type = SOCKET_ADDRESS_TYPE_INET,
+        .u = {
+            .inet = {
+                .host = thr->hostname,
+                .port = thr->port,
+                .has_ipv4 = thr->ipv4,
+                .ipv4 = thr->ipv4,
+                .has_ipv6 = thr->ipv6,
+                .ipv6 = thr->ipv6,
+                .has_to = true,
+                .to = thr->to_port,
+            },
+        },
+    };
+    Error *err = NULL;
+    int fd;
+
+    fd = socket_listen(&addr, &err);
+    if (fd < 0) {
+        thr->eno = errno;
+        thr->errstr = error_get_pretty(err);
+    } else {
+        struct sockaddr_in a;
+        socklen_t a_len = sizeof(a);
+        g_assert_cmpint(getsockname(fd, (struct sockaddr *)&a, &a_len), ==, 0);
+        thr->got_port = ntohs(a.sin_port);
+        thr->fd = fd;
+    }
+    return arg;
+}
+
+
+static void listen_compete_nthr(bool threaded, int nthreads,
+                                int start_port, int max_offset,
+                                bool ipv4, bool ipv6)
+{
+    int i;
+    int failed_listens = 0;
+    struct thr_info *thr = g_new0(struct thr_info, nthreads);
+    int used[max_offset + 1];
+
+    memset(used, 0, sizeof(used));
+    for (i = 0; i < nthreads; i++) {
+        snprintf(thr[i].port, PORT_LEN, "%d", start_port);
+        strcpy(thr[i].hostname, "localhost");
+        thr[i].to_port = start_port + max_offset;
+        thr[i].ipv4 = ipv4;
+        thr[i].ipv6 = ipv6;
+    }
+
+    for (i = 0; i < nthreads; i++) {
+        if (threaded) {
+            qemu_thread_create(&thr[i].thread, "listener",
+                               listener_thread, &thr[i],
+                               QEMU_THREAD_JOINABLE);
+        } else {
+            listener_thread(&thr[i]);
+        }
+    }
+
+    if (threaded) {
+        for (i = 0; i < nthreads; i++) {
+            qemu_thread_join(&thr[i].thread);
+        }
+    }
+    for (i = 0; i < nthreads; i++) {
+        if (thr[i].got_port) {
+            closesocket(thr[i].fd);
+        }
+    }
+
+    for (i = 0; i < nthreads; i++) {
+        if (thr[i].eno != 0) {
+            const char *m;
+            g_printerr("** Failed to assign a port to thread %d (errno = %d)\n",
+                   i, thr[i].eno);
+            /* This is what we are interested in capturing -
+             * catch and report details if something unexpected happens:
+             */
+            m = strstr(thr[i].errstr, "Failed to listen on socket");
+            if (m != NULL) {
+                g_assert_cmpstr(thr[i].errstr, ==,
+                    "Failed to listen on socket: Address already in use");
+            }
+            failed_listens++;
+        } else {
+            int assigned_port = thr[i].got_port;
+            g_assert_cmpint(assigned_port, <= , thr[i].to_port);
+            g_assert_cmpint(used[assigned_port - start_port], == , 0);
+        }
+    }
+    g_assert_cmpint(failed_listens, ==, 0);
+    g_free(thr);
+}
+
+
+static void listen_compete_ipv4(void)
+{
+    listen_compete_nthr(true, 200, 5920, 300, true, false);
+}
+
+static void listen_serial_ipv4(void)
+{
+    listen_compete_nthr(false, 200, 6300, 300, true, false);
+}
+
+static void listen_compete_ipv6(void)
+{
+    listen_compete_nthr(true, 200, 5920, 300, true, false);
+}
+
+static void listen_serial_ipv6(void)
+{
+    listen_compete_nthr(false, 200, 6300, 300, false, true);
+}
+
+static void listen_compete_gen(void)
+{
+    listen_compete_nthr(true, 200, 5920, 300, true, true);
+}
+
+static void listen_serial_gen(void)
+{
+    listen_compete_nthr(false, 200, 6300, 300, true, true);
+}
+
+
+int main(int argc, char **argv)
+{
+    bool has_ipv4, has_ipv6;
+    g_test_init(&argc, &argv, NULL);
+
+    if (check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
+        return 1;
+    }
+
+    if (has_ipv4) {
+        g_test_add_func("/socket/listen-serial/ipv4", listen_serial_ipv4);
+        g_test_add_func("/socket/listen-compete/ipv4", listen_compete_ipv4);
+    }
+    if (has_ipv6) {
+        g_test_add_func("/socket/listen-serial/ipv6", listen_serial_ipv6);
+        g_test_add_func("/socket/listen-compete/ipv6", listen_compete_ipv6);
+    }
+    if (has_ipv4 && has_ipv6) {
+        g_test_add_func("/socket/listen-serial/generic", listen_serial_gen);
+        g_test_add_func("/socket/listen-compete/generic", listen_compete_gen);
+    }
+    return g_test_run();
+}
-- 
2.13.6

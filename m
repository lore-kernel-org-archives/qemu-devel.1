Received: from eggs.gnu.org ([2001:4830:134:3::10]:50290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dKgcp-0006bX-Hn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dKgcl-00075K-KI
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:52:31 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:30120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dKgcl-00075B-8q
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:52:27 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Tue, 13 Jun 2017 09:52:09 +0200
Message-Id: <e816cc0470461d5a7c06a4d6213e4adc2402c58f.1497339083.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.af39bf23ea744fd4a1461a0fec7ded29e5f43611.1497339083.git-series.knut.omang@oracle.com>
References: <cover.af39bf23ea744fd4a1461a0fec7ded29e5f43611.1497339083.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v2 1/2] Add test-listen - a stress test for
 QEMU socket listen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Knut Omang <knut.omang@oracle.com>

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
---
 tests/Makefile.include |   2 +-
 tests/test-listen.c    | 141 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+)
 create mode 100644 tests/test-listen.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3df..a492285 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -127,6 +127,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
+#check-unit-y += tests/test-listen$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
@@ -760,6 +761,7 @@ tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
+tests/test-listen$(EXESUF): tests/test-listen.o $(test-util-obj-y)
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/test-listen.c b/tests/test-listen.c
new file mode 100644
index 0000000..45fe9a8
--- /dev/null
+++ b/tests/test-listen.c
@@ -0,0 +1,141 @@
+/*
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
+    int got_port;
+    int eno;
+    int fd;
+    const char *errstr;
+};
+
+static char hostname[NAME_LEN + 1];
+static char port[PORT_LEN + 1];
+
+static void *listener_thread(void *arg)
+{
+    struct thr_info *thr = (struct thr_info *)arg;
+    SocketAddress addr = {
+        .type = SOCKET_ADDRESS_TYPE_INET,
+        .u = {
+            .inet = {
+                .host = hostname,
+                .port = port,
+                .ipv4 = true,
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
+                                int start_port, int max_offset)
+{
+    int i;
+    int failed_listens = 0;
+    size_t alloc_sz = sizeof(struct thr_info) * nthreads;
+    struct thr_info *thr = g_malloc(alloc_sz);
+    int used[max_offset + 1];
+    memset(used, 0, sizeof(used));
+    g_assert_nonnull(thr);
+    g_assert_cmpint(gethostname(hostname, NAME_LEN), == , 0);
+    snprintf(port, PORT_LEN, "%d", start_port);
+    memset(thr, 0, alloc_sz);
+
+    for (i = 0; i < nthreads; i++) {
+        thr[i].to_port = start_port + max_offset;
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
+            printf("** Failed to assign a port to thread %d (errno = %d)\n",
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
+    free(thr);
+}
+
+
+static void listen_compete(void)
+{
+    listen_compete_nthr(true, 200, 5920, 300);
+}
+
+static void listen_serial(void)
+{
+    listen_compete_nthr(false, 200, 6300, 300);
+}
+
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/socket/listen-serial", listen_serial);
+    g_test_add_func("/socket/listen-compete", listen_compete);
+
+    return g_test_run();
+}
-- 
git-series 0.9.1

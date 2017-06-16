Received: from eggs.gnu.org ([2001:4830:134:3::10]:33983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLoFa-00066D-Mx
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dLoFW-0002zl-U4
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dLoFW-0002yb-GU
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:13:06 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 16 Jun 2017 11:12:46 +0100
Message-Id: <20170616101246.1550-6-berrange@redhat.com>
In-Reply-To: <20170616101246.1550-1-berrange@redhat.com>
References: <20170616101246.1550-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/5] tests: add functional test validating
 ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The semantics around handling ipv4=on|off & ipv6=on|off are quite
subtle to understand in combination with the various hostname addresses
and backend types. Introduce a massive test matrix that launches QEMU
and validates the ability to connect a client on each protocol as
appropriate.

The test requires that the host has ability to bind to both :: and
0.0.0.0, on port 9000. If either protocol is not available, or if
something is already listening on that port the test will skip.

Although it isn't using the QTest APIs, it expects the
QTEST_QEMU_BINARY env variable to be set.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/.gitignore           |   1 +
 tests/Makefile.include     |   3 +
 tests/test-sockets-proto.c | 921 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 925 insertions(+)
 create mode 100644 tests/test-sockets-proto.c

diff --git a/tests/.gitignore b/tests/.gitignore
index 40c2e3e..9fa14e5 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -76,6 +76,7 @@ test-qobject-output-visitor
 test-rcu-list
 test-replication
 test-shift128
+test-sockets-proto
 test-string-input-visitor
 test-string-output-visitor
 test-thread-pool
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f42f3df..eb3e8da 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -336,6 +336,7 @@ check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
+check-qtest-generic-y += tests/test-sockets-proto$(EXESUF)
 
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
@@ -743,6 +744,8 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/pc-cpu-test$(EXESUF): tests/pc-cpu-test.o
 tests/postcopy-test$(EXESUF): tests/postcopy-test.o
+tests/test-sockets-proto$(EXESUF): tests/test-sockets-proto.o \
+	$(test-io-obj-y)
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
diff --git a/tests/test-sockets-proto.c b/tests/test-sockets-proto.c
new file mode 100644
index 0000000..eebf2c5
--- /dev/null
+++ b/tests/test-sockets-proto.c
@@ -0,0 +1,921 @@
+/*
+ * QTest for IPv4/IPv6 protocol setup
+ *
+ * Copyright (c) 2017 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "io/channel-socket.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+
+typedef struct {
+    const char *name;
+    const char *args;
+    int ipv4; /* 0 -> disabled, 1 -> enabled */
+    int ipv6; /* 0 -> disabled, 1 -> enabled, -1 -> check getaddrinfo() order */
+    bool error;
+} QSocketsData;
+
+/*
+ * This is the giant matrix of combinations we need to consider.
+ * There are 3 axes we deal with
+ *
+ * Axis 1: Protocol flags:
+ *
+ *  ipv4=unset, ipv6=unset  -> v4 & v6 clients ([1]
+ *  ipv4=unset, ipv6=off    -> v4 clients only
+ *  ipv4=unset, ipv6=on     -> v6 clients only
+ *  ipv4=off, ipv6=unset    -> v6 clients only
+ *  ipv4=off, ipv6=off      -> error - can't disable both [2]
+ *  ipv4=off, ipv6=on       -> v6 clients only
+ *  ipv4=on, ipv6=unset     -> v4 clients only
+ *  ipv4=on, ipv6=off       -> v4 clients only
+ *  ipv4=on, ipv6=on        -> v4 & v6 clients [3]
+ *
+ * Depending on the listening address, some of those combinations
+ * may result in errors. eg ipv4=off,ipv6=on combined with 0.0.0.0
+ * is nonsensical.
+ *
+ * [1] Some backends only support a single socket listener, so
+ *     will actually only allow v4 clients
+ * [2] QEMU should fail to startup in this case
+ * [3] If hostname is "" or "::", then we get a single listener
+ *     on IPv6 and thus can also accept v4 clients. For all other
+ *     hostnames, have same problem as [1].
+ *
+ * Axis 2: Listening address:
+ *
+ *  ""        - resolves to 0.0.0.0 and ::, in that order
+ *  "0.0.0.0" - v4 clients only
+ *  "::"      - Mostly v6 clients only. Some scenarios should
+ *              permit v4 clients too.
+ *
+ * Axis 3: Backend type:
+ *
+ *  Migration - restricted to a single listener. Also relies
+ *              on buggy inet_parse() which can't accept
+ *              =off/=on parameters to ipv4/ipv6 flags
+ *  Chardevs  - restricted to a single listener.
+ *  VNC       - supports multiple listeners. Also supports
+ *              socket ranges, so has extra set of tests
+ *              in the matrix
+ *
+ */
+static QSocketsData test_data[] = {
+    /* Migrate with "" address */
+    /* XXX all settings with =off are disabled due to inet_parse() bug */
+    /* XXX multilistener bug - should be .ipv6 = 1 */
+    { .ipv4 = 1, .ipv6 = -1, .error = false,
+      .name = "/sockets/migrate/wildcard/all",
+      .args = "-incoming tcp::9000" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv4",
+      .args = "-incoming tcp::9000,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv6",
+      .args = "-incoming tcp::9000,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv4on",
+      .args = "-incoming tcp::9000,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv6on",
+      .args = "-incoming tcp::9000,ipv6=on" },
+    /*
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv4off",
+      .args = "-incoming tcp::9000,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv6off",
+      .args = "-incoming tcp::9000,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv4onipv6off",
+      .args = "-incoming tcp::9000,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv4offipv6on",
+      .args = "-incoming tcp::9000,ipv4=off,ipv6=on" },
+    */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/wildcard/ipv4onipv6on",
+      .args = "-incoming tcp::9000,ipv4=on,ipv6=on" },
+    /*
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/wildcard/ipv4offipv6off",
+      .args = "-incoming tcp::9000,ipv4=off,ipv6=off" },
+    */
+
+    /* Migrate with 0.0.0.0 address */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/0.0.0.0/all",
+      .args = "-incoming tcp:0.0.0.0:9000" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/0.0.0.0/ipv4",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/0.0.0.0/ipv6",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/0.0.0.0/ipv4on",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/0.0.0.0/ipv6on",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv6=on" },
+    /*
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/0.0.0.0/ipv4off",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/0.0.0.0/ipv6off",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/0.0.0.0/ipv4onipv6off",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/0.0.0.0/ipv4offipv6on",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4=off,ipv6=on" },
+    */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/migrate/0.0.0.0/ipv4onipv6on",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4=on,ipv6=on" },
+    /*
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/0.0.0.0/ipv4offipv6off",
+      .args = "-incoming tcp:0.0.0.0:9000,ipv4=off,ipv6=off" },
+    */
+
+    /* Migrate with :: address */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/::/all",
+      .args = "-incoming tcp:[::]:9000" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/::/ipv4",
+      .args = "-incoming tcp:[::]:9000,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/::/ipv6",
+      .args = "-incoming tcp:[::]:9000,ipv6" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/::/ipv4on",
+      .args = "-incoming tcp:[::]:9000,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/::/ipv6on",
+      .args = "-incoming tcp:[::]:9000,ipv6=on" },
+    /*
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/::/ipv4off",
+      .args = "-incoming tcp:[::]:9000,ipv4=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/::/ipv6off",
+      .args = "-incoming tcp:[::]:9000,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/::/ipv4onipv6off",
+      .args = "-incoming tcp:[::]:9000,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/::/ipv4offipv6on",
+      .args = "-incoming tcp:[::]:9000,ipv4=off,ipv6=on" },
+    */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/migrate/::/ipv4onipv6on",
+      .args = "-incoming tcp:[::]:9000,ipv4=on,ipv6=on" },
+    /*
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/migrate/::/ipv4offipv6off",
+      .args = "-incoming tcp:[::]:9000,ipv4=off,ipv6=off" },
+    */
+
+
+
+    /* Chardev with "" address */
+    /* XXX multilistener bug - should be .ipv6 = 1 */
+    { .ipv4 = 1, .ipv6 = -1, .error = false,
+      .name = "/sockets/chardev/wildcard/all",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv4",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv6",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv4on",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv6on",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv4off",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv6off",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv4onipv6off",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv4offipv6on",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/wildcard/ipv4onipv6on",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/wildcard/ipv4offipv6off",
+      .args = "-chardev socket,id=cdev0,host=,port=9000,server,nowait,"
+              "ipv4=off,ipv6=off" },
+
+    /* Chardev with 0.0.0.0 address */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/0.0.0.0/all",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/0.0.0.0/ipv4",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/0.0.0.0/ipv6",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/0.0.0.0/ipv4on",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/0.0.0.0/ipv6on",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/0.0.0.0/ipv4off",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/0.0.0.0/ipv6off",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/0.0.0.0/ipv4onipv6off",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/0.0.0.0/ipv4offipv6on",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/chardev/0.0.0.0/ipv4onipv6on",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/0.0.0.0/ipv4offipv6off",
+      .args = "-chardev socket,id=cdev0,host=0.0.0.0,port=9000,server,nowait,"
+              "ipv4=off,ipv6=off" },
+
+    /* Chardev with :: address */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/::/all",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/::/ipv4",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/::/ipv6",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv6" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/::/ipv4on",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/::/ipv6on",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/::/ipv4off",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/::/ipv6off",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/::/ipv4onipv6off",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/::/ipv4offipv6on",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/chardev/::/ipv4onipv6on",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/chardev/::/ipv4offipv6off",
+      .args = "-chardev socket,id=cdev0,host=::,port=9000,server,nowait,"
+              "ipv4=off,ipv6=off" },
+
+
+
+    /* Net with "" address */
+    /* XXX does not yet support ipv4/ipv6 flags at all */
+    /* XXX multilistener bug - should be .ipv6 = 1 */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/wildcard/all",
+      .args = "-netdev socket,id=net0,listen=:9000" },
+    /*
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/wildcard/ipv4",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/wildcard/ipv6",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/wildcard/ipv4on",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/wildcard/ipv6on",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/wildcard/ipv4off",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/wildcard/ipv6off",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/wildcard/ipv4onipv6off",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/wildcard/ipv4offipv6on",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/wildcard/ipv4onipv6on",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/wildcard/ipv4offipv6off",
+      .args = "-netdev socket,id=net0,listen=:9000,ipv4=off,ipv6=off" },
+    */
+
+    /* Net with 0.0.0.0 address */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/0.0.0.0/all",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000" },
+    /*
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/0.0.0.0/ipv4",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/0.0.0.0/ipv6",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/0.0.0.0/ipv4on",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/0.0.0.0/ipv6on",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/0.0.0.0/ipv4off",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/0.0.0.0/ipv6off",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/0.0.0.0/ipv4onipv6off",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/0.0.0.0/ipv4offipv6on",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/net/0.0.0.0/ipv4onipv6on",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/0.0.0.0/ipv4offipv6off",
+      .args = "-netdev socket,id=net0,listen=0.0.0.0:9000,ipv4=off,ipv6=off" },
+    */
+
+    /* Net with :: address */
+    /* parse_host_port() doesn't cope with [] for IPv6 addrs
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/::/all",
+      .args = "-netdev socket,id=net0,listen=[::]:9000" },
+    */
+    /*
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/::/ipv4",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/::/ipv6",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv6" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/::/ipv4on",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/::/ipv6on",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/::/ipv4off",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/::/ipv6off",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/::/ipv4onipv6off",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/::/ipv4offipv6on",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/net/::/ipv4onipv6on",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/net/::/ipv4offipv6off",
+      .args = "-netdev socket,id=net0,listen=[::]:9000,ipv4=off,ipv6=off" },
+    */
+
+
+    /* VNC with "" address */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/wildcard/all",
+      .args = "-vnc :3100" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv4",
+      .args = "-vnc :3100,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv6",
+      .args = "-vnc :3100,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv4on",
+      .args = "-vnc :3100,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv6on",
+      .args = "-vnc :3100,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv4off",
+      .args = "-vnc :3100,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv6off",
+      .args = "-vnc :3100,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv4onipv6off",
+      .args = "-vnc :3100,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv4offipv6on",
+      .args = "-vnc :3100,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/wildcard/ipv4onipv6on",
+      .args = "-vnc :3100,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/wildcard/ipv4offipv6off",
+      .args = "-vnc :3100,ipv4=off,ipv6=off" },
+
+    /* VNC with 0.0.0.0 address */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/0.0.0.0/all",
+      .args = "-vnc 0.0.0.0:3100" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/0.0.0.0/ipv4",
+      .args = "-vnc 0.0.0.0:3100,ipv4" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/0.0.0.0/ipv6",
+      .args = "-vnc 0.0.0.0:3100,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/0.0.0.0/ipv4on",
+      .args = "-vnc 0.0.0.0:3100,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/0.0.0.0/ipv6on",
+      .args = "-vnc 0.0.0.0:3100,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/0.0.0.0/ipv4off",
+      .args = "-vnc 0.0.0.0:3100,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/0.0.0.0/ipv6off",
+      .args = "-vnc 0.0.0.0:3100,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/0.0.0.0/ipv4onipv6off",
+      .args = "-vnc 0.0.0.0:3100,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/0.0.0.0/ipv4offipv6on",
+      .args = "-vnc 0.0.0.0:3100,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc/0.0.0.0/ipv4onipv6on",
+      .args = "-vnc 0.0.0.0:3100,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/0.0.0.0/ipv4offipv6off",
+      .args = "-vnc 0.0.0.0:3100,ipv4=off,ipv6=off" },
+
+    /* VNC with :: address */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/::/all",
+      .args = "-vnc :::3100" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/::/ipv4",
+      .args = "-vnc :::3100,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/::/ipv6",
+      .args = "-vnc :::3100,ipv6" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/::/ipv4on",
+      .args = "-vnc :::3100,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/::/ipv6on",
+      .args = "-vnc :::3100,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/::/ipv4off",
+      .args = "-vnc :::3100,ipv4=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/::/ipv6off",
+      .args = "-vnc :::3100,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/::/ipv4onipv6off",
+      .args = "-vnc :::3100,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/::/ipv4offipv6on",
+      .args = "-vnc :::3100,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc/::/ipv4onipv6on",
+      .args = "-vnc :::3100,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc/::/ipv4offipv6off",
+      .args = "-vnc :::3100,ipv4=off,ipv6=off" },
+
+
+
+    /* VNC with "" address and range */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/wildcard/all",
+      .args = "-vnc :3100,to=9005" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv4",
+      .args = "-vnc :3100,to=9005,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv6",
+      .args = "-vnc :3100,to=9005,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv4on",
+      .args = "-vnc :3100,to=9005,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv6on",
+      .args = "-vnc :3100,to=9005,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv4off",
+      .args = "-vnc :3100,to=9005,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv6off",
+      .args = "-vnc :3100,to=9005,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv4onipv6off",
+      .args = "-vnc :3100,to=9005,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv4offipv6on",
+      .args = "-vnc :3100,to=9005,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/wildcard/ipv4onipv6on",
+      .args = "-vnc :3100,to=9005,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/wildcard/ipv4offipv6off",
+      .args = "-vnc :3100,to=9005,ipv4=off,ipv6=off" },
+
+    /* VNC with 0.0.0.0 address and range */
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/0.0.0.0/all",
+      .args = "-vnc 0.0.0.0:3100,to=9005" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv6",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv6" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4on",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv6on",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4off",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv6off",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv6=off" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4onipv6off",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4offipv6on",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 0, .error = false,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4onipv6on",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/0.0.0.0/ipv4offipv6off",
+      .args = "-vnc 0.0.0.0:3100,to=9005,ipv4=off,ipv6=off" },
+
+    /* VNC with :: address and range */
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/::/all",
+      .args = "-vnc :::3100,to=9005" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/::/ipv4",
+      .args = "-vnc :::3100,to=9005,ipv4" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/::/ipv6",
+      .args = "-vnc :::3100,to=9005,ipv6" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/::/ipv4on",
+      .args = "-vnc :::3100,to=9005,ipv4=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/::/ipv6on",
+      .args = "-vnc :::3100,to=9005,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/::/ipv4off",
+      .args = "-vnc :::3100,to=9005,ipv4=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/::/ipv6off",
+      .args = "-vnc :::3100,to=9005,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/::/ipv4onipv6off",
+      .args = "-vnc :::3100,to=9005,ipv4=on,ipv6=off" },
+    { .ipv4 = 0, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/::/ipv4offipv6on",
+      .args = "-vnc :::3100,to=9005,ipv4=off,ipv6=on" },
+    { .ipv4 = 1, .ipv6 = 1, .error = false,
+      .name = "/sockets/vnc-to/::/ipv4onipv6on",
+      .args = "-vnc :::3100,to=9005,ipv4=on,ipv6=on" },
+    { .ipv4 = 0, .ipv6 = 0, .error = true,
+      .name = "/sockets/vnc-to/::/ipv4offipv6off",
+      .args = "-vnc :::3100,to=9005,ipv4=off,ipv6=off" },
+};
+
+static int check_bind(const char *hostname)
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
+    rc = getaddrinfo(hostname, "9000", &ai, &res);
+    if (rc != 0) {
+        goto cleanup;
+    }
+
+    fd = qemu_socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+    if (fd < 0) {
+        goto cleanup;
+    }
+
+    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
+        goto cleanup;
+    }
+
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
+
+/*
+ * Validates that getaddrinfo() with a hostname of "",
+ * returns both an IPv4 and IPv6 address, and reports
+ * their order
+ *
+ * Returns:
+ *  -1: if resolving "" didn't return IPv4+IPv6 addrs
+ *   0: if IPv4 addr is first
+ *   1: if IPv6 addr is first
+ */
+static int check_resolve_order(void)
+{
+    struct addrinfo ai, *res = NULL, *e;
+    int rc;
+    int ret = -1;
+    int ipv4_idx = -1, ipv6_idx = -1;
+    int idx;
+
+    memset(&ai, 0, sizeof(ai));
+    ai.ai_flags = AI_ADDRCONFIG | AI_PASSIVE;
+    ai.ai_family = AF_UNSPEC;
+    ai.ai_socktype = SOCK_STREAM;
+
+    /* lookup */
+    rc = getaddrinfo(NULL, "9000", &ai, &res);
+    if (rc != 0) {
+        goto cleanup;
+    }
+
+    for (e = res, idx = 0; e != NULL; e = e->ai_next, idx++) {
+        if (e->ai_family == AF_INET) {
+            ipv4_idx = idx;
+        } else if (e->ai_family == AF_INET6) {
+            ipv6_idx = idx;
+        } else {
+            goto cleanup;
+        }
+    }
+
+    if (ipv4_idx == -1 || ipv6_idx == -1) {
+        goto cleanup;
+    }
+
+    if (ipv4_idx < ipv6_idx) {
+        ret = 0;
+    } else {
+        ret = 1;
+    }
+
+ cleanup:
+    if (res) {
+        freeaddrinfo(res);
+    }
+    return ret;
+}
+
+static int check_protocol_support(void)
+{
+    if (check_bind("0.0.0.0") < 0) {
+        return -1;
+    }
+    if (check_bind("::") < 0) {
+        return -1;
+    }
+
+    return check_resolve_order();
+}
+
+static pid_t run_qemu(const char *args)
+{
+    const char *pidfile = "test-sockets-proto.pid";
+    char *pidstr;
+    pid_t child;
+    int status;
+    pid_t ret;
+    const char *binary = getenv("QTEST_QEMU_BINARY");
+    long pid;
+    if (binary == NULL) {
+        g_printerr("Missing QTEST_QEMU_BINARY env variable");
+        exit(1);
+    }
+
+    unlink(pidfile);
+    child = fork();
+    if (child == 0) {
+        setenv("QEMU_AUDIO_DRV", "none", true);
+        char *cmd = g_strdup_printf(
+            "exec %s -pidfile %s -daemonize -nodefconfig -nodefaults "
+            "-machine none -display none %s 1>/dev/null 2>&1",
+            binary, pidfile, args);
+        execlp("/bin/sh", "sh", "-c", cmd, NULL);
+        _exit(1);
+    }
+
+    do {
+        ret = waitpid(child, &status, 0);
+    } while (ret == -1 && errno == EINTR);
+
+    if (WEXITSTATUS(status) != 0) {
+        return 0;
+    }
+
+    if (!g_file_get_contents(pidfile, &pidstr, NULL, NULL)) {
+        return 0;
+    }
+
+    qemu_strtol(pidstr, NULL, 0, &pid);
+    return (pid_t)pid;
+}
+
+static void test_listen(const void *opaque)
+{
+    const QSocketsData *data = opaque;
+    QIOChannelSocket *sioc;
+    SocketAddress *saddr;
+    Error *err = NULL;
+    pid_t child;
+
+    /* First test IPv4 */
+    saddr = g_new0(SocketAddress, 1);
+    saddr->type = SOCKET_ADDRESS_TYPE_INET;
+    saddr->u.inet.host = g_strdup("127.0.0.1");
+    saddr->u.inet.port = g_strdup("9000");
+    saddr->u.inet.has_ipv4 = true;
+    saddr->u.inet.ipv4 = true;
+    saddr->u.inet.has_ipv6 = true;
+    saddr->u.inet.ipv6 = false;
+
+    child = run_qemu(data->args);
+
+    if (!child) {
+        /* QEMU failed to start, so make sure we are expecting
+         * this scenario to fail
+         */
+        g_assert(data->error);
+        goto cleanup;
+    } else {
+        g_assert(!data->error);
+    }
+
+    sioc = qio_channel_socket_new();
+    qio_channel_socket_connect_sync(sioc, saddr, &err);
+
+    if (err != NULL) {
+        /* We failed to connect to IPv4, make sure that
+         * matches the scenario expectation
+         */
+        g_assert(data->ipv4 == 0);
+        error_free(err);
+        err = NULL;
+    } else {
+        g_assert(data->ipv4 != 0);
+        object_unref(OBJECT(sioc));
+    }
+
+    kill(child, SIGKILL);
+
+
+    /* Now test IPv6 */
+    child = run_qemu(data->args);
+
+    /*
+     * The child should always succeed, because its the
+     * same config as the successful run we just did above
+     */
+    g_assert(child != 0);
+
+    g_free(saddr->u.inet.host);
+    saddr->u.inet.host = g_strdup("::1");
+    saddr->u.inet.ipv4 = false;
+    saddr->u.inet.ipv6 = true;
+
+    sioc = qio_channel_socket_new();
+    qio_channel_socket_connect_sync(sioc, saddr, &err);
+
+    if (err != NULL) {
+        /* We failed to connect to IPv6, make sure that
+         * matches the scenario expectation
+         */
+        g_assert(data->ipv6 == 0);
+        error_free(err);
+        err = NULL;
+    } else {
+        g_assert(data->ipv6 != 0);
+        object_unref(OBJECT(sioc));
+    }
+    kill(child, SIGKILL);
+
+ cleanup:
+    qapi_free_SocketAddress(saddr);
+}
+
+
+int main(int argc, char **argv)
+{
+    int ret;
+    gsize i;
+    int ipv6_first;
+
+    ipv6_first = check_protocol_support();
+    if (ipv6_first < 0) {
+        /* Skip test if we can't bind, or have unexpected
+         * results from getaddrinfo */
+         return 0;
+     }
+
+    signal(SIGPIPE, SIG_IGN);
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
+        QSocketsData *data = &test_data[i];
+        if (data->ipv6 == -1) {
+            data->ipv6 = ipv6_first ? 1 : 0;
+        }
+        g_test_add_data_func(data->name, data, test_listen);
+    }
+
+    ret = g_test_run();
+
+    return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.9.3

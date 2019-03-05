Received: from eggs.gnu.org ([209.51.188.92]:43574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14GP-0003Hl-U9
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14GN-0000wQ-JQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14GL-0000si-JX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:18 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:20 +0800
Message-Id: <1551769940-22739-14-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 13/13] tests: Add a test for qemu self
 announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vlad Yasevich <vyasevic@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We now expose qemu_announce_self through QMP and HMP.  Add a test
with some very basic packet validation (make sure we get a RARP).

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/Makefile.include     |  3 ++
 tests/test-announce-self.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tests/test-announce-self.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index c2ac4b8..5527581 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -225,6 +225,7 @@ check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_RTL8139_PCI) += tests/test-filter-redirector$(EXESUF)
 check-qtest-i386-y += tests/migration-test$(EXESUF)
+check-qtest-i386-y += tests/test-announce-self$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
 check-qtest-x86_64-y += $(check-qtest-i386-y)
@@ -263,6 +264,7 @@ check-qtest-ppc64-$(CONFIG_PSERIES) += tests/spapr-phb-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_PSERIES) += tests/device-plug-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POWERNV) += tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y += tests/migration-test$(EXESUF)
+check-qtest-ppc64-y += tests/test-announce-self$(EXESUF)
 check-qtest-ppc64-$(CONFIG_PSERIES) += tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_OHCI) += tests/usb-hcd-ohci-test$(EXESUF)
@@ -779,6 +781,7 @@ tests/usb-hcd-ehci-test$(EXESUF): tests/usb-hcd-ehci-test.o $(libqos-usb-obj-y)
 tests/usb-hcd-xhci-test$(EXESUF): tests/usb-hcd-xhci-test.o $(libqos-usb-obj-y)
 tests/cpu-plug-test$(EXESUF): tests/cpu-plug-test.o
 tests/migration-test$(EXESUF): tests/migration-test.o
+tests/test-announce-self$(EXESUF): tests/test-announce-self.o
 tests/vhost-user-test$(EXESUF): tests/vhost-user-test.o $(test-util-obj-y) \
 	$(qtest-obj-y) $(test-io-obj-y) $(libqos-virtio-obj-y) $(libqos-pc-obj-y) \
 	$(chardev-obj-y)
diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
new file mode 100644
index 0000000..1644d34
--- /dev/null
+++ b/tests/test-announce-self.c
@@ -0,0 +1,82 @@
+/*
+ * QTest testcase for qemu_announce_self
+ *
+ * Copyright (c) 2017 Red hat, Inc.
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qemu-common.h"
+#include "qemu/sockets.h"
+#include "qemu/iov.h"
+#include "libqos/libqos-pc.h"
+#include "libqos/libqos-spapr.h"
+
+#ifndef ETH_P_RARP
+#define ETH_P_RARP 0x8035
+#endif
+
+static QTestState *test_init(int socket)
+{
+    char *args;
+
+    args = g_strdup_printf("-netdev socket,fd=%d,id=hs0 -device "
+                           "virtio-net-pci,netdev=hs0", socket);
+
+    return qtest_start(args);
+}
+
+
+static void test_announce(int socket)
+{
+    char buffer[60];
+    int len;
+    QDict *rsp;
+    int ret;
+    uint16_t *proto = (uint16_t *)&buffer[12];
+
+    rsp = qmp("{ 'execute' : 'announce-self', "
+                  " 'arguments': {"
+                      " 'initial': 50, 'max': 550,"
+                      " 'rounds': 10, 'step': 50 } }");
+    assert(!qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    /* Catch the packet and make sure it's a RARP */
+    ret = qemu_recv(socket, &len, sizeof(len), 0);
+    g_assert_cmpint(ret, ==,  sizeof(len));
+    len = ntohl(len);
+
+    ret = qemu_recv(socket, buffer, len, 0);
+    g_assert_cmpint(*proto, ==, htons(ETH_P_RARP));
+}
+
+static void setup(gconstpointer data)
+{
+    QTestState *qs;
+    void (*func) (int socket) = data;
+    int sv[2], ret;
+
+    ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
+    g_assert_cmpint(ret, !=, -1);
+
+    qs = test_init(sv[1]);
+    func(sv[0]);
+
+    /* End test */
+    close(sv[0]);
+    qtest_quit(qs);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_data_func("/virtio/net/test_announce_self", test_announce, setup);
+
+    return g_test_run();
+}
-- 
2.5.0

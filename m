Received: from eggs.gnu.org ([2001:4830:134:3::10]:52353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafl-00047j-Rn
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafk-0001RV-RH
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafk-0001RE-Iw
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 926FFC04B946
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:06:11 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:28 -0400
Message-Id: <1495649128-10529-13-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 12/12] tests: Add a test for qemu self
 announcments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

We now expose qemu_announce_self through QMP and HMP.  Add a test
with some very basic packet validation (make sure we get a RARP).

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
---
 tests/Makefile.include     |  2 ++
 tests/test-announce-self.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tests/test-announce-self.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4277597..e735bb2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,6 +140,8 @@ check-qtest-generic-y = tests/qmp-test$(EXESUF)
 gcov-files-generic-y = monitor.c qapi/qmp-dispatch.c
 check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
 gcov-files-generic-y = qdev-monitor.c qmp.c
+check-qtest-generic-y += tests/test-announce-self$(EXESUF)
+gcov-files-generic-y = migration/savevm.c
 
 gcov-files-ipack-y += hw/ipack/ipack.c
 check-qtest-ipack-y += tests/ipoctal232-test$(EXESUF)
diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
new file mode 100644
index 0000000..f3cfa7d
--- /dev/null
+++ b/tests/test-announce-self.c
@@ -0,0 +1,78 @@
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
+    rsp = qmp("{ 'execute' : 'announce-self' }");
+    assert(!qdict_haskey(rsp, "error"));
+    QDECREF(rsp);
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
2.7.4

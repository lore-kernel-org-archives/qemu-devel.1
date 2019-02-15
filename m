Received: from eggs.gnu.org ([209.51.188.92]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gubGX-0007kP-Nq
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gub39-0002aQ-Q5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:48:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gub39-0002Mi-Hr
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:48:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E197B131519
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 10:48:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Feb 2019 10:47:47 +0000
Message-Id: <20190215104747.16770-10-dgilbert@redhat.com>
In-Reply-To: <20190215104747.16770-1-dgilbert@redhat.com>
References: <20190215104747.16770-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 9/9] tests: Add a test for qemu self
 announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, quintela@redhat.com
Cc: mst@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We now expose qemu_announce_self through QMP and HMP.  Add a test
with some very basic packet validation (make sure we get a RARP).

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/Makefile.include     |  3 ++
 tests/test-announce-self.c | 83 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 tests/test-announce-self.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b39e989f72..1b0874c125 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -144,6 +144,7 @@ check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF=
)
=20
 check-qtest-generic-y +=3D tests/device-introspect-test$(EXESUF)
 check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
+gcov-files-generic-y =3D migration/savevm.c
=20
 check-qtest-ipack-y +=3D tests/ipoctal232-test$(EXESUF)
=20
@@ -221,6 +222,7 @@ check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netf=
ilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D tests/test-filter-redirector=
$(EXESUF)
 check-qtest-i386-y +=3D tests/migration-test$(EXESUF)
+check-qtest-i386-y +=3D tests/test-announce-self$(EXESUF)
 check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
 check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
@@ -258,6 +260,7 @@ check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
 check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/spapr-phb-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_POWERNV) +=3D tests/pnv-xscom-test$(EXESUF)
 check-qtest-ppc64-y +=3D tests/migration-test$(EXESUF)
+check-qtest-ppc64-y +=3D tests/test-announce-self$(EXESUF)
 check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/rtas-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_USB_OHCI) +=3D tests/usb-hcd-ohci-test$(EXESU=
F)
diff --git a/tests/test-announce-self.c b/tests/test-announce-self.c
new file mode 100644
index 0000000000..2ff0c77255
--- /dev/null
+++ b/tests/test-announce-self.c
@@ -0,0 +1,83 @@
+/*
+ * QTest testcase for qemu_announce_self
+ *
+ * Copyright (c) 2017 Red hat, Inc.
+ * Copyright (c) 2014 SUSE LINUX Products GmbH
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
+    args =3D g_strdup_printf("-netdev socket,fd=3D%d,id=3Dhs0 -device "
+                           "virtio-net-pci,netdev=3Dhs0", socket);
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
+    uint16_t *proto =3D (uint16_t *)&buffer[12];
+
+    rsp =3D qmp("{ 'execute' : 'announce-self', "
+                  " 'arguments': {"
+                      " 'params': {"
+                          " 'initial': 50, 'max': 550,"
+                          " 'rounds': 10, 'step': 50 } } }");
+    assert(!qdict_haskey(rsp, "error"));
+    qobject_unref(rsp);
+
+    /* Catch the packet and make sure it's a RARP */
+    ret =3D qemu_recv(socket, &len, sizeof(len), 0);
+    g_assert_cmpint(ret, =3D=3D,  sizeof(len));
+    len =3D ntohl(len);
+
+    ret =3D qemu_recv(socket, buffer, len, 0);
+    g_assert_cmpint(*proto, =3D=3D, htons(ETH_P_RARP));
+}
+
+static void setup(gconstpointer data)
+{
+    QTestState *qs;
+    void (*func) (int socket) =3D data;
+    int sv[2], ret;
+
+    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
+    g_assert_cmpint(ret, !=3D, -1);
+
+    qs =3D test_init(sv[1]);
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
+    qtest_add_data_func("/virtio/net/test_announce_self", test_announce,=
 setup);
+
+    return g_test_run();
+}
--=20
2.20.1

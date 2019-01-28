Received: from eggs.gnu.org ([209.51.188.92]:52617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAKC-0008WC-Hz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAKA-0004ew-N1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goAKA-0004ML-4i
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A82F3C2CF9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:03:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 28 Jan 2019 17:03:21 +0000
Message-Id: <20190128170321.16936-10-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-1-dgilbert@redhat.com>
References: <20190128170321.16936-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 9/9] tests: Add a test for qemu self
 announcments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We now expose qemu_announce_self through QMP and HMP.  Add a test
with some very basic packet validation (make sure we get a RARP).

Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tests/Makefile.include     |  2 +
 tests/test-announce-self.c | 83 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)
 create mode 100644 tests/test-announce-self.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 19b4c0a696..57ce722d73 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -143,6 +143,8 @@ check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF=
)
=20
 check-qtest-generic-y +=3D tests/device-introspect-test$(EXESUF)
 check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
+check-qtest-generic-y +=3D tests/test-announce-self$(EXESUF)
+gcov-files-generic-y =3D migration/savevm.c
=20
 check-qtest-ipack-y +=3D tests/ipoctal232-test$(EXESUF)
=20
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

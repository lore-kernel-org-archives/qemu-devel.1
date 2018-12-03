Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTkj4-0002bg-ED
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTkeC-0007t0-OF
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:36:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gTkeC-0007so-JG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 04:36:12 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  3 Dec 2018 17:35:42 +0800
Message-Id: <20181203093544.6184-3-jasowang@redhat.com>
In-Reply-To: <20181203093544.6184-1-jasowang@redhat.com>
References: <20181203093544.6184-1-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V3 for 3.1 2/4] virtio-net-test: accept command
 line string instead of socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: mst@redhat.com, ppandit@redhat.com, liq3ea@163.com, liq3ea@gmail.com, pbonzini@redhat.com, thuth@redhat.com, eblake@redhat.com, Jason Wang <jasowang@redhat.com>

This will allow passing different kinds of command line string.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/virtio-net-test.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index dcb87a8b6e..233b9ab5f7 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -52,17 +52,15 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
     return dev;
 }
 
-static QOSState *pci_test_start(int socket)
+static QOSState *pci_test_start(const char *cmd)
 {
     QOSState *qs;
     const char *arch = qtest_get_arch();
-    const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
-                      "virtio-net-pci,netdev=hs0";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, socket);
+        qs = qtest_pc_boot(cmd);
     } else if (strcmp(arch, "ppc64") == 0) {
-        qs = qtest_spapr_boot(cmd, socket);
+        qs = qtest_spapr_boot(cmd);
     } else {
         g_printerr("virtio-net tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
@@ -219,11 +217,15 @@ static void pci_basic(gconstpointer data)
                   QVirtQueue *tvq,
                   int socket) = data;
     int sv[2], ret;
+    char cmd[256];
 
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
     g_assert_cmpint(ret, !=, -1);
 
-    qs = pci_test_start(sv[1]);
+    sprintf(cmd, "-netdev socket,fd=%d,id=hs0 "
+            "-device virtio-net-pci,netdev=hs0", sv[1]);
+
+    qs = pci_test_start(cmd);
     dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
 
     rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
-- 
2.17.1

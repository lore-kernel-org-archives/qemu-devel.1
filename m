Received: from eggs.gnu.org ([2001:4830:134:3::10]:36742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTl7n-000466-W7
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gTl7m-0004hx-0i
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gTl7k-0004ah-Dq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:06:45 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  3 Dec 2018 18:06:06 +0800
Message-Id: <20181203100608.28538-3-jasowang@redhat.com>
In-Reply-To: <20181203100608.28538-1-jasowang@redhat.com>
References: <20181203100608.28538-1-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V4 for 3.1 2/4] virtio-net-test: accept
 variable length argument in pci_test_start()
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

This allows flexibility to be reused for all kinds of command line
used by other tests.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/virtio-net-test.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index dcb87a8b6e..587a043e67 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -52,17 +52,21 @@ static QVirtioPCIDevice *virtio_net_pci_init(QPCIBus *bus, int slot)
     return dev;
 }
 
-static QOSState *pci_test_start(int socket)
+GCC_FMT_ATTR(1, 2)
+static QOSState *pci_test_start(const char *cmd, ...)
 {
     QOSState *qs;
+    va_list ap;
     const char *arch = qtest_get_arch();
-    const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
-                      "virtio-net-pci,netdev=hs0";
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qs = qtest_pc_boot(cmd, socket);
+        va_start(ap, cmd);
+        qs = qtest_pc_vboot(cmd, ap);
+        va_end(ap);
     } else if (strcmp(arch, "ppc64") == 0) {
-        qs = qtest_spapr_boot(cmd, socket);
+        va_start(ap, cmd);
+        qs = qtest_spapr_vboot(cmd, ap);
+        va_end(ap);
     } else {
         g_printerr("virtio-net tests are only available on x86 or ppc64\n");
         exit(EXIT_FAILURE);
@@ -223,7 +227,8 @@ static void pci_basic(gconstpointer data)
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, sv);
     g_assert_cmpint(ret, !=, -1);
 
-    qs = pci_test_start(sv[1]);
+    qs = pci_test_start("-netdev socket,fd=%d,id=hs0 -device "
+                        "virtio-net-pci,netdev=hs0", sv[1]);
     dev = virtio_net_pci_init(qs->pcibus, PCI_SLOT);
 
     rx = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, qs->alloc, 0);
-- 
2.17.1

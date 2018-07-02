Received: from eggs.gnu.org ([2001:4830:134:3::10]:49532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <emanuele.giuseppe.esposito@usi.ch>)
	id 1fZzTX-0000RT-Fn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <emanuele.giuseppe.esposito@usi.ch>)
	id 1fZzTU-0003mR-Av
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:06:43 -0400
Received: from mail-he1eur02on0600.outbound.protection.outlook.com
	([2a01:111:f400:fe05::600]:6611
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <emanuele.giuseppe.esposito@usi.ch>)
	id 1fZzTT-0003kA-L9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:06:40 -0400
From: Emanuele Giuseppe Esposito <esposem@usi.ch>
Date: Mon,  2 Jul 2018 16:05:58 +0200
Message-Id: <20180702140558.18267-1-esposem@usi.ch>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] qpci_free_pc: sdhci-test and
 vhost-user-test could free() NULL pointers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Emanuele Giuseppe Esposito <esposem@usi.ch>

server->bus in _test_server_free() could be NULL, since TestServer *dest in
test_migrate() was not properly initialized like TestServer *s. Added
init_virtio_dev(dest) and uninit_virtio_dev(dest), so the fields are properly
set and when test_server_free(dest); is called, they can be correctly freed.

Same applies to s->pci.bus, since it is set depending on the architecture.

Problem came out once I modified  pci-pc.c and pci-pc.h, modifying QPCIBusPC
by adding another field before QPCIBus bus. Re-running the tests showed
vhost-user-test failing.

Signed-off-by: Emanuele Giuseppe Esposito <esposem@usi.ch>
---
 tests/libqos/pci-pc.c   | 2 ++
 tests/sdhci-test.c      | 4 +++-
 tests/vhost-user-test.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index a7803308b7..c126b08ff5 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -152,6 +152,8 @@ QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
 
 void qpci_free_pc(QPCIBus *bus)
 {
+    g_assert(bus);
+
     QPCIBusPC *s = container_of(bus, QPCIBusPC, bus);
 
     g_free(s);
diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
index 1d825eb010..9b486b93bf 100644
--- a/tests/sdhci-test.c
+++ b/tests/sdhci-test.c
@@ -209,7 +209,9 @@ static QSDHCI *machine_start(const struct sdhci_t *test)
 
 static void machine_stop(QSDHCI *s)
 {
-    qpci_free_pc(s->pci.bus);
+    if (s->pci.bus) {
+        qpci_free_pc(s->pci.bus);
+    }
     g_free(s->pci.dev);
     qtest_quit(global_qtest);
     g_free(s);
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 8ff2106d32..a8a02c45cd 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -684,6 +684,7 @@ static void test_migrate(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
@@ -739,6 +740,7 @@ static void test_migrate(void)
     read_guest_mem_server(dest);
 
     uninit_virtio_dev(s);
+    uninit_virtio_dev(dest);
 
     g_source_destroy(source);
     g_source_unref(source);
-- 
2.17.1

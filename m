Received: from eggs.gnu.org ([2001:4830:134:3::10]:41534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fXooZ-0008AK-CL
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fXooW-0006fT-7H
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:19:27 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fXooW-0006eB-0m
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:19:24 -0400
Received: by mail-ed1-x531.google.com with SMTP id q24-v6so1115812edr.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:19:23 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Date: Tue, 26 Jun 2018 16:18:53 +0200
Message-Id: <1530022733-29581-1-git-send-email-esposem@usi.ch>
Subject: [Qemu-devel] [PATCH] vhost-user-test: added proper TestServer *dest
 initialization in test_migrate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Emanuele Giuseppe Esposito <esposem@usi.ch>

server->bus in _test_server_free() could be NULL, since TestServer *dest in test_migrate() was not properly initialized like TestServer *s.
Added init_virtio_dev(dest) and uninit_virtio_dev(dest), so the fields are properly set and when test_server_free(dest); is called, they can be correctly freed.

The reason for that is init_virtio_dev() calls qpci_init_pc(), that creates a QPCIBusPC * (returned as QPCIBus *), while test_server_free() calls qpci_free_pc(),
that frees the QPCIBus *. Not calling init_virtio_dev() would leave the QPCIBus * of TestServer unset.

Problem came out once I modified  pci-pc.c and pci-pc.h, modifying QPCIBusPC by adding another field before QPCIBus bus. Re-running the tests showed vhost-user-test failing.

Signed-off-by: Emanuele Giuseppe Esposito <esposem@usi.ch>
---
 tests/vhost-user-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index bbc8091..4d71d5e 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -545,6 +545,7 @@ static gboolean _test_server_free(TestServer *server)
     g_free(server->mig_path);
 
     g_free(server->chr_name);
+    g_assert(server->bus);
     qpci_free_pc(server->bus);
 
     g_free(server);
@@ -706,6 +707,7 @@ static void test_migrate(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
@@ -761,6 +763,7 @@ static void test_migrate(void)
     read_guest_mem_server(dest);
 
     uninit_virtio_dev(s);
+    uninit_virtio_dev(dest);
 
     g_source_destroy(source);
     g_source_unref(source);
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZJ-0005Ae-AZ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZF-0007F0-6k
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZF-0007Eh-0J
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:09 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:47 +0200
Message-Id: <1531840015-28804-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/13] vhost-user-test: added proper TestServer
 *dest initialization in test_migrate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

server->bus in _test_server_free() could be NULL, since TestServer
*dest in test_migrate() was not properly initialized like TestServer *s.
Added init_virtio_dev(dest) and uninit_virtio_dev(dest), so the fields
are properly set and when test_server_free(dest); is called, they can
be correctly freed.

The reason for that is init_virtio_dev() calls qpci_init_pc(), that
creates a QPCIBusPC * (returned as QPCIBus *), while test_server_free()
calls qpci_free_pc(), that frees the QPCIBus *. Not calling
init_virtio_dev() would leave the QPCIBus * of TestServer unset.

Problem came out once I modified  pci-pc.c and pci-pc.h, modifying
QPCIBusPC by adding another field before QPCIBus bus. Re-running the
tests showed vhost-user-test failing.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
Message-Id: <1530022733-29581-1-git-send-email-esposem@usi.ch>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 8ff2106..fecc832 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -537,6 +537,7 @@ static gboolean _test_server_free(TestServer *server)
     g_free(server->mig_path);
 
     g_free(server->chr_name);
+    g_assert(server->bus);
     qpci_free_pc(server->bus);
 
     g_free(server);
@@ -684,6 +685,7 @@ static void test_migrate(void)
     g_free(cmd);
 
     init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
+    init_virtio_dev(dest, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
@@ -739,6 +741,7 @@ static void test_migrate(void)
     read_guest_mem_server(dest);
 
     uninit_virtio_dev(s);
+    uninit_virtio_dev(dest);
 
     g_source_destroy(source);
     g_source_unref(source);
-- 
1.8.3.1

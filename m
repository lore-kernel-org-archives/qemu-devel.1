Received: from eggs.gnu.org ([209.51.188.92]:58773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gwU5Y-0001j5-1y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gwU5W-0003Tm-P9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:47:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gwU5W-0003Q4-Ec
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:47:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id t18so26582925wrx.2
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:47:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Feb 2019 16:47:01 +0100
Message-Id: <1550677621-10139-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! vhost-user-test: create a main loop per
 TestServer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

Fix a hang that is only latent until qgraph is merged.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 33030e0..527d3b3 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -557,8 +557,6 @@ static void test_server_free(TestServer *server)
     while (g_main_context_pending(NULL)) {
         g_main_context_iteration(NULL, TRUE);
     }
-    g_main_loop_unref(server->loop);
-    g_main_context_unref(server->context);
 
     qemu_chr_fe_deinit(&server->chr, true);
 
@@ -580,6 +578,8 @@ static void test_server_free(TestServer *server)
     g_assert(server->bus);
     qpci_free_pc(server->bus);
 
+    g_main_loop_unref(server->loop);
+    g_main_context_unref(server->context);
     g_free(server);
 }
 
-- 
1.8.3.1

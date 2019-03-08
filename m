Received: from eggs.gnu.org ([209.51.188.92]:36969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf1-0005lT-QW
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf1-0000Id-5k
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Bf0-0000HQ-VM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:23 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:41 +0100
Message-Id: <1552036723-1949-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/7] vhost-user-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Fixes: ae31fb54914 and 4d3f50eb489
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vhost-user-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 83ea15f..14a1e2f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -588,6 +588,7 @@ static void test_server_free(TestServer *server)
         g_test_message("unable to rmdir: path (%s): %s",
                        server->tmpfs, strerror(errno));
     }
+    g_free(server->tmpfs);
=20
     qemu_chr_fe_deinit(&server->chr, true);
=20
@@ -605,6 +606,8 @@ static void test_server_free(TestServer *server)
=20
     g_main_loop_unref(server->loop);
     g_main_context_unref(server->context);
+    g_cond_clear(&server->data_cond);
+    g_mutex_clear(&server->data_mutex);
     g_free(server);
 }
=20
--=20
1.8.3.1

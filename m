Received: from eggs.gnu.org ([209.51.188.92]:57139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h1IuU-0008NC-32
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1h1IuT-0002eD-Aj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:51:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1h1IuT-0002cp-3n
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:51:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFC983083362
	for <qemu-devel@nongnu.org>; Tue,  5 Mar 2019 22:51:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  5 Mar 2019 23:51:35 +0100
Message-Id: <20190305225135.7060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vhost-user-test: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 4cd0a97f13..9364227ba4 100644
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
2.21.0.4.g36eb1cb9cf

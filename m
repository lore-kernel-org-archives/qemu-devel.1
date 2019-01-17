Received: from eggs.gnu.org ([209.51.188.92]:52110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gkAM5-0004Jm-Kb
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gkAM4-0000ej-OA
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:21 -0500
Received: from smtp45.i.mail.ru ([94.100.177.105]:37110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gkAM2-0000Y1-C9
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:20 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 17 Jan 2019 19:16:38 +0300
Message-Id: <20190117161640.5496-2-jusual@mail.ru>
In-Reply-To: <20190117161640.5496-1-jusual@mail.ru>
References: <20190117161640.5496-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v4 1/3] tests/libqtest: Introduce
 qtest_init_with_serial()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Run qtest with a socket that connects QEMU chardev and test code.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 tests/libqtest.c | 26 ++++++++++++++++++++++++++
 tests/libqtest.h | 11 +++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 55750dd68d..3a015cfe13 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -315,6 +315,32 @@ QTestState *qtest_initf(const char *fmt, ...)
     return s;
 }
 
+QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
+{
+    int sock_fd_init;
+    char *sock_path, sock_dir[] = "/tmp/qtest-serial-XXXXXX";
+    QTestState *qts;
+
+    g_assert(mkdtemp(sock_dir));
+    sock_path = g_strdup_printf("%s/sock", sock_dir);
+
+    sock_fd_init = init_socket(sock_path);
+
+    qts = qtest_initf("-chardev socket,id=s0,path=%s,nowait "
+                      "-serial chardev:s0 %s",
+                      sock_path, extra_args);
+
+    *sock_fd = socket_accept(sock_fd_init);
+
+    unlink(sock_path);
+    g_free(sock_path);
+    rmdir(sock_dir);
+
+    g_assert(*sock_fd >= 0);
+
+    return qts;
+}
+
 void qtest_quit(QTestState *s)
 {
     g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE, s));
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 7ea94139b0..5937f91912 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -62,6 +62,17 @@ QTestState *qtest_init(const char *extra_args);
  */
 QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
 
+/**
+ * qtest_init_with_serial:
+ * @extra_args: other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
+ * @sock_fd: pointer to store the socket file descriptor for
+ * connection with serial.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd);
+
 /**
  * qtest_quit:
  * @s: #QTestState instance to operate on.
-- 
2.17.1

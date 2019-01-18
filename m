Received: from eggs.gnu.org ([209.51.188.92]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbv-0003G2-5H
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbu-0007p9-Bc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbu-0007oN-3M
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:59:06 -0500
Received: by mail-wr1-x42f.google.com with SMTP id t6so15372161wrr.12
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:59:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.59.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:59:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:58:05 +0000
Message-Id: <20190118145805.6852-50-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 49/49] tests/libqtest: Introduce
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

From: Julia Suvorova <jusual@mail.ru>

Run qtest with a socket that connects QEMU chardev and test code.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190117161640.5496-2-jusual@mail.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/libqtest.h | 11 +++++++++++
 tests/libqtest.c | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 7ea94139b0c..5937f919123 100644
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
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 55750dd68de..1f99ea63846 100644
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
-- 
2.20.1

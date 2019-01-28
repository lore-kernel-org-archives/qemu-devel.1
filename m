Received: from eggs.gnu.org ([209.51.188.92]:41093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNU-00031J-Dh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBNQ-0000Pt-5m
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:23 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBNJ-00007A-9N
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:11:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t27so19148662wra.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:11:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.11.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:11:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:34 +0000
Message-Id: <20190128181047.20781-14-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/26] tests/libqtest: Introduce
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190123120759.7162-2-jusual@mail.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/libqtest.h | 11 +++++++++++
 tests/libqtest.c | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

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
index 55750dd68de..6fb30855faf 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -315,6 +315,31 @@ QTestState *qtest_initf(const char *fmt, ...)
     return s;
 }
 
+QTestState *qtest_init_with_serial(const char *extra_args, int *sock_fd)
+{
+    int sock_fd_init;
+    char *sock_path, sock_dir[] = "/tmp/qtest-serial-XXXXXX";
+    QTestState *qts;
+
+    g_assert_true(mkdtemp(sock_dir) != NULL);
+    sock_path = g_strdup_printf("%s/sock", sock_dir);
+
+    sock_fd_init = init_socket(sock_path);
+
+    qts = qtest_initf("-chardev socket,id=s0,path=%s -serial chardev:s0 %s",
+                      sock_path, extra_args);
+
+    *sock_fd = socket_accept(sock_fd_init);
+
+    unlink(sock_path);
+    g_free(sock_path);
+    rmdir(sock_dir);
+
+    g_assert_true(*sock_fd >= 0);
+
+    return qts;
+}
+
 void qtest_quit(QTestState *s)
 {
     g_hook_destroy_link(&abrt_hooks, g_hook_find_data(&abrt_hooks, TRUE, s));
-- 
2.20.1

Received: from eggs.gnu.org ([209.51.188.92]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guL4K-0002Xb-2c
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1guKvi-0003RN-HL
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:12 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1guKvg-0003Ng-HV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:36:10 -0500
Received: by mail-wr1-x42a.google.com with SMTP id i12so7455823wrw.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:36:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 Feb 2019 18:35:55 +0100
Message-Id: <1550165756-21617-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
References: <1550165756-21617-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/9] vhost-user-test: small changes to
 init_hugepagefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com

After the conversion to qgraph, the equivalent of "main" will be in
a constructor and will run even if the tests are not being requested.
Therefore, it should not assert that init_hugepagefs succeeds and will
be called when creating the TestServer.  This patch changes the prototype
of init_hugepagefs, this way the next patch looks nicer.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543851204-41186-14-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 33030e0..516e31c 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -465,14 +465,20 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     g_mutex_unlock(&s->data_mutex);
 }
 
-#ifdef CONFIG_LINUX
-static const char *init_hugepagefs(const char *path)
+static const char *init_hugepagefs(void)
 {
+#ifdef CONFIG_LINUX
+    const char *path = getenv("QTEST_HUGETLBFS_PATH");
     struct statfs fs;
     int ret;
 
+    if (!path) {
+        return NULL;
+    }
+
     if (access(path, R_OK | W_OK | X_OK)) {
         g_test_message("access on path (%s): %s\n", path, strerror(errno));
+        abort();
         return NULL;
     }
 
@@ -482,17 +488,21 @@ static const char *init_hugepagefs(const char *path)
 
     if (ret != 0) {
         g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
+        abort();
         return NULL;
     }
 
     if (fs.f_type != HUGETLBFS_MAGIC) {
         g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
+        abort();
         return NULL;
     }
 
     return path;
-}
+#else
+    return NULL;
 #endif
+}
 
 static TestServer *test_server_new(const gchar *name)
 {
@@ -986,7 +996,6 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
 
@@ -1001,14 +1010,7 @@ int main(int argc, char **argv)
     }
     g_assert(tmpfs);
 
-    root = tmpfs;
-#ifdef CONFIG_LINUX
-    hugefs = getenv("QTEST_HUGETLBFS_PATH");
-    if (hugefs) {
-        root = init_hugepagefs(hugefs);
-        g_assert(root);
-    }
-#endif
+    root = init_hugepagefs() ? : tmpfs;
 
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
-- 
1.8.3.1

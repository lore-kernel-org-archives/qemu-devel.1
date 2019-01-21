Received: from eggs.gnu.org ([209.51.188.92]:51619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy4-0004JW-Kn
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy3-00046O-Hi
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:40 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldy3-000452-9j
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:39 -0500
Received: by mail-wr1-x435.google.com with SMTP id u4so24487904wrp.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:39 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.37 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:46 +0100
Message-Id: <1548093980-43088-16-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/49] vhost-user-test: small changes to
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
index 6aa62ac..a02f107 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -464,14 +464,20 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
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
 
@@ -481,17 +487,21 @@ static const char *init_hugepagefs(const char *path)
 
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
@@ -978,7 +988,6 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
 
@@ -993,14 +1002,7 @@ int main(int argc, char **argv)
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

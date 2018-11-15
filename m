Received: from eggs.gnu.org ([2001:4830:134:3::10]:34960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgY-0002SU-Sl
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgV-00045c-65
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNIgU-0003xX-PT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:54 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so3915335wrs.10
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:31:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 15:31:23 +0100
Message-Id: <20181115143124.19234-10-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-1-pbonzini@redhat.com>
References: <20181115143124.19234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/10] vhost-user-test: small changes to
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
Cc: lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

After the conversion to qgraph, the equivalent of "main" will be in
a constructor and will run even if the tests are not being requested.
Therefore, it should not assert that init_hugepagefs succeeds and will
be called when creating the TestServer.  This patch changes the prototype
of init_hugepagefs, this way the next patch looks nicer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 93d5157b13..a282fc57c8 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -461,13 +461,19 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     g_mutex_unlock(&s->data_mutex);
 }
 
-static const char *init_hugepagefs(const char *path)
+static const char *init_hugepagefs(void)
 {
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
 
@@ -477,11 +483,13 @@ static const char *init_hugepagefs(const char *path)
 
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
 
@@ -974,7 +982,6 @@ static void test_multiqueue(void)
 
 int main(int argc, char **argv)
 {
-    const char *hugefs;
     int ret;
     char template[] = "/tmp/vhost-test-XXXXXX";
 
@@ -989,13 +996,7 @@ int main(int argc, char **argv)
     }
     g_assert(tmpfs);
 
-    hugefs = getenv("QTEST_HUGETLBFS_PATH");
-    if (hugefs) {
-        root = init_hugepagefs(hugefs);
-        g_assert(root);
-    } else {
-        root = tmpfs;
-    }
+    root = init_hugepagefs() ? : tmpfs;
 
     if (qemu_memfd_check(0)) {
         qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
-- 
2.19.1

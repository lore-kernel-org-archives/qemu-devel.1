Received: from eggs.gnu.org ([2001:4830:134:3::10]:52817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6NA-0001Nu-4n
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N6-0000gx-8B
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N5-0000bq-S4
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id m1so5560018wml.2
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.14 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:14 +0100
Message-Id: <1544628195-37728-54-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 53/54] vhost-user-test: small changes to
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
 tests/vhost-user-test.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 2e610d4..4e4765b 100644
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
1.8.3.1

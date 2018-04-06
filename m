Received: from eggs.gnu.org ([2001:4830:134:3::10]:36127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uth-0007lv-Ct
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utg-0007Qk-5A
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:33 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:55477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utf-0007Lq-UL
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:32 -0400
Received: by mail-wm0-x242.google.com with SMTP id b127so4877138wmf.5
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:05 +0200
Message-Id: <1523034681-33787-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/20] memfd: fix vhost-user-test on non-memfd
 capable host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

On RHEL7, memfd is not supported, and vhost-user-test fails:
TEST: tests/vhost-user-test... (pid=10248)
  /x86_64/vhost-user/migrate:
  qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: failed to create memfd
FAIL

There is a qemu_memfd_check() to prevent running memfd path, but it
also checks for fallback implementation. Let's specialize
qemu_memfd_check() to check memfd only, while qemu_memfd_alloc_check()
checks for the qemu_memfd_alloc() API.

Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Tested-by: Miroslav Rezanina <mrezanin@redhat.com>
Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180328121804.16203-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/vhost.c    |  2 +-
 include/qemu/memfd.h |  1 +
 util/memfd.c         | 30 +++++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 250f886..27c1ec5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1223,7 +1223,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
             error_setg(&hdev->migration_blocker,
                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
-        } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_check()) {
+        } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
             error_setg(&hdev->migration_blocker,
                        "Migration disabled: failed to allocate shared memory");
         }
diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index de10198..49e7963 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -18,6 +18,7 @@
 
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       uint64_t hugetlbsize, unsigned int seals, Error **errp);
+bool qemu_memfd_alloc_check(void);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
diff --git a/util/memfd.c b/util/memfd.c
index 07d579e..277f721 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -173,7 +173,13 @@ enum {
     MEMFD_TODO
 };
 
-bool qemu_memfd_check(void)
+/**
+ * qemu_memfd_alloc_check():
+ *
+ * Check if qemu_memfd_alloc() can allocate, including using a
+ * fallback implementation when host doesn't support memfd.
+ */
+bool qemu_memfd_alloc_check(void)
 {
     static int memfd_check = MEMFD_TODO;
 
@@ -188,3 +194,25 @@ bool qemu_memfd_check(void)
 
     return memfd_check == MEMFD_OK;
 }
+
+/**
+ * qemu_memfd_check():
+ *
+ * Check if host supports memfd.
+ */
+bool qemu_memfd_check(void)
+{
+    static int memfd_check = MEMFD_TODO;
+
+    if (memfd_check == MEMFD_TODO) {
+        int mfd = memfd_create("test", 0);
+        if (mfd >= 0) {
+            memfd_check = MEMFD_OK;
+            close(mfd);
+        } else {
+            memfd_check = MEMFD_KO;
+        }
+    }
+
+    return memfd_check == MEMFD_OK;
+}
-- 
1.8.3.1

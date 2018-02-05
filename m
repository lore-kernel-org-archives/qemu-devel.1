Received: from eggs.gnu.org ([2001:4830:134:3::10]:45024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSb-0004pA-O0
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSa-00058m-LO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:49 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimSa-00058S-Ak
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:48 -0500
Received: by mail-wm0-x242.google.com with SMTP id 141so27960116wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:50 +0100
Message-Id: <1517858941-5538-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/47] memfd: add error argument,
 instead of perror()
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

This will allow callers to silence error report when the call is
allowed to failed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180201132757.23063-2-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/vhost.c    |  8 +++++++-
 include/qemu/memfd.h |  5 +++--
 util/memfd.c         | 57 +++++++++++++++++++++++++++-------------------------
 3 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d16c0c8..338e439 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -330,6 +330,7 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
 
 static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
 {
+    Error *err = NULL;
     struct vhost_log *log;
     uint64_t logsize = size * sizeof(*(log->log));
     int fd = -1;
@@ -338,7 +339,12 @@ static struct vhost_log *vhost_log_alloc(uint64_t size, bool share)
     if (share) {
         log->log = qemu_memfd_alloc("vhost-log", logsize,
                                     F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
-                                    &fd);
+                                    &fd, &err);
+        if (err) {
+            error_report_err(err);
+            g_free(log);
+            return NULL;
+        }
         memset(log->log, 0, logsize);
     } else {
         log->log = g_malloc0(logsize);
diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index 41c24d8..b9d0987 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -16,9 +16,10 @@
 #define F_SEAL_WRITE    0x0008  /* prevent writes */
 #endif
 
-int qemu_memfd_create(const char *name, size_t size, unsigned int seals);
+int qemu_memfd_create(const char *name, size_t size, unsigned int seals,
+                      Error **errp);
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
-                       int *fd);
+                       int *fd, Error **errp);
 void qemu_memfd_free(void *ptr, size_t size, int fd);
 bool qemu_memfd_check(void);
 
diff --git a/util/memfd.c b/util/memfd.c
index dce61f9..8d27307 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 
+#include "qapi/error.h"
 #include "qemu/memfd.h"
 
 #if defined CONFIG_LINUX && !defined CONFIG_MEMFD
@@ -51,11 +52,11 @@ static int memfd_create(const char *name, unsigned int flags)
 #define MFD_ALLOW_SEALING 0x0002U
 #endif
 
-int qemu_memfd_create(const char *name, size_t size, unsigned int seals)
+int qemu_memfd_create(const char *name, size_t size,
+                      unsigned int seals, Error **errp)
 {
-    int mfd = -1;
-
 #ifdef CONFIG_LINUX
+    int mfd = -1;
     unsigned int flags = MFD_CLOEXEC;
 
     if (seals) {
@@ -64,23 +65,26 @@ int qemu_memfd_create(const char *name, size_t size, unsigned int seals)
 
     mfd = memfd_create(name, flags);
     if (mfd < 0) {
-        return -1;
+        goto err;
     }
 
     if (ftruncate(mfd, size) == -1) {
-        perror("ftruncate");
-        close(mfd);
-        return -1;
+        goto err;
     }
 
     if (seals && fcntl(mfd, F_ADD_SEALS, seals) == -1) {
-        perror("fcntl");
-        close(mfd);
-        return -1;
+        goto err;
     }
-#endif
 
     return mfd;
+
+err:
+    if (mfd >= 0) {
+        close(mfd);
+    }
+#endif
+    error_setg_errno(errp, errno, "failed to create memfd");
+    return -1;
 }
 
 /*
@@ -90,14 +94,14 @@ int qemu_memfd_create(const char *name, size_t size, unsigned int seals)
  * sealing.
  */
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
-                       int *fd)
+                       int *fd, Error **errp)
 {
     void *ptr;
-    int mfd = qemu_memfd_create(name, size, seals);
+    int mfd = qemu_memfd_create(name, size, seals, NULL);
 
     /* some systems have memfd without sealing */
     if (mfd == -1) {
-        mfd = qemu_memfd_create(name, size, 0);
+        mfd = qemu_memfd_create(name, size, 0, NULL);
     }
 
     if (mfd == -1) {
@@ -109,27 +113,26 @@ void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
         unlink(fname);
         g_free(fname);
 
-        if (mfd == -1) {
-            perror("mkstemp");
-            return NULL;
-        }
-
-        if (ftruncate(mfd, size) == -1) {
-            perror("ftruncate");
-            close(mfd);
-            return NULL;
+        if (mfd == -1 ||
+            ftruncate(mfd, size) == -1) {
+            goto err;
         }
     }
 
     ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
     if (ptr == MAP_FAILED) {
-        perror("mmap");
-        close(mfd);
-        return NULL;
+        goto err;
     }
 
     *fd = mfd;
     return ptr;
+
+err:
+    error_setg_errno(errp, errno, "failed to allocate shared memory");
+    if (mfd >= 0) {
+        close(mfd);
+    }
+    return NULL;
 }
 
 void qemu_memfd_free(void *ptr, size_t size, int fd)
@@ -157,7 +160,7 @@ bool qemu_memfd_check(void)
         int fd;
         void *ptr;
 
-        ptr = qemu_memfd_alloc("test", 4096, 0, &fd);
+        ptr = qemu_memfd_alloc("test", 4096, 0, &fd, NULL);
         memfd_check = ptr ? MEMFD_OK : MEMFD_KO;
         qemu_memfd_free(ptr, 4096, fd);
     }
-- 
1.8.3.1

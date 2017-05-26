Received: from eggs.gnu.org ([2001:4830:134:3::10]:40653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dED7S-00070x-Rx
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dED7P-0001Ad-Ma
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:09:22 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:5011 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dED7P-00019F-7p
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:09:19 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 26 May 2017 14:09:13 +0300
Message-Id: <20170526110913.89098-1-vsementsov@virtuozzo.com>
In-Reply-To: <1495192872-27667-15-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-15-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v2] nbd/client.c: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: vsementsov@virtuozzo.com

Move to modern errp scheme from just LOGging errors.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Fixes:

- local_err initialized to NULL
- 083 iotest ajusted

\I feel like an idiot...

 block/nbd-client.c         |  7 ++++++-
 include/block/nbd.h        |  5 +++--
 nbd/client.c               | 30 +++++++++++++++++-------------
 qemu-nbd.c                 |  3 ++-
 tests/qemu-iotests/083.out |  2 ++
 5 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 538d95e031..09d955bc4d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -28,6 +28,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "nbd-client.h"
 
 #define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs))
@@ -70,10 +71,14 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
     NBDClientSession *s = opaque;
     uint64_t i;
     int ret;
+    Error *local_err = NULL;
 
     for (;;) {
         assert(s->reply.handle == 0);
-        ret = nbd_receive_reply(s->ioc, &s->reply);
+        ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+        }
         if (ret <= 0) {
             break;
         }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index a96fb5fceb..e0c64e4981 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -133,9 +133,10 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
                           off_t *size, Error **errp);
-int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size);
+int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
+             Error **errp);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
-ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
+ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
 int nbd_client(int fd);
 int nbd_disconnect(int fd);
 
diff --git a/nbd/client.c b/nbd/client.c
index f102375504..f9e1d75be4 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -627,11 +627,13 @@ fail:
 }
 
 #ifdef __linux__
-int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
+int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
+             Error **errp)
 {
     unsigned long sectors = size / BDRV_SECTOR_SIZE;
     if (size / BDRV_SECTOR_SIZE != sectors) {
-        LOG("Export size %lld too large for 32-bit kernel", (long long) size);
+        error_setg(errp, "Export size %lld too large for 32-bit kernel",
+                   (long long) size);
         return -E2BIG;
     }
 
@@ -639,7 +641,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
 
     if (ioctl(fd, NBD_SET_SOCK, (unsigned long) sioc->fd) < 0) {
         int serrno = errno;
-        LOG("Failed to set NBD socket");
+        error_setg(errp, "Failed to set NBD socket");
         return -serrno;
     }
 
@@ -647,7 +649,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
 
     if (ioctl(fd, NBD_SET_BLKSIZE, (unsigned long)BDRV_SECTOR_SIZE) < 0) {
         int serrno = errno;
-        LOG("Failed setting NBD block size");
+        error_setg(errp, "Failed setting NBD block size");
         return -serrno;
     }
 
@@ -659,7 +661,7 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
 
     if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
         int serrno = errno;
-        LOG("Failed setting size (in blocks)");
+        error_setg(errp, "Failed setting size (in blocks)");
         return -serrno;
     }
 
@@ -670,12 +672,12 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
 
             if (ioctl(fd, BLKROSET, (unsigned long) &read_only) < 0) {
                 int serrno = errno;
-                LOG("Failed setting read-only attribute");
+                error_setg(errp, "Failed setting read-only attribute");
                 return -serrno;
             }
         } else {
             int serrno = errno;
-            LOG("Failed setting flags");
+            error_setg(errp, "Failed setting flags");
             return -serrno;
         }
     }
@@ -723,8 +725,10 @@ int nbd_disconnect(int fd)
 }
 
 #else
-int nbd_init(int fd, QIOChannelSocket *ioc, uint16_t flags, off_t size)
+int nbd_init(int fd, QIOChannelSocket *ioc, uint16_t flags, off_t size,
+             Error **errp)
 {
+    error_setg(errp, "nbd_init is not supported");
     return -ENOTSUP;
 }
 
@@ -758,19 +762,19 @@ ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request)
     return write_sync(ioc, buf, sizeof(buf), NULL);
 }
 
-ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
+ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
 {
     uint8_t buf[NBD_REPLY_SIZE];
     uint32_t magic;
     ssize_t ret;
 
-    ret = read_sync_eof(ioc, buf, sizeof(buf), NULL);
+    ret = read_sync_eof(ioc, buf, sizeof(buf), errp);
     if (ret <= 0) {
         return ret;
     }
 
     if (ret != sizeof(buf)) {
-        LOG("read failed");
+        error_setg(errp, "read failed");
         return -EINVAL;
     }
 
@@ -788,7 +792,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
 
     if (reply->error == ESHUTDOWN) {
         /* This works even on mingw which lacks a native ESHUTDOWN */
-        LOG("server shutting down");
+        error_setg(errp, "server shutting down");
         return -EINVAL;
     }
     TRACE("Got reply: { magic = 0x%" PRIx32 ", .error = % " PRId32
@@ -796,7 +800,7 @@ ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply)
           magic, reply->error, reply->handle);
 
     if (magic != NBD_REPLY_MAGIC) {
-        LOG("invalid magic (got 0x%" PRIx32 ")", magic);
+        error_setg(errp, "invalid magic (got 0x%" PRIx32 ")", magic);
         return -EINVAL;
     }
     return sizeof(buf);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e080fb7c75..83b8b3e1d9 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -288,8 +288,9 @@ static void *nbd_client_thread(void *arg)
         goto out_socket;
     }
 
-    ret = nbd_init(fd, sioc, nbdflags, size);
+    ret = nbd_init(fd, sioc, nbdflags, size, &local_error);
     if (ret < 0) {
+        error_report_err(local_error);
         goto out_fd;
     }
 
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index 0c13888ba1..a24c6bfece 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -69,10 +69,12 @@ read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
+read failed
 read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
+read failed
 read failed: Input/output error
 
 === Check disconnect before data ===
-- 
2.11.1

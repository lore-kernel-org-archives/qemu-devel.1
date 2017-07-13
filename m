Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4c-00023L-6d
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4Y-0004Ou-3t
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4X-0004OP-Q2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so5447375wmh.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:24 +0200
Message-Id: <1499955874-10954-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/41] nbd: Create struct for tracking export
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The NBD Protocol is introducing some additional information
about exports, such as minimum request size and alignment, as
well as an advertised maximum request size.  It will be easier
to feed this information back to the block layer if we gather
all the information into a struct, rather than adding yet more
pointer parameters during negotiation.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20170707203049.534-2-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c  | 18 ++++++++----------
 block/nbd-client.h  |  3 +--
 block/nbd.c         |  2 +-
 include/block/nbd.h | 15 +++++++++++----
 nbd/client.c        | 44 ++++++++++++++++++++++----------------------
 qemu-nbd.c          | 10 ++++------
 6 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 208f907..aab1e32 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -242,7 +242,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
     ssize_t ret;
 
     if (flags & BDRV_REQ_FUA) {
-        assert(client->nbdflags & NBD_FLAG_SEND_FUA);
+        assert(client->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
     }
 
@@ -270,12 +270,12 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     };
     NBDReply reply;
 
-    if (!(client->nbdflags & NBD_FLAG_SEND_WRITE_ZEROES)) {
+    if (!(client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
     }
 
     if (flags & BDRV_REQ_FUA) {
-        assert(client->nbdflags & NBD_FLAG_SEND_FUA);
+        assert(client->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
     }
     if (!(flags & BDRV_REQ_MAY_UNMAP)) {
@@ -299,7 +299,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     NBDReply reply;
     ssize_t ret;
 
-    if (!(client->nbdflags & NBD_FLAG_SEND_FLUSH)) {
+    if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
     }
 
@@ -327,7 +327,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
     NBDReply reply;
     ssize_t ret;
 
-    if (!(client->nbdflags & NBD_FLAG_SEND_TRIM)) {
+    if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
     }
 
@@ -385,19 +385,17 @@ int nbd_client_init(BlockDriverState *bs,
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
-                                &client->nbdflags,
                                 tlscreds, hostname,
-                                &client->ioc,
-                                &client->size, errp);
+                                &client->ioc, &client->info, errp);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
     }
-    if (client->nbdflags & NBD_FLAG_SEND_FUA) {
+    if (client->info.flags & NBD_FLAG_SEND_FUA) {
         bs->supported_write_flags = BDRV_REQ_FUA;
         bs->supported_zero_flags |= BDRV_REQ_FUA;
     }
-    if (client->nbdflags & NBD_FLAG_SEND_WRITE_ZEROES) {
+    if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
 
diff --git a/block/nbd-client.h b/block/nbd-client.h
index 49636bc..df80771 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -20,8 +20,7 @@
 typedef struct NBDClientSession {
     QIOChannelSocket *sioc; /* The master data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
-    uint16_t nbdflags;
-    off_t size;
+    NBDExportInfo info;
 
     CoMutex send_mutex;
     CoQueue free_sema;
diff --git a/block/nbd.c b/block/nbd.c
index d529305..4a9048c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -492,7 +492,7 @@ static int64_t nbd_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
 
-    return s->client.size;
+    return s->client.info.size;
 }
 
 static void nbd_detach_aio_context(BlockDriverState *bs)
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6d75d5a..9092374 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -123,13 +123,20 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256
 
+/* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
+struct NBDExportInfo {
+    uint64_t size;
+    uint16_t flags;
+};
+typedef struct NBDExportInfo NBDExportInfo;
+
 ssize_t nbd_rwv(QIOChannel *ioc, struct iovec *iov, size_t niov, size_t length,
                 bool do_read, Error **errp);
-int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
+int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
-                          QIOChannel **outioc,
-                          off_t *size, Error **errp);
-int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
+                          QIOChannel **outioc, NBDExportInfo *info,
+                          Error **errp);
+int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
 ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply, Error **errp);
diff --git a/nbd/client.c b/nbd/client.c
index 9c52b9b..1250273 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -425,13 +425,13 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
 }
 
 
-int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
+int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
-                          QIOChannel **outioc,
-                          off_t *size, Error **errp)
+                          QIOChannel **outioc, NBDExportInfo *info,
+                          Error **errp)
 {
     char buf[256];
-    uint64_t magic, s;
+    uint64_t magic;
     int rc;
     bool zeroes = true;
 
@@ -532,17 +532,17 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         }
 
         /* Read the response */
-        if (nbd_read(ioc, &s, sizeof(s), errp) < 0) {
+        if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
             error_prepend(errp, "Failed to read export length");
             goto fail;
         }
-        *size = be64_to_cpu(s);
+        be64_to_cpus(&info->size);
 
-        if (nbd_read(ioc, flags, sizeof(*flags), errp) < 0) {
+        if (nbd_read(ioc, &info->flags, sizeof(info->flags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags");
             goto fail;
         }
-        be16_to_cpus(flags);
+        be16_to_cpus(&info->flags);
     } else if (magic == NBD_CLIENT_MAGIC) {
         uint32_t oldflags;
 
@@ -555,11 +555,11 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }
 
-        if (nbd_read(ioc, &s, sizeof(s), errp) < 0) {
+        if (nbd_read(ioc, &info->size, sizeof(info->size), errp) < 0) {
             error_prepend(errp, "Failed to read export length");
             goto fail;
         }
-        *size = be64_to_cpu(s);
+        be64_to_cpus(&info->size);
 
         if (nbd_read(ioc, &oldflags, sizeof(oldflags), errp) < 0) {
             error_prepend(errp, "Failed to read export flags");
@@ -570,13 +570,13 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
             goto fail;
         }
-        *flags = oldflags;
+        info->flags = oldflags;
     } else {
         error_setg(errp, "Bad magic received");
         goto fail;
     }
 
-    trace_nbd_receive_negotiate_size_flags(*size, *flags);
+    trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
     if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
         error_prepend(errp, "Failed to read reserved block");
         goto fail;
@@ -588,13 +588,13 @@ fail:
 }
 
 #ifdef __linux__
-int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
+int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp)
 {
-    unsigned long sectors = size / BDRV_SECTOR_SIZE;
-    if (size / BDRV_SECTOR_SIZE != sectors) {
-        error_setg(errp, "Export size %lld too large for 32-bit kernel",
-                   (long long) size);
+    unsigned long sectors = info->size / BDRV_SECTOR_SIZE;
+    if (info->size / BDRV_SECTOR_SIZE != sectors) {
+        error_setg(errp, "Export size %" PRIu64 " too large for 32-bit kernel",
+                   info->size);
         return -E2BIG;
     }
 
@@ -615,8 +615,8 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
     }
 
     trace_nbd_init_set_size(sectors);
-    if (size % BDRV_SECTOR_SIZE) {
-        trace_nbd_init_trailing_bytes(size % BDRV_SECTOR_SIZE);
+    if (info->size % BDRV_SECTOR_SIZE) {
+        trace_nbd_init_trailing_bytes(info->size % BDRV_SECTOR_SIZE);
     }
 
     if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
@@ -625,9 +625,9 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size,
         return -serrno;
     }
 
-    if (ioctl(fd, NBD_SET_FLAGS, (unsigned long) flags) < 0) {
+    if (ioctl(fd, NBD_SET_FLAGS, (unsigned long) info->flags) < 0) {
         if (errno == ENOTTY) {
-            int read_only = (flags & NBD_FLAG_READ_ONLY) != 0;
+            int read_only = (info->flags & NBD_FLAG_READ_ONLY) != 0;
             trace_nbd_init_set_readonly();
 
             if (ioctl(fd, BLKROSET, (unsigned long) &read_only) < 0) {
@@ -685,7 +685,7 @@ int nbd_disconnect(int fd)
 }
 
 #else
-int nbd_init(int fd, QIOChannelSocket *ioc, uint16_t flags, off_t size,
+int nbd_init(int fd, QIOChannelSocket *ioc, NBDExportInfo *info,
 	     Error **errp)
 {
     error_setg(errp, "nbd_init is only supported on Linux");
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4dd3fd4..c8bd47f 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -255,8 +255,7 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     char *device = arg;
-    off_t size;
-    uint16_t nbdflags;
+    NBDExportInfo info;
     QIOChannelSocket *sioc;
     int fd;
     int ret;
@@ -271,9 +270,8 @@ static void *nbd_client_thread(void *arg)
         goto out;
     }
 
-    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL, &nbdflags,
-                                NULL, NULL, NULL,
-                                &size, &local_error);
+    ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL,
+                                NULL, NULL, NULL, &info, &local_error);
     if (ret < 0) {
         if (local_error) {
             error_report_err(local_error);
@@ -288,7 +286,7 @@ static void *nbd_client_thread(void *arg)
         goto out_socket;
     }
 
-    ret = nbd_init(fd, sioc, nbdflags, size, &local_error);
+    ret = nbd_init(fd, sioc, &info, &local_error);
     if (ret < 0) {
         error_report_err(local_error);
         goto out_fd;
-- 
1.8.3.1

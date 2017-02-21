Received: from eggs.gnu.org ([2001:4830:134:3::10]:40784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q0-0005Yf-UQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Pz-0003VF-3g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:09 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:42 -0600
Message-Id: <20170221024248.11027-3-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/8] nbd: Create struct for tracking export
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
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The NBD Protocol is introducing some additional information
about exports, such as minimum request size and alignment, as
well as an advertised maximum request size.  It will be easier
to feed this information back to the block layer if we gather
all the information into a struct, rather than adding yet more
pointer parameters during negotiation.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: rebase to master
v3: new patch
---
 block/nbd-client.h  |  3 +--
 include/block/nbd.h | 15 +++++++++++----
 block/nbd-client.c  | 18 ++++++++----------
 block/nbd.c         |  2 +-
 nbd/client.c        | 47 +++++++++++++++++++++++++----------------------
 qemu-nbd.c          | 10 ++++------
 6 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index f8d6006..098b65c 100644
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
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 3e373f0..8cc9cbe 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -123,16 +123,23 @@ enum {
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256

+/* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
+struct NBDExportInfo {
+    uint64_t size;
+    uint16_t flags;
+};
+typedef struct NBDExportInfo NBDExportInfo;
+
 ssize_t nbd_wr_syncv(QIOChannel *ioc,
                      struct iovec *iov,
                      size_t niov,
                      size_t length,
                      bool do_read);
-int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
+int nbd_receive_negotiate(QIOChannel *ioc, const char *name,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
-                          QIOChannel **outioc,
-                          off_t *size, Error **errp);
-int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size);
+                          QIOChannel **outioc, NBDExportInfo *info,
+                          Error **errp);
+int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
 ssize_t nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
 int nbd_client(int fd);
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 06f1532..32d7c90 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -258,7 +258,7 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
     ssize_t ret;

     if (flags & BDRV_REQ_FUA) {
-        assert(client->nbdflags & NBD_FLAG_SEND_FUA);
+        assert(client->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |= NBD_CMD_FLAG_FUA;
     }

@@ -287,12 +287,12 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
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
@@ -317,7 +317,7 @@ int nbd_client_co_flush(BlockDriverState *bs)
     NBDReply reply;
     ssize_t ret;

-    if (!(client->nbdflags & NBD_FLAG_SEND_FLUSH)) {
+    if (!(client->info.flags & NBD_FLAG_SEND_FLUSH)) {
         return 0;
     }

@@ -346,7 +346,7 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
     NBDReply reply;
     ssize_t ret;

-    if (!(client->nbdflags & NBD_FLAG_SEND_TRIM)) {
+    if (!(client->info.flags & NBD_FLAG_SEND_TRIM)) {
         return 0;
     }

@@ -405,19 +405,17 @@ int nbd_client_init(BlockDriverState *bs,
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

diff --git a/block/nbd.c b/block/nbd.c
index 35f24be..c43fa35 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -485,7 +485,7 @@ static int64_t nbd_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;

-    return s->client.size;
+    return s->client.info.size;
 }

 static void nbd_detach_aio_context(BlockDriverState *bs)
diff --git a/nbd/client.c b/nbd/client.c
index 0d16cd1..69f0e09 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -454,13 +454,13 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
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

@@ -573,17 +573,19 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         }

         /* Read the response */
-        if (read_sync(ioc, &s, sizeof(s)) != sizeof(s)) {
+        if (read_sync(ioc, &info->size, sizeof(info->size)) !=
+            sizeof(info->size)) {
             error_setg(errp, "Failed to read export length");
             goto fail;
         }
-        *size = be64_to_cpu(s);
+        be64_to_cpus(&info->size);

-        if (read_sync(ioc, flags, sizeof(*flags)) != sizeof(*flags)) {
+        if (read_sync(ioc, &info->flags, sizeof(info->flags)) !=
+            sizeof(info->flags)) {
             error_setg(errp, "Failed to read export flags");
             goto fail;
         }
-        be16_to_cpus(flags);
+        be16_to_cpus(&info->flags);
     } else if (magic == NBD_CLIENT_MAGIC) {
         uint32_t oldflags;

@@ -596,12 +598,12 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             goto fail;
         }

-        if (read_sync(ioc, &s, sizeof(s)) != sizeof(s)) {
+        if (read_sync(ioc, &info->size, sizeof(info->size)) !=
+            sizeof(info->size)) {
             error_setg(errp, "Failed to read export length");
             goto fail;
         }
-        *size = be64_to_cpu(s);
-        TRACE("Size is %" PRIu64, *size);
+        be64_to_cpus(&info->size);

         if (read_sync(ioc, &oldflags, sizeof(oldflags)) != sizeof(oldflags)) {
             error_setg(errp, "Failed to read export flags");
@@ -612,13 +614,14 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
             error_setg(errp, "Unexpected export flags %0x" PRIx32, oldflags);
             goto fail;
         }
-        *flags = oldflags;
+        info->flags = oldflags;
     } else {
         error_setg(errp, "Bad magic received");
         goto fail;
     }

-    TRACE("Size is %" PRIu64 ", export flags %" PRIx16, *size, *flags);
+    TRACE("Size is %" PRIu64 ", export flags %" PRIx16,
+          info->size, info->flags);
     if (zeroes && drop_sync(ioc, 124) != 124) {
         error_setg(errp, "Failed to read reserved block");
         goto fail;
@@ -630,11 +633,11 @@ fail:
 }

 #ifdef __linux__
-int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
+int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info)
 {
-    unsigned long sectors = size / BDRV_SECTOR_SIZE;
-    if (size / BDRV_SECTOR_SIZE != sectors) {
-        LOG("Export size %lld too large for 32-bit kernel", (long long) size);
+    unsigned long sectors = info->size / BDRV_SECTOR_SIZE;
+    if (info->size / BDRV_SECTOR_SIZE != sectors) {
+        LOG("Export size %" PRId64 " too large for 32-bit kernel", info->size);
         return -E2BIG;
     }

@@ -655,9 +658,9 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
     }

     TRACE("Setting size to %lu block(s)", sectors);
-    if (size % BDRV_SECTOR_SIZE) {
+    if (info->size % BDRV_SECTOR_SIZE) {
         TRACE("Ignoring trailing %d bytes of export",
-              (int) (size % BDRV_SECTOR_SIZE));
+              (int) (info->size % BDRV_SECTOR_SIZE));
     }

     if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
@@ -666,9 +669,9 @@ int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size)
         return -serrno;
     }

-    if (ioctl(fd, NBD_SET_FLAGS, (unsigned long) flags) < 0) {
+    if (ioctl(fd, NBD_SET_FLAGS, (unsigned long) info->flags) < 0) {
         if (errno == ENOTTY) {
-            int read_only = (flags & NBD_FLAG_READ_ONLY) != 0;
+            int read_only = (info->flags & NBD_FLAG_READ_ONLY) != 0;
             TRACE("Setting readonly attribute");

             if (ioctl(fd, BLKROSET, (unsigned long) &read_only) < 0) {
@@ -726,7 +729,7 @@ int nbd_disconnect(int fd)
 }

 #else
-int nbd_init(int fd, QIOChannelSocket *ioc, uint16_t flags, off_t size)
+int nbd_init(int fd, QIOChannelSocket *ioc, NBDExportInfo *info)
 {
     return -ENOTSUP;
 }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e4fede6..c598cbe 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -254,8 +254,7 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     char *device = arg;
-    off_t size;
-    uint16_t nbdflags;
+    NBDExportInfo info;
     QIOChannelSocket *sioc;
     int fd;
     int ret;
@@ -270,9 +269,8 @@ static void *nbd_client_thread(void *arg)
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
@@ -287,7 +285,7 @@ static void *nbd_client_thread(void *arg)
         goto out_socket;
     }

-    ret = nbd_init(fd, sioc, nbdflags, size);
+    ret = nbd_init(fd, sioc, &info);
     if (ret < 0) {
         goto out_fd;
     }
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nf-Bv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-000829-7W
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:48678 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007zh-O1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:51 +0300
Message-Id: <20170203154757.36140-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 12/18] nbd: BLOCK_STATUS for bitmap export:
 client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/nbd-client.h   |   6 +++
 block/nbd.c          |   9 +++-
 include/block/nbd.h  |   6 ++-
 nbd/client.c         | 103 +++++++++++++++++++++++++++++++++++-
 nbd/server.c         |   2 -
 qapi/block-core.json |   5 +-
 qemu-nbd.c           |   2 +-
 8 files changed, 270 insertions(+), 9 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index ff96bd1635..c7eb21fb02 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -388,6 +388,147 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
 
 }
 
+static inline ssize_t read_sync(QIOChannel *ioc, void *buffer, size_t size)
+{
+    struct iovec iov = { .iov_base = buffer, .iov_len = size };
+    /* Sockets are kept in blocking mode in the negotiation phase.  After
+     * that, a non-readable socket simply means that another thread stole
+     * our request/reply.  Synchronization is done with recv_coroutine, so
+     * that this is coroutine-safe.
+     */
+    return nbd_wr_syncv(ioc, &iov, 1, size, true);
+}
+
+static int nbd_client_co_cmd_block_status(BlockDriverState *bs, uint64_t offset,
+                                          uint64_t bytes, NBDExtent **pextents,
+                                          unsigned *nb_extents)
+{
+    int64_t ret;
+    NBDReply reply;
+    uint32_t context_id;
+    int64_t nb, i;
+    NBDExtent *extents = NULL;
+    NBDClientSession *client = nbd_get_client_session(bs);
+    NBDRequest request = {
+        .type = NBD_CMD_BLOCK_STATUS,
+        .from = offset,
+        .len = bytes,
+        .flags = 0,
+    };
+
+    nbd_coroutine_start(client, &request);
+
+    ret = nbd_co_send_request(bs, &request, NULL);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    nbd_co_receive_reply(client, &request, &reply, NULL);
+    if (reply.error != 0) {
+        ret = -reply.error;
+    }
+    if (reply.simple) {
+        ret = -EINVAL;
+        goto fail;
+    }
+    if (reply.error != 0) {
+        ret = -reply.error;
+        goto fail;
+    }
+    if (reply.type != NBD_REPLY_TYPE_BLOCK_STATUS) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    read_sync(client->ioc, &context_id, sizeof(context_id));
+    cpu_to_be32s(&context_id);
+    if (client->meta_data_context_id != context_id) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    nb = (reply.length - sizeof(context_id)) / sizeof(NBDExtent);
+    extents = g_new(NBDExtent, nb);
+    if (read_sync(client->ioc, extents, nb * sizeof(NBDExtent)) !=
+        nb * sizeof(NBDExtent))
+    {
+        ret = -EIO;
+        goto fail;
+    }
+
+    if (!(reply.flags && NBD_REPLY_FLAG_DONE)) {
+        nbd_co_receive_reply(client, &request, &reply, NULL);
+        if (reply.simple) {
+            ret = -EINVAL;
+            goto fail;
+        }
+        if (reply.error != 0) {
+            ret = -reply.error;
+            goto fail;
+        }
+        if (reply.type != NBD_REPLY_TYPE_NONE ||
+            !(reply.flags && NBD_REPLY_FLAG_DONE)) {
+            ret = -EINVAL;
+            goto fail;
+        }
+    }
+
+    for (i = 0; i < nb; ++i) {
+        cpu_to_be32s(&extents[i].length);
+        cpu_to_be32s(&extents[i].flags);
+    }
+
+    *pextents = extents;
+    *nb_extents = nb;
+    nbd_coroutine_end(client, &request);
+    return 0;
+
+fail:
+    g_free(extents);
+    nbd_coroutine_end(client, &request);
+    return ret;
+}
+
+/* nbd_client_co_load_bitmap_part() returns end of set area, i.e. first next
+ * byte of unknown status (may be >= disk size, which means that the bitmap was
+ * set up to the end).
+ */
+int64_t nbd_client_co_load_bitmap_part(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t bytes, BdrvDirtyBitmap *bitmap)
+{
+    int64_t ret;
+    uint64_t start_byte;
+    uint32_t nb_extents;
+    int64_t i, start_sector, last_sector, nr_sectors;
+    NBDExtent *extents = NULL;
+
+    ret = nbd_client_co_cmd_block_status(bs, offset, bytes, &extents,
+                                         &nb_extents);
+    if (ret < 0) {
+        return ret;
+    }
+
+    start_byte = offset;
+    for (i = 0; i < nb_extents; ++i) {
+        if (extents[i].flags == 1) {
+            start_sector = start_byte >> BDRV_SECTOR_BITS;
+            last_sector =
+                (start_byte + extents[i].length - 1) >> BDRV_SECTOR_BITS;
+            nr_sectors = last_sector - start_sector + 1;
+
+            bdrv_set_dirty_bitmap(bitmap, start_sector, nr_sectors);
+        }
+
+        start_byte += extents[i].length;
+    }
+
+    g_free(extents);
+
+    return ROUND_UP((uint64_t)start_byte,
+                    (uint64_t)bdrv_dirty_bitmap_granularity(bitmap));
+}
+
+
 void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     aio_set_fd_handler(bdrv_get_aio_context(bs),
@@ -421,6 +562,7 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    const char *bitmap_name,
                     Error **errp)
 {
     NBDClientSession *client = nbd_get_client_session(bs);
@@ -435,7 +577,9 @@ int nbd_client_init(BlockDriverState *bs,
                                 tlscreds, hostname,
                                 &client->ioc,
                                 &client->size,
-                                &client->structured_reply, errp);
+                                &client->structured_reply,
+                                bitmap_name,
+                                &client->bitmap_ok, errp);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
diff --git a/block/nbd-client.h b/block/nbd-client.h
index cba1f965bf..e5ec89b9f6 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -34,6 +34,8 @@ typedef struct NBDClientSession {
     bool is_unix;
 
     bool structured_reply;
+    bool bitmap_ok;
+    uint32_t meta_data_context_id;
 } NBDClientSession;
 
 NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
@@ -43,6 +45,7 @@ int nbd_client_init(BlockDriverState *bs,
                     const char *export_name,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
+                    const char *bitmap_name,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
 
@@ -54,9 +57,12 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                                 int count, BdrvRequestFlags flags);
 int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags);
+int64_t nbd_client_co_load_bitmap_part(BlockDriverState *bs, uint64_t offset,
+                                       uint64_t bytes, BdrvDirtyBitmap *bitmap);
 
 void nbd_client_detach_aio_context(BlockDriverState *bs);
 void nbd_client_attach_aio_context(BlockDriverState *bs,
                                    AioContext *new_context);
 
+
 #endif /* NBD_CLIENT_H */
diff --git a/block/nbd.c b/block/nbd.c
index 35f24be069..63bc3f04d0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -382,6 +382,11 @@ static QemuOptsList nbd_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "ID of the TLS credentials to use",
         },
+        {
+            .name = "bitmap",
+            .type = QEMU_OPT_STRING,
+            .help = "Name of dirty bitmap to export",
+        },
     },
 };
 
@@ -440,8 +445,8 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* NBD handshake */
-    ret = nbd_client_init(bs, sioc, s->export,
-                          tlscreds, hostname, errp);
+    ret = nbd_client_init(bs, sioc, s->export, tlscreds, hostname,
+                          qemu_opt_get(opts, "bitmap"), errp);
  error:
     if (sioc) {
         object_unref(OBJECT(sioc));
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 516a24765c..08d5e51f21 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -181,6 +181,8 @@ enum {
 #define NBD_REPLY_TYPE_ERROR ((1 << 15) + 1)
 #define NBD_REPLY_TYPE_ERROR_OFFSET ((1 << 15) + 2)
 
+#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data */
+
 ssize_t nbd_wr_syncv(QIOChannel *ioc,
                      struct iovec *iov,
                      size_t niov,
@@ -189,7 +191,9 @@ ssize_t nbd_wr_syncv(QIOChannel *ioc,
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
-                          off_t *size, bool *structured_reply, Error **errp);
+                          off_t *size, bool *structured_reply,
+                          const char *bitmap_name, bool *bitmap_ok,
+                          Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
diff --git a/nbd/client.c b/nbd/client.c
index 9225f7e30d..c3817b84fa 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -472,10 +472,101 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     return QIO_CHANNEL(tioc);
 }
 
+static int nbd_receive_query_meta_context(QIOChannel *ioc, const char *export,
+                                          const char *context, bool *ok,
+                                          Error **errp)
+{
+    int ret;
+    nbd_opt_reply reply;
+    size_t export_len = strlen(export);
+    size_t context_len = strlen(context);
+    size_t data_len = 4 + export_len + 4 + 4 + context_len;
+
+    char *data = g_malloc(data_len);
+    char *p = data;
+    int nb_reps = 0;
+
+    *ok = false;
+    stl_be_p(p, export_len);
+    memcpy(p += 4, export, export_len);
+    stl_be_p(p += export_len, 1);
+    stl_be_p(p += 4, context_len);
+    memcpy(p += 4, context, context_len);
+
+    TRACE("Requesting set_meta_context option from server");
+    ret = nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, data_len, data,
+                                errp);
+    if (ret < 0) {
+        goto out;
+    }
+
+    while (true) {
+        uint32_t context_id;
+        char *context_name;
+        size_t len;
+
+        ret = nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &reply,
+                                       errp);
+        if (ret < 0) {
+            goto out;
+        }
+
+        ret = nbd_handle_reply_err(ioc, &reply, errp);
+        if (ret <= 0) {
+            goto out;
+        }
+
+        if (reply.type != NBD_REP_META_CONTEXT) {
+            break;
+        }
+
+        if (read_sync(ioc, &context_id, sizeof(context_id)) !=
+            sizeof(context_id))
+        {
+            ret = -EIO;
+            goto out;
+        }
+
+        be32_to_cpus(&context_id);
+
+        len = reply.length - sizeof(context_id);
+        context_name = g_malloc(len + 1);
+        if (read_sync(ioc, context_name, len) != len) {
+
+            ret = -EIO;
+            goto out;
+        }
+        context_name[len] = '\0';
+
+        TRACE("set meta: %u %s", context_id, context_name);
+
+        nb_reps++;
+    }
+
+    *ok = nb_reps == 1 && reply.type == NBD_REP_ACK;
+
+out:
+    g_free(data);
+    return ret;
+}
+
+static int nbd_receive_query_bitmap(QIOChannel *ioc, const char *export,
+                                    const char *bitmap, bool *ok, Error **errp)
+{
+    char *context = g_strdup_printf("%s:%s", NBD_META_NS_BITMAPS, bitmap);
+    int ret = nbd_receive_query_meta_context(ioc, export, context, ok, errp);
+
+    g_free(context);
+
+    return ret;
+}
+
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
-                          off_t *size, bool *structured_reply, Error **errp)
+                          off_t *size, bool *structured_reply,
+                          const char *bitmap_name, bool *bitmap_ok,
+                          Error **errp)
 {
     char buf[256];
     uint64_t magic, s;
@@ -589,6 +680,16 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                     nbd_receive_simple_option(ioc, NBD_OPT_STRUCTURED_REPLY,
                                               false, NULL) == 0;
             }
+
+            if (!!structured_reply && *structured_reply && !!bitmap_name) {
+                int ret;
+                assert(!!bitmap_ok);
+                ret = nbd_receive_query_bitmap(ioc, name, bitmap_name,
+                                               bitmap_ok, errp) == 0;
+                if (ret < 0) {
+                    goto fail;
+                }
+            }
         }
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, name,
diff --git a/nbd/server.c b/nbd/server.c
index 0b7b7230df..c96dda4086 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -21,8 +21,6 @@
 #include "qapi/error.h"
 #include "nbd-internal.h"
 
-#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8) /* 1 mb of extents data */
-
 static int system_errno_to_nbd_errno(int err)
 {
     switch (err) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b42216960..0e15c73774 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2331,12 +2331,15 @@
 #
 # @tls-creds:   #optional TLS credentials ID
 #
+# @bitmap:   #optional Dirty bitmap name to export (vz-7.4)
+#
 # Since: 2.8
 ##
 { 'struct': 'BlockdevOptionsNbd',
   'data': { 'server': 'SocketAddress',
             '*export': 'str',
-            '*tls-creds': 'str' } }
+            '*tls-creds': 'str',
+            '*bitmap': 'str'} }
 
 ##
 # @BlockdevOptionsRaw:
diff --git a/qemu-nbd.c b/qemu-nbd.c
index de0099e333..cf45444faf 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -272,7 +272,7 @@ static void *nbd_client_thread(void *arg)
 
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL, &nbdflags,
                                 NULL, NULL, NULL,
-                                &size, NULL, &local_error);
+                                &size, NULL, NULL, NULL, &local_error);
     if (ret < 0) {
         if (local_error) {
             error_report_err(local_error);
-- 
2.11.0

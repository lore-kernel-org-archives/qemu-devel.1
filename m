Received: from eggs.gnu.org ([2001:4830:134:3::10]:36740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5o-0007p9-Dn
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5k-00083b-DE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:08 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:48742 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5j-00080Y-RA
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:04 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:57 +0300
Message-Id: <20170203154757.36140-19-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 18/18] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
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

Minimal realization: only first extent from the answer is used.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 block/nbd-client.h  |  5 +++++
 block/nbd.c         |  3 +++
 include/block/nbd.h |  2 +-
 nbd/client.c        | 23 ++++++++++++++++-------
 qemu-nbd.c          |  2 +-
 6 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index c7eb21fb02..e419c1497c 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -528,6 +528,44 @@ int64_t nbd_client_co_load_bitmap_part(BlockDriverState *bs, uint64_t offset,
                     (uint64_t)bdrv_dirty_bitmap_granularity(bitmap));
 }
 
+int64_t coroutine_fn nbd_client_co_get_block_status(BlockDriverState *bs,
+                                                    int64_t sector_num,
+                                                    int nb_sectors, int *pnum,
+                                                    BlockDriverState **file)
+{
+    int64_t ret;
+    uint32_t nb_extents;
+    NBDExtent *extents;
+    NBDClientSession *client = nbd_get_client_session(bs);
+
+    if (!client->block_status_ok) {
+        *pnum = nb_sectors;
+        ret = BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED;
+        if (bs->drv->protocol_name) {
+            ret |= BDRV_BLOCK_OFFSET_VALID | (sector_num * BDRV_SECTOR_SIZE);
+        }
+        return ret;
+    }
+
+    ret = nbd_client_co_cmd_block_status(bs, sector_num << BDRV_SECTOR_BITS,
+                                         nb_sectors << BDRV_SECTOR_BITS,
+                                         &extents, &nb_extents);
+    if (ret < 0) {
+        return ret;
+    }
+
+    *pnum = extents[0].length >> BDRV_SECTOR_BITS;
+    ret = (extents[0].flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_ALLOCATED) |
+          (extents[0].flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
+
+    if ((ret & BDRV_BLOCK_ALLOCATED) && !(ret & BDRV_BLOCK_ZERO)) {
+        ret |= BDRV_BLOCK_DATA;
+    }
+
+    g_free(extents);
+
+    return ret;
+}
 
 void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
@@ -579,7 +617,8 @@ int nbd_client_init(BlockDriverState *bs,
                                 &client->size,
                                 &client->structured_reply,
                                 bitmap_name,
-                                &client->bitmap_ok, errp);
+                                &client->bitmap_ok,
+                                &client->block_status_ok, errp);
     if (ret < 0) {
         logout("Failed to negotiate with the NBD server\n");
         return ret;
diff --git a/block/nbd-client.h b/block/nbd-client.h
index e5ec89b9f6..9848732628 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -34,6 +34,7 @@ typedef struct NBDClientSession {
     bool is_unix;
 
     bool structured_reply;
+    bool block_status_ok;
     bool bitmap_ok;
     uint32_t meta_data_context_id;
 } NBDClientSession;
@@ -59,6 +60,10 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
                          uint64_t bytes, QEMUIOVector *qiov, int flags);
 int64_t nbd_client_co_load_bitmap_part(BlockDriverState *bs, uint64_t offset,
                                        uint64_t bytes, BdrvDirtyBitmap *bitmap);
+int64_t coroutine_fn nbd_client_co_get_block_status(BlockDriverState *bs,
+                                                    int64_t sector_num,
+                                                    int nb_sectors, int *pnum,
+                                                    BlockDriverState **file);
 
 void nbd_client_detach_aio_context(BlockDriverState *bs);
 void nbd_client_attach_aio_context(BlockDriverState *bs,
diff --git a/block/nbd.c b/block/nbd.c
index b2b6fd1cf9..b3a28f0746 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -604,6 +604,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirty_bitmap_load     = nbd_dirty_bitmap_load,
+    .bdrv_co_get_block_status   = nbd_client_co_get_block_status,
 };
 
 static BlockDriver bdrv_nbd_tcp = {
@@ -624,6 +625,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirty_bitmap_load     = nbd_dirty_bitmap_load,
+    .bdrv_co_get_block_status   = nbd_client_co_get_block_status,
 };
 
 static BlockDriver bdrv_nbd_unix = {
@@ -644,6 +646,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_attach_aio_context    = nbd_attach_aio_context,
     .bdrv_refresh_filename      = nbd_refresh_filename,
     .bdrv_dirty_bitmap_load     = nbd_dirty_bitmap_load,
+    .bdrv_co_get_block_status   = nbd_client_co_get_block_status,
 };
 
 static void bdrv_nbd_init(void)
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 69aee1eda1..58c1a3866b 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -196,7 +196,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QIOChannel **outioc,
                           off_t *size, bool *structured_reply,
                           const char *bitmap_name, bool *bitmap_ok,
-                          Error **errp);
+                          bool *block_status_ok, Error **errp);
 int nbd_init(int fd, QIOChannelSocket *sioc, uint16_t flags, off_t size);
 ssize_t nbd_send_request(QIOChannel *ioc, NBDRequest *request);
 int nbd_receive_reply(QIOChannel *ioc, NBDReply *reply);
diff --git a/nbd/client.c b/nbd/client.c
index c3817b84fa..1b478d112c 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -563,10 +563,10 @@ static int nbd_receive_query_bitmap(QIOChannel *ioc, const char *export,
 
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
-                          QIOChannel **outioc,
-                          off_t *size, bool *structured_reply,
+                          QIOChannel **outioc, off_t *size,
+                          bool *structured_reply,
                           const char *bitmap_name, bool *bitmap_ok,
-                          Error **errp)
+                          bool *block_status_ok, Error **errp)
 {
     char buf[256];
     uint64_t magic, s;
@@ -681,11 +681,19 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                                               false, NULL) == 0;
             }
 
-            if (!!structured_reply && *structured_reply && !!bitmap_name) {
+            if (!!structured_reply && *structured_reply) {
                 int ret;
-                assert(!!bitmap_ok);
-                ret = nbd_receive_query_bitmap(ioc, name, bitmap_name,
-                                               bitmap_ok, errp) == 0;
+
+                if (!!bitmap_name) {
+                    assert(!!bitmap_ok);
+                    ret = nbd_receive_query_bitmap(ioc, name, bitmap_name,
+                                                   bitmap_ok, errp) == 0;
+                } else {
+                    ret = nbd_receive_query_meta_context(ioc, name,
+                                                         "base:allocation",
+                                                         block_status_ok,
+                                                         errp);
+                }
                 if (ret < 0) {
                     goto fail;
                 }
@@ -969,6 +977,7 @@ static int nbd_receive_structured_reply_chunk(QIOChannel *ioc, NBDReply *reply)
 
     switch (reply->type) {
     case NBD_REPLY_TYPE_NONE:
+    case NBD_REPLY_TYPE_BLOCK_STATUS:
         break;
     case NBD_REPLY_TYPE_OFFSET_DATA:
     case NBD_REPLY_TYPE_OFFSET_HOLE:
diff --git a/qemu-nbd.c b/qemu-nbd.c
index cf45444faf..e3a4733e60 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -272,7 +272,7 @@ static void *nbd_client_thread(void *arg)
 
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), NULL, &nbdflags,
                                 NULL, NULL, NULL,
-                                &size, NULL, NULL, NULL, &local_error);
+                                &size, NULL, NULL, NULL, NULL, &local_error);
     if (ret < 0) {
         if (local_error) {
             error_report_err(local_error);
-- 
2.11.0

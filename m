Received: from eggs.gnu.org ([2001:4830:134:3::10]:40919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0QA-0005fq-1J
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Q5-0003ZZ-13
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:18 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:48 -0600
Message-Id: <20170221024248.11027-9-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 8/8] nbd: Implement NBD_INFO_BLOCK_SIZE on
 client
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

The upstream NBD Protocol has defined a new extension to allow
the server to advertise block sizes to the client, as well as
a way for the client to inform the server whether it intends to
obey block sizes.

When using the block layer as the client, we will obey block
sizes; but when used as 'qemu-nbd -c' to hand off to the
kernel nbd module as the client, we are still waiting for the
kernel to implement a way for us to learn if it will honor
block sizes (perhaps by an addition to sysfs, rather than an
ioctl), as well as any way to tell the kernel what additional
block sizes to obey (NBD_SET_BLKSIZE appears to be accurate
for the minimum size, but preferred and maximum sizes would
probably be new ioctl()s), so until then, we need to make our
request for block sizes conditional.

When using ioctl(NBD_SET_BLKSIZE) to hand off to the kernel,
use the minimum block size as the sector size if it is larger
than 512, which also has the nice effect of cooperating with
(non-qemu) servers that don't do read-modify-write when
exposing a block device with 4k sectors; it might also allow
us to visit a file larger than 2T on a 32-bit kernel.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: new patch
---
 include/block/nbd.h |  6 ++++
 block/nbd-client.c  |  4 +++
 block/nbd.c         | 14 +++++++--
 nbd/client.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++---------
 qemu-nbd.c          |  2 +-
 5 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index c84e022..ae8cc12 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -143,8 +143,14 @@ enum {

 /* Details collected by NBD_OPT_EXPORT_NAME and NBD_OPT_GO */
 struct NBDExportInfo {
+    /* Set by client before nbd_receive_negotiate() */
+    bool request_sizes;
+    /* Set by server results during nbd_receive_negotiate() */
     uint64_t size;
     uint16_t flags;
+    uint32_t min_block;
+    uint32_t opt_block;
+    uint32_t max_block;
 };
 typedef struct NBDExportInfo NBDExportInfo;

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 32d7c90..7dfe4ec 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -404,6 +404,7 @@ int nbd_client_init(BlockDriverState *bs,
     logout("session init %s\n", export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);

+    client->info.request_sizes = true;
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
@@ -418,6 +419,9 @@ int nbd_client_init(BlockDriverState *bs,
     if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
+    if (client->info.min_block > bs->bl.request_alignment) {
+        bs->bl.request_alignment = client->info.min_block;
+    }

     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
diff --git a/block/nbd.c b/block/nbd.c
index c43fa35..3afd475 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -465,9 +465,17 @@ static int nbd_co_flush(BlockDriverState *bs)

 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    bs->bl.max_pdiscard = NBD_MAX_BUFFER_SIZE;
-    bs->bl.max_pwrite_zeroes = NBD_MAX_BUFFER_SIZE;
-    bs->bl.max_transfer = NBD_MAX_BUFFER_SIZE;
+    NBDClientSession *s = nbd_get_client_session(bs);
+    uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);
+
+    bs->bl.max_pdiscard = max;
+    bs->bl.max_pwrite_zeroes = max;
+    bs->bl.max_transfer = max;
+
+    if (s->info.opt_block &&
+        s->info.opt_block > bs->bl.opt_transfer) {
+        bs->bl.opt_transfer = s->info.opt_block;
+    }
 }

 static void nbd_close(BlockDriverState *bs)
diff --git a/nbd/client.c b/nbd/client.c
index b408945..9f62a02 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -399,11 +399,17 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
     info->flags = 0;

     TRACE("Attempting NBD_OPT_GO for export '%s'", wantname);
-    buf = g_malloc(2 + 4 + len + 1);
-    stw_be_p(buf, 0); /* No requests, live with whatever server sends */
-    stl_be_p(buf + 2, len);
-    memcpy(buf + 6, wantname, len);
-    if (nbd_send_option_request(ioc, NBD_OPT_GO, len + 6, buf, errp) < 0) {
+    /* At most one request, everything else up to server */
+    buf = g_malloc(2 + 2 * info->request_sizes + 4 + len);
+    stw_be_p(buf, info->request_sizes);
+    if (info->request_sizes) {
+        stw_be_p(buf + 2, NBD_INFO_BLOCK_SIZE);
+    }
+    stl_be_p(buf + 2 + 2 * info->request_sizes, len);
+    memcpy(buf + 2 + 2 * info->request_sizes + 4, wantname, len);
+    if (nbd_send_option_request(ioc, NBD_OPT_GO,
+                                2 + 2 * info->request_sizes + 4 + len, buf,
+                                errp) < 0) {
         return -1;
     }

@@ -435,8 +441,9 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             return 1;
         }
         if (reply.type != NBD_REP_INFO) {
-            error_setg(errp, "unexpected reply type %" PRIx32 ", expected %x",
-                       reply.type, NBD_REP_INFO);
+            error_setg(errp, "unexpected reply type %" PRIx32
+                       " (%s), expected %x",
+                       reply.type, nbd_rep_lookup(reply.type), NBD_REP_INFO);
             nbd_send_opt_abort(ioc);
             return -1;
         }
@@ -479,6 +486,51 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                   info->size, info->flags);
             break;

+        case NBD_INFO_BLOCK_SIZE:
+            if (len != sizeof(info->min_block) * 3) {
+                error_setg(errp, "remaining export info len %" PRIu32
+                           " is unexpected size", len);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (read_sync(ioc, &info->min_block, sizeof(info->min_block)) !=
+                sizeof(info->min_block)) {
+                error_setg(errp, "failed to read info minimum block size");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->min_block);
+            if (!is_power_of_2(info->min_block)) {
+                error_setg(errp, "server minimum block size %" PRId32
+                           "is not a power of two", info->min_block);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (read_sync(ioc, &info->opt_block, sizeof(info->opt_block)) !=
+                sizeof(info->opt_block)) {
+                error_setg(errp, "failed to read info preferred block size");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->opt_block);
+            if (!is_power_of_2(info->opt_block) ||
+                info->opt_block < info->min_block) {
+                error_setg(errp, "server preferred block size %" PRId32
+                           "is not valid", info->opt_block);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (read_sync(ioc, &info->max_block, sizeof(info->max_block)) !=
+                sizeof(info->max_block)) {
+                error_setg(errp, "failed to read info maximum block size");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->max_block);
+            TRACE("Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32,
+                  info->min_block, info->opt_block, info->max_block);
+            break;
+
         default:
             TRACE("ignoring unknown export info %" PRIu16 " (%s)", type,
                   nbd_info_lookup(type));
@@ -779,8 +831,14 @@ fail:
 #ifdef __linux__
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info)
 {
-    unsigned long sectors = info->size / BDRV_SECTOR_SIZE;
-    if (info->size / BDRV_SECTOR_SIZE != sectors) {
+    unsigned long sector_size = MAX(BDRV_SECTOR_SIZE, info->min_block);
+    unsigned long sectors = info->size / sector_size;
+
+    /* FIXME: Once the kernel module is patched to honor block sizes,
+     * and to advertise that fact to user space, we should update the
+     * hand-off to the kernel to use any block sizes we learned. */
+    assert(!info->request_sizes);
+    if (info->size / sector_size != sectors) {
         LOG("Export size %" PRId64 " too large for 32-bit kernel", info->size);
         return -E2BIG;
     }
@@ -793,18 +851,18 @@ int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info)
         return -serrno;
     }

-    TRACE("Setting block size to %lu", (unsigned long)BDRV_SECTOR_SIZE);
+    TRACE("Setting block size to %lu", sector_size);

-    if (ioctl(fd, NBD_SET_BLKSIZE, (unsigned long)BDRV_SECTOR_SIZE) < 0) {
+    if (ioctl(fd, NBD_SET_BLKSIZE, sector_size) < 0) {
         int serrno = errno;
         LOG("Failed setting NBD block size");
         return -serrno;
     }

     TRACE("Setting size to %lu block(s)", sectors);
-    if (info->size % BDRV_SECTOR_SIZE) {
-        TRACE("Ignoring trailing %d bytes of export",
-              (int) (info->size % BDRV_SECTOR_SIZE));
+    if (info->size % sector_size) {
+        TRACE("Ignoring trailing %" PRId64 " bytes of export",
+              info->size % sector_size);
     }

     if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
diff --git a/qemu-nbd.c b/qemu-nbd.c
index c598cbe..45405ce 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -254,7 +254,7 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     char *device = arg;
-    NBDExportInfo info;
+    NBDExportInfo info = { .request_sizes = false, };
     QIOChannelSocket *sioc;
     int fd;
     int ret;
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4m-0002Dx-PT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4k-0004UX-Uj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4k-0004U6-Jp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so5448621wmh.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:32 +0200
Message-Id: <1499955874-10954-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 39/41] nbd: Implement NBD_INFO_BLOCK_SIZE on
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

From: Eric Blake <eblake@redhat.com>

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
Message-Id: <20170707203049.534-10-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/nbd-client.c  |  4 +++
 block/nbd.c         | 14 +++++++--
 include/block/nbd.h |  6 ++++
 nbd/client.c        | 81 +++++++++++++++++++++++++++++++++++++++++++++--------
 nbd/trace-events    |  1 +
 qemu-nbd.c          |  2 +-
 6 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index aab1e32..25dd284 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -384,6 +384,7 @@ int nbd_client_init(BlockDriverState *bs,
     logout("session init %s\n", export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
+    client->info.request_sizes = true;
     ret = nbd_receive_negotiate(QIO_CHANNEL(sioc), export,
                                 tlscreds, hostname,
                                 &client->ioc, &client->info, errp);
@@ -398,6 +399,9 @@ int nbd_client_init(BlockDriverState *bs,
     if (client->info.flags & NBD_FLAG_SEND_WRITE_ZEROES) {
         bs->supported_zero_flags |= BDRV_REQ_MAY_UNMAP;
     }
+    if (client->info.min_block > bs->bl.request_alignment) {
+        bs->bl.request_alignment = client->info.min_block;
+    }
 
     qemu_co_mutex_init(&client->send_mutex);
     qemu_co_queue_init(&client->free_sema);
diff --git a/block/nbd.c b/block/nbd.c
index 4a9048c..a50d24b 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -472,9 +472,17 @@ static int nbd_co_flush(BlockDriverState *bs)
 
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
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 4a22eca..9c3d0a5 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -144,8 +144,14 @@ enum {
 
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
 
diff --git a/nbd/client.c b/nbd/client.c
index 1e98ca9..c3ee9f3 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -369,12 +369,17 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
     info->flags = 0;
 
     trace_nbd_opt_go_start(wantname);
-    buf = g_malloc(4 + len + 2 + 1);
+    buf = g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
     memcpy(buf + 4, wantname, len);
-    /* No requests, live with whatever server sends */
-    stw_be_p(buf + 4 + len, 0);
-    if (nbd_send_option_request(ioc, NBD_OPT_GO, len + 6, buf, errp) < 0) {
+    /* At most one request, everything else up to server */
+    stw_be_p(buf + 4 + len, info->request_sizes);
+    if (info->request_sizes) {
+        stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
+    }
+    if (nbd_send_option_request(ioc, NBD_OPT_GO,
+                                4 + len + 2 + 2 * info->request_sizes, buf,
+                                errp) < 0) {
         return -1;
     }
 
@@ -405,8 +410,9 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
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
@@ -446,6 +452,51 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
             trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
             break;
 
+        case NBD_INFO_BLOCK_SIZE:
+            if (len != sizeof(info->min_block) * 3) {
+                error_setg(errp, "remaining export info len %" PRIu32
+                           " is unexpected size", len);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (nbd_read(ioc, &info->min_block, sizeof(info->min_block),
+                         errp) < 0) {
+                error_prepend(errp, "failed to read info minimum block size");
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
+            if (nbd_read(ioc, &info->opt_block, sizeof(info->opt_block),
+                         errp) < 0) {
+                error_prepend(errp, "failed to read info preferred block size");
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
+            if (nbd_read(ioc, &info->max_block, sizeof(info->max_block),
+                         errp) < 0) {
+                error_prepend(errp, "failed to read info maximum block size");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->max_block);
+            trace_nbd_opt_go_info_block_size(info->min_block, info->opt_block,
+                                             info->max_block);
+            break;
+
         default:
             trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
             if (nbd_drop(ioc, len, errp) < 0) {
@@ -729,8 +780,14 @@ fail:
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp)
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
         error_setg(errp, "Export size %" PRIu64 " too large for 32-bit kernel",
                    info->size);
         return -E2BIG;
@@ -744,17 +801,17 @@ int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
         return -serrno;
     }
 
-    trace_nbd_init_set_block_size(BDRV_SECTOR_SIZE);
+    trace_nbd_init_set_block_size(sector_size);
 
-    if (ioctl(fd, NBD_SET_BLKSIZE, (unsigned long)BDRV_SECTOR_SIZE) < 0) {
+    if (ioctl(fd, NBD_SET_BLKSIZE, sector_size) < 0) {
         int serrno = errno;
         error_setg(errp, "Failed setting NBD block size");
         return -serrno;
     }
 
     trace_nbd_init_set_size(sectors);
-    if (info->size % BDRV_SECTOR_SIZE) {
-        trace_nbd_init_trailing_bytes(info->size % BDRV_SECTOR_SIZE);
+    if (info->size % sector_size) {
+        trace_nbd_init_trailing_bytes(info->size % sector_size);
     }
 
     if (ioctl(fd, NBD_SET_SIZE_BLOCKS, sectors) < 0) {
diff --git a/nbd/trace-events b/nbd/trace-events
index be3dce7..f5024d8 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -6,6 +6,7 @@ nbd_reply_err_unsup(uint32_t option, const char *name) "server doesn't understan
 nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
+nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_request(void) "Requesting TLS from server"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index c8bd47f..78d05be 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -255,7 +255,7 @@ static void *show_parts(void *arg)
 static void *nbd_client_thread(void *arg)
 {
     char *device = arg;
-    NBDExportInfo info;
+    NBDExportInfo info = { .request_sizes = false, };
     QIOChannelSocket *sioc;
     int fd;
     int ret;
-- 
1.8.3.1

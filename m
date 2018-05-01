Received: from eggs.gnu.org ([2001:4830:134:3::10]:46235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcax-0006nD-7P
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDcav-0001aV-NA
	for qemu-devel@nongnu.org; Tue, 01 May 2018 17:13:55 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  1 May 2018 16:13:35 -0500
Message-Id: <20180501211336.986372-4-eblake@redhat.com>
In-Reply-To: <20180501211336.986372-1-eblake@redhat.com>
References: <20180501211336.986372-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] nbd/client: Support requests of additional
 block sizing info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, edgar.kaziakhmedov@virtuozzo.com, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The NBD spec is clarifying [1] that a server may want to advertise
different limits for READ/WRITE (in our case, 32M) than for
TRIM/ZERO (in our case, nearly 4G).  Implement the client
side support for these alternate limits, by always requesting
the new information (a compliant server must ignore the
request if it is unknown), and by validating anything reported
by the server before populating the block layer limits.

[1] https://lists.debian.org/nbd/2018/03/msg00048.html

Signed-off-by: Eric Blake <eblake@redhat.com>

---

The given URL for the NBD spec was v3; it will change to be a v4
version of that patch in part to point back to this qemu commit
as a proof of implementation.
---
 include/block/nbd.h |   4 ++
 block/nbd.c         |  15 ++++++-
 nbd/client.c        | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 nbd/trace-events    |   2 +
 4 files changed, 131 insertions(+), 6 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index cbf51628f78..90ddef32bb3 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -270,6 +270,10 @@ struct NBDExportInfo {
     uint32_t min_block;
     uint32_t opt_block;
     uint32_t max_block;
+    uint32_t min_trim;
+    uint32_t max_trim;
+    uint32_t min_zero;
+    uint32_t max_zero;

     uint32_t meta_base_allocation_id;
 };
diff --git a/block/nbd.c b/block/nbd.c
index 1e2b3ba2d3b..823d10b251d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -478,8 +478,19 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
     uint32_t max = MIN_NON_ZERO(NBD_MAX_BUFFER_SIZE, s->info.max_block);

     bs->bl.request_alignment = min ? min : BDRV_SECTOR_SIZE;
-    bs->bl.max_pdiscard = max;
-    bs->bl.max_pwrite_zeroes = max;
+    if (s->info.max_trim) {
+        bs->bl.max_pdiscard = MIN(s->info.max_trim, BDRV_REQUEST_MAX_BYTES);
+    } else {
+        bs->bl.max_pdiscard = max;
+    }
+    bs->bl.pdiscard_alignment = s->info.min_trim;
+    if (s->info.max_zero) {
+        bs->bl.max_pwrite_zeroes = MIN(s->info.max_zero,
+                                       BDRV_REQUEST_MAX_BYTES);
+    } else {
+        bs->bl.max_pwrite_zeroes = max;
+    }
+    bs->bl.pwrite_zeroes_alignment = s->info.min_zero;
     bs->bl.max_transfer = max;

     if (s->info.opt_block &&
diff --git a/nbd/client.c b/nbd/client.c
index 0abb195b856..f1364747ba1 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -337,16 +337,18 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
     info->flags = 0;

     trace_nbd_opt_go_start(wantname);
-    buf = g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
+    buf = g_malloc(4 + len + 2 + 3 * 2 * info->request_sizes + 1);
     stl_be_p(buf, len);
     memcpy(buf + 4, wantname, len);
-    /* At most one request, everything else up to server */
-    stw_be_p(buf + 4 + len, info->request_sizes);
+    /* Either 0 or 3 requests, everything else up to server */
+    stw_be_p(buf + 4 + len, 3 * info->request_sizes);
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
+        stw_be_p(buf + 4 + len + 2 + 2, NBD_INFO_TRIM_SIZE);
+        stw_be_p(buf + 4 + len + 2 + 2 + 2, NBD_INFO_ZERO_SIZE);
     }
     error = nbd_send_option_request(ioc, NBD_OPT_GO,
-                                    4 + len + 2 + 2 * info->request_sizes,
+                                    4 + len + 2 + 3 * 2 * info->request_sizes,
                                     buf, errp);
     g_free(buf);
     if (error < 0) {
@@ -467,6 +469,72 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                                              info->max_block);
             break;

+        case NBD_INFO_TRIM_SIZE:
+            if (len != sizeof(info->min_trim) * 2) {
+                error_setg(errp, "remaining trim info len %" PRIu32
+                           " is unexpected size", len);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (nbd_read(ioc, &info->min_trim, sizeof(info->min_trim),
+                         errp) < 0) {
+                error_prepend(errp, "failed to read info minimum trim size: ");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->min_trim);
+            if (nbd_read(ioc, &info->max_trim, sizeof(info->max_trim),
+                         errp) < 0) {
+                error_prepend(errp,
+                              "failed to read info maximum trim size: ");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->max_trim);
+            if (!info->min_trim || !info->max_trim ||
+                (info->max_trim != UINT32_MAX &&
+                 !QEMU_IS_ALIGNED(info->max_trim, info->min_trim))) {
+                error_setg(errp, "server trim sizes %" PRIu32 "/%" PRIu32
+                           " are not valid", info->min_trim, info->max_trim);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            trace_nbd_opt_go_info_trim_size(info->min_trim, info->max_trim);
+            break;
+
+        case NBD_INFO_ZERO_SIZE:
+            if (len != sizeof(info->min_zero) * 2) {
+                error_setg(errp, "remaining zero info len %" PRIu32
+                           " is unexpected size", len);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (nbd_read(ioc, &info->min_zero, sizeof(info->min_zero),
+                         errp) < 0) {
+                error_prepend(errp, "failed to read info minimum zero size: ");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->min_zero);
+            if (nbd_read(ioc, &info->max_zero, sizeof(info->max_zero),
+                         errp) < 0) {
+                error_prepend(errp,
+                              "failed to read info maximum zero size: ");
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            be32_to_cpus(&info->max_zero);
+            if (!info->min_zero || !info->max_zero ||
+                (info->max_zero != UINT32_MAX &&
+                 !QEMU_IS_ALIGNED(info->max_zero, info->min_zero))) {
+                error_setg(errp, "server zero sizes %" PRIu32 "/%" PRIu32
+                           " are not valid", info->min_zero, info->max_zero);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            trace_nbd_opt_go_info_zero_size(info->min_zero, info->max_zero);
+            break;
+
         default:
             trace_nbd_opt_go_info_unknown(type, nbd_info_lookup(type));
             if (nbd_drop(ioc, len, errp) < 0) {
@@ -483,6 +551,46 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
         error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
         return -1;
     }
+    if (info->min_trim) {
+        if (!info->min_block) {
+            error_setg(errp, "broken server sent INFO_TRIM_SIZE without"
+                       " INFO_BLOCK_SIZE");
+            return -1;
+        }
+        if (info->min_trim < info->opt_block) {
+            error_setg(errp, "broken server sent INFO_TRIM_SIZE with"
+                       " minimum trim %" PRIu32 " less than preferred block %"
+                       PRIu32, info->min_trim, info->opt_block);
+            return -1;
+        }
+        if (info->max_trim < info->max_block) {
+            error_setg(errp, "broken server sent INFO_TRIM_SIZE with"
+                       " maximum trim %" PRIu32 " less than maximum block %"
+                       PRIu32, info->max_trim, info->max_block);
+            return -1;
+        }
+        info->max_trim = QEMU_ALIGN_DOWN(info->max_trim, info->min_block);
+    }
+    if (info->min_zero) {
+        if (!info->min_block) {
+            error_setg(errp, "broken server sent INFO_ZERO_SIZE without"
+                       " INFO_BLOCK_SIZE");
+            return -1;
+        }
+        if (info->min_zero < info->opt_block) {
+            error_setg(errp, "broken server sent INFO_ZERO_SIZE with"
+                       " minimum zero %" PRIu32 " less than preferred block %"
+                       PRIu32, info->min_zero, info->opt_block);
+            return -1;
+        }
+        if (info->max_zero < info->max_block) {
+            error_setg(errp, "broken server sent INFO_ZERO_SIZE with"
+                       " maximum zero %" PRIu32 " less than maximum block %"
+                       PRIu32, info->max_zero, info->max_block);
+            return -1;
+        }
+        info->max_zero = QEMU_ALIGN_DOWN(info->max_zero, info->min_block);
+    }
     trace_nbd_opt_go_success();
     return 1;
 }
diff --git a/nbd/trace-events b/nbd/trace-events
index dee081e7758..ddb9d0a2b3e 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -6,6 +6,8 @@ nbd_opt_go_start(const char *name) "Attempting NBD_OPT_GO for export '%s'"
 nbd_opt_go_success(void) "Export is good to go"
 nbd_opt_go_info_unknown(int info, const char *name) "Ignoring unknown info %d (%s)"
 nbd_opt_go_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t maximum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
+nbd_opt_go_info_trim_size(uint32_t minimum, uint32_t maximum) "Trim sizes are 0x%" PRIx32 ", 0x%" PRIx32
+nbd_opt_go_info_zero_size(uint32_t minimum, uint32_t maximum) "Zero sizes are 0x%" PRIx32 ", 0x%" PRIx32
 nbd_receive_query_exports_start(const char *wantname) "Querying export list for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired export name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
-- 
2.14.3

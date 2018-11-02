Received: from eggs.gnu.org ([2001:4830:134:3::10]:32863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb7C-0004b7-UL
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gIb77-0003JA-TI
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 11:12:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Nov 2018 18:11:52 +0300
Message-Id: <20181102151152.288399-4-vsementsov@virtuozzo.com>
In-Reply-To: <20181102151152.288399-1-vsementsov@virtuozzo.com>
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/3] block/nbd-client: use traces instead of
 noisy error_report_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Reduce extra noise of nbd-client, change 083 correspondingly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.c         | 27 +++++++++++++++++++++++----
 block/trace-events         |  4 ++++
 tests/qemu-iotests/083.out | 28 ----------------------------
 3 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9686ecbd5e..9b1dab6e5d 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -28,6 +28,8 @@
  */
 
 #include "qemu/osdep.h"
+
+#include "trace.h"
 #include "qapi/error.h"
 #include "nbd-client.h"
 
@@ -79,7 +81,9 @@ static coroutine_fn void nbd_read_reply_entry(void *opaque)
         assert(s->reply.handle == 0);
         ret = nbd_receive_reply(s->ioc, &s->reply, &local_err);
         if (local_err) {
-            error_report_err(local_err);
+            trace_nbd_read_reply_entry_fail(ret, error_get_pretty(local_err),
+                                            error_get_hint(local_err) ?: "");
+            error_free(local_err);
         }
         if (ret <= 0) {
             break;
@@ -771,7 +775,12 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
 
     ret = nbd_co_receive_return_code(client, request->handle, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        trace_nbd_co_request_fail(request->from, request->len, request->handle,
+                                  request->flags, request->type,
+                                  nbd_cmd_lookup(request->type),
+                                  ret, error_get_pretty(local_err),
+                                  error_get_hint(local_err) ?: "");
+        error_free(local_err);
     }
     return ret;
 }
@@ -802,7 +811,12 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
                                        &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        trace_nbd_co_request_fail(request.from, request.len, request.handle,
+                                  request.flags, request.type,
+                                  nbd_cmd_lookup(request.type),
+                                  ret, error_get_pretty(local_err),
+                                  error_get_hint(local_err) ?: "");
+        error_free(local_err);
     }
     return ret;
 }
@@ -925,7 +939,12 @@ int coroutine_fn nbd_client_co_block_status(BlockDriverState *bs,
     ret = nbd_co_receive_blockstatus_reply(client, request.handle, bytes,
                                            &extent, &local_err);
     if (local_err) {
-        error_report_err(local_err);
+        trace_nbd_co_request_fail(request.from, request.len, request.handle,
+                                  request.flags, request.type,
+                                  nbd_cmd_lookup(request.type),
+                                  ret, error_get_pretty(local_err),
+                                  error_get_hint(local_err) ?: "");
+        error_free(local_err);
     }
     if (ret < 0) {
         return ret;
diff --git a/block/trace-events b/block/trace-events
index 3e8c47bb24..f518432300 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -156,3 +156,7 @@ nvme_cmd_map_qiov_iov(void *s, int i, void *page, int pages) "s %p iov[%d] %p pa
 
 # block/iscsi.c
 iscsi_xcopy(void *src_lun, uint64_t src_off, void *dst_lun, uint64_t dst_off, uint64_t bytes, int ret) "src_lun %p offset %"PRIu64" dst_lun %p offset %"PRIu64" bytes %"PRIu64" ret %d"
+
+# block/nbd-client.c
+nbd_read_reply_entry_fail(int ret, const char *err, const char *hint) "ret = %d, err: %s%s"
+nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err, const char *hint) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s%s"
diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
index f9af8bb691..7419722cd7 100644
--- a/tests/qemu-iotests/083.out
+++ b/tests/qemu-iotests/083.out
@@ -41,8 +41,6 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect after neg2 ===
 
-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
@@ -55,40 +53,30 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
 
 === Check disconnect before request ===
 
-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error
 
 === Check disconnect after request ===
 
-Connection closed
 read failed: Input/output error
 
 === Check disconnect before reply ===
 
-Connection closed
 read failed: Input/output error
 
 === Check disconnect after reply ===
 
-Unexpected end-of-file before all bytes were read
 read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error
 
 === Check disconnect before data ===
 
-Unexpected end-of-file before all bytes were read
 read failed: Input/output error
 
 === Check disconnect after data ===
@@ -118,8 +106,6 @@ can't open device nbd+tcp://127.0.0.1:PORT/
 
 === Check disconnect after neg-classic ===
 
-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error
 
 === Check disconnect before neg1 ===
@@ -164,8 +150,6 @@ can't open device nbd+unix:///foo?socket=TEST_DIR/nbd.sock
 
 === Check disconnect after neg2 ===
 
-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error
 
 === Check disconnect 8 neg2 ===
@@ -178,40 +162,30 @@ can't open device nbd+unix:///foo?socket=TEST_DIR/nbd.sock
 
 === Check disconnect before request ===
 
-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error
 
 === Check disconnect after request ===
 
-Connection closed
 read failed: Input/output error
 
 === Check disconnect before reply ===
 
-Connection closed
 read failed: Input/output error
 
 === Check disconnect after reply ===
 
-Unexpected end-of-file before all bytes were read
 read failed: Input/output error
 
 === Check disconnect 4 reply ===
 
-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error
 
 === Check disconnect 8 reply ===
 
-Unexpected end-of-file before all bytes were read
-Connection closed
 read failed: Input/output error
 
 === Check disconnect before data ===
 
-Unexpected end-of-file before all bytes were read
 read failed: Input/output error
 
 === Check disconnect after data ===
@@ -241,8 +215,6 @@ can't open device nbd+unix:///?socket=TEST_DIR/nbd.sock
 
 === Check disconnect after neg-classic ===
 
-Unable to read from socket: Connection reset by peer
-Connection closed
 read failed: Input/output error
 
 *** done
-- 
2.18.0

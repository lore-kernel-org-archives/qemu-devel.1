Received: from eggs.gnu.org ([2001:4830:134:3::10]:51616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgl-0004hJ-Ot
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvgk-0003lW-Vl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:39 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 May 2017 18:32:11 +0200
Message-Id: <20170525163225.29954-5-pbonzini@redhat.com>
In-Reply-To: <20170525163225.29954-1-pbonzini@redhat.com>
References: <20170525163225.29954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/18] block: access serialising_in_flight with
 atomic ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                |  6 +++---
 include/block/block_int.h | 10 ++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7d31946..cc5de2c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -388,7 +388,7 @@ void bdrv_drain_all(void)
 static void tracked_request_end(BdrvTrackedRequest *req)
 {
     if (req->serialising) {
-        req->bs->serialising_in_flight--;
+        atomic_dec(&req->bs->serialising_in_flight);
     }
 
     QLIST_REMOVE(req, list);
@@ -427,7 +427,7 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
                                - overlap_offset;
 
     if (!req->serialising) {
-        req->bs->serialising_in_flight++;
+        atomic_inc(&req->bs->serialising_in_flight);
         req->serialising = true;
     }
 
@@ -532,7 +532,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
     bool retry;
     bool waited = false;
 
-    if (!bs->serialising_in_flight) {
+    if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
     }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4af44df..2fafd65 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -604,10 +604,6 @@ struct BlockDriverState {
     /* Callback before write request is processed */
     NotifierWithReturnList before_write_notifiers;
 
-    /* number of in-flight requests; overall and serialising */
-    unsigned int in_flight;
-    unsigned int serialising_in_flight;
-
     bool wakeup;
 
     /* Offset after the highest byte written to */
@@ -634,6 +630,12 @@ struct BlockDriverState {
      */
     int copy_on_read;
 
+    /* number of in-flight requests; overall and serialising.
+     * Accessed with atomic ops.
+     */
+    unsigned int in_flight;
+    unsigned int serialising_in_flight;
+
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
-- 
1.8.3.1

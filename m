Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3h-0004I3-T5
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3g-0006Ae-0P
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA3f-0006AP-QB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:53:15 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:32 +0800
Message-Id: <20170526075246.20265-9-famz@redhat.com>
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 08/22] block: access serialising_in_flight with
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
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20170525163225.29954-5-pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.4

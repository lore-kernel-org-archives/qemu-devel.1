Received: from eggs.gnu.org ([2001:4830:134:3::10]:54526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgV-0001ka-M2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhgS-0002Ds-MQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGhgS-0002Dc-GD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:11:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Jun 2017 16:11:06 +0800
Message-Id: <20170602081120.3497-9-famz@redhat.com>
In-Reply-To: <20170602081120.3497-1-famz@redhat.com>
References: <20170602081120.3497-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/22] block: access serialising_in_flight
 with atomic ops
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
index 70643df..d76202b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -375,7 +375,7 @@ void bdrv_drain_all(void)
 static void tracked_request_end(BdrvTrackedRequest *req)
 {
     if (req->serialising) {
-        req->bs->serialising_in_flight--;
+        atomic_dec(&req->bs->serialising_in_flight);
     }
 
     QLIST_REMOVE(req, list);
@@ -414,7 +414,7 @@ static void mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
                                - overlap_offset;
 
     if (!req->serialising) {
-        req->bs->serialising_in_flight++;
+        atomic_inc(&req->bs->serialising_in_flight);
         req->serialising = true;
     }
 
@@ -519,7 +519,7 @@ static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *self)
     bool retry;
     bool waited = false;
 
-    if (!bs->serialising_in_flight) {
+    if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
     }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 9691db3..e5f19eb 100644
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

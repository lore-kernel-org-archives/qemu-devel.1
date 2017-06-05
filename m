Received: from eggs.gnu.org ([2001:4830:134:3::10]:41583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHw-0008KW-O6
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHv-0005pK-Oq
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrHv-0005oQ-JE
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:15 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E1AE13A5D
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:53 +0200
Message-Id: <20170605123908.18777-5-pbonzini@redhat.com>
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
References: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/19] block: access serialising_in_flight with
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
Cc: famz@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c                |  6 +++---
 include/block/block_int.h | 10 ++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index 70643df494..d76202b452 100644
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
index 9691db35e9..e5f19eb24c 100644
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
2.13.0

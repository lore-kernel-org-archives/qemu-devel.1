Received: from eggs.gnu.org ([2001:4830:134:3::10]:33070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9nf-0004ne-8O
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT9ne-000612-Es
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:38:43 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Jul 2017 18:38:18 +0200
Message-Id: <20170706163828.24082-2-pbonzini@redhat.com>
In-Reply-To: <20170706163828.24082-1-pbonzini@redhat.com>
References: <20170706163828.24082-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code for
 thread safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

Code refactoring only.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/write-threshold.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/block/write-threshold.c b/block/write-threshold.c
index 0bd1a01c86..c8ebc32b4d 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -37,18 +37,22 @@ static void write_threshold_disable(BlockDriverState *bs)
     }
 }
 
+static uint64_t exceeded_amount(const BdrvTrackedRequest *req,
+                                uint64_t thres)
+{
+    if (thres > 0 && req->offset + req->bytes > thres) {
+        return req->offset + req->bytes - thres;
+    } else {
+        return 0;
+    }
+}
+
 uint64_t bdrv_write_threshold_exceeded(const BlockDriverState *bs,
                                        const BdrvTrackedRequest *req)
 {
-    if (bdrv_write_threshold_is_set(bs)) {
-        if (req->offset > bs->write_threshold_offset) {
-            return (req->offset - bs->write_threshold_offset) + req->bytes;
-        }
-        if ((req->offset + req->bytes) > bs->write_threshold_offset) {
-            return (req->offset + req->bytes) - bs->write_threshold_offset;
-        }
-    }
-    return 0;
+    uint64_t thres = bdrv_write_threshold_get(bs);
+
+    return exceeded_amount(req, thres);
 }
 
 static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
@@ -56,14 +60,14 @@ static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
 {
     BdrvTrackedRequest *req = opaque;
     BlockDriverState *bs = req->bs;
-    uint64_t amount = 0;
+    uint64_t thres = bdrv_write_threshold_get(bs);
+    uint64_t amount = exceeded_amount(req, thres);
 
-    amount = bdrv_write_threshold_exceeded(bs, req);
     if (amount > 0) {
         qapi_event_send_block_write_threshold(
             bs->node_name,
             amount,
-            bs->write_threshold_offset,
+            thres,
             &error_abort);
 
         /* autodisable to avoid flooding the monitor */
-- 
2.13.0

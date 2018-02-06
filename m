Received: from eggs.gnu.org ([2001:4830:134:3::10]:44755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8jA-0005mR-T9
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j1-0008IW-Qr
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8j1-0008ID-LN
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:15 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEQo7019569
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:15 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhccjugd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:14 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:13 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:14:28 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-8-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 07/54] block: Make bdrv_drain_invoke() recursive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

This change separates bdrv_drain_invoke(), which calls the BlockDriver
drain callbacks, from bdrv_drain_recurse(). Instead, the function
performs its own recursion now.

One reason for this is that bdrv_drain_recurse() can be called multiple
times by bdrv_drain_all_begin(), but the callbacks may only be called
once. The separation is necessary to fix this bug.

The other reason is that we intend to go to a model where we call all
driver callbacks first, and only then start polling. This is not fully
achieved yet with this patch, as bdrv_drain_invoke() contains a
BDRV_POLL_WHILE() loop for the block driver callbacks, which can still
call callbacks for any unrelated event. It's a step in this direction
anyway.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit db0289b9b26cb653d5662f5d6a2a52d70243cd56)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6773926fc1..096468b761 100644
--- a/block/io.c
+++ b/block/io.c
@@ -175,8 +175,10 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
     bdrv_wakeup(bs);
 }
 
+/* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
 static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 {
+    BdrvChild *child, *tmp;
     BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
 
     if (!bs->drv || (begin && !bs->drv->bdrv_co_drain_begin) ||
@@ -187,6 +189,10 @@ static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
     data.co = qemu_coroutine_create(bdrv_drain_invoke_entry, &data);
     bdrv_coroutine_enter(bs, data.co);
     BDRV_POLL_WHILE(bs, !data.done);
+
+    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
+        bdrv_drain_invoke(child->bs, begin);
+    }
 }
 
 static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
@@ -194,9 +200,6 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
     BdrvChild *child, *tmp;
     bool waited;
 
-    /* Ensure any pending metadata writes are submitted to bs->file.  */
-    bdrv_drain_invoke(bs, begin);
-
     /* Wait for drained requests to finish */
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
 
@@ -279,6 +282,7 @@ void bdrv_drained_begin(BlockDriverState *bs)
         bdrv_parent_drained_begin(bs);
     }
 
+    bdrv_drain_invoke(bs, true);
     bdrv_drain_recurse(bs, true);
 }
 
@@ -294,6 +298,7 @@ void bdrv_drained_end(BlockDriverState *bs)
     }
 
     bdrv_parent_drained_end(bs);
+    bdrv_drain_invoke(bs, false);
     bdrv_drain_recurse(bs, false);
     aio_enable_external(bdrv_get_aio_context(bs));
 }
@@ -372,6 +377,8 @@ void bdrv_drain_all_begin(void)
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
+                    /* FIXME Calling this multiple times is wrong */
+                    bdrv_drain_invoke(bs, true);
                     waited |= bdrv_drain_recurse(bs, true);
                 }
             }
@@ -393,6 +400,7 @@ void bdrv_drain_all_end(void)
         aio_context_acquire(aio_context);
         aio_enable_external(aio_context);
         bdrv_parent_drained_end(bs);
+        bdrv_drain_invoke(bs, false);
         bdrv_drain_recurse(bs, false);
         aio_context_release(aio_context);
     }
-- 
2.11.0

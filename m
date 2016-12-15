Received: from eggs.gnu.org ([2001:4830:134:3::10]:43204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCG-0004Rg-VR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCD-0001ao-Ox
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58329
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCD-0001aJ-IJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:53 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hblg007101
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:53 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm612by-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:52 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:52 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:47 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-54-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/67] block: Pass unaligned discard requests
 to drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Eric Blake <eblake@redhat.com>

Discard is advisory, so rounding the requests to alignment
boundaries is never semantically wrong from the data that
the guest sees.  But at least the Dell Equallogic iSCSI SANs
has an interesting property that its advertised discard
alignment is 15M, yet documents that discarding a sequence
of 1M slices will eventually result in the 15M page being
marked as discarded, and it is possible to observe which
pages have been discarded.

Between commits 9f1963b and b8d0a980, we converted the block
layer to a byte-based interface that ultimately ignores any
unaligned head or tail based on the driver's advertised
discard granularity, which means that qemu 2.7 refuses to
pass any discard request smaller than 15M down to the Dell
Equallogic hardware.  This is a slight regression in behavior
compared to earlier qemu, where a guest executing discards
in power-of-2 chunks used to be able to get every page
discarded, but is now left with various pages still allocated
because the guest requests did not align with the hardware's
15M pages.

Since the SCSI specification says nothing about a minimum
discard granularity, and only documents the preferred
alignment, it is best if the block layer gives the driver
every bit of information about discard requests, rather than
rounding it to alignment boundaries early.

Rework the block layer discard algorithm to mirror the write
zero algorithm: always peel off any unaligned head or tail
and manage that in isolation, then do the bulk of the request
on an aligned boundary.  The fallback when the driver returns
-ENOTSUP for an unaligned request is to silently ignore that
portion of the discard request; but for devices that can pass
the partial request all the way down to hardware, this can
result in the hardware coalescing requests and discarding
aligned pages after all.

Reported by: Peter Lieven <pl@kamp.de>
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>

(cherry picked from commit 3482b9bc411a9a12b2efde1018e1ddc906cd817e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/block/io.c b/block/io.c
index 959e140..5147080 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2437,7 +2437,7 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
-    int head, align;
+    int head, tail, align;
 
     if (!bs->drv) {
         return -ENOMEDIUM;
@@ -2460,19 +2460,15 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
         return 0;
     }
 
-    /* Discard is advisory, so ignore any unaligned head or tail */
+    /* Discard is advisory, but some devices track and coalesce
+     * unaligned requests, so we must pass everything down rather than
+     * round here.  Still, most devices will just silently ignore
+     * unaligned requests (by returning -ENOTSUP), so we must fragment
+     * the request accordingly.  */
     align = MAX(bs->bl.pdiscard_alignment, bs->bl.request_alignment);
     assert(align % bs->bl.request_alignment == 0);
     head = offset % align;
-    if (head) {
-        head = MIN(count, align - head);
-        count -= head;
-        offset += head;
-    }
-    count = QEMU_ALIGN_DOWN(count, align);
-    if (!count) {
-        return 0;
-    }
+    tail = (offset + count) % align;
 
     tracked_request_begin(&req, bs, offset, count, BDRV_TRACKED_DISCARD);
 
@@ -2483,11 +2479,34 @@ int coroutine_fn bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset,
 
     max_pdiscard = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard, INT_MAX),
                                    align);
-    assert(max_pdiscard);
+    assert(max_pdiscard >= bs->bl.request_alignment);
 
     while (count > 0) {
         int ret;
-        int num = MIN(count, max_pdiscard);
+        int num = count;
+
+        if (head) {
+            /* Make small requests to get to alignment boundaries. */
+            num = MIN(count, align - head);
+            if (!QEMU_IS_ALIGNED(num, bs->bl.request_alignment)) {
+                num %= bs->bl.request_alignment;
+            }
+            head = (head + num) % align;
+            assert(num < max_pdiscard);
+        } else if (tail) {
+            if (num > align) {
+                /* Shorten the request to the last aligned cluster.  */
+                num -= tail;
+            } else if (!QEMU_IS_ALIGNED(tail, bs->bl.request_alignment) &&
+                       tail > bs->bl.request_alignment) {
+                tail %= bs->bl.request_alignment;
+                num -= tail;
+            }
+        }
+        /* limit request size */
+        if (num > max_pdiscard) {
+            num = max_pdiscard;
+        }
 
         if (bs->drv->bdrv_co_pdiscard) {
             ret = bs->drv->bdrv_co_pdiscard(bs, offset, num);
-- 
1.9.1

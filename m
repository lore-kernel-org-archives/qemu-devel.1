Received: from eggs.gnu.org ([209.51.188.92]:40955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44d-0001SD-Uk
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44c-0003U6-P5
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52730
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44c-0003L5-K1
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:30 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1tnB096087
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:19 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegwku-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:18 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:14 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:12 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-39-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 38/97] nbd/server: fix bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eric Blake <eblake@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

bitmap_to_extents function is broken: it switches dirty variable after
every iteration, however it can process only part of dirty (or zero)
area during one iteration in case when this area is too large for one
extent.

Fortunately, the bug doesn't produce wrong extent flags: it just inserts
a zero-length extent between sequential extents representing large dirty
(or zero) area. However, zero-length extents are forbidden by the NBD
protocol. So, a careful client should consider such a reply as a server
fault, while a less-careful will likely ignore zero-length extents.

The bug can only be triggered by a client that requests block status
for nearly 4G at once (a request of 4G and larger is impossible per
the protocol, and requests smaller than 4G less the bitmap granularity
cause the loop to quit iterating rather than revisit the tail of the
large area); it also cannot trigger if the client used the
NBD_CMD_FLAG_REQ_ONE flag.  Since qemu 3.0 as client (using the
x-dirty-bitmap extension) always passes the flag, it is immune; and
we are not aware of other open-source clients that know how to request
qemu:dirty-bitmap:FOO contexts.  Clients that want to avoid the bug
could cap block status requests to a smaller length, such as 2G or 3G.

Fix this by more careful handling of dirty variable.

Bug was introduced in 3d068aff16
 "nbd/server: implement dirty bitmap export", with the whole function.
and is present in v3.0.0 release.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20180914165116.23182-1-vsementsov@virtuozzo.com>
CC: qemu-stable@nongnu.org
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: improved commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 6545916d528de7a6b784f4d10e7b236b30bfaced)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 nbd/server.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index ea5fe0eb33..12f721482d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1951,6 +1951,8 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
 
     assert(begin < overall_end && nb_extents);
     while (begin < overall_end && i < nb_extents) {
+        bool next_dirty = !dirty;
+
         if (dirty) {
             end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
         } else {
@@ -1962,6 +1964,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
             end = MIN(bdrv_dirty_bitmap_size(bitmap),
                       begin + UINT32_MAX + 1 -
                       bdrv_dirty_bitmap_granularity(bitmap));
+            next_dirty = dirty;
         }
         if (dont_fragment && end > overall_end) {
             end = overall_end;
@@ -1971,7 +1974,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
         extents[i].flags = cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
         i++;
         begin = end;
-        dirty = !dirty;
+        dirty = next_dirty;
     }
 
     bdrv_dirty_iter_free(it);
-- 
2.17.1

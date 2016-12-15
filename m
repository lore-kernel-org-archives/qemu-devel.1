Received: from eggs.gnu.org ([2001:4830:134:3::10]:43080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCC-00047I-8b
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCB-0001YS-09
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41425
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCA-0001Y3-QE
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:50 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbMS084032
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:50 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdkv8yh1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:50 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:49 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:45 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-52-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 51/67] block: Let write zeroes fallback work
 even with small max_transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>

From: Eric Blake <eblake@redhat.com>

Commit 443668ca rewrote the write_zeroes logic to guarantee that
an unaligned request never crosses a cluster boundary.  But
in the rewrite, the new code assumed that at most one iteration
would be needed to get to an alignment boundary.

However, it is easy to trigger an assertion failure: the Linux
kernel limits loopback devices to advertise a max_transfer of
only 64k.  Any operation that requires falling back to writes
rather than more efficient zeroing must obey max_transfer during
that fallback, which means an unaligned head may require multiple
iterations of the write fallbacks before reaching the aligned
boundaries, when layering a format with clusters larger than 64k
atop the protocol of file access to a loopback device.

Test case:

$ qemu-img create -f qcow2 -o cluster_size=1M file 10M
$ losetup /dev/loop2 /path/to/file
$ qemu-io -f qcow2 /dev/loop2
qemu-io> w 7m 1k
qemu-io> w -z 8003584 2093056

In fairness to Denis (as the original listed author of the culprit
commit), the faulty logic for at most one iteration is probably all
my fault in reworking his idea.  But the solution is to restore what
was in place prior to that commit: when dealing with an unaligned
head or tail, iterate as many times as necessary while fragmenting
the operation at max_transfer boundaries.

Reported-by: Ed Swierk <eswierk@skyportsystems.com>
CC: qemu-stable@nongnu.org
CC: Denis V. Lunev <den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b2f95feec5e4d546b932848dd421ec3361e8ef77)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index e579eda..959e140 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1179,6 +1179,8 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
+    int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
+                                    MAX_WRITE_ZEROES_BOUNCE_BUFFER);
 
     assert(alignment % bs->bl.request_alignment == 0);
     head = offset % alignment;
@@ -1194,9 +1196,12 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
          * boundaries.
          */
         if (head) {
-            /* Make a small request up to the first aligned sector.  */
-            num = MIN(count, alignment - head);
-            head = 0;
+            /* Make a small request up to the first aligned sector. For
+             * convenience, limit this request to max_transfer even if
+             * we don't need to fall back to writes.  */
+            num = MIN(MIN(count, max_transfer), alignment - head);
+            head = (head + num) % alignment;
+            assert(num < max_write_zeroes);
         } else if (tail && num > alignment) {
             /* Shorten the request to the last aligned sector.  */
             num -= tail;
@@ -1222,8 +1227,6 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 
         if (ret == -ENOTSUP) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
-            int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
-                                            MAX_WRITE_ZEROES_BOUNCE_BUFFER);
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
 
             if ((flags & BDRV_REQ_FUA) &&
-- 
1.9.1

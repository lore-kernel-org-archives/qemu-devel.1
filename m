Received: from eggs.gnu.org ([2001:4830:134:3::10]:48055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCT-0001Hl-Hl
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCQ-0005Sl-BP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53239
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCQ-0005SD-5r
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9gi081527
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:09 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncrm9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:09 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:08 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:13 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-39-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 38/79] blkdebug: Sanity check block layer
 guarantees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Eric Blake <eblake@redhat.com>

Commits 04ed95f4 and 1a62d0ac updated the block layer to auto-fragment
any I/O to fit within device boundaries. Additionally, when using a
minimum alignment of 4k, we want to ensure the block layer does proper
read-modify-write rather than requesting I/O on a slice of a sector.
Let's enforce that the contract is obeyed when using blkdebug.  For
now, blkdebug only allows alignment overrides, and just inherits other
limits from whatever device it is wrapping, but a future patch will
further enhance things.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170429191419.30051-5-eblake@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit e0ef439588ce1ede747f82b77d893190c1cc9f4d)
* prereq for 81c219a
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkdebug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 46bd08a..b2cee0c 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -429,6 +429,13 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
+    /* Sanity check block layer guarantees */
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+    if (bs->bl.max_transfer) {
+        assert(bytes <= bs->bl.max_transfer);
+    }
+
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
         uint64_t inject_offset = rule->options.inject.offset;
 
@@ -453,6 +460,13 @@ blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     BDRVBlkdebugState *s = bs->opaque;
     BlkdebugRule *rule = NULL;
 
+    /* Sanity check block layer guarantees */
+    assert(QEMU_IS_ALIGNED(offset, bs->bl.request_alignment));
+    assert(QEMU_IS_ALIGNED(bytes, bs->bl.request_alignment));
+    if (bs->bl.max_transfer) {
+        assert(bytes <= bs->bl.max_transfer);
+    }
+
     QSIMPLEQ_FOREACH(rule, &s->active_rules, active_next) {
         uint64_t inject_offset = rule->options.inject.offset;
 
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBp-0002e6-09
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBl-0001F0-P4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57711
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBl-0001EV-JT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:25 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0ha8t007030
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:25 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm611t1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:24 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:24 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:19 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-26-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 25/67] block: reintroduce bdrv_flush_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: John Snow <jsnow@redhat.com>

Commit fe1a9cbc moved the flush_all routine from the bdrv layer to the
block-backend layer. In doing so, however, the semantics of the routine
changed slightly such that flush_all now used blk_flush instead of
bdrv_flush.

blk_flush can fail if the attached device model reports that it is not
"available," (i.e. the tray is open.) This changed the semantics of
flush_all such that it can now fail for e.g. open CDROM drives.

Reintroduce bdrv_flush_all to regain the old semantics without having to
alter the behavior of blk_flush or blk_flush_all, which are already
'doing the right thing.'

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 4085f5c7a239567a292876f46cb59d9b19bcf6ac)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/io.c            | 25 +++++++++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/block/io.c b/block/io.c
index 420944d..487755a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1615,6 +1615,31 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
+/*
+ * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or not.
+ */
+int bdrv_flush_all(void)
+{
+    BdrvNextIterator it;
+    BlockDriverState *bs = NULL;
+    int result = 0;
+
+    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+        AioContext *aio_context = bdrv_get_aio_context(bs);
+        int ret;
+
+        aio_context_acquire(aio_context);
+        ret = bdrv_flush(bs);
+        if (ret < 0 && !result) {
+            result = ret;
+        }
+        aio_context_release(aio_context);
+    }
+
+    return result;
+}
+
+
 typedef struct BdrvCoGetBlockStatusData {
     BlockDriverState *bs;
     BlockDriverState *base;
diff --git a/include/block/block.h b/include/block/block.h
index 11c162d..acddf3b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -336,6 +336,7 @@ int bdrv_inactivate_all(void);
 /* Ensure contents are flushed to disk.  */
 int bdrv_flush(BlockDriverState *bs);
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs);
+int bdrv_flush_all(void);
 void bdrv_close_all(void);
 void bdrv_drain(BlockDriverState *bs);
 void coroutine_fn bdrv_co_drain(BlockDriverState *bs);
-- 
1.9.1

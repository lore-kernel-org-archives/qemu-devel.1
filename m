Received: from eggs.gnu.org ([2001:4830:134:3::10]:57248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f0oOY-0006kJ-IU
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1f0oOT-0001s0-Ik
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:12:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48532
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1f0oOT-0001iB-CH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:12:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2RDAsoj145383
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:11:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gyky4gtu4-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:11:52 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 27 Mar 2018 09:08:57 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 10:08:46 -0300
Message-Id: <20180327130846.21902-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] block-backend: simplify blk_get_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

blk_get_aio_context verifies if BlockDriverState bs is not NULL,
return bdrv_get_aio_context(bs) if true or qemu_get_aio_context()
otherwise. However, bdrv_get_aio_context from block.c already does
this verification itself, also returning qemu_get_aio_context()
if bs is NULL:

AioContext *bdrv_get_aio_context(BlockDriverState *bs)
{
    return bs ? bs->aio_context : qemu_get_aio_context();
}

This patch simplifies blk_get_aio_context to simply call
bdrv_get_aio_context instead of replicating the same logic.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 block/block-backend.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 681b240b12..89f47b00ea 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1865,13 +1865,7 @@ void blk_op_unblock_all(BlockBackend *blk, Error *reason)
 
 AioContext *blk_get_aio_context(BlockBackend *blk)
 {
-    BlockDriverState *bs = blk_bs(blk);
-
-    if (bs) {
-        return bdrv_get_aio_context(bs);
-    } else {
-        return qemu_get_aio_context();
-    }
+    return bdrv_get_aio_context(blk_bs(blk));
 }
 
 static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
-- 
2.14.3

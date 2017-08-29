Received: from eggs.gnu.org ([2001:4830:134:3::10]:47855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCN-00019U-Gp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCK-0005NU-Bf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCK-0005La-39
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:04 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9WX077591
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:03 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yuu0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:03 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:01 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:06 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-32-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 31/79] stream: fix crash in stream_start() when
 block_job_create() fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

From: Alberto Garcia <berto@igalia.com>

The code that tries to reopen a BlockDriverState in stream_start()
when the creation of a new block job fails crashes because it attempts
to dereference a pointer that is known to be NULL.

This is a regression introduced in a170a91fd3eab6155da39e740381867e,
likely because the code was copied from stream_complete().

Cc: qemu-stable@nongnu.org
Reported-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 525989a50a70ea0ffa2b1cdf56279765bb2b7de0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/stream.c b/block/stream.c
index 0113710..52d329f 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -280,6 +280,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
 fail:
     if (orig_bs_flags != bdrv_get_flags(bs)) {
-        bdrv_reopen(bs, s->bs_flags, NULL);
+        bdrv_reopen(bs, orig_bs_flags, NULL);
     }
 }
-- 
2.7.4

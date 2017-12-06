Received: from eggs.gnu.org ([2001:4830:134:3::10]:49658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCZ-0000qB-LI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCW-0000r3-H3
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48732
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCW-0000qS-AQ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:48 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JEsEi037203
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:47 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eppat0mfp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:47 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:46 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:15:56 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-4-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 03/55] block/mirror: check backing in
 bdrv_mirror_top_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Backing may be zero after failed bdrv_append in mirror_start_job,
which leads to SIGSEGV.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170929152255.5431-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit ce960aa9062a407d0ca15aee3dcd3bd84a4e24f9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/mirror.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 429751b9fe..03fc6d63b7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1056,6 +1056,10 @@ static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
 
 static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 {
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_append in mirror_start_job */
+        return 0;
+    }
     return bdrv_co_flush(bs->backing->bs);
 }
 
-- 
2.11.0

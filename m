Received: from eggs.gnu.org ([209.51.188.92]:41642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45M-000285-JH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45L-0003vl-Hp
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45L-0003oY-6m
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31KrcmM128186
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:03 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkq85hrfh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:00 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:04 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:09 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-36-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 35/97] block: Fix use after free error in
 bdrv_open_inherit()
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

When a block device is opened with BDRV_O_SNAPSHOT and the
bdrv_append_temp_snapshot() call fails then the error code path tries
to unref the already destroyed 'options' QDict.

This can be reproduced easily by setting TMPDIR to a location where
the QEMU process can't write:

   $ TMPDIR=/nonexistent $QEMU -drive driver=null-co,snapshot=on

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 8961be33e8ca7e809c603223803ea66ef7ea5be7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index 39f373e035..a7f6a13a74 100644
--- a/block.c
+++ b/block.c
@@ -2787,6 +2787,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     bdrv_parent_cb_change_media(bs, true);
 
     qobject_unref(options);
+    options = NULL;
 
     /* For snapshot=on, create a temporary qcow2 overlay. bs points to the
      * temporary snapshot afterwards. */
-- 
2.17.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCs-0001nD-Lx
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCp-0006FP-RB
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCp-0006DM-J2
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0Eec3006452
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:34 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmvjejm0n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:34 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:33 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:44 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-70-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 69/79] commit: Add NULL check for overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

I can't see how overlay_bs could become NULL with the current code, but
other code in this function already checks it and we can make Coverity
happy with this check, so let's add it.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit b1e1fa0c3afc7f671fbc24645bdf67949a5657e5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index fba25e2..66e3418 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -91,7 +91,9 @@ static void commit_complete(BlockJob *job, void *opaque)
 
     /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
     bdrv_ref(top);
-    bdrv_ref(overlay_bs);
+    if (overlay_bs) {
+        bdrv_ref(overlay_bs);
+    }
 
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
-- 
2.7.4

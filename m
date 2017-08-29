Received: from eggs.gnu.org ([2001:4830:134:3::10]:48544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCh-0001YY-Qp
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCe-0005oz-5j
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42402
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCd-0005nj-Vf
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EBJ8019642
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:23 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmsfn2wme-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:23 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:22 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:32 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-58-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 57/79] commit: Fix use after free in completion
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

The final bdrv_set_backing_hd() could be working on already freed nodes
because the commit job drops its references (through BlockBackends) to
both overlay_bs and top already a bit earlier.

One way to trigger the bug is hot unplugging a disk for which
blockdev_mark_auto_del() cancels the block job.

Fix this by taking BDS-level references while we're still using the
nodes.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 19ebd13ed45ad5d5f277f5914d55b83f13eb09eb)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/commit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 76a0d98..3bae46e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -89,6 +89,10 @@ static void commit_complete(BlockJob *job, void *opaque)
     int ret = data->ret;
     bool remove_commit_top_bs = false;
 
+    /* Make sure overlay_bs and top stay around until bdrv_set_backing_hd() */
+    bdrv_ref(top);
+    bdrv_ref(overlay_bs);
+
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
     blk_unref(s->base);
@@ -124,6 +128,9 @@ static void commit_complete(BlockJob *job, void *opaque)
     if (remove_commit_top_bs) {
         bdrv_set_backing_hd(overlay_bs, top, &error_abort);
     }
+
+    bdrv_unref(overlay_bs);
+    bdrv_unref(top);
 }
 
 static void coroutine_fn commit_run(void *opaque)
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCk-0001aI-8Y
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCg-0005un-Uo
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57765
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCg-0005tX-O6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8F3099488
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:26 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmr22ykgq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:26 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:25 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:35 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-61-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 60/79] commit: Fix completion with extra
 reference
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

commit_complete() can't assume that after its block_job_completed() the
job is actually immediately freed; someone else may still be holding
references. In this case, the op blockers on the intermediate nodes make
the graph reconfiguration in the completion code fail.

Call block_job_remove_all_bdrv() manually so that we know for sure that
any blockers on intermediate nodes are given up.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 4f78a16fee462471416dc49b409d57b2071cf3d9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/commit.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/commit.c b/block/commit.c
index 3bae46e..fba25e2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -119,6 +119,13 @@ static void commit_complete(BlockJob *job, void *opaque)
     }
     g_free(s->backing_file_str);
     blk_unref(s->top);
+
+    /* If there is more than one reference to the job (e.g. if called from
+     * block_job_finish_sync()), block_job_completed() won't free it and
+     * therefore the blockers on the intermediate nodes remain. This would
+     * cause bdrv_set_backing_hd() to fail. */
+    block_job_remove_all_bdrv(job);
+
     block_job_completed(&s->common, ret);
     g_free(data);
 
-- 
2.7.4

Received: from eggs.gnu.org ([209.51.188.92]:42040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB46A-0002oD-FX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB468-0004Mj-Fw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52074
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB464-0004GW-I2
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:04:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L3sVl062213
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:03:54 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkskgsyp4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:03:52 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:08 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:01 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-88-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 87/97] block: Fix invalidate_cache error path
 for parent activation
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

bdrv_co_invalidate_cache() clears the BDRV_O_INACTIVE flag before
actually activating a node so that the correct permissions etc. are
taken. In case of errors, the flag must be restored so that the next
call to bdrv_co_invalidate_cache() retries activation.

Restoring the flag was missing in the error path for a failed
parent->role->activate() call. The consequence is that this attempt to
activate all images correctly fails because we still set errp, however
on the next attempt BDRV_O_INACTIVE is already clear, so we return
success without actually retrying the failed action.

An example where this is observable in practice is migration to a QEMU
instance that has a raw format block node attached to a guest device
with share-rw=off (the default) while another process holds
BLK_PERM_WRITE for the same image. In this case, all activation steps
before parent->role->activate() succeed because raw can tolerate other
writers to the image. Only the parent callback (in particular
blk_root_activate()) tries to implement the share-rw=on property and
requests exclusive write permissions. This fails when the migration
completes and correctly displays an error. However, a manual 'cont' will
incorrectly resume the VM without calling blk_root_activate() again.

This case is described in more detail in the following bug report:
https://bugzilla.redhat.com/show_bug.cgi?id=1531888

Fix this by correctly restoring the BDRV_O_INACTIVE flag in the error
path.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 78fc3b3a26c145eebcdee992988644974b243a74)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index a7f6a13a74..50b9bd695d 100644
--- a/block.c
+++ b/block.c
@@ -4395,6 +4395,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
         if (parent->role->activate) {
             parent->role->activate(parent, &local_err);
             if (local_err) {
+                bs->open_flags |= BDRV_O_INACTIVE;
                 error_propagate(errp, local_err);
                 return;
             }
-- 
2.17.1

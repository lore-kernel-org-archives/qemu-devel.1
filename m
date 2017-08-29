Received: from eggs.gnu.org ([2001:4830:134:3::10]:48245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCZ-0001Pw-Hy
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCW-0005eD-SP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCW-0005c8-H8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0FNJl080780
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:15 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yv53-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:15 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:14 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:21 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-47-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/79] mirror: Drop permissions on s->target on
 completion
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

This fixes an assertion failure that was triggered by qemu-iotests 129
on some CI host, while the same test case didn't seem to fail on other
hosts.

Essentially the problem is that the blk_unref(s->target) in
mirror_exit() doesn't necessarily mean that the BlockBackend goes away
immediately. It is possible that the job completion was triggered nested
in mirror_drain(), which looks like this:

    BlockBackend *target = s->target;
    blk_ref(target);
    blk_drain(target);
    blk_unref(target);

In this case, the write permissions for s->target are retained until
after blk_drain(), which makes removing mirror_top_bs fail for the
active commit case (can't have a writable backing file in the chain
without the filter driver).

Explicitly dropping the permissions first means that the additional
reference doesn't hurt and the job can complete successfully even if
called from the nested blk_drain().

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 63c8ef289087a225d445319d047501d4fe593687)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/mirror.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2173a2f..4e8f124 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -514,7 +514,12 @@ static void mirror_exit(BlockJob *job, void *opaque)
 
     /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
      * inserting target_bs at s->to_replace, where we might not be able to get
-     * these permissions. */
+     * these permissions.
+     *
+     * Note that blk_unref() alone doesn't necessarily drop permissions because
+     * we might be running nested inside mirror_drain(), which takes an extra
+     * reference, so use an explicit blk_set_perm() first. */
+    blk_set_perm(s->target, 0, BLK_PERM_ALL, &error_abort);
     blk_unref(s->target);
     s->target = NULL;
 
-- 
2.7.4

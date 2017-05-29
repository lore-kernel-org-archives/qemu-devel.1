Received: from eggs.gnu.org ([2001:4830:134:3::10]:45522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGE-0000yI-8l
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGB-0006Nf-44
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:44 +0200
Message-Id: <1496070414-6744-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] mirror: Drop permissions on s->target on
 completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

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
---
 block/mirror.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index e86f8f8..e778ee0 100644
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
1.8.3.1

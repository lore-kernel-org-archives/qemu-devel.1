Received: from eggs.gnu.org ([2001:4830:134:3::10]:39877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIx-0001z5-6z
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cqAIu-0000fQ-27
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 23:17:51 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 21 Mar 2017 11:16:24 +0800
Message-Id: <20170321031635.22123-6-famz@redhat.com>
In-Reply-To: <20170321031635.22123-1-famz@redhat.com>
References: <20170321031635.22123-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 05/16] backup: Request
 BLK_PERM_AIO_CONTEXT_CHANGE on target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

What's done in the source's context change notifier is moving the
target's context to follow the new one, so we request this permission
here.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/backup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index a4fb288..546c5c5 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -636,7 +636,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     /* The target must match the source in size, so no resize here either */
-    job->target = blk_new(BLK_PERM_WRITE,
+    job->target = blk_new(BLK_PERM_WRITE | BLK_PERM_AIO_CONTEXT_CHANGE,
                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
     ret = blk_insert_bs(job->target, target, errp);
-- 
2.9.3

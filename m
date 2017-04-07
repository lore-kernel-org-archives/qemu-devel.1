Received: from eggs.gnu.org ([2001:4830:134:3::10]:46056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNnL-00080U-VW
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cwNnL-0004VT-6c
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:54:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  7 Apr 2017 14:54:11 +0800
Message-Id: <20170407065414.9143-4-famz@redhat.com>
In-Reply-To: <20170407065414.9143-1-famz@redhat.com>
References: <20170407065414.9143-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/6] mirror: Fix aio context of mirror_top_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

It should be moved to the same context as source, before inserting to the
graph.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/mirror.c b/block/mirror.c
index 9e2fecc..e904fef 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1148,6 +1148,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
      * it alive until block_job_create() even if bs has no parent. */
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMOz-0003gT-Oe
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyMOw-00074W-MI
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:49:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Apr 2017 12:49:10 -0500
Message-Id: <20170412174920.8744-3-eblake@redhat.com>
In-Reply-To: <20170412174920.8744-1-eblake@redhat.com>
References: <20170412174920.8744-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 02/12] migration: Don't lose errno across aio
 context changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

set_drity_tracking() was assuming that the errno value set by
bdrv_create_dirty_bitmap() would not be corrupted by either
blk_get_aio_context() or aio_context_release().  Rather than
audit whether this assumption is safe, rewrite the code to just
grab the value of errno sooner.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 18d50ff..9a9c214 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -350,9 +350,9 @@ static int set_dirty_tracking(void)
         aio_context_acquire(blk_get_aio_context(bmds->blk));
         bmds->dirty_bitmap = bdrv_create_dirty_bitmap(blk_bs(bmds->blk),
                                                       BLOCK_SIZE, NULL, NULL);
+        ret = -errno;
         aio_context_release(blk_get_aio_context(bmds->blk));
         if (!bmds->dirty_bitmap) {
-            ret = -errno;
             goto fail;
         }
     }
-- 
2.9.3

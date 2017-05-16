Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNf-0002U0-8r
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAjNe-0003Td-BX
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:47:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 16 May 2017 15:47:14 -0500
Message-Id: <20170516204724.1617-3-eblake@redhat.com>
In-Reply-To: <20170516204724.1617-1-eblake@redhat.com>
References: <20170516204724.1617-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/12] migration: Don't lose errno across
 aio context changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

set_dirty_tracking() was assuming that the errno value set by
bdrv_create_dirty_bitmap() would not be corrupted by either
blk_get_aio_context() or aio_context_release().  Rather than
audit whether this assumption is safe, rewrite the code to just
grab the value of errno sooner.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>

---
v2: fix commit message typo, no code change
---
 migration/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/block.c b/migration/block.c
index 8d79d84..ecc838a 100644
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
2.9.4

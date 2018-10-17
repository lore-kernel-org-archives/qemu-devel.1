Received: from eggs.gnu.org ([2001:4830:134:3::10]:52330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005I9-6x
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006XA-3u
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:24 +0300
Message-Id: <f3d26c58a772098d6c53094047685ab126fcf7f4.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 08/14] block: Use
 bdrv_reopen_set_read_only() in external_snapshot_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch replaces the bdrv_reopen() call that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index f64569795c..7a57572e1a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1701,8 +1701,7 @@ static void external_snapshot_commit(BlkActionState *common)
      * bdrv_reopen_multiple() across all the entries at once, because we
      * don't want to abort all of them if one of them fails the reopen */
     if (!atomic_read(&state->old_bs->copy_on_read)) {
-        bdrv_reopen(state->old_bs, state->old_bs->open_flags & ~BDRV_O_RDWR,
-                    NULL);
+        bdrv_reopen_set_read_only(state->old_bs, true, NULL);
     }
 
     aio_context_release(aio_context);
-- 
2.11.0

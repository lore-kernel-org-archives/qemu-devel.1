Received: from eggs.gnu.org ([2001:4830:134:3::10]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMCmy-0000yK-2w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMCmw-0001ih-6w
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:02:03 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon, 12 Nov 2018 16:00:39 +0200
Message-Id: <35768d725ca22f3599157e70d17960f998ac9a56.1542031058.git.berto@igalia.com>
In-Reply-To: <cover.1542031058.git.berto@igalia.com>
References: <cover.1542031058.git.berto@igalia.com>
In-Reply-To: <cover.1542031058.git.berto@igalia.com>
References: <cover.1542031058.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v5 07/16] block: Use
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
index 20d1d84bab..112bc62ae5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1703,8 +1703,7 @@ static void external_snapshot_commit(BlkActionState *common)
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

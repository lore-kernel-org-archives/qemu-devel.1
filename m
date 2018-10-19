Received: from eggs.gnu.org ([2001:4830:134:3::10]:38835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gDTrP-0004ra-W0
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gDTrB-00005p-4O
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:26:26 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 19 Oct 2018 15:24:46 +0300
Message-Id: <bbae2fbe4fa97068e92fd8181128cdd0df11cb82.1539950487.git.berto@igalia.com>
In-Reply-To: <cover.1539950487.git.berto@igalia.com>
References: <cover.1539950487.git.berto@igalia.com>
In-Reply-To: <cover.1539950487.git.berto@igalia.com>
References: <cover.1539950487.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 15/15] block: Assert that flags are
 up-to-date in bdrv_reopen_prepare()
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

Towards the end of bdrv_reopen_queue_child(), before starting to
process the children, the update_flags_from_options() function is
called in order to have BDRVReopenState.flags in sync with the options
from the QDict.

This is necessary because during the reopen process flags must be
updated for all nodes in the queue so bdrv_is_writable_after_reopen()
and the permission checks work correctly.

Because of that, calling update_flags_from_options() again in
bdrv_reopen_prepare() doesn't really change the flags (they are
already up-to-date). But we need to call it in order to remove those
options from QemuOpts and that way indicate that they have been
processed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block.c b/block.c
index 0a0de2dc78..1d1cf3fb5f 100644
--- a/block.c
+++ b/block.c
@@ -3143,6 +3143,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
                         Error **errp)
 {
     int ret = -1;
+    int old_flags;
     Error *local_err = NULL;
     BlockDriver *drv;
     QemuOpts *opts;
@@ -3168,7 +3169,12 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         goto error;
     }
 
+    /* This was already called in bdrv_reopen_queue_child() so the flags
+     * are up-to-date. This time we simply want to remove the options from
+     * QemuOpts in order to indicate that they have been processed. */
+    old_flags = reopen_state->flags;
     update_flags_from_options(&reopen_state->flags, opts);
+    assert(old_flags == reopen_state->flags);
 
     discard = qemu_opt_get_del(opts, "discard");
     if (discard != NULL) {
-- 
2.11.0

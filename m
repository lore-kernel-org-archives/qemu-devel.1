Received: from eggs.gnu.org ([2001:4830:134:3::10]:36693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwh-0004G0-RZ
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fwpwc-0000Yc-Jr
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:35:15 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  3 Sep 2018 17:34:04 +0300
Message-Id: <293e7df1bffd17584b6e36d11efb097ea48cd214.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
In-Reply-To: <cover.1535983918.git.berto@igalia.com>
References: <cover.1535983918.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 06/10] block: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The bdrv_reopen_prepare() function checks all options passed to each
BlockDriverState (in the reopen_state->options QDict) and makes all
necessary preparations to apply the option changes requested by the
user.

Options are removed from the QDict as they are processed, so at the
end of bdrv_reopen_prepare() only the options that can't be changed
are left. Then a loop goes over all remaining options and verifies
that the old and new values are identical, returning an error if
they're not.

The problem is that at the moment there are options that are removed
from the QDict although they can't be changed. The consequence of this
is any modification to any of those options is silently ignored:

   (qemu) qemu-io virtio0 "reopen -o discard=on"

This happens when all options from bdrv_runtime_opts are removed
from the QDict but then only a few of them are processed. Since
it's especially important that "node-name" and "driver" are not
changed, the code puts them back into the QDict so they are checked
at the end of the function. Instead of putting only those two options
back into the QDict, this patch puts all unprocessed options using
qemu_opts_to_qdict().

update_flags_from_options() also needs to be modified to prevent
BDRV_OPT_CACHE_NO_FLUSH, BDRV_OPT_CACHE_DIRECT and BDRV_OPT_READ_ONLY
from going back to the QDict.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index 5223d16f1b..1c0f72454a 100644
--- a/block.c
+++ b/block.c
@@ -1094,19 +1094,19 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
     *flags &= ~BDRV_O_CACHE_MASK;
 
     assert(qemu_opt_find(opts, BDRV_OPT_CACHE_NO_FLUSH));
-    if (qemu_opt_get_bool(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
+    if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_NO_FLUSH, false)) {
         *flags |= BDRV_O_NO_FLUSH;
     }
 
     assert(qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT));
-    if (qemu_opt_get_bool(opts, BDRV_OPT_CACHE_DIRECT, false)) {
+    if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_DIRECT, false)) {
         *flags |= BDRV_O_NOCACHE;
     }
 
     *flags &= ~BDRV_O_RDWR;
 
     assert(qemu_opt_find(opts, BDRV_OPT_READ_ONLY));
-    if (!qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false)) {
+    if (!qemu_opt_get_bool_del(opts, BDRV_OPT_READ_ONLY, false)) {
         *flags |= BDRV_O_RDWR;
     }
 
@@ -3155,7 +3155,6 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     BlockDriver *drv;
     QemuOpts *opts;
     QDict *orig_reopen_opts;
-    const char *value;
     bool read_only;
 
     assert(reopen_state != NULL);
@@ -3178,17 +3177,10 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     update_flags_from_options(&reopen_state->flags, opts);
 
-    /* node-name and driver must be unchanged. Put them back into the QDict, so
-     * that they are checked at the end of this function. */
-    value = qemu_opt_get(opts, "node-name");
-    if (value) {
-        qdict_put_str(reopen_state->options, "node-name", value);
-    }
-
-    value = qemu_opt_get(opts, "driver");
-    if (value) {
-        qdict_put_str(reopen_state->options, "driver", value);
-    }
+    /* All other options (including node-name and driver) must be unchanged.
+     * Put them back into the QDict, so that they are checked at the end
+     * of this function. */
+    qemu_opts_to_qdict(opts, reopen_state->options);
 
     /* If we are to stay read-only, do not allow permission change
      * to r/w. Attempting to set to r/w may fail if either BDRV_O_ALLOW_RDWR is
-- 
2.11.0

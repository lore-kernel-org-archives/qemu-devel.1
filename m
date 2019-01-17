Received: from eggs.gnu.org ([209.51.188.92]:39003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gn-0001s4-9a
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gh-0007bk-Kj
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:41 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:58 +0200
Message-Id: <6ec504767392cb91591542c416f0c2ae52f847f8.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
In-Reply-To: <cover.1547739122.git.berto@igalia.com>
References: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 07/13] block: Allow omitting the 'backing'
 option in certain cases
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

Of all options of type BlockdevRef used to specify children in
BlockdevOptions, 'backing' is the only one that is optional.

For "x-blockdev-reopen" we want that if an option is omitted then it
must be reset to its default value. The default value of 'backing'
means that QEMU opens the backing file specified in the image
metadata, but this is not something that we want to support for the
reopen operation.

Because of this the 'backing' option has to be specified during
reopen, pointing to the existing backing file if we want to keep it,
or pointing to a different one (or NULL) if we want to replace it (to
be implemented in a subsequent patch).

In order to simplify things a bit and not to require that the user
passes the 'backing' option to every single block device even when
it's clearly not necessary, this patch allows omitting this option if
the block device being reopened doesn't have a backing file attached
_and_ no default backing file is specified in the image metadata.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index fd51f1cd35..897c8b85cd 100644
--- a/block.c
+++ b/block.c
@@ -3336,7 +3336,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     drv_prepared = true;
 
-    if (reopen_state->backing_missing) {
+    /*
+     * We must provide the 'backing' option if the BDS has a backing
+     * file or if the image file has a backing file name as part of
+     * its metadata. Otherwise the 'backing' option can be omitted.
+     */
+    if (reopen_state->backing_missing &&
+        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret = -EINVAL;
-- 
2.11.0

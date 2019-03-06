Received: from eggs.gnu.org ([209.51.188.92]:59929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b2f-00058a-6C
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1b2V-0006ma-Ml
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:13:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  6 Mar 2019 20:11:07 +0200
Message-Id: <2aa65ff5c15e667d64aea53b6787205c0344b6c5.1551895814.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
In-Reply-To: <cover.1551895813.git.berto@igalia.com>
References: <cover.1551895813.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 07/13] block: Allow omitting the 'backing'
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
index d7fa577c18..6db8a65e61 100644
--- a/block.c
+++ b/block.c
@@ -3414,7 +3414,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
 
     drv_prepared = true;
 
-    if (drv->supports_backing && reopen_state->backing_missing) {
+    /*
+     * We must provide the 'backing' option if the BDS has a backing
+     * file or if the image file has a backing file name as part of
+     * its metadata. Otherwise the 'backing' option can be omitted.
+     */
+    if (drv->supports_backing && reopen_state->backing_missing &&
+        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
         ret = -EINVAL;
-- 
2.11.0

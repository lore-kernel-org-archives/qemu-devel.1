Received: from eggs.gnu.org ([2001:4830:134:3::10]:56783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxvEl-0002jC-TV
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 10:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxvEh-0001FY-UE
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 10:26:23 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  6 Sep 2018 17:25:41 +0300
Message-Id: <20180906142541.8238-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] block: Fix use after free error in
 bdrv_open_inherit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

When a block device is opened with BDRV_O_SNAPSHOT and the
bdrv_append_temp_snapshot() call fails then the error code path tries
to unref the already destroyed 'options' QDict.

This can be reproduced easily by setting TMPDIR to a location where
the QEMU process can't write:

   $ TMPDIR=/nonexistent $QEMU -drive driver=null-co,snapshot=on

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index 0dbb1fcc7b..a381c8ece8 100644
--- a/block.c
+++ b/block.c
@@ -2792,6 +2792,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     bdrv_parent_cb_change_media(bs, true);
 
     qobject_unref(options);
+    options = NULL;
 
     /* For snapshot=on, create a temporary qcow2 overlay. bs points to the
      * temporary snapshot afterwards. */
-- 
2.11.0

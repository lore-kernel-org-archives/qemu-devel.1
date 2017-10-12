Received: from eggs.gnu.org ([2001:4830:134:3::10]:39014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1e2eFs-00044K-KK
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1e2eFr-0000dv-RZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:14:32 -0400
From: Peter Krempa <pkrempa@redhat.com>
Date: Thu, 12 Oct 2017 16:14:10 +0200
Message-Id: <bdbb9d79839f3149db9cf2ff11a2cc04977e0a64.1507817548.git.pkrempa@redhat.com>
Subject: [Qemu-devel] [PATCH] block: don't add 'driver' to options when
 refering to backing via node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Peter Krempa <pkrempa@redhat.com>

When refering to a backing file of an image via node name
bdrv_open_backing_file would add the 'driver' option to the option list
filling it with the backing format driver. This breaks construction of
the backing chain via -blockdev, as bdrv_open_inherit reports an error
if both 'reference' and 'options' are provided.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 46eb1728da..684cb018da 100644
--- a/block.c
+++ b/block.c
@@ -2245,7 +2245,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         goto free_exit;
     }

-    if (bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
+    if (!reference &&
+        bs->backing_format[0] != '\0' && !qdict_haskey(options, "driver")) {
         qdict_put_str(options, "driver", bs->backing_format);
     }

-- 
2.14.1

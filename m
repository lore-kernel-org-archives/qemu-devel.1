Received: from eggs.gnu.org ([2001:4830:134:3::10]:58449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2o-000073-GV
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e7i2n-0001cG-A5
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:17:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 26 Oct 2017 15:17:07 +0200
Message-Id: <20171026131741.5059-2-kwolf@redhat.com>
In-Reply-To: <20171026131741.5059-1-kwolf@redhat.com>
References: <20171026131741.5059-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/35] block: don't add 'driver' to options when
 referring to backing via node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Peter Krempa <pkrempa@redhat.com>

When referring to a backing file of an image via node name
bdrv_open_backing_file would add the 'driver' option to the option list
filling it with the backing format driver. This breaks construction of
the backing chain via -blockdev, as bdrv_open_inherit reports an error
if both 'reference' and 'options' are provided.

$ qemu-img create -f raw /tmp/backing.raw 64M
$ qemu-img create -f qcow2 -F raw -b /tmp/backing.raw /tmp/test.qcow2
$ qemu-system-x86_64 \
  -blockdev driver=file,filename=/tmp/backing.raw,node-name=backing \
  -blockdev driver=qcow2,file.driver=file,file.filename=/tmp/test.qcow2,node-name=root,backing=backing
qemu-system-x86_64: -blockdev driver=qcow2,file.driver=file,file.filename=/tmp/test.qcow2,node-name=root,backing=backing: Could not open backing file: Cannot reference an existing block device with additional options or a new filename

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.13.6

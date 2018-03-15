Received: from eggs.gnu.org ([2001:4830:134:3::10]:35335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewJpZ-0006rH-BJ
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewJpY-0003ao-E9
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:45:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 15 Mar 2018 11:45:07 +0800
Message-Id: <20180315034507.6341-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] vvfat: Fix inherit_options flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

Overriding flags violates the precedence rules of
bdrv_reopen_queue_child. Just like the read-only option, no-flush should
be put into the options. The same is done in bdrv_temp_snapshot_options.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/vvfat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 4a17a49e12..1569783b0f 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3129,7 +3129,7 @@ static void vvfat_qcow_options(int *child_flags, QDict *child_options,
                                int parent_flags, QDict *parent_options)
 {
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
-    *child_flags = BDRV_O_NO_FLUSH;
+    qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
 }
 
 static const BdrvChildRole child_vvfat_qcow = {
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKd-0000dH-EZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXTKY-0007hF-PF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:18:35 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 18 Jul 2017 16:17:55 +0200
Message-Id: <1500387486-5469-11-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
References: <1500387486-5469-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/21] block: List anonymous device BBs in
 query-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Instead of listing only monitor-owned BlockBackends in query-block, also
add those anonymous BlockBackends that are owned by a qdev device and as
such under the control of the user.

This allows using query-block to inspect BlockBackends for the modern
configuration syntax with -blockdev and -device.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 block/qapi.c | 2 +-
 hmp.c        | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 164dd2b..95b2e2d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -475,7 +475,7 @@ BlockInfoList *qmp_query_block(Error **errp)
     for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
         BlockInfoList *info;
 
-        if (!*blk_name(blk)) {
+        if (!*blk_name(blk) && !blk_get_attached_dev(blk)) {
             continue;
         }
 
diff --git a/hmp.c b/hmp.c
index 0e57f47..bf1de74 100644
--- a/hmp.c
+++ b/hmp.c
@@ -401,16 +401,16 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
 
     assert(!info || !info->has_inserted || info->inserted == inserted);
 
-    if (info) {
+    if (info && *info->device) {
         monitor_printf(mon, "%s", info->device);
         if (inserted && inserted->has_node_name) {
             monitor_printf(mon, " (%s)", inserted->node_name);
         }
     } else {
-        assert(inserted);
+        assert(info || inserted);
         monitor_printf(mon, "%s",
-                       inserted->has_node_name
-                       ? inserted->node_name
+                       inserted && inserted->has_node_name ? inserted->node_name
+                       : info && info->has_qdev ? info->qdev
                        : "<anonymous>");
     }
 
-- 
1.8.3.1

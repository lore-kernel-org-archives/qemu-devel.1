Received: from eggs.gnu.org ([2001:4830:134:3::10]:36494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dXj1c-0007hn-5i
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dXj1Y-0005Q2-8k
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:04:00 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:38607)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dXj1X-0005Ha-Mi
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:03:56 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 19 Jul 2017 23:17:32 +0800
Message-Id: <1500477452-59643-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] vhost: fix a migration failed because of vhost
 region merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>, Wang Yechao <wang.yechao255@zte.com.cn>

When a guest that has several hotplugged dimms is migrated, in
destination host it will fail to resume. Because vhost regions of
several dimms in source host are merged and in the restore stage
in destination host it computes whether more than vhost slot limit
before merging vhost regions of several dimms.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 hw/mem/pc-dimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index ea67b46..bb0fa08 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -101,7 +101,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
         goto out;
     }
 
-    if (!vhost_has_free_slot()) {
+    if (!vhost_has_free_slot() && runstate_is_running()) {
         error_setg(&local_err, "a used vhost backend has no free"
                                " memory slots left");
         goto out;
-- 
1.8.3.1

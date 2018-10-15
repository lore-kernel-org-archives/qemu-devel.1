Received: from eggs.gnu.org ([2001:4830:134:3::10]:45542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX9-0004Ke-Ln
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByX8-0004Hq-2l
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByX7-000437-IE
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:25 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:14 +0800
Message-Id: <1539593186-32183-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 14/26] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 477853d..7e7deec 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3714,6 +3714,7 @@ int colo_init_ram_cache(void)
     }
     ram_state = g_new0(RAMState, 1);
     ram_state->migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -3735,6 +3736,7 @@ void colo_release_ram_cache(void)
 {
     RAMBlock *block;
 
+    memory_global_dirty_log_stop();
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         g_free(block->bmap);
         block->bmap = NULL;
@@ -3985,6 +3987,13 @@ static void colo_flush_ram_cache(void)
     void *src_host;
     unsigned long offset = 0;
 
+    memory_global_dirty_log_sync();
+    rcu_read_lock();
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        migration_bitmap_sync_range(ram_state, block, 0, block->used_length);
+    }
+    rcu_read_unlock();
+
     trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
     rcu_read_lock();
     block = QLIST_FIRST_RCU(&ram_list.blocks);
-- 
2.5.0

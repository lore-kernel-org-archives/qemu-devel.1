Received: from eggs.gnu.org ([2001:4830:134:3::10]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybh-0003wX-BG
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eWybg-0004OX-BJ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:25 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eWybg-0004Nh-5I
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 01:02:24 -0500
Received: by mail-pg0-x241.google.com with SMTP id t67so340181pgc.5
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 22:02:23 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu,  4 Jan 2018 14:01:11 +0800
Message-Id: <1515045675-6993-13-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH RESEND V3 12/16] COLO: flush host dirty ram
 from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/ram.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 23c67e0..0188712 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2679,6 +2679,7 @@ int colo_init_ram_cache(void)
     }
     ram_state = g_new0(RAMState, 1);
     ram_state->migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -2699,10 +2700,12 @@ void colo_release_ram_cache(void)
 {
     RAMBlock *block;
 
+    memory_global_dirty_log_stop();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         g_free(block->bmap);
         block->bmap = NULL;
     }
+
     rcu_read_lock();
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         if (block->colo_cache) {
@@ -2919,6 +2922,15 @@ static void colo_flush_ram_cache(void)
     void *src_host;
     unsigned long offset = 0;
 
+    memory_global_dirty_log_sync();
+    qemu_mutex_lock(&ram_state->bitmap_mutex);
+    rcu_read_lock();
+    RAMBLOCK_FOREACH(block) {
+        migration_bitmap_sync_range(ram_state, block, 0, block->used_length);
+    }
+    rcu_read_unlock();
+    qemu_mutex_unlock(&ram_state->bitmap_mutex);
+
     trace_colo_flush_ram_cache_begin(ram_state->migration_dirty_pages);
     rcu_read_lock();
     block = QLIST_FIRST_RCU(&ram_list.blocks);
-- 
2.7.4

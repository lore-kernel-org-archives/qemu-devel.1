Received: from eggs.gnu.org ([2001:4830:134:3::10]:42399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI6M8-0004LU-Ak
	for qemu-devel@nongnu.org; Mon, 14 May 2018 01:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fI46s-0000eD-Ir
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:15 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fI46s-0000da-CV
	for qemu-devel@nongnu.org; Sun, 13 May 2018 23:25:14 -0400
Received: by mail-pl0-x242.google.com with SMTP id w19-v6so3895300plq.4
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 20:25:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 14 May 2018 11:23:44 +0800
Message-Id: <1526268228-27951-14-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
References: <1526268228-27951-1-git-send-email-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V7 13/17] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/ram.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4235a8f..21027c5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2786,6 +2786,7 @@ int colo_init_ram_cache(void)
     }
     ram_state = g_new0(RAMState, 1);
     ram_state->migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -2806,10 +2807,12 @@ void colo_release_ram_cache(void)
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
@@ -3042,6 +3045,15 @@ static void colo_flush_ram_cache(void)
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

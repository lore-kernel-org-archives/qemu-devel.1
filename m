Received: from eggs.gnu.org ([2001:4830:134:3::10]:49896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHHK-0004Kc-S7
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fYHHK-0006km-1q
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:43:02 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fYHHJ-0006k3-Sh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 16:43:02 -0400
Received: by mail-pg0-x241.google.com with SMTP id o11-v6so1427815pgv.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:43:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 28 Jun 2018 04:41:30 +0800
Message-Id: <20180627204136.4177-15-zhangckid@gmail.com>
In-Reply-To: <20180627204136.4177-1-zhangckid@gmail.com>
References: <20180627204136.4177-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V9 14/20] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4199d64ebd..fc0151cbfc 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3125,6 +3125,7 @@ int colo_init_ram_cache(void)
     }
     ram_state = g_new0(RAMState, 1);
     ram_state->migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -3145,10 +3146,12 @@ void colo_release_ram_cache(void)
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
@@ -3381,6 +3384,13 @@ static void colo_flush_ram_cache(void)
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
2.17.GIT

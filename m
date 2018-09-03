Received: from eggs.gnu.org ([2001:4830:134:3::10]:56510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgga-0000kZ-OD
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fwgga-0005v9-1Z
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:42:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fwggZ-0005uF-R5
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:41:59 -0400
Received: by mail-pf1-x444.google.com with SMTP id j8-v6so8108538pff.6
	for <qemu-devel@nongnu.org>; Sun, 02 Sep 2018 21:41:59 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon,  3 Sep 2018 12:38:55 +0800
Message-Id: <20180903043900.28592-15-zhangckid@gmail.com>
In-Reply-To: <20180903043900.28592-1-zhangckid@gmail.com>
References: <20180903043900.28592-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH V12 14/19] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <chen.zhang@intel.com>

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index a478d85740..739458be5b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3665,6 +3665,7 @@ int colo_init_ram_cache(void)
     }
     ram_state = g_new0(RAMState, 1);
     ram_state->migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -3686,6 +3687,7 @@ void colo_release_ram_cache(void)
 {
     RAMBlock *block;
 
+    memory_global_dirty_log_stop();
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         g_free(block->bmap);
         block->bmap = NULL;
@@ -3936,6 +3938,13 @@ static void colo_flush_ram_cache(void)
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

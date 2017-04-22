Received: from eggs.gnu.org ([2001:4830:134:3::10]:34178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXF-00013e-NW
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXC-0003tT-Kl
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3510
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qXC-0003rQ-27
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:50 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:25 +0800
Message-ID: <1492850128-17472-16-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 15/18] COLO: flush host dirty ram
 from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
v2:
 - stop dirty log after exit from COLO state. (Dave)
---
 migration/ram.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index f171a82..7bf3515 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2775,6 +2775,7 @@ int colo_init_ram_cache(void)
     ram_state.ram_bitmap = g_new0(RAMBitmap, 1);
     ram_state.ram_bitmap->bmap = bitmap_new(last_ram_page());
     ram_state.migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -2798,6 +2799,7 @@ void colo_release_ram_cache(void)
 
     atomic_rcu_set(&ram_state.ram_bitmap, NULL);
     if (bitmap) {
+        memory_global_dirty_log_stop();
         call_rcu(bitmap, migration_bitmap_free, rcu);
     }
 
@@ -2822,6 +2824,16 @@ void colo_flush_ram_cache(void)
     void *src_host;
     unsigned long offset = 0;
 
+    memory_global_dirty_log_sync();
+    qemu_mutex_lock(&ram_state.bitmap_mutex);
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        migration_bitmap_sync_range(&ram_state, block, block->offset,
+                                    block->used_length);
+    }
+    rcu_read_unlock();
+    qemu_mutex_unlock(&ram_state.bitmap_mutex);
+
     trace_colo_flush_ram_cache_begin(ram_state.migration_dirty_pages);
     rcu_read_lock();
     block = QLIST_FIRST_RCU(&ram_list.blocks);
-- 
1.8.3.1

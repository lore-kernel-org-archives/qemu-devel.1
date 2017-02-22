Received: from eggs.gnu.org ([2001:4830:134:3::10]:42636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpR-0004j4-03
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpM-0002ve-OR
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:57 -0500
Received: from [45.249.212.188] (port=2933 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpM-0002rt-53
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:52 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:16 +0800
Message-ID: <1487734936-43472-16-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 15/15] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>

Don't need to flush all VM's ram from cache, only
flush the dirty pages since last checkpoint

Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 migration/ram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 6227b94..e9ba740 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2702,6 +2702,7 @@ int colo_init_ram_cache(void)
     migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
     migration_bitmap_rcu->bmap = bitmap_new(ram_cache_pages);
     migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
 
     return 0;
 
@@ -2750,6 +2751,15 @@ void colo_flush_ram_cache(void)
     void *src_host;
     ram_addr_t offset = 0;
 
+    memory_global_dirty_log_sync();
+    qemu_mutex_lock(&migration_bitmap_mutex);
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        migration_bitmap_sync_range(block->offset, block->used_length);
+    }
+    rcu_read_unlock();
+    qemu_mutex_unlock(&migration_bitmap_mutex);
+
     trace_colo_flush_ram_cache_begin(migration_dirty_pages);
     rcu_read_lock();
     block = QLIST_FIRST_RCU(&ram_list.blocks);
-- 
1.8.3.1

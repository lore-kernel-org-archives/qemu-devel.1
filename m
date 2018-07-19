Received: from eggs.gnu.org ([2001:4830:134:3::10]:35106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qs-0002Gi-Nm
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qr-0005bm-Nn
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:16:10 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fg7qr-0005bB-HP
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:16:09 -0400
Received: by mail-pl0-x243.google.com with SMTP id 6-v6so3585895plb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:16:09 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu, 19 Jul 2018 20:15:20 +0800
Message-Id: <20180719121520.30026-9-xiaoguangrong@tencent.com>
In-Reply-To: <20180719121520.30026-1-xiaoguangrong@tencent.com>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 8/8] migration: do not flush_compressed_data
 at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

flush_compressed_data() needs to wait all compression threads to
finish their work, after that all threads are free until the
migration feeds new request to them, reducing its call can improve
the throughput and use CPU resource more effectively

We do not need to flush all threads at the end of iteration, the
data can be kept locally until the memory block is changed or
memory migration starts over in that case we will meet a dirtied
page which may still exists in compression threads's ring

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 89305c7af5..fdab13821d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -315,6 +315,8 @@ struct RAMState {
     uint64_t iterations;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* last dirty_sync_count we have seen */
+    uint64_t dirty_sync_count;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* The RAMBlock used in the last src_page_requests */
@@ -2532,6 +2534,7 @@ static void ram_save_cleanup(void *opaque)
     }
 
     xbzrle_cleanup();
+    flush_compressed_data(*rsp);
     compress_threads_save_cleanup();
     ram_state_cleanup(rsp);
 }
@@ -3203,6 +3206,17 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
     ram_control_before_iterate(f, RAM_CONTROL_ROUND);
 
+    /*
+     * if memory migration starts over, we will meet a dirtied page which
+     * may still exists in compression threads's ring, so we should flush
+     * the compressed data to make sure the new page is not overwritten by
+     * the old one in the destination.
+     */
+    if (ram_counters.dirty_sync_count != rs->dirty_sync_count) {
+        rs->dirty_sync_count = ram_counters.dirty_sync_count;
+        flush_compressed_data(rs);
+    }
+
     t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     i = 0;
     while ((ret = qemu_file_rate_limit(f)) == 0 ||
@@ -3235,7 +3249,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         }
         i++;
     }
-    flush_compressed_data(rs);
     rcu_read_unlock();
 
     /*
-- 
2.14.4

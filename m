Received: from eggs.gnu.org ([2001:4830:134:3::10]:39676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fwl8M-00075U-Ji
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fwl8L-00042A-HS
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:26:58 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fwl8L-00041v-As
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 05:26:57 -0400
Received: by mail-pl1-x641.google.com with SMTP id f6-v6so8400555plo.1
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 02:26:57 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  3 Sep 2018 17:26:41 +0800
Message-Id: <20180903092644.25812-2-xiaoguangrong@tencent.com>
In-Reply-To: <20180903092644.25812-1-xiaoguangrong@tencent.com>
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v5 1/4] migration: do not flush_compressed_data
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

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
 migration/ram.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 79c89425a3..2ad07b5e15 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -307,6 +307,8 @@ struct RAMState {
     uint64_t iterations;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
+    /* last dirty_sync_count we have seen */
+    uint64_t dirty_sync_count;
     /* protects modification of the bitmap */
     QemuMutex bitmap_mutex;
     /* The RAMBlock used in the last src_page_requests */
@@ -3180,6 +3182,17 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 
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
@@ -3212,7 +3225,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         }
         i++;
     }
-    flush_compressed_data(rs);
     rcu_read_unlock();
 
     /*
-- 
2.14.4

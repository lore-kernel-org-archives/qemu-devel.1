Received: from eggs.gnu.org ([2001:4830:134:3::10]:33548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fxoI6-0001PM-0D
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fxoI4-0008B6-Cq
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:44726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fxoHz-000887-Va
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:01:19 -0400
Received: by mail-pl1-x634.google.com with SMTP id ba4-v6so4510473plb.11
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 00:01:15 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu,  6 Sep 2018 15:00:59 +0800
Message-Id: <20180906070101.27280-2-xiaoguangrong@tencent.com>
In-Reply-To: <20180906070101.27280-1-xiaoguangrong@tencent.com>
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v6 1/3] migration: do not flush_compressed_data
 at the end of iteration
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
 migration/ram.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2add09174d..e152831254 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1996,17 +1996,22 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss, bool *again)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
+            /*
+             * If memory migration starts over, we will meet a dirtied page
+             * which may still exists in compression threads's ring, so we
+             * should flush the compressed data to make sure the new page
+             * is not overwritten by the old one in the destination.
+             *
+             * Also If xbzrle is on, stop using the data compression at this
+             * point. In theory, xbzrle can do better than compression.
+             */
+            flush_compressed_data(rs);
+
             /* Hit the end of the list */
             pss->block = QLIST_FIRST_RCU(&ram_list.blocks);
             /* Flag that we've looped */
             pss->complete_round = true;
             rs->ram_bulk_stage = false;
-            if (migrate_use_xbzrle()) {
-                /* If xbzrle is on, stop using the data compression at this
-                 * point. In theory, xbzrle can do better than compression.
-                 */
-                flush_compressed_data(rs);
-            }
         }
         /* Didn't find anything this time, but try again on the new block */
         *again = true;
@@ -3219,7 +3224,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         }
         i++;
     }
-    flush_compressed_data(rs);
     rcu_read_unlock();
 
     /*
-- 
2.14.4

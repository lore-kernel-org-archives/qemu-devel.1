Received: from eggs.gnu.org ([2001:4830:134:3::10]:47698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8X-0003Qs-PN
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0R8U-0003GT-HB
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0R8T-0003Dw-Bs
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:54:18 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 13 Sep 2018 14:53:36 +0200
Message-Id: <20180913125343.10912-6-quintela@redhat.com>
In-Reply-To: <20180913125343.10912-1-quintela@redhat.com>
References: <20180913125343.10912-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] migration: do not flush_compressed_data
 at the end of iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

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
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20180906070101.27280-2-xiaoguangrong@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
2.17.1

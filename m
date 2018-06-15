Received: from eggs.gnu.org ([2001:4830:134:3::10]:47979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRt-0004GB-4q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRs-0000jT-2A
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47870 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRr-0000jI-Ul
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:36 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:13 +0100
Message-Id: <20180615151518.83637-6-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] migration: fix counting xbzrle
 cache_miss_rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

Sync up xbzrle_cache_miss_prev only after migration iteration goes
forward

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20180604095520.8563-4-xiaoguangrong@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index e0d19305ee..d273a19699 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1200,9 +1200,9 @@ static void migration_bitmap_sync(RAMState *rs)
                    (double)(xbzrle_counters.cache_miss -
                             rs->xbzrle_cache_miss_prev) /
                    (rs->iterations - rs->iterations_prev);
+                rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
             }
             rs->iterations_prev = rs->iterations;
-            rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
         }
 
         /* reset period counters */
-- 
2.17.1

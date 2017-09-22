Received: from eggs.gnu.org ([2001:4830:134:3::10]:53197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1t-0002jc-1u
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1s-0002Bv-50
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvN1r-0002BJ-Ux
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:00 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 14:25:01 +0200
Message-Id: <20170922122505.9413-15-quintela@redhat.com>
In-Reply-To: <20170922122505.9413-1-quintela@redhat.com>
References: <20170922122505.9413-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 14/18] migration: fix ram_save_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fill postcopy-able pending only if ram postcopy is enabled.
It is necessary because of there will be other postcopy-able states and
when ram postcopy is disabled, it should not spoil common postcopy
related pending.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index cedbeae48d..88ca69e7b2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2276,8 +2276,12 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
         remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
     }
 
-    /* We can do postcopy, and all the data is postcopiable */
-    *postcopiable_pending += remaining_size;
+    if (migrate_postcopy_ram()) {
+        /* We can do postcopy, and all the data is postcopiable */
+        *postcopiable_pending += remaining_size;
+    } else {
+        *non_postcopiable_pending += remaining_size;
+    }
 }
 
 static int load_xbzrle(QEMUFile *f, ram_addr_t addr, void *host)
-- 
2.13.5

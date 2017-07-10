Received: from eggs.gnu.org ([2001:4830:134:3::10]:47121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba6-0000fV-3B
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba2-0001N4-F8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 10 Jul 2017 19:30:15 +0300
Message-Id: <20170710163029.129912-3-vsementsov@virtuozzo.com>
In-Reply-To: <20170710163029.129912-1-vsementsov@virtuozzo.com>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 02/16] migration: fix ram_save_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Fill postcopy-able pending only if ram postcopy is enabled.
It is necessary because of there will be other postcopy-able states and
when ram postcopy is disabled, it should not spoil common postcopy
related pending.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 64d006bc8b..b43589e3d2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2068,8 +2068,12 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
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
2.11.1

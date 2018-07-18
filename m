Received: from eggs.gnu.org ([2001:4830:134:3::10]:52975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Ho-Jp
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000HX-Hj
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000Fs-3E
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:55 +0300
Message-Id: <20180718154200.26777-13-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 12/17] ram: add background snapshot support
 in ram page saving part of migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

Unify the function saving the ram pages for using in both the migration
and the background snapshots.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/ram.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 10b6fdf23e..b1623e96e7 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1803,11 +1803,28 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
         if (!found) {
             /* priority queue empty, so just search for something dirty */
             found = find_dirty_block(rs, &pss, &again);
+
+            if (found && migrate_background_snapshot()) {
+                /* make a copy of the page and
+                 * pass it to the page search status */
+                int ret;
+                ret = ram_copy_page(pss.block, pss.page, &pss.page_copy);
+                if (ret == 0) {
+                    found = false;
+                    pages = 0;
+                } else if (ret < 0) {
+                    return ret;
+                }
+            }
         }
 
         if (found) {
             pages = ram_save_host_page(rs, &pss, last_stage);
         }
+
+        if (pss.page_copy) {
+            ram_page_buffer_decrease_used();
+        }
     } while (!pages && again);
 
     rs->last_seen_block = pss.block;
-- 
2.17.0

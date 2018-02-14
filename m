Received: from eggs.gnu.org ([2001:4830:134:3::10]:53925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA3-0008IY-EM
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA0-00075Y-7W
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40565 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elz9z-00074Y-VK
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:52 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:32 +0000
Message-Id: <20180214153938.5410-5-dgilbert@redhat.com>
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 04/10] migration: Fix early failure cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Avoid crash in cleanup after a very early migration failure
(possibly due to my 688a3dcba980bf01344a  'Route errors down ...')

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180212160340.15333-2-dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8333d8e35e..7095c1040e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1602,11 +1602,13 @@ static void xbzrle_load_cleanup(void)
 
 static void ram_state_cleanup(RAMState **rsp)
 {
-    migration_page_queue_free(*rsp);
-    qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
-    qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
-    g_free(*rsp);
-    *rsp = NULL;
+    if (*rsp) {
+        migration_page_queue_free(*rsp);
+        qemu_mutex_destroy(&(*rsp)->bitmap_mutex);
+        qemu_mutex_destroy(&(*rsp)->src_page_req_mutex);
+        g_free(*rsp);
+        *rsp = NULL;
+    }
 }
 
 static void xbzrle_cleanup(void)
-- 
2.14.3

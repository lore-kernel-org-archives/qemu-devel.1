Received: from eggs.gnu.org ([2001:4830:134:3::10]:35852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHN-0005kh-CF
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fHM-0000JE-CY
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fHM-0000He-6J
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13E724A700
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:52 +0200
Message-Id: <20171023160800.20540-14-quintela@redhat.com>
In-Reply-To: <20171023160800.20540-1-quintela@redhat.com>
References: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 13/21] migration: provide ram_state_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

The old ram_state_init() is not really initializing the RAMState only,
but including lots of other stuff that is RAM-related.  Renaming it to
ram_init_all().  Instead, provide a real ram_state_init().

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 47501460c8..13f4b3d101 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2019,13 +2019,36 @@ err:
 
 static int ram_state_init(RAMState **rsp)
 {
-    *rsp = g_new0(RAMState, 1);
-    Error *local_err = NULL;
+    *rsp = g_try_new0(RAMState, 1);
+
+    if (!*rsp) {
+        error_report("%s: Init ramstate fail", __func__);
+        return -1;
+    }
 
     qemu_mutex_init(&(*rsp)->bitmap_mutex);
     qemu_mutex_init(&(*rsp)->src_page_req_mutex);
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
 
+    /*
+     * Count the total number of pages used by ram blocks not including any
+     * gaps due to alignment or unplugs.
+     */
+    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
+
+    ram_state_reset(*rsp);
+
+    return 0;
+}
+
+static int ram_init_all(RAMState **rsp)
+{
+    Error *local_err = NULL;
+
+    if (ram_state_init(rsp)) {
+        return -1;
+    }
+
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
         XBZRLE.zero_target_page = g_malloc0(TARGET_PAGE_SIZE);
@@ -2065,7 +2088,6 @@ static int ram_state_init(RAMState **rsp)
 
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
-    ram_state_reset(*rsp);
 
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
@@ -2083,12 +2105,6 @@ static int ram_state_init(RAMState **rsp)
         }
     }
 
-    /*
-     * Count the total number of pages used by ram blocks not including any
-     * gaps due to alignment or unplugs.
-     */
-    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
-
     memory_global_dirty_log_start();
     migration_bitmap_sync(*rsp);
     qemu_mutex_unlock_ramlist();
@@ -2120,7 +2136,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_state_init(rsp) != 0) {
+        if (ram_init_all(rsp) != 0) {
             return -1;
         }
     }
-- 
2.13.6

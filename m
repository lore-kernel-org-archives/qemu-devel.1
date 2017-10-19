Received: from eggs.gnu.org ([2001:4830:134:3::10]:51712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NJ-0000kx-Uk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e54NI-0003CT-5J
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e54NH-0003C9-UV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9F0E13A49
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:32:10 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 19 Oct 2017 14:31:57 +0800
Message-Id: <20171019063200.19048-2-peterx@redhat.com>
In-Reply-To: <20171019063200.19048-1-peterx@redhat.com>
References: <20171019063200.19048-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] migration: provide ram_state_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The old ram_state_init() is not really initializing the RAMState only,
but including lots of other stuff that is RAM-related.  Renaming it to
ram_init_all().  Instead, provide a real ram_state_init().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b83f8977c5..fd8e14c59b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2009,12 +2009,34 @@ err:
 
 static int ram_state_init(RAMState **rsp)
 {
-    *rsp = g_new0(RAMState, 1);
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
+    if (ram_state_init(rsp)) {
+        return -1;
+    }
+
     if (migrate_use_xbzrle()) {
         XBZRLE_cache_lock();
         XBZRLE.zero_target_page = g_malloc0(TARGET_PAGE_SIZE);
@@ -2055,7 +2077,6 @@ static int ram_state_init(RAMState **rsp)
 
     qemu_mutex_lock_ramlist();
     rcu_read_lock();
-    ram_state_reset(*rsp);
 
     /* Skip setting bitmap if there is no RAM */
     if (ram_bytes_total()) {
@@ -2073,12 +2094,6 @@ static int ram_state_init(RAMState **rsp)
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
@@ -2110,7 +2125,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
-        if (ram_state_init(rsp) != 0) {
+        if (ram_init_all(rsp) != 0) {
             return -1;
         }
     }
-- 
2.13.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE2-00024n-CL
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVmE0-0002kB-Bk
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cVmE0-0002i4-74
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 16:32:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F94361BA9
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 21:32:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Jan 2017 22:32:05 +0100
Message-Id: <1485207141-1941-2-git-send-email-quintela@redhat.com>
In-Reply-To: <1485207141-1941-1-git-send-email-quintela@redhat.com>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 01/17] migration: transform remained DPRINTF
 into trace_
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

So we can remove DPRINTF() macro

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 18 ++++--------------
 migration/trace-events |  4 ++++
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index a1c8089..ef8fadf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -45,14 +45,6 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"

-#ifdef DEBUG_MIGRATION_RAM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stdout, "migration_ram: " fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 static int dirty_rate_high_cnt;

 static uint64_t bitmap_sync_count;
@@ -507,10 +499,10 @@ static int save_xbzrle_page(QEMUFile *f, uint8_t **current_data,
                                        TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
                                        TARGET_PAGE_SIZE);
     if (encoded_len == 0) {
-        DPRINTF("Skipping unmodified page\n");
+        trace_save_xbzrle_page_skipping();
         return 0;
     } else if (encoded_len == -1) {
-        DPRINTF("Overflow\n");
+        trace_save_xbzrle_page_overflow();
         acct_info.xbzrle_overflows++;
         /* update data in the cache */
         if (!last_stage) {
@@ -2020,8 +2012,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         if ((i & 63) == 0) {
             uint64_t t1 = (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - t0) / 1000000;
             if (t1 > MAX_WAIT) {
-                DPRINTF("big wait: %" PRIu64 " milliseconds, %d iterations\n",
-                        t1, i);
+                trace_ram_save_iterate_big_wait(t1, i);
                 break;
             }
         }
@@ -2594,8 +2585,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)

     wait_for_decompress_done();
     rcu_read_unlock();
-    DPRINTF("Completed load of VM with exit code %d seq iteration "
-            "%" PRIu64 "\n", ret, seq_iter);
+    trace_ram_load_complete(ret, seq_iter);
     return ret;
 }

diff --git a/migration/trace-events b/migration/trace-events
index 94134f7..6d781cf 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -186,6 +186,10 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
 postcopy_ram_incoming_cleanup_entry(void) ""
 postcopy_ram_incoming_cleanup_exit(void) ""
 postcopy_ram_incoming_cleanup_join(void) ""
+save_xbzrle_page_skipping(void) ""
+save_xbzrle_page_overflow(void) ""
+ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
+ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64

 # migration/exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.9.3

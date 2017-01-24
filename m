Received: from eggs.gnu.org ([2001:4830:134:3::10]:55461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68L-0001NP-KJ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cW68K-0006tV-Oh
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cW68K-0006sz-Ha
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:47:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3B0514BFEB
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 18:47:56 +0000 (UTC)
Received: from dgilbert-t530.redhat.com (ovpn-116-204.ams2.redhat.com
	[10.36.116.204])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0OIlhV2020536
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:47:56 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jan 2017 18:47:41 +0000
Message-Id: <20170124184742.1639-15-dgilbert@redhat.com>
In-Reply-To: <20170124184742.1639-1-dgilbert@redhat.com>
References: <20170124184742.1639-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 14/15] migration: transform remaining DPRINTF
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

From: Juan Quintela <quintela@redhat.com>

So we can remove DPRINTF() macro

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1485207141-1941-2-git-send-email-quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixed up 'remained/remaining' as requested by Eric
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
index c46f9e9..ba6bee4 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -190,6 +190,10 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
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

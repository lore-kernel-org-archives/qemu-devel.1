Received: from eggs.gnu.org ([2001:4830:134:3::10]:55137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCi-00054K-S1
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzhCf-00034q-Pt
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzhCf-00033Z-Kn
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:47:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A9FAC04AC74
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:47:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:46:33 +0200
Message-Id: <20171004104636.7963-10-quintela@redhat.com>
In-Reply-To: <20171004104636.7963-1-quintela@redhat.com>
References: <20171004104636.7963-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v9 09/12] migration: Rename initial_bytes
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

Now it is called qemu_file_bytes that reflects better what it does,
and we create qemu_file_bytes_now to not have to call qemu_ftell() twice.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1e7c537954..54ef095d82 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2078,13 +2078,13 @@ static void *migration_thread(void *opaque)
     /* Used by the bandwidth calcs, updated later */
     int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
-    int64_t initial_bytes = 0;
     /*
      * The final stage happens when the remaining data is smaller than
      * this threshold; it's calculated from the requested downtime and
      * measured bandwidth
      */
     int64_t threshold_size = 0;
+    int64_t qemu_file_bytes = 0;
     int64_t start_time = initial_time;
     int64_t end_time;
     bool old_vm_running = false;
@@ -2172,8 +2172,9 @@ static void *migration_thread(void *opaque)
         }
         current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         if (current_time >= initial_time + BUFFER_DELAY) {
-            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
-                                         initial_bytes;
+            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
+            uint64_t transferred_bytes =
+                qemu_file_bytes_now - qemu_file_bytes;
             uint64_t time_spent = current_time - initial_time;
             double bandwidth = (double)transferred_bytes / time_spent;
             threshold_size = bandwidth * s->parameters.downtime_limit;
@@ -2192,7 +2193,7 @@ static void *migration_thread(void *opaque)
 
             qemu_file_reset_rate_limit(s->to_dst_file);
             initial_time = current_time;
-            initial_bytes = qemu_ftell(s->to_dst_file);
+            qemu_file_bytes = qemu_file_bytes_now;
         }
         if (qemu_file_rate_limit(s->to_dst_file)) {
             /* usleep expects microseconds */
-- 
2.13.5

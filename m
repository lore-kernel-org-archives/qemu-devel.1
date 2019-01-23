Received: from eggs.gnu.org ([209.51.188.92]:41051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvg-0007Le-Ti
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvf-0005d5-N5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:59:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvf-0005cj-EX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:59:03 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:30 +0000
Message-Id: <20190123155830.8459-10-dgilbert@redhat.com>
In-Reply-To: <20190123155830.8459-1-dgilbert@redhat.com>
References: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] migration: introduce pages-per-second
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: Xiao Guangrong <xiaoguangrong@tencent.com>

It introduces a new statistic, pages-per-second, as bandwidth or mbps is
not enough to measure the performance of posting pages out as we have
compression, xbzrle, which can significantly reduce the amount of the
data size, instead, pages-per-second is the one we want

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
Message-Id: <20190111063732.10484-2-xiaoguangrong@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  With typo's Eric spotted fixed
---
 hmp.c                 |  2 ++
 migration/migration.c | 11 ++++++++++-
 migration/migration.h | 10 +++++++++-
 migration/ram.c       |  6 ++++++
 qapi/migration.json   |  5 ++++-
 5 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8da5fd8760..b2a2b1f84e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -236,6 +236,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdic=
t)
                        info->ram->page_size >> 10);
         monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
                        info->ram->multifd_bytes >> 10);
+        monitor_printf(mon, "pages-per-second: %" PRIu64 "\n",
+                       info->ram->pages_per_second);
=20
         if (info->ram->dirty_pages_rate) {
             monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
diff --git a/migration/migration.c b/migration/migration.c
index ded151b1bf..37e06b76dc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -782,6 +782,7 @@ static void populate_ram_info(MigrationInfo *info, Mi=
grationState *s)
     info->ram->postcopy_requests =3D ram_counters.postcopy_requests;
     info->ram->page_size =3D qemu_target_page_size();
     info->ram->multifd_bytes =3D ram_counters.multifd_bytes;
+    info->ram->pages_per_second =3D s->pages_per_second;
=20
     if (migrate_use_xbzrle()) {
         info->has_xbzrle_cache =3D true;
@@ -1565,6 +1566,7 @@ void migrate_init(MigrationState *s)
     s->rp_state.from_dst_file =3D NULL;
     s->rp_state.error =3D false;
     s->mbps =3D 0.0;
+    s->pages_per_second =3D 0.0;
     s->downtime =3D 0;
     s->expected_downtime =3D 0;
     s->setup_time =3D 0;
@@ -2883,7 +2885,7 @@ static void migration_calculate_complete(MigrationS=
tate *s)
 static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
-    uint64_t transferred, time_spent;
+    uint64_t transferred, transferred_pages, time_spent;
     uint64_t current_bytes; /* bytes transferred since the beginning */
     double bandwidth;
=20
@@ -2900,6 +2902,11 @@ static void migration_update_counters(MigrationSta=
te *s,
     s->mbps =3D (((double) transferred * 8.0) /
                ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
=20
+    transferred_pages =3D ram_get_total_transferred_pages() -
+                            s->iteration_initial_pages;
+    s->pages_per_second =3D (double) transferred_pages /
+                             (((double) time_spent / 1000.0));
+
     /*
      * if we haven't sent anything, we don't want to
      * recalculate. 10000 is a small enough number for our purposes
@@ -2912,6 +2919,7 @@ static void migration_update_counters(MigrationStat=
e *s,
=20
     s->iteration_start_time =3D current_time;
     s->iteration_initial_bytes =3D current_bytes;
+    s->iteration_initial_pages =3D ram_get_total_transferred_pages();
=20
     trace_migrate_transferred(transferred, time_spent,
                               bandwidth, s->threshold_size);
@@ -3316,6 +3324,7 @@ static void migration_instance_init(Object *obj)
=20
     ms->state =3D MIGRATION_STATUS_NONE;
     ms->mbps =3D -1;
+    ms->pages_per_second =3D -1;
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
=20
diff --git a/migration/migration.h b/migration/migration.h
index 02b7304610..dcd05d9f87 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -126,7 +126,13 @@ struct MigrationState
      */
     QemuSemaphore rate_limit_sem;
=20
-    /* bytes already send at the beggining of current interation */
+    /* pages already send at the beginning of current iteration */
+    uint64_t iteration_initial_pages;
+
+    /* pages transferred per second */
+    double pages_per_second;
+
+    /* bytes already send at the beginning of current iteration */
     uint64_t iteration_initial_bytes;
     /* time at the start of current iteration */
     int64_t iteration_start_time;
@@ -271,6 +277,8 @@ bool migrate_use_block_incremental(void);
 int migrate_max_cpu_throttle(void);
 bool migrate_use_return_path(void);
=20
+uint64_t ram_get_total_transferred_pages(void);
+
 bool migrate_use_compression(void);
 int migrate_compress_level(void);
 int migrate_compress_threads(void);
diff --git a/migration/ram.c b/migration/ram.c
index 43c2b442af..59191c1ed2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1601,6 +1601,12 @@ uint64_t ram_pagesize_summary(void)
     return summary;
 }
=20
+uint64_t ram_get_total_transferred_pages(void)
+{
+    return  ram_counters.normal + ram_counters.duplicate +
+                compression_counters.pages + xbzrle_counters.pages;
+}
+
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
     uint64_t page_count =3D rs->target_page_count - rs->target_page_coun=
t_prev;
diff --git a/qapi/migration.json b/qapi/migration.json
index 31b589ec26..7a795ecc16 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -41,6 +41,9 @@
 #
 # @multifd-bytes: The number of bytes sent through multifd (since 3.0)
 #
+# @pages-per-second: the number of memory pages transferred per second
+#        (Since 4.0)
+#
 # Since: 0.14.0
 ##
 { 'struct': 'MigrationStats',
@@ -49,7 +52,7 @@
            'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
            'mbps' : 'number', 'dirty-sync-count' : 'int',
            'postcopy-requests' : 'int', 'page-size' : 'int',
-           'multifd-bytes' : 'uint64' } }
+           'multifd-bytes' : 'uint64', 'pages-per-second' : 'uint64' } }
=20
 ##
 # @XBZRLECacheStats:
--=20
2.20.1

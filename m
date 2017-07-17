Received: from eggs.gnu.org ([2001:4830:134:3::10]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1MM-0006QZ-Kq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1MH-0001mC-OP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1MH-0001m4-F6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CB0E4E4D6
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 08:26:24 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:02 +0800
Message-Id: <1500279971-13875-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/11] migration: export parameters to props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Export migration parameters to qdev properties. Then we can use, for
example:

  -global migration.x-cpu-throttle-initial=xxx

To specify migration parameters during init.

Prefix "x-" is appended for each parameter exported to show that this is
not a stable interface, and only for debugging/testing purpose.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a0db40d..ad2505c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2009,6 +2009,31 @@ static Property migration_properties[] = {
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,
                      send_section_footer, true),
+
+    /* Migration parameters */
+    DEFINE_PROP_INT64("x-compress-level", MigrationState,
+                      parameters.compress_level,
+                      DEFAULT_MIGRATE_COMPRESS_LEVEL),
+    DEFINE_PROP_INT64("x-compress-threads", MigrationState,
+                      parameters.compress_threads,
+                      DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT),
+    DEFINE_PROP_INT64("x-decompress-threads", MigrationState,
+                      parameters.decompress_threads,
+                      DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
+    DEFINE_PROP_INT64("x-cpu-throttle-initial", MigrationState,
+                      parameters.cpu_throttle_initial,
+                      DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
+    DEFINE_PROP_INT64("x-cpu-throttle-increment", MigrationState,
+                      parameters.cpu_throttle_increment,
+                      DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
+    DEFINE_PROP_INT64("x-max-bandwidth", MigrationState,
+                      parameters.max_bandwidth, MAX_THROTTLE),
+    DEFINE_PROP_INT64("x-downtime-limit", MigrationState,
+                      parameters.downtime_limit,
+                      DEFAULT_MIGRATE_SET_DOWNTIME),
+    DEFINE_PROP_INT64("x-checkpoint-delay", MigrationState,
+                      parameters.x_checkpoint_delay,
+                      DEFAULT_MIGRATE_X_CHECKPOINT_DELAY),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2027,16 +2052,6 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->xbzrle_cache_size = DEFAULT_MIGRATE_CACHE_SIZE;
     ms->mbps = -1;
-    ms->parameters = (MigrationParameters) {
-        .compress_level = DEFAULT_MIGRATE_COMPRESS_LEVEL,
-        .compress_threads = DEFAULT_MIGRATE_COMPRESS_THREAD_COUNT,
-        .decompress_threads = DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT,
-        .cpu_throttle_initial = DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL,
-        .cpu_throttle_increment = DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT,
-        .max_bandwidth = MAX_THROTTLE,
-        .downtime_limit = DEFAULT_MIGRATE_SET_DOWNTIME,
-        .x_checkpoint_delay = DEFAULT_MIGRATE_X_CHECKPOINT_DELAY,
-    };
     ms->parameters.tls_creds = g_strdup("");
     ms->parameters.tls_hostname = g_strdup("");
 }
-- 
2.7.4

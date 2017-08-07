Received: from eggs.gnu.org ([2001:4830:134:3::10]:48960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-0007Mx-6C
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIo-0003tn-5N
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:46:58 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:22 +0200
Message-Id: <1502117160-24655-19-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 18/56] migration: Make parameter
 max-bandwidth unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Byte rates should use QAPI type 'size' (uint64_t).
migrate_set_speed's parameter @value and member @max-bandwidth of
MigrationParameters and MigrateSetParameters are 'int' (int64_t).

Change them all to 'size'.

migrate_set_speed and migrate-set-parameters now accept bandwidth
values between 2^63 and SIZE_MAX (commonly 2^64-1).  They accept
negative values as before, because that's how the QObject input
visitor works for backward compatibility.

So does HMP's migrate_set_speed, except it continues to reject
negative values.

query-migrate-parameters now reports bandwidth values above 2^63-1
correctly instead of their (negative) two's complement.

So does HMP's "info migrate_params".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                 | 2 +-
 migration/migration.c | 9 ++++-----
 qapi-schema.json      | 6 +++---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hmp.c b/hmp.c
index 184fb8b..9bcdcb3 100644
--- a/hmp.c
+++ b/hmp.c
@@ -322,7 +322,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_lookup[MIGRATION_PARAMETER_TLS_HOSTNAME],
             params->tls_hostname);
         assert(params->has_max_bandwidth);
-        monitor_printf(mon, "%s: %" PRId64 " bytes/second\n",
+        monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_lookup[MIGRATION_PARAMETER_MAX_BANDWIDTH],
             params->max_bandwidth);
         assert(params->has_downtime_limit);
diff --git a/migration/migration.c b/migration/migration.c
index 2d7f3a2..0b47371 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -716,8 +716,7 @@ static bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_max_bandwidth &&
-        (params->max_bandwidth < 0 || params->max_bandwidth > SIZE_MAX)) {
+    if (params->has_max_bandwidth && params->max_bandwidth > SIZE_MAX) {
         error_setg(errp, "Parameter 'max_bandwidth' expects an integer in the"
                          " range of 0 to %zu bytes/second", SIZE_MAX);
         return false;
@@ -1311,7 +1310,7 @@ uint64_t qmp_query_migrate_cache_size(Error **errp)
     return migrate_xbzrle_cache_size();
 }
 
-void qmp_migrate_set_speed(int64_t value, Error **errp)
+void qmp_migrate_set_speed(uint64_t value, Error **errp)
 {
     MigrateSetParameters p = {
         .has_max_bandwidth = true,
@@ -2179,8 +2178,8 @@ static Property migration_properties[] = {
     DEFINE_PROP_INT64("x-cpu-throttle-increment", MigrationState,
                       parameters.cpu_throttle_increment,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
-    DEFINE_PROP_INT64("x-max-bandwidth", MigrationState,
-                      parameters.max_bandwidth, MAX_THROTTLE),
+    DEFINE_PROP_UINT64("x-max-bandwidth", MigrationState,
+                       parameters.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_INT64("x-downtime-limit", MigrationState,
                       parameters.downtime_limit,
                       DEFAULT_MIGRATE_SET_DOWNTIME),
diff --git a/qapi-schema.json b/qapi-schema.json
index 2eee676..c18e574 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1116,7 +1116,7 @@
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
-            '*max-bandwidth': 'int',
+            '*max-bandwidth': 'size',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool' } }
@@ -1200,7 +1200,7 @@
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
-            '*max-bandwidth': 'int',
+            '*max-bandwidth': 'size',
             '*downtime-limit': 'int',
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool' } }
@@ -2852,7 +2852,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
+{ 'command': 'migrate_set_speed', 'data': {'value': 'size'} }
 
 ##
 # @migrate-set-cache-size:
-- 
2.7.5

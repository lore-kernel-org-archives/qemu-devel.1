Received: from eggs.gnu.org ([209.51.188.92]:52533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAK6-0008KC-8X
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAK1-0004N4-7W
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goAJr-0003jC-5w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C65EF37E85
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:03:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 28 Jan 2019 17:03:14 +0000
Message-Id: <20190128170321.16936-3-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-1-dgilbert@redhat.com>
References: <20190128170321.16936-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/9] migration: Add announce parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add migration parameters that control RARP/GARP announcement timeouts.

Based on earlier patches by myself and
  Vladislav Yasevich <vyasevic@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c                    |  28 +++++++++++
 include/migration/misc.h |   2 +
 include/qemu/typedefs.h  |   1 +
 migration/migration.c    | 100 +++++++++++++++++++++++++++++++++++++++
 qapi/migration.json      |  56 ++++++++++++++++++++--
 5 files changed, 183 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..319f5134cd 100644
--- a/hmp.c
+++ b/hmp.c
@@ -334,6 +334,18 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
 QDict *qdict)
     params =3D qmp_query_migrate_parameters(NULL);
=20
     if (params) {
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_INITIAL)=
,
+            params->announce_initial);
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_MAX),
+            params->announce_max);
+        monitor_printf(mon, "%s: %" PRIu64 "\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_ROUNDS),
+            params->announce_rounds);
+        monitor_printf(mon, "%s: %" PRIu64 " ms\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_ANNOUNCE_STEP),
+            params->announce_step);
         assert(params->has_compress_level);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_LEVEL),
@@ -1757,6 +1769,22 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
         p->has_max_postcopy_bandwidth =3D true;
         visit_type_size(v, param, &p->max_postcopy_bandwidth, &err);
         break;
+    case MIGRATION_PARAMETER_ANNOUNCE_INITIAL:
+        p->has_announce_initial =3D true;
+        visit_type_size(v, param, &p->announce_initial, &err);
+        break;
+    case MIGRATION_PARAMETER_ANNOUNCE_MAX:
+        p->has_announce_max =3D true;
+        visit_type_size(v, param, &p->announce_max, &err);
+        break;
+    case MIGRATION_PARAMETER_ANNOUNCE_ROUNDS:
+        p->has_announce_rounds =3D true;
+        visit_type_size(v, param, &p->announce_rounds, &err);
+        break;
+    case MIGRATION_PARAMETER_ANNOUNCE_STEP:
+        p->has_announce_step =3D true;
+        visit_type_size(v, param, &p->announce_step, &err);
+        break;
     default:
         assert(0);
     }
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 4ebf24c6c2..e837ab3042 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -15,6 +15,7 @@
 #define MIGRATION_MISC_H
=20
 #include "qemu/notify.h"
+#include "qapi/qapi-types-net.h"
=20
 /* migration/ram.c */
=20
@@ -38,6 +39,7 @@ int64_t self_announce_delay(int round)
     return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
 }
=20
+AnnounceParameters *migrate_announce_params(void);
 /* migration/savevm.c */
=20
 void dump_vmstate_json_to_file(FILE *out_fp);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index e4a0a656d1..22b8b20306 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -8,6 +8,7 @@
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
+typedef struct AnnounceParameters AnnounceParameters;
 typedef struct AnnounceTimer AnnounceTimer;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
diff --git a/migration/migration.c b/migration/migration.c
index a9c4c6f01d..ca9c35a5cd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -87,6 +87,15 @@
  */
 #define DEFAULT_MIGRATE_MAX_POSTCOPY_BANDWIDTH 0
=20
+/*
+ * Parameters for self_announce_delay giving a stream of RARP/ARP
+ * packets after migration.
+ */
+#define DEFAULT_MIGRATE_ANNOUNCE_INITIAL  50
+#define DEFAULT_MIGRATE_ANNOUNCE_MAX     550
+#define DEFAULT_MIGRATE_ANNOUNCE_ROUNDS    5
+#define DEFAULT_MIGRATE_ANNOUNCE_STEP    100
+
 static NotifierList migration_state_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
=20
@@ -740,10 +749,32 @@ MigrationParameters *qmp_query_migrate_parameters(E=
rror **errp)
     params->max_postcopy_bandwidth =3D s->parameters.max_postcopy_bandwi=
dth;
     params->has_max_cpu_throttle =3D true;
     params->max_cpu_throttle =3D s->parameters.max_cpu_throttle;
+    params->has_announce_initial =3D true;
+    params->announce_initial =3D s->parameters.announce_initial;
+    params->has_announce_max =3D true;
+    params->announce_max =3D s->parameters.announce_max;
+    params->has_announce_rounds =3D true;
+    params->announce_rounds =3D s->parameters.announce_rounds;
+    params->has_announce_step =3D true;
+    params->announce_step =3D s->parameters.announce_step;
=20
     return params;
 }
=20
+AnnounceParameters *migrate_announce_params(void)
+{
+    static AnnounceParameters ap;
+
+    MigrationState *s =3D migrate_get_current();
+
+    ap.initial =3D s->parameters.announce_initial;
+    ap.max =3D s->parameters.announce_max;
+    ap.rounds =3D s->parameters.announce_rounds;
+    ap.step =3D s->parameters.announce_step;
+
+    return &ap;
+}
+
 /*
  * Return true if we're already in the middle of a migration
  * (i.e. any of the active or setup states)
@@ -1117,6 +1148,35 @@ static bool migrate_params_check(MigrationParamete=
rs *params, Error **errp)
         return false;
     }
=20
+    if (params->has_announce_initial &&
+        params->announce_initial > 100000) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_initial",
+                   "is invalid, it must be less than 100000 ms");
+        return false;
+    }
+    if (params->has_announce_max &&
+        params->announce_max > 100000) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_max",
+                   "is invalid, it must be less than 100000 ms");
+       return false;
+    }
+    if (params->has_announce_rounds &&
+        params->announce_rounds > 1000) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_rounds",
+                   "is invalid, it must be in the range of 0 to 1000");
+       return false;
+    }
+    if (params->has_announce_step &&
+        (params->announce_step < 1 ||
+        params->announce_step > 10000)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "announce_step",
+                   "is invalid, it must be in the range of 1 to 10000 ms=
");
+       return false;
+    }
     return true;
 }
=20
@@ -1191,6 +1251,18 @@ static void migrate_params_test_apply(MigrateSetPa=
rameters *params,
     if (params->has_max_cpu_throttle) {
         dest->max_cpu_throttle =3D params->max_cpu_throttle;
     }
+    if (params->has_announce_initial) {
+        dest->announce_initial =3D params->announce_initial;
+    }
+    if (params->has_announce_max) {
+        dest->announce_max =3D params->announce_max;
+    }
+    if (params->has_announce_rounds) {
+        dest->announce_rounds =3D params->announce_rounds;
+    }
+    if (params->has_announce_step) {
+        dest->announce_step =3D params->announce_step;
+    }
 }
=20
 static void migrate_params_apply(MigrateSetParameters *params, Error **e=
rrp)
@@ -1273,6 +1345,18 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle =3D params->max_cpu_throttle;
     }
+    if (params->has_announce_initial) {
+        s->parameters.announce_initial =3D params->announce_initial;
+    }
+    if (params->has_announce_max) {
+        s->parameters.announce_max =3D params->announce_max;
+    }
+    if (params->has_announce_rounds) {
+        s->parameters.announce_rounds =3D params->announce_rounds;
+    }
+    if (params->has_announce_step) {
+        s->parameters.announce_step =3D params->announce_step;
+    }
 }
=20
 void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **er=
rp)
@@ -3275,6 +3359,18 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("max-cpu-throttle", MigrationState,
                       parameters.max_cpu_throttle,
                       DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
+    DEFINE_PROP_SIZE("announce-initial", MigrationState,
+                      parameters.announce_initial,
+                      DEFAULT_MIGRATE_ANNOUNCE_INITIAL),
+    DEFINE_PROP_SIZE("announce-max", MigrationState,
+                      parameters.announce_max,
+                      DEFAULT_MIGRATE_ANNOUNCE_MAX),
+    DEFINE_PROP_SIZE("announce-rounds", MigrationState,
+                      parameters.announce_rounds,
+                      DEFAULT_MIGRATE_ANNOUNCE_ROUNDS),
+    DEFINE_PROP_SIZE("announce-step", MigrationState,
+                      parameters.announce_step,
+                      DEFAULT_MIGRATE_ANNOUNCE_STEP),
=20
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -3347,6 +3443,10 @@ static void migration_instance_init(Object *obj)
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
+    params->has_announce_initial =3D true;
+    params->has_announce_max =3D true;
+    params->has_announce_rounds =3D true;
+    params->has_announce_step =3D true;
=20
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
diff --git a/qapi/migration.json b/qapi/migration.json
index 7a795ecc16..868071d3a0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -6,6 +6,7 @@
 ##
=20
 { 'include': 'common.json' }
+{ 'include': 'net.json' }
=20
 ##
 # @MigrationStats:
@@ -480,6 +481,18 @@
 #
 # Migration parameters enumeration
 #
+# @announce-initial: Inital delay (in ms) before sending the first annou=
nce
+#          (Since 4.0)
+#
+# @announce-max: Maximum delay (in ms) between packets in the announcmen=
t
+#          (Since 4.0)
+#
+# @announce-rounds: Number of self-announce packets sent after migration
+#          (Since 4.0)
+#
+# @announce-step: Increase in delay (in ms) between subsequent packets i=
n
+#          the announcement (Since 4.0)
+#
 # @compress-level: Set the compression level to be used in live migratio=
n,
 #          the compression level is an integer between 0 and 9, where 0 =
means
 #          no compression, 1 means the best compression speed, and 9 mea=
ns best
@@ -557,10 +570,13 @@
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
-  'data': ['compress-level', 'compress-threads', 'decompress-threads',
+  'data': ['announce-initial', 'announce-max',
+           'announce-rounds', 'announce-step',
+           'compress-level', 'compress-threads', 'decompress-threads',
            'compress-wait-thread',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
@@ -572,6 +588,18 @@
 ##
 # @MigrateSetParameters:
 #
+# @announce-initial: Inital delay (in ms) before sending the first annou=
nce
+#          (Since 4.0)
+#
+# @announce-max: Maximum delay (in ms) between packets in the announcmen=
t
+#          (Since 4.0)
+#
+# @announce-rounds: Number of self-announce packets sent after migration
+#          (Since 4.0)
+#
+# @announce-step: Increase in delay (in ms) between subsequent packets i=
n
+#          the announcement (Since 4.0)
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -653,7 +681,11 @@
 # TODO either fuse back into MigrationParameters, or make
 # MigrationParameters members mandatory
 { 'struct': 'MigrateSetParameters',
-  'data': { '*compress-level': 'int',
+  'data': { '*announce-initial': 'size',
+            '*announce-max': 'size',
+            '*announce-rounds': 'size',
+            '*announce-step': 'size',
+            '*compress-level': 'int',
             '*compress-threads': 'int',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
@@ -692,6 +724,18 @@
 #
 # The optional members aren't actually optional.
 #
+# @announce-initial: Inital delay (in ms) before sending the first annou=
nce
+#          (Since 4.0)
+#
+# @announce-max: Maximum delay (in ms) between packets in the announcmen=
t
+#          (Since 4.0)
+#
+# @announce-rounds: Number of self-announce packets sent after migration
+#          (Since 4.0)
+#
+# @announce-step: Increase in delay (in ms) between subsequent packets i=
n
+#          the announcement (Since 4.0)
+#
 # @compress-level: compression level
 #
 # @compress-threads: compression thread count
@@ -769,7 +813,11 @@
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
-  'data': { '*compress-level': 'uint8',
+  'data': { '*announce-initial': 'size',
+            '*announce-max': 'size',
+            '*announce-rounds': 'size',
+            '*announce-step': 'size',
+            '*compress-level': 'uint8',
             '*compress-threads': 'uint8',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
@@ -785,7 +833,7 @@
             '*x-multifd-page-count': 'uint32',
             '*xbzrle-cache-size': 'size',
 	    '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle':'uint8'} }
+            '*max-cpu-throttle':'uint8' } }
=20
 ##
 # @query-migrate-parameters:
--=20
2.20.1

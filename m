Received: from eggs.gnu.org ([209.51.188.92]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBZ-0006mm-3u
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1grNBS-0007iR-OA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:24:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1grNBS-0007iE-9Z
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:24:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91E5E58E59
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 13:24:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  6 Feb 2019 14:23:29 +0100
Message-Id: <20190206132331.1694-3-quintela@redhat.com>
In-Reply-To: <20190206132331.1694-1-quintela@redhat.com>
References: <20190206132331.1694-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] multifd: Drop x-multifd-page-count
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Libvirt don't want to expose (and explain it).  And testing looks like
128 is good for all use cases, so just drop it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                 |  7 -------
 migration/migration.c | 30 ------------------------------
 migration/migration.h |  1 -
 migration/ram.c       | 13 ++++++++-----
 qapi/migration.json   | 13 +------------
 5 files changed, 9 insertions(+), 55 deletions(-)

diff --git a/hmp.c b/hmp.c
index 63019729ed..73b8443a8e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -426,9 +426,6 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_CHANNEL=
S),
             params->x_multifd_channels);
-        monitor_printf(mon, "%s: %u\n",
-            MigrationParameter_str(MIGRATION_PARAMETER_X_MULTIFD_PAGE_CO=
UNT),
-            params->x_multifd_page_count);
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
             params->xbzrle_cache_size);
@@ -1776,10 +1773,6 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
         p->has_x_multifd_channels =3D true;
         visit_type_int(v, param, &p->x_multifd_channels, &err);
         break;
-    case MIGRATION_PARAMETER_X_MULTIFD_PAGE_COUNT:
-        p->has_x_multifd_page_count =3D true;
-        visit_type_int(v, param, &p->x_multifd_page_count, &err);
-        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
diff --git a/migration/migration.c b/migration/migration.c
index f673486679..65df9b566e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -81,7 +81,6 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
-#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 128
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -749,8 +748,6 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->block_incremental =3D s->parameters.block_incremental;
     params->has_x_multifd_channels =3D true;
     params->x_multifd_channels =3D s->parameters.x_multifd_channels;
-    params->has_x_multifd_page_count =3D true;
-    params->x_multifd_page_count =3D s->parameters.x_multifd_page_count;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1112,14 +1109,6 @@ static bool migrate_params_check(MigrationParamete=
rs *params, Error **errp)
                    "is invalid, it should be in the range of 1 to 255");
         return false;
     }
-    if (params->has_x_multifd_page_count &&
-        (params->x_multifd_page_count < 1 ||
-         params->x_multifd_page_count > 10000)) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                   "multifd_page_count",
-                   "is invalid, it should be in the range of 1 to 10000"=
);
-        return false;
-    }
=20
     if (params->has_xbzrle_cache_size &&
         (params->xbzrle_cache_size < qemu_target_page_size() ||
@@ -1202,9 +1191,6 @@ static void migrate_params_test_apply(MigrateSetPar=
ameters *params,
     if (params->has_x_multifd_channels) {
         dest->x_multifd_channels =3D params->x_multifd_channels;
     }
-    if (params->has_x_multifd_page_count) {
-        dest->x_multifd_page_count =3D params->x_multifd_page_count;
-    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
     }
@@ -1283,9 +1269,6 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
     if (params->has_x_multifd_channels) {
         s->parameters.x_multifd_channels =3D params->x_multifd_channels;
     }
-    if (params->has_x_multifd_page_count) {
-        s->parameters.x_multifd_page_count =3D params->x_multifd_page_co=
unt;
-    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
@@ -2044,15 +2027,6 @@ int migrate_multifd_channels(void)
     return s->parameters.x_multifd_channels;
 }
=20
-int migrate_multifd_page_count(void)
-{
-    MigrationState *s;
-
-    s =3D migrate_get_current();
-
-    return s->parameters.x_multifd_page_count;
-}
-
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
@@ -3286,9 +3260,6 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("x-multifd-channels", MigrationState,
                       parameters.x_multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
-    DEFINE_PROP_UINT32("x-multifd-page-count", MigrationState,
-                      parameters.x_multifd_page_count,
-                      DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3366,7 +3337,6 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay =3D true;
     params->has_block_incremental =3D true;
     params->has_x_multifd_channels =3D true;
-    params->has_x_multifd_page_count =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/migration/migration.h b/migration/migration.h
index bd41b57af9..5e2b004a6c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -269,7 +269,6 @@ bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
-int migrate_multifd_page_count(void);
=20
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/migration/ram.c b/migration/ram.c
index 59191c1ed2..ebe893e356 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -520,6 +520,9 @@ exit:
=20
 #define MULTIFD_FLAG_SYNC (1 << 0)
=20
+#define MULTIFD_PAGE_COUNT 128
+
+
 typedef struct {
     uint32_t magic;
     uint32_t version;
@@ -718,7 +721,7 @@ static void multifd_send_fill_packet(MultiFDSendParam=
s *p)
     packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
     packet->version =3D cpu_to_be32(MULTIFD_VERSION);
     packet->flags =3D cpu_to_be32(p->flags);
-    packet->size =3D cpu_to_be32(migrate_multifd_page_count());
+    packet->size =3D cpu_to_be32(MULTIFD_PAGE_COUNT);
     packet->used =3D cpu_to_be32(p->pages->used);
     packet->packet_num =3D cpu_to_be64(p->packet_num);
=20
@@ -756,10 +759,10 @@ static int multifd_recv_unfill_packet(MultiFDRecvPa=
rams *p, Error **errp)
     p->flags =3D be32_to_cpu(packet->flags);
=20
     packet->size =3D be32_to_cpu(packet->size);
-    if (packet->size > migrate_multifd_page_count()) {
+    if (packet->size > MULTIFD_PAGE_COUNT) {
         error_setg(errp, "multifd: received packet "
                    "with size %d and expected maximum size %d",
-                   packet->size, migrate_multifd_page_count()) ;
+                   packet->size, MULTIFD_PAGE_COUNT) ;
         return -1;
     }
=20
@@ -1085,7 +1088,7 @@ static void multifd_new_send_channel_async(QIOTask =
*task, gpointer opaque)
 int multifd_save_setup(void)
 {
     int thread_count;
-    uint32_t page_count =3D migrate_multifd_page_count();
+    uint32_t page_count =3D MULTIFD_PAGE_COUNT;
     uint8_t i;
=20
     if (!migrate_use_multifd()) {
@@ -1281,7 +1284,7 @@ static void *multifd_recv_thread(void *opaque)
 int multifd_load_setup(void)
 {
     int thread_count;
-    uint32_t page_count =3D migrate_multifd_page_count();
+    uint32_t page_count =3D MULTIFD_PAGE_COUNT;
     uint8_t i;
=20
     if (!migrate_use_multifd()) {
diff --git a/qapi/migration.json b/qapi/migration.json
index b62947791f..8c5db60406 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -547,9 +547,6 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread.
-#                        The default value is 16 (since 2.11)
-#
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
@@ -569,7 +566,7 @@
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
-           'x-multifd-channels', 'x-multifd-page-count',
+           'x-multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle' ] }
=20
@@ -637,9 +634,6 @@
 #                     number of sockets used for migration.  The
 #                     default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread.
-#                        The default value is 16 (since 2.11)
-#
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
@@ -670,7 +664,6 @@
             '*x-checkpoint-delay': 'int',
             '*block-incremental': 'bool',
             '*x-multifd-channels': 'int',
-            '*x-multifd-page-count': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
 	    '*max-cpu-throttle': 'int' } }
@@ -754,9 +747,6 @@
 #                     number of sockets used for migration.
 #                     The default value is 2 (since 2.11)
 #
-# @x-multifd-page-count: Number of pages sent together to a thread.
-#                        The default value is 16 (since 2.11)
-#
 # @xbzrle-cache-size: cache size to be used by XBZRLE migration.  It
 #                     needs to be a multiple of the target page size
 #                     and a power of 2
@@ -786,7 +776,6 @@
             '*x-checkpoint-delay': 'uint32',
             '*block-incremental': 'bool' ,
             '*x-multifd-channels': 'uint8',
-            '*x-multifd-page-count': 'uint32',
             '*xbzrle-cache-size': 'size',
 	    '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle':'uint8'} }
--=20
2.20.1

Received: from eggs.gnu.org ([209.51.188.92]:39672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwULS-0007tX-5n
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwULP-0003zE-He
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:03:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwULP-0003sv-54
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75EDBC007351
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:58:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Feb 2019 13:57:53 +0100
Message-Id: <20190220125755.3906-2-quintela@redhat.com>
In-Reply-To: <20190220125755.3906-1-quintela@redhat.com>
References: <20190220125755.3906-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] migration: Add multifd-compress parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hmp.c                        | 17 +++++++++++++++++
 hw/core/qdev-properties.c    | 11 +++++++++++
 include/hw/qdev-properties.h |  1 +
 migration/migration.c        | 25 +++++++++++++++++++++++++
 migration/migration.h        |  1 +
 qapi/common.json             | 15 +++++++++++++++
 qapi/migration.json          | 20 ++++++++++++++++----
 7 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/hmp.c b/hmp.c
index 34edad6ea3..abbd49ec17 100644
--- a/hmp.c
+++ b/hmp.c
@@ -422,6 +422,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const =
QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS)=
,
             params->multifd_channels);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS)=
,
+            MultifdCompress_str(params->multifd_compress));
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE=
),
             params->xbzrle_cache_size);
@@ -1690,6 +1693,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
     MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
     uint64_t valuebw =3D 0;
     uint64_t cache_size;
+    int compress_type;
     Error *err =3D NULL;
     int val, ret;
=20
@@ -1769,6 +1773,19 @@ void hmp_migrate_set_parameter(Monitor *mon, const=
 QDict *qdict)
         p->has_multifd_channels =3D true;
         visit_type_int(v, param, &p->multifd_channels, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
+        p->has_multifd_compress =3D true;
+        visit_type_enum(v, param, &compress_type,
+                        &MultifdCompress_lookup, &err);
+        if (err) {
+            break;
+        }
+        if (compress_type < 0 || compress_type > MULTIFD_COMPRESS__MAX) =
{
+            error_setg(&err, "Invalid multifd_compress option %s", value=
str);
+            break;
+        }
+        p->multifd_compress =3D compress_type;
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5da1439a8b..7c8e71532f 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -645,6 +645,17 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
     .set_default_value =3D set_default_value_enum,
 };
=20
+/* --- MultifdCompress --- */
+
+const PropertyInfo qdev_prop_multifd_compress =3D {
+    .name =3D "MultifdCompress",
+    .description =3D "multifd_compress values",
+    .enum_table =3D &MultifdCompress_lookup,
+    .get =3D get_enum,
+    .set =3D set_enum,
+    .set_default_value =3D set_default_value_enum,
+};
+
 /* --- pci address --- */
=20
 /*
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b6758c852e..ac452d8f2c 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -23,6 +23,7 @@ extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
+extern const PropertyInfo qdev_prop_multifd_compress;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
diff --git a/migration/migration.c b/migration/migration.c
index f246519ec8..568ec8530f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -81,6 +81,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESS false
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -748,6 +749,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->block_incremental =3D s->parameters.block_incremental;
     params->has_multifd_channels =3D true;
     params->multifd_channels =3D s->parameters.multifd_channels;
+    params->has_multifd_compress =3D true;
+    params->multifd_compress =3D s->parameters.multifd_compress;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1191,6 +1194,9 @@ static void migrate_params_test_apply(MigrateSetPar=
ameters *params,
     if (params->has_multifd_channels) {
         dest->multifd_channels =3D params->multifd_channels;
     }
+    if (params->has_multifd_compress) {
+        dest->multifd_compress =3D params->multifd_compress;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
     }
@@ -1269,6 +1275,9 @@ static void migrate_params_apply(MigrateSetParamete=
rs *params, Error **errp)
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels =3D params->multifd_channels;
     }
+    if (params->has_multifd_compress) {
+        s->parameters.multifd_compress =3D params->multifd_compress;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
@@ -2008,6 +2017,15 @@ bool migrate_use_multifd(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIFD];
 }
=20
+bool migrate_use_multifd_zlib(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multifd_compress =3D=3D MULTIFD_COMPRESS_ZLIB;
+}
+
 bool migrate_pause_before_switchover(void)
 {
     MigrationState *s;
@@ -3220,6 +3238,9 @@ void migration_global_dump(Monitor *mon)
 #define DEFINE_PROP_MIG_CAP(name, x)             \
     DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], fals=
e)
=20
+#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, Multi=
fdCompress)
+
 static Property migration_properties[] =3D {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
@@ -3260,6 +3281,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
                       parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
+    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
+                      parameters.multifd_compress,
+                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3337,6 +3361,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay =3D true;
     params->has_block_incremental =3D true;
     params->has_multifd_channels =3D true;
+    params->has_multifd_compress =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/migration/migration.h b/migration/migration.h
index 7e03643683..646614f71b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -267,6 +267,7 @@ bool migrate_dirty_bitmaps(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
+bool migrate_use_multifd_zlib(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
=20
diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..ccdd58d21b 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -193,3 +193,18 @@
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
+
+##
+# @MultifdCompress:
+#
+# An enumeration of multifd compression.
+#
+# @none: no compression.
+#
+# @zlib: Compress using zlib.
+#
+# Since: 3.1
+#
+##
+{ 'enum': 'MultifdCompress',
+  'data': [ 'none', 'zlib' ] }
diff --git a/qapi/migration.json b/qapi/migration.json
index c202703889..a882fc0823 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -558,6 +558,10 @@
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
+#
+# @multifd-compress: What compression method to use.
+#                    Defaults to none. (Since 4.0)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -568,7 +572,7 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle' ] }
+           'max-cpu-throttle', 'multifd-compress' ] }
=20
 ##
 # @MigrateSetParameters:
@@ -644,7 +648,10 @@
 #                     (Since 3.0)
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
-#                    The default value is 99. (Since 3.1)
+#                    The default value is 99. (Since 4.0)
+#
+# @multifd-compress: What compression method to use.
+#                    Defaults to none. (Since 4.0)
 #
 # Since: 2.4
 ##
@@ -666,7 +673,8 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-	    '*max-cpu-throttle': 'int' } }
+	    '*max-cpu-throttle': 'int',
+            '*multifd-compress': 'MultifdCompress' } }
=20
 ##
 # @migrate-set-parameters:
@@ -760,6 +768,9 @@
 #                    Defaults to 99.
 #                     (Since 3.1)
 #
+# @multifd-compress: What compression method to use.
+#                    Defaults to none. (Since 4.0)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -778,7 +789,8 @@
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
 	    '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle':'uint8'} }
+            '*max-cpu-throttle': 'uint8',
+            '*multifd-compress': 'MultifdCompress' } }
=20
 ##
 # @query-migrate-parameters:
--=20
2.20.1

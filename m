Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A248C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3262321835
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 02:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6MFRT9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3262321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihOno-0005sQ-AB
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 21:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihOeo-00032Q-Dn
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihOem-0005nn-FM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihOel-0005mY-PC
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 21:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576634502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVRIBO5wyUrsQa52u78XdUvKUuObp4iAocslgdnORJw=;
 b=M6MFRT9C1IltZ9zE6bRWYLKQVDxM3JzWTYvePnyxIJDouf30c85vRBeSwnkyLBEeqh6pt3
 2tbFSWeKwN+hRGDrLDsbdT2KHnB3PN+wzxD1ditpE7JYUfqTEhmxRVlBrHOdR2Ec3A60qJ
 JSlnmdm508sEl5iY2W3kuj282mj6v7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-ujEIcne4M42VAqocn6TrSQ-1; Tue, 17 Dec 2019 21:01:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82D46DB21
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 02:01:38 +0000 (UTC)
Received: from secure.mitica (ovpn-116-32.ams2.redhat.com [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA6519C58;
 Wed, 18 Dec 2019 02:01:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] migration: Add multifd-compress parameter
Date: Wed, 18 Dec 2019 03:01:15 +0100
Message-Id: <20191218020119.3776-7-quintela@redhat.com>
In-Reply-To: <20191218020119.3776-1-quintela@redhat.com>
References: <20191218020119.3776-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ujEIcne4M42VAqocn6TrSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>

---
Rename it to NONE
Fix typos (dave)
We don't need to chek values returned by visit_type_MultifdCompress (markus=
)
Fix yet more typos (wei)
---
 hw/core/qdev-properties.c    | 13 +++++++++++++
 include/hw/qdev-properties.h |  3 +++
 migration/migration.c        | 13 +++++++++++++
 monitor/hmp-cmds.c           | 13 +++++++++++++
 qapi/migration.json          | 30 +++++++++++++++++++++++++++---
 tests/migration-test.c       | 13 ++++++++++---
 6 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ac28890e5a..644705235e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -8,6 +8,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-types-migration.h"
 #include "hw/block/block.h"
 #include "net/hub.h"
 #include "qapi/visitor.h"
@@ -648,6 +649,18 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
     .set_default_value =3D set_default_value_enum,
 };
=20
+/* --- MultifdCompress --- */
+
+const PropertyInfo qdev_prop_multifd_compress =3D {
+    .name =3D "MultifdCompress",
+    .description =3D "multifd_compress values, "
+                   "none",
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
index c6a8cb5516..07d7bba682 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -21,6 +21,7 @@ extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
+extern const PropertyInfo qdev_prop_multifd_compress;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -204,6 +205,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
+#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, Multifd=
Compress)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/migration/migration.c b/migration/migration.c
index cf6cec5fb6..93c6ed10a6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -87,6 +87,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 16
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESS MULTIFD_COMPRESS_NONE
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -774,6 +775,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->block_incremental =3D s->parameters.block_incremental;
     params->has_multifd_channels =3D true;
     params->multifd_channels =3D s->parameters.multifd_channels;
+    params->has_multifd_compress =3D true;
+    params->multifd_compress =3D s->parameters.multifd_compress;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1281,6 +1284,9 @@ static void migrate_params_test_apply(MigrateSetParam=
eters *params,
     if (params->has_multifd_channels) {
         dest->multifd_channels =3D params->multifd_channels;
     }
+    if (params->has_multifd_compress) {
+        dest->multifd_compress =3D params->multifd_compress;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size =3D params->xbzrle_cache_size;
     }
@@ -1377,6 +1383,9 @@ static void migrate_params_apply(MigrateSetParameters=
 *params, Error **errp)
     if (params->has_multifd_channels) {
         s->parameters.multifd_channels =3D params->multifd_channels;
     }
+    if (params->has_multifd_compress) {
+        s->parameters.multifd_compress =3D params->multifd_compress;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size =3D params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
@@ -3474,6 +3483,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
                       parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
+    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
+                      parameters.multifd_compress,
+                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3564,6 +3576,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay =3D true;
     params->has_block_incremental =3D true;
     params->has_multifd_channels =3D true;
+    params->has_multifd_compress =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b2551c16d1..caf06b0668 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -39,6 +39,7 @@
 #include "qapi/qapi-commands-tpm.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qapi-visit-net.h"
+#include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
@@ -448,6 +449,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QD=
ict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_CHANNELS),
             params->multifd_channels);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_MULTIFD_COMPRESS),
+            MultifdCompress_str(params->multifd_compress));
         monitor_printf(mon, "%s: %" PRIu64 "\n",
             MigrationParameter_str(MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE),
             params->xbzrle_cache_size);
@@ -1739,6 +1743,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
     MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
     uint64_t valuebw =3D 0;
     uint64_t cache_size;
+    MultifdCompress compress_type;
     Error *err =3D NULL;
     int val, ret;
=20
@@ -1824,6 +1829,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
         p->has_multifd_channels =3D true;
         visit_type_int(v, param, &p->multifd_channels, &err);
         break;
+    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
+        p->has_multifd_compress =3D true;
+        visit_type_MultifdCompress(v, param, &compress_type, &err);
+        if (err) {
+            break;
+        }
+        p->multifd_compress =3D compress_type;
+        break;
     case MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE:
         p->has_xbzrle_cache_size =3D true;
         visit_type_size(v, param, &cache_size, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index b7348d0c8b..430a39382e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -488,6 +488,19 @@
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapabil=
ityStatus']}
=20
+##
+# @MultifdCompress:
+#
+# An enumeration of multifd compression.
+#
+# @none: no compression.
+#
+# Since: 4.1
+#
+##
+{ 'enum': 'MultifdCompress',
+  'data': [ 'none' ] }
+
 ##
 # @MigrationParameter:
 #
@@ -586,6 +599,9 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
 #
+# @multifd-compress: Which compression method to use.
+#                    Defaults to none. (Since 4.1)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -598,7 +614,7 @@
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
-           'max-cpu-throttle' ] }
+           'max-cpu-throttle', 'multifd-compress' ] }
=20
 ##
 # @MigrateSetParameters:
@@ -688,6 +704,9 @@
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    The default value is 99. (Since 3.1)
 #
+# @multifd-compress: Which compression method to use.
+#                    Defaults to none. (Since 4.1)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -713,7 +732,8 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-=09    '*max-cpu-throttle': 'int' } }
+            '*max-cpu-throttle': 'int',
+            '*multifd-compress': 'MultifdCompress' } }
=20
 ##
 # @migrate-set-parameters:
@@ -823,6 +843,9 @@
 #                    Defaults to 99.
 #                     (Since 3.1)
 #
+# @multifd-compress: Which compression method to use.
+#                    Defaults to none. (Since 4.1)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -846,7 +869,8 @@
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
 =09    '*max-postcopy-bandwidth': 'size',
-            '*max-cpu-throttle':'uint8'} }
+            '*max-cpu-throttle': 'uint8',
+            '*multifd-compress': 'MultifdCompress' } }
=20
 ##
 # @query-migrate-parameters:
diff --git a/tests/migration-test.c b/tests/migration-test.c
index fc221f172a..e5b6e54cfa 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -482,7 +482,6 @@ static void migrate_check_parameter_str(QTestState *who=
, const char *parameter,
     g_free(result);
 }
=20
-__attribute__((unused))
 static void migrate_set_parameter_str(QTestState *who, const char *paramet=
er,
                                       const char *value)
 {
@@ -1398,7 +1397,7 @@ static void test_migrate_auto_converge(void)
     test_migrate_end(from, to, true);
 }
=20
-static void test_multifd_tcp(void)
+static void test_multifd_tcp(const char *method)
 {
     MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
@@ -1422,6 +1421,9 @@ static void test_multifd_tcp(void)
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
=20
+    migrate_set_parameter_str(from, "multifd-compress", method);
+    migrate_set_parameter_str(to, "multifd-compress", method);
+
     migrate_set_capability(from, "multifd", "true");
     migrate_set_capability(to, "multifd", "true");
=20
@@ -1453,6 +1455,11 @@ static void test_multifd_tcp(void)
     free(uri);
 }
=20
+static void test_multifd_tcp_none(void)
+{
+    test_multifd_tcp("none");
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1517,7 +1524,7 @@ int main(int argc, char **argv)
                    test_validate_uuid_dst_not_set);
=20
     qtest_add_func("/migration/auto_converge", test_migrate_auto_converge)=
;
-    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
+    qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
=20
     ret =3D g_test_run();
=20
--=20
2.23.0



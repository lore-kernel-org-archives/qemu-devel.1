Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6651724655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 13:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVRb5x5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6651724655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iucE6-0004Lv-TR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 08:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iub8i-0001uL-4I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iub8g-0004uP-4t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55884
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iub8f-0004tG-V8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMkXTWrXl1nIHDu6Pwtz6k1RxcJSxrnoNOMJSzgEYLI=;
 b=QVRb5x5OjN04KbV9aa7q5XpfVi2NCX+6cFAW2+zjYXXQ2ftOlkQ4mDI8V7uALI1n4lrLaH
 zLnnNYL9TOOSM7xnqDZPJop5aAxB5whq2d9GXrOZGAmUexRPQNbZG0gTgB3M4FfVpjLEdj
 GR9g99sJNIzH2wuHnoVlFLEQuowlIIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-rv6vBLUOMwu9DO3ctyYALw-1; Thu, 23 Jan 2020 06:59:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 610EE18A6ECF
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:59:05 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DEE219C69;
 Thu, 23 Jan 2020 11:59:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/21] migration: Add multifd-compress parameter
Date: Thu, 23 Jan 2020 12:58:19 +0100
Message-Id: <20200123115831.36842-10-quintela@redhat.com>
In-Reply-To: <20200123115831.36842-1-quintela@redhat.com>
References: <20200123115831.36842-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: rv6vBLUOMwu9DO3ctyYALw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

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
 tests/qtest/migration-test.c | 14 ++++++++++----
 6 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 6ca7697599..ff6a752b19 100644
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
@@ -641,6 +642,18 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
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
index a90a9cec80..72f21a74c6 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -20,6 +20,7 @@ extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_on_off_auto;
+extern const PropertyInfo qdev_prop_multifd_compress;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -184,6 +185,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
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
index ef17b9f3f2..ecb56afd50 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -87,6 +87,7 @@
 /* The delay time (in ms) between two COLO checkpoints */
 #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
 #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
+#define DEFAULT_MIGRATE_MULTIFD_COMPRESS MULTIFD_COMPRESS_NONE
=20
 /* Background transfer rate for postcopy, 0 means unlimited, note
  * that page requests can still exceed this limit.
@@ -797,6 +798,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->block_incremental =3D s->parameters.block_incremental;
     params->has_multifd_channels =3D true;
     params->multifd_channels =3D s->parameters.multifd_channels;
+    params->has_multifd_compress =3D true;
+    params->multifd_compress =3D s->parameters.multifd_compress;
     params->has_xbzrle_cache_size =3D true;
     params->xbzrle_cache_size =3D s->parameters.xbzrle_cache_size;
     params->has_max_postcopy_bandwidth =3D true;
@@ -1314,6 +1317,9 @@ static void migrate_params_test_apply(MigrateSetParam=
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
@@ -1410,6 +1416,9 @@ static void migrate_params_apply(MigrateSetParameters=
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
@@ -3514,6 +3523,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("multifd-channels", MigrationState,
                       parameters.multifd_channels,
                       DEFAULT_MIGRATE_MULTIFD_CHANNELS),
+    DEFINE_PROP_MULTIFD_COMPRESS("multifd-compress", MigrationState,
+                      parameters.multifd_compress,
+                      DEFAULT_MIGRATE_MULTIFD_COMPRESS),
     DEFINE_PROP_SIZE("xbzrle-cache-size", MigrationState,
                       parameters.xbzrle_cache_size,
                       DEFAULT_MIGRATE_XBZRLE_CACHE_SIZE),
@@ -3604,6 +3616,7 @@ static void migration_instance_init(Object *obj)
     params->has_x_checkpoint_delay =3D true;
     params->has_block_incremental =3D true;
     params->has_multifd_channels =3D true;
+    params->has_multifd_compress =3D true;
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d0e0af893a..ba75a609a7 100644
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
@@ -447,6 +448,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QD=
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
@@ -1738,6 +1742,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
     MigrateSetParameters *p =3D g_new0(MigrateSetParameters, 1);
     uint64_t valuebw =3D 0;
     uint64_t cache_size;
+    MultifdCompress compress_type;
     Error *err =3D NULL;
     int val, ret;
=20
@@ -1823,6 +1828,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
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
index b7348d0c8b..c2891e6ebf 100644
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
+#                    Defaults to none. (Since 5.0)
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
+#                    Defaults to none. (Since 5.0)
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
+#                    Defaults to none. (Since 5.0)
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
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index cf27ebbc9d..3d5d2aba8c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -378,7 +378,6 @@ static void migrate_check_parameter_str(QTestState *who=
, const char *parameter,
     g_free(result);
 }
=20
-__attribute__((unused))
 static void migrate_set_parameter_str(QTestState *who, const char *paramet=
er,
                                       const char *value)
 {
@@ -1251,7 +1250,7 @@ static void test_migrate_auto_converge(void)
     test_migrate_end(from, to, true);
 }
=20
-static void test_multifd_tcp(void)
+static void test_multifd_tcp(const char *method)
 {
     MigrateStart *args =3D migrate_start_new();
     QTestState *from, *to;
@@ -1275,6 +1274,9 @@ static void test_multifd_tcp(void)
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
=20
+    migrate_set_parameter_str(from, "multifd-compress", method);
+    migrate_set_parameter_str(to, "multifd-compress", method);
+
     migrate_set_capability(from, "multifd", "true");
     migrate_set_capability(to, "multifd", "true");
=20
@@ -1306,6 +1308,11 @@ static void test_multifd_tcp(void)
     g_free(uri);
 }
=20
+static void test_multifd_tcp_none(void)
+{
+    test_multifd_tcp("none");
+}
+
 /*
  * This test does:
  *  source               target
@@ -1317,7 +1324,6 @@ static void test_multifd_tcp(void)
  *
  *  And see that it works
  */
-
 static void test_multifd_tcp_cancel(void)
 {
     MigrateStart *args =3D migrate_start_new();
@@ -1467,7 +1473,7 @@ int main(int argc, char **argv)
                    test_validate_uuid_dst_not_set);
=20
     qtest_add_func("/migration/auto_converge", test_migrate_auto_converge)=
;
-    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
+    qtest_add_func("/migration/multifd/tcp/none", test_multifd_tcp_none);
     qtest_add_func("/migration/multifd/tcp/cancel", test_multifd_tcp_cance=
l);
=20
     ret =3D g_test_run();
--=20
2.24.1



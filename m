Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBE1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23754207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23754207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3GP-0002bL-Uc
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Ay-0004RO-M2
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Av-0006xn-Pv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:24 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CV4tQ08HHz74SM;
 Mon,  9 Nov 2020 17:09:02 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:09:02 +0800
From: Zeyu Jin <jinzeyu@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 1/6] migration: Add multi-thread compress method
Date: Mon, 9 Nov 2020 17:08:45 +0800
Message-ID: <20201109090850.2424-2-jinzeyu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109090850.2424-1-jinzeyu@huawei.com>
References: <20201109090850.2424-1-jinzeyu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=jinzeyu@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 04:09:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org,
 Zeyu Jin <jinzeyu@huawei.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A multi-thread compress method parameter is added to hold the method we
are going to use. By default the 'zlib' method is used to maintain the
compatibility as before.

Signed-off-by: Zeyu Jin <jinzeyu@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/core/qdev-properties-system.c | 11 +++++++++++
 include/hw/qdev-properties.h     |  4 ++++
 migration/migration.c            | 15 +++++++++++++++
 monitor/hmp-cmds.c               | 12 ++++++++++++
 qapi/migration.json              | 26 +++++++++++++++++++++++++-
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b81a4e8d14..d757b2cd70 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -663,6 +663,17 @@ const PropertyInfo qdev_prop_multifd_compression = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- CompressMethod --- */
+const PropertyInfo qdev_prop_compress_method = {
+    .name = "CompressMethod",
+    .description = "multi-thread compression method, "
+                   "zlib",
+    .enum_table = &CompressMethod_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4437450065..4a943f7e80 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -23,6 +23,7 @@ extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_multifd_compression;
+extern const PropertyInfo qdev_prop_compress_method;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -193,6 +194,9 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compression, \
                        MultiFDCompression)
+#define DEFINE_PROP_COMPRESS_METHOD(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_compress_method, \
+                       CompressMethod)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/migration/migration.c b/migration/migration.c
index 3263aa55a9..d0da95fc0d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -83,6 +83,7 @@
 #define DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT 2
 /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_COMPRESS_LEVEL 1
+#define DEFAULT_MIGRATE_COMPRESS_METHOD COMPRESS_METHOD_ZLIB
 /* Define default autoconverge cpu throttle migration parameters */
 #define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
@@ -843,6 +844,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->compress_wait_thread = s->parameters.compress_wait_thread;
     params->has_decompress_threads = true;
     params->decompress_threads = s->parameters.decompress_threads;
+    params->has_compress_method = true;
+    params->compress_method = s->parameters.compress_method;
     params->has_throttle_trigger_threshold = true;
     params->throttle_trigger_threshold = s->parameters.throttle_trigger_threshold;
     params->has_cpu_throttle_initial = true;
@@ -1407,6 +1410,10 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
         dest->decompress_threads = params->decompress_threads;
     }
 
+    if (params->has_compress_method) {
+        dest->compress_method = params->compress_method;
+    }
+
     if (params->has_throttle_trigger_threshold) {
         dest->throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
@@ -1504,6 +1511,10 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
         s->parameters.decompress_threads = params->decompress_threads;
     }
 
+    if (params->has_compress_method) {
+        s->parameters.compress_method = params->compress_method;
+    }
+
     if (params->has_throttle_trigger_threshold) {
         s->parameters.throttle_trigger_threshold = params->throttle_trigger_threshold;
     }
@@ -3715,6 +3726,9 @@ static Property migration_properties[] = {
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
+    DEFINE_PROP_COMPRESS_METHOD("compress-method", MigrationState,
+                      parameters.compress_method,
+                      DEFAULT_MIGRATE_COMPRESS_METHOD),
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
                       parameters.throttle_trigger_threshold,
                       DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
@@ -3829,6 +3843,7 @@ static void migration_instance_init(Object *obj)
     params->has_compress_level = true;
     params->has_compress_threads = true;
     params->has_decompress_threads = true;
+    params->has_compress_method = true;
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
     params->has_cpu_throttle_increment = true;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 56e9bad33d..e771c36e1b 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -419,6 +419,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS),
             params->decompress_threads);
         assert(params->has_throttle_trigger_threshold);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_COMPRESS_METHOD),
+            CompressMethod_str(params->compress_method));
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD),
             params->throttle_trigger_threshold);
@@ -1281,6 +1284,7 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
     MigrateSetParameters *p = g_new0(MigrateSetParameters, 1);
     uint64_t valuebw = 0;
     uint64_t cache_size;
+    CompressMethod compress_method;
     Error *err = NULL;
     int val, ret;
 
@@ -1306,6 +1310,14 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         p->has_decompress_threads = true;
         visit_type_int(v, param, &p->decompress_threads, &err);
         break;
+    case MIGRATION_PARAMETER_COMPRESS_METHOD:
+        p->has_compress_method = true;
+        visit_type_CompressMethod(v, param, &compress_method, &err);
+        if (err) {
+            break;
+        }
+        p->compress_method = compress_method;
+        break;
     case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
         p->has_throttle_trigger_threshold = true;
         visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index 3c75820527..d262683a38 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -525,6 +525,19 @@
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
 
+##
+# @CompressMethod:
+#
+# An enumeration of multi-thread compression methods.
+#
+# @zlib: use zlib compression method.
+#
+# Since: 5.0
+#
+##
+{ 'enum': 'CompressMethod',
+  'data': [ 'zlib' ] }
+
 ##
 # @BitmapMigrationBitmapAlias:
 #
@@ -599,6 +612,9 @@
 #                      compression, so set the decompress-threads to the number about 1/4
 #                      of compress-threads is adequate.
 #
+# @compress-method: Set compression method to use in multi-thread compression.
+#                   Defaults to none. (Since 5.0)
+#
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and bytes_xfer_period
 #                              to trigger throttling. It is expressed as percentage.
 #                              The default value is 50. (Since 5.0)
@@ -722,7 +738,7 @@
   'data': ['announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
            'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread', 'throttle-trigger-threshold',
+           'compress-wait-thread', 'compress-method', 'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
@@ -759,6 +775,9 @@
 #
 # @decompress-threads: decompression thread count
 #
+# @compress-method: Which multi-thread compression method to use.
+#                   Defaults to none. (Since 5.0)
+#
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and bytes_xfer_period
 #                              to trigger throttling. It is expressed as percentage.
 #                              The default value is 50. (Since 5.0)
@@ -889,6 +908,7 @@
             '*compress-threads': 'int',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
+            '*compress-method': 'CompressMethod',
             '*throttle-trigger-threshold': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
@@ -953,6 +973,9 @@
 #
 # @decompress-threads: decompression thread count
 #
+# @compress-method: Which multi-thread compression method to use.
+#                   Defaults to none. (Since 5.0)
+#
 # @throttle-trigger-threshold: The ratio of bytes_dirty_period and bytes_xfer_period
 #                              to trigger throttling. It is expressed as percentage.
 #                              The default value is 50. (Since 5.0)
@@ -1083,6 +1106,7 @@
             '*compress-threads': 'uint8',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
+            '*compress-method': 'CompressMethod',
             '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
-- 
2.23.0



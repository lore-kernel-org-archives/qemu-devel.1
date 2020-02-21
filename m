Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9EC11D00
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083FF208CD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083FF208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4yYn-0004gi-8n
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1j4yXl-00045b-Ru
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 21:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1j4yXk-00034y-48
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 21:59:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2721 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1j4yXf-0002le-UT; Thu, 20 Feb 2020 21:59:52 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2C519A1C619A80C408AD;
 Fri, 21 Feb 2020 10:59:42 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 21 Feb 2020 10:59:36 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] migration/throttle: Add throttle-trig-thres migration
 parameter
Date: Fri, 21 Feb 2020 10:57:27 +0800
Message-ID: <20200221025727.63808-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, wanghaibin.wang@huawei.com,
 Keqian Zhu <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, if the bytes_dirty_period is more than the 50% of
bytes_xfer_period, we start or increase throttling.

If we make this percentage higher, then we can tolerate higher
dirty rate during migration, which means less impact on guest.
The side effect of higher percentage is longer migration time.

We can configure this parameter to switch between migration time
firt or guest performance first. The default value is 50.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c | 24 ++++++++++++++++++++++++
 migration/ram.c       | 21 +++++++++++++++------
 monitor/hmp-cmds.c    |  7 +++++++
 qapi/migration.json   | 16 +++++++++++++++-
 4 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8fb68795dc..e6c2451734 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@
 /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_COMPRESS_LEVEL 1
 /* Define default autoconverge cpu throttle migration parameters */
+#define DEFAULT_MIGRATE_THROTTLE_TRIG_THRES 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT 10
 #define DEFAULT_MIGRATE_MAX_CPU_THROTTLE 99
@@ -778,6 +779,8 @@ MigrationParameters *qmp_query_migrate_parameters(Err=
or **errp)
     params->compress_wait_thread =3D s->parameters.compress_wait_thread;
     params->has_decompress_threads =3D true;
     params->decompress_threads =3D s->parameters.decompress_threads;
+    params->has_throttle_trig_thres =3D true;
+    params->throttle_trig_thres =3D s->parameters.throttle_trig_thres;
     params->has_cpu_throttle_initial =3D true;
     params->cpu_throttle_initial =3D s->parameters.cpu_throttle_initial;
     params->has_cpu_throttle_increment =3D true;
@@ -1164,6 +1167,15 @@ static bool migrate_params_check(MigrationParamete=
rs *params, Error **errp)
         return false;
     }
=20
+    if (params->has_throttle_trig_thres &&
+        (params->throttle_trig_thres < 1 ||
+         params->throttle_trig_thres > 99)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "throttle_trig_thres",
+                   "an integer in the range of 1 to 99");
+        return false;
+    }
+
     if (params->has_cpu_throttle_initial &&
         (params->cpu_throttle_initial < 1 ||
          params->cpu_throttle_initial > 99)) {
@@ -1279,6 +1291,10 @@ static void migrate_params_test_apply(MigrateSetPa=
rameters *params,
         dest->decompress_threads =3D params->decompress_threads;
     }
=20
+    if (params->has_throttle_trig_thres) {
+        dest->throttle_trig_thres =3D params->throttle_trig_thres;
+    }
+
     if (params->has_cpu_throttle_initial) {
         dest->cpu_throttle_initial =3D params->cpu_throttle_initial;
     }
@@ -1360,6 +1376,10 @@ static void migrate_params_apply(MigrateSetParamet=
ers *params, Error **errp)
         s->parameters.decompress_threads =3D params->decompress_threads;
     }
=20
+    if (params->has_throttle_trig_thres) {
+        s->parameters.throttle_trig_thres =3D params->throttle_trig_thre=
s;
+    }
+
     if (params->has_cpu_throttle_initial) {
         s->parameters.cpu_throttle_initial =3D params->cpu_throttle_init=
ial;
     }
@@ -3506,6 +3526,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
+    DEFINE_PROP_UINT8("x-throttle-trig-thres", MigrationState,
+                      parameters.throttle_trig_thres,
+                      DEFAULT_MIGRATE_THROTTLE_TRIG_THRES),
     DEFINE_PROP_UINT8("x-cpu-throttle-initial", MigrationState,
                       parameters.cpu_throttle_initial,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
@@ -3606,6 +3629,7 @@ static void migration_instance_init(Object *obj)
     params->has_compress_level =3D true;
     params->has_compress_threads =3D true;
     params->has_decompress_threads =3D true;
+    params->has_throttle_trig_thres =3D true;
     params->has_cpu_throttle_initial =3D true;
     params->has_cpu_throttle_increment =3D true;
     params->has_max_bandwidth =3D true;
diff --git a/migration/ram.c b/migration/ram.c
index ed23ed1c7c..28081cb1e1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -901,6 +901,11 @@ static void migration_bitmap_sync(RAMState *rs)
     RAMBlock *block;
     int64_t end_time;
     uint64_t bytes_xfer_now;
+    uint64_t bytes_dirty_period;
+    uint64_t bytes_xfer_period;
+    uint64_t bytes_dirty_thres;
+    uint64_t throttle_trig_thres;
+    MigrationState *s =3D migrate_get_current();
=20
     ram_counters.dirty_sync_count++;
=20
@@ -934,13 +939,17 @@ static void migration_bitmap_sync(RAMState *rs)
          * throttling logic during the bulk phase of block migration. */
         if (migrate_auto_converge() && !blk_mig_bulk_active()) {
             /* The following detection logic can be refined later. For n=
ow:
-               Check to see if the dirtied bytes is 50% more than the ap=
prox.
-               amount of bytes that just got transferred since the last =
time we
-               were in this routine. If that happens twice, start or inc=
rease
-               throttling */
+               Check to see if the ratio between dirtied bytes and the a=
pprox.
+               amount of bytes that just got transferred since the last =
time
+               we were in this routine reaches the threshold. If that ha=
ppens
+               twice, start or increase throttling. */
+
+            bytes_dirty_period =3D rs->num_dirty_pages_period * TARGET_P=
AGE_SIZE;
+            bytes_xfer_period =3D bytes_xfer_now - rs->bytes_xfer_prev;
+            throttle_trig_thres =3D s->parameters.throttle_trig_thres;
+            bytes_dirty_thres =3D bytes_xfer_period * throttle_trig_thre=
s / 100;
=20
-            if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
-                   (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
+            if ((bytes_dirty_period > bytes_dirty_thres) &&
                 (++rs->dirty_rate_high_cnt >=3D 2)) {
                     trace_migration_throttle();
                     rs->dirty_rate_high_cnt =3D 0;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index b237613e0d..8673f5eeb2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -409,6 +409,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const=
 QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREAD=
S),
             params->decompress_threads);
+        assert(params->has_throttle_trig_thres);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIG_THR=
ES),
+            params->throttle_trig_thres);
         assert(params->has_cpu_throttle_initial);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INIT=
IAL),
@@ -1764,6 +1768,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const =
QDict *qdict)
         p->has_decompress_threads =3D true;
         visit_type_int(v, param, &p->decompress_threads, &err);
         break;
+    case MIGRATION_PARAMETER_THROTTLE_TRIG_THRES:
+        p->has_throttle_trig_thres =3D true;
+        visit_type_int(v, param, &p->throttle_trig_thres, &err);
     case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
         p->has_cpu_throttle_initial =3D true;
         visit_type_int(v, param, &p->cpu_throttle_initial, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index 52f3429969..4da5385832 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -524,6 +524,10 @@
 #                      compression, so set the decompress-threads to the=
 number about 1/4
 #                      of compress-threads is adequate.
 #
+# @throttle-trig-thres: The ratio of bytes_dirty_period and bytes_xfer_p=
eriod to
+#                       trigger throttling. It is expressed as percentag=
e. The
+#                       default value is 50. (Since 5.0)
+#
 # @cpu-throttle-initial: Initial percentage of time guest cpus are throt=
tled
 #                        when migration auto-converge is activated. The
 #                        default value is 20. (Since 2.7)
@@ -592,7 +596,7 @@
   'data': ['announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
            'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread',
+           'compress-wait-thread', 'throttle-trig-thres',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
@@ -626,6 +630,10 @@
 #
 # @decompress-threads: decompression thread count
 #
+# @throttle-trig-thres: The ratio of bytes_dirty_period and bytes_xfer_p=
eriod to
+#                       trigger throttling. It is expressed as percentag=
e. The
+#                       default value is 50. (Since 5.0)
+#
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #                        throttled when migration auto-converge is activ=
ated.
 #                        The default value is 20. (Since 2.7)
@@ -701,6 +709,7 @@
             '*compress-threads': 'int',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
+            '*throttle-trig-thres': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'StrOrNull',
@@ -759,6 +768,10 @@
 #
 # @decompress-threads: decompression thread count
 #
+# @throttle-trig-thres: The ratio of bytes_dirty_period and bytes_xfer_p=
eriod to
+#                       trigger throttling. It is expressed as percentag=
e. The
+#                       default value is 50. (Since 5.0)
+#
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #                        throttled when migration auto-converge is activ=
ated.
 #                        (Since 2.7)
@@ -834,6 +847,7 @@
             '*compress-threads': 'uint8',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
+            '*throttle-trig-thres': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*tls-creds': 'str',
--=20
2.19.1



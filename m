Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE68FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B528D206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3PR9ZcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B528D206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChc7-0001F6-Uf
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jChae-0008LW-6o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jChac-0005tj-9F
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jChac-0005qx-4K
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584095449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ilh5twvEhfre1mz234YZWMn9UbV7IQ+O7d/iKntKls=;
 b=Z3PR9ZcN8JeEcFGMgPZ3+TWtdm2MJM+Px0uPhXPUMKgK1PvpKjrNCZO/AI5GloJk/EPeH5
 wi26laNLcU6CQho1JWA4GGefUFvn4rPQl/tWWH1lLMq246uD586MiFGK2XNzoZgC8hlUC6
 2rNsECNDDnLHfp8wuJ2Ng8/lIDUTznA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-4ZIzarBBO1eIpsL_z_O7SQ-1; Fri, 13 Mar 2020 06:30:47 -0400
X-MC-Unique: 4ZIzarBBO1eIpsL_z_O7SQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C0DB107ACC9;
 Fri, 13 Mar 2020 10:30:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFACA8B773;
 Fri, 13 Mar 2020 10:30:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com,
 zhukeqian1@huawei.com, quintela@redhat.com
Subject: [PULL 2/5] migration/throttle: Add throttle-trig-thres migration
 parameter
Date: Fri, 13 Mar 2020 10:30:36 +0000
Message-Id: <20200313103039.150133-3-dgilbert@redhat.com>
In-Reply-To: <20200313103039.150133-1-dgilbert@redhat.com>
References: <20200313103039.150133-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keqian Zhu <zhukeqian1@huawei.com>

Currently, if the bytes_dirty_period is more than the 50% of
bytes_xfer_period, we start or increase throttling.

If we make this percentage higher, then we can tolerate higher
dirty rate during migration, which means less impact on guest.
The side effect of higher percentage is longer migration time.
We can make this parameter configurable to switch between mig-
ration time first or guest performance first.

The default value is 50 and valid range is 1 to 100.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Message-Id: <20200224023142.39360-1-zhukeqian1@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 24 ++++++++++++++++++++
 migration/ram.c       | 52 +++++++++++++++++++++++++------------------
 monitor/hmp-cmds.c    |  7 ++++++
 qapi/migration.json   | 16 ++++++++++++-
 4 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0b2045ccbd..59da5d0625 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@
 /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
 #define DEFAULT_MIGRATE_COMPRESS_LEVEL 1
 /* Define default autoconverge cpu throttle migration parameters */
+#define DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD 50
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL 20
 #define DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT 10
 #define DEFAULT_MIGRATE_MAX_CPU_THROTTLE 99
@@ -778,6 +779,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->compress_wait_thread =3D s->parameters.compress_wait_thread;
     params->has_decompress_threads =3D true;
     params->decompress_threads =3D s->parameters.decompress_threads;
+    params->has_throttle_trigger_threshold =3D true;
+    params->throttle_trigger_threshold =3D s->parameters.throttle_trigger_=
threshold;
     params->has_cpu_throttle_initial =3D true;
     params->cpu_throttle_initial =3D s->parameters.cpu_throttle_initial;
     params->has_cpu_throttle_increment =3D true;
@@ -1169,6 +1172,15 @@ static bool migrate_params_check(MigrationParameters=
 *params, Error **errp)
         return false;
     }
=20
+    if (params->has_throttle_trigger_threshold &&
+        (params->throttle_trigger_threshold < 1 ||
+         params->throttle_trigger_threshold > 100)) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "throttle_trigger_threshold",
+                   "an integer in the range of 1 to 100");
+        return false;
+    }
+
     if (params->has_cpu_throttle_initial &&
         (params->cpu_throttle_initial < 1 ||
          params->cpu_throttle_initial > 99)) {
@@ -1298,6 +1310,10 @@ static void migrate_params_test_apply(MigrateSetPara=
meters *params,
         dest->decompress_threads =3D params->decompress_threads;
     }
=20
+    if (params->has_throttle_trigger_threshold) {
+        dest->throttle_trigger_threshold =3D params->throttle_trigger_thre=
shold;
+    }
+
     if (params->has_cpu_throttle_initial) {
         dest->cpu_throttle_initial =3D params->cpu_throttle_initial;
     }
@@ -1382,6 +1398,10 @@ static void migrate_params_apply(MigrateSetParameter=
s *params, Error **errp)
         s->parameters.decompress_threads =3D params->decompress_threads;
     }
=20
+    if (params->has_throttle_trigger_threshold) {
+        s->parameters.throttle_trigger_threshold =3D params->throttle_trig=
ger_threshold;
+    }
+
     if (params->has_cpu_throttle_initial) {
         s->parameters.cpu_throttle_initial =3D params->cpu_throttle_initia=
l;
     }
@@ -3558,6 +3578,9 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("x-decompress-threads", MigrationState,
                       parameters.decompress_threads,
                       DEFAULT_MIGRATE_DECOMPRESS_THREAD_COUNT),
+    DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
+                      parameters.throttle_trigger_threshold,
+                      DEFAULT_MIGRATE_THROTTLE_TRIGGER_THRESHOLD),
     DEFINE_PROP_UINT8("x-cpu-throttle-initial", MigrationState,
                       parameters.cpu_throttle_initial,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INITIAL),
@@ -3667,6 +3690,7 @@ static void migration_instance_init(Object *obj)
     params->has_compress_level =3D true;
     params->has_compress_threads =3D true;
     params->has_decompress_threads =3D true;
+    params->has_throttle_trigger_threshold =3D true;
     params->has_cpu_throttle_initial =3D true;
     params->has_cpu_throttle_increment =3D true;
     params->has_max_bandwidth =3D true;
diff --git a/migration/ram.c b/migration/ram.c
index 0ef68798d2..02cfd76d19 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -896,11 +896,38 @@ static void migration_update_rates(RAMState *rs, int6=
4_t end_time)
     }
 }
=20
+static void migration_trigger_throttle(RAMState *rs)
+{
+    MigrationState *s =3D migrate_get_current();
+    uint64_t threshold =3D s->parameters.throttle_trigger_threshold;
+
+    uint64_t bytes_xfer_period =3D ram_counters.transferred - rs->bytes_xf=
er_prev;
+    uint64_t bytes_dirty_period =3D rs->num_dirty_pages_period * TARGET_PA=
GE_SIZE;
+    uint64_t bytes_dirty_threshold =3D bytes_xfer_period * threshold / 100=
;
+
+    /* During block migration the auto-converge logic incorrectly detects
+     * that ram migration makes no progress. Avoid this by disabling the
+     * throttling logic during the bulk phase of block migration. */
+    if (migrate_auto_converge() && !blk_mig_bulk_active()) {
+        /* The following detection logic can be refined later. For now:
+           Check to see if the ratio between dirtied bytes and the approx.
+           amount of bytes that just got transferred since the last time
+           we were in this routine reaches the threshold. If that happens
+           twice, start or increase throttling. */
+
+        if ((bytes_dirty_period > bytes_dirty_threshold) &&
+            (++rs->dirty_rate_high_cnt >=3D 2)) {
+            trace_migration_throttle();
+            rs->dirty_rate_high_cnt =3D 0;
+            mig_throttle_guest_down();
+        }
+    }
+}
+
 static void migration_bitmap_sync(RAMState *rs)
 {
     RAMBlock *block;
     int64_t end_time;
-    uint64_t bytes_xfer_now;
=20
     ram_counters.dirty_sync_count++;
=20
@@ -927,26 +954,7 @@ static void migration_bitmap_sync(RAMState *rs)
=20
     /* more than 1 second =3D 1000 millisecons */
     if (end_time > rs->time_last_bitmap_sync + 1000) {
-        bytes_xfer_now =3D ram_counters.transferred;
-
-        /* During block migration the auto-converge logic incorrectly dete=
cts
-         * that ram migration makes no progress. Avoid this by disabling t=
he
-         * throttling logic during the bulk phase of block migration. */
-        if (migrate_auto_converge() && !blk_mig_bulk_active()) {
-            /* The following detection logic can be refined later. For now=
:
-               Check to see if the dirtied bytes is 50% more than the appr=
ox.
-               amount of bytes that just got transferred since the last ti=
me we
-               were in this routine. If that happens twice, start or incre=
ase
-               throttling */
-
-            if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
-                   (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
-                (++rs->dirty_rate_high_cnt >=3D 2)) {
-                    trace_migration_throttle();
-                    rs->dirty_rate_high_cnt =3D 0;
-                    mig_throttle_guest_down();
-            }
-        }
+        migration_trigger_throttle(rs);
=20
         migration_update_rates(rs, end_time);
=20
@@ -955,7 +963,7 @@ static void migration_bitmap_sync(RAMState *rs)
         /* reset period counters */
         rs->time_last_bitmap_sync =3D end_time;
         rs->num_dirty_pages_period =3D 0;
-        rs->bytes_xfer_prev =3D bytes_xfer_now;
+        rs->bytes_xfer_prev =3D ram_counters.transferred;
     }
     if (migrate_use_events()) {
         qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 1c69d51b97..58724031ea 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -407,6 +407,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const Q=
Dict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_DECOMPRESS_THREADS)=
,
             params->decompress_threads);
+        assert(params->has_throttle_trigger_threshold);
+        monitor_printf(mon, "%s: %u\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_THROTTLE_TRIGGER_TH=
RESHOLD),
+            params->throttle_trigger_threshold);
         assert(params->has_cpu_throttle_initial);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INITIA=
L),
@@ -1254,6 +1258,9 @@ void hmp_migrate_set_parameter(Monitor *mon, const QD=
ict *qdict)
         p->has_decompress_threads =3D true;
         visit_type_int(v, param, &p->decompress_threads, &err);
         break;
+    case MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD:
+        p->has_throttle_trigger_threshold =3D true;
+        visit_type_int(v, param, &p->throttle_trigger_threshold, &err);
     case MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL:
         p->has_cpu_throttle_initial =3D true;
         visit_type_int(v, param, &p->cpu_throttle_initial, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index d44d99cd78..0d1c0712ca 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -540,6 +540,10 @@
 #                      compression, so set the decompress-threads to the n=
umber about 1/4
 #                      of compress-threads is adequate.
 #
+# @throttle-trigger-threshold: The ratio of bytes_dirty_period and bytes_x=
fer_period
+#                              to trigger throttling. It is expressed as p=
ercentage.
+#                              The default value is 50. (Since 5.0)
+#
 # @cpu-throttle-initial: Initial percentage of time guest cpus are throttl=
ed
 #                        when migration auto-converge is activated. The
 #                        default value is 20. (Since 2.7)
@@ -625,7 +629,7 @@
   'data': ['announce-initial', 'announce-max',
            'announce-rounds', 'announce-step',
            'compress-level', 'compress-threads', 'decompress-threads',
-           'compress-wait-thread',
+           'compress-wait-thread', 'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
@@ -660,6 +664,10 @@
 #
 # @decompress-threads: decompression thread count
 #
+# @throttle-trigger-threshold: The ratio of bytes_dirty_period and bytes_x=
fer_period
+#                              to trigger throttling. It is expressed as p=
ercentage.
+#                              The default value is 50. (Since 5.0)
+#
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #                        throttled when migration auto-converge is activat=
ed.
 #                        The default value is 20. (Since 2.7)
@@ -752,6 +760,7 @@
             '*compress-threads': 'int',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'int',
+            '*throttle-trigger-threshold': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
             '*tls-creds': 'StrOrNull',
@@ -813,6 +822,10 @@
 #
 # @decompress-threads: decompression thread count
 #
+# @throttle-trigger-threshold: The ratio of bytes_dirty_period and bytes_x=
fer_period
+#                              to trigger throttling. It is expressed as p=
ercentage.
+#                              The default value is 50. (Since 5.0)
+#
 # @cpu-throttle-initial: Initial percentage of time guest cpus are
 #                        throttled when migration auto-converge is activat=
ed.
 #                        (Since 2.7)
@@ -905,6 +918,7 @@
             '*compress-threads': 'uint8',
             '*compress-wait-thread': 'bool',
             '*decompress-threads': 'uint8',
+            '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*tls-creds': 'str',
--=20
2.24.1



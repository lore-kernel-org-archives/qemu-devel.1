Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BEC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1668207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3agdkXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1668207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk0b-00057D-0D
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvA-00058G-6j
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46468
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjv8-0001pI-KZ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9830tuCVliiKiqClXJIDgdXEVLx8/nO9GCzgD/Dx128=;
 b=Q3agdkXvGY7SlBxl2QOyk3MNXPxEsDrF7GfwV6nAf8wLdq7LDuH1fAygfwkaUNrVRjd343
 Qd9wl4Q+08+D57dW2nAytouP4KnG+qT8ZR7SUhLs76EjKtZfHUagxmQQk6K/Gp8oZqiIVQ
 pf8E5nofbz3hUXSWd4sL8dGjufPT/BQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-9dgjmYf7MI-nTINUxUPUmg-1; Thu, 07 May 2020 13:02:46 -0400
X-MC-Unique: 9dgjmYf7MI-nTINUxUPUmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 540741009613;
 Thu,  7 May 2020 17:02:45 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D00010372CB;
 Thu,  7 May 2020 17:02:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 07/12] migration/throttle: Add cpu-throttle-tailslow migration
 parameter
Date: Thu,  7 May 2020 18:02:06 +0100
Message-Id: <20200507170211.238283-8-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keqian Zhu <zhukeqian1@huawei.com>

At the tail stage of throttling, the Guest is very sensitive to
CPU percentage while the @cpu-throttle-increment is excessive
usually at tail stage.

If this parameter is true, we will compute the ideal CPU percentage
used by the Guest, which may exactly make the dirty rate match the
dirty rate threshold. Then we will choose a smaller throttle increment
between the one specified by @cpu-throttle-increment and the one
generated by ideal CPU percentage.

Therefore, it is compatible to traditional throttling, meanwhile
the throttle increment won't be excessive at tail stage. This may
make migration time longer, and is disabled by default.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Message-Id: <20200413101508.54793-1-zhukeqian1@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 13 ++++++++++++
 migration/ram.c       | 25 +++++++++++++++++-----
 monitor/hmp-cmds.c    |  8 ++++++++
 qapi/migration.json   | 48 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 79f16f6625..f5dbffc442 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -785,6 +785,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->cpu_throttle_initial =3D s->parameters.cpu_throttle_initial;
     params->has_cpu_throttle_increment =3D true;
     params->cpu_throttle_increment =3D s->parameters.cpu_throttle_incremen=
t;
+    params->has_cpu_throttle_tailslow =3D true;
+    params->cpu_throttle_tailslow =3D s->parameters.cpu_throttle_tailslow;
     params->has_tls_creds =3D true;
     params->tls_creds =3D g_strdup(s->parameters.tls_creds);
     params->has_tls_hostname =3D true;
@@ -1327,6 +1329,10 @@ static void migrate_params_test_apply(MigrateSetPara=
meters *params,
         dest->cpu_throttle_increment =3D params->cpu_throttle_increment;
     }
=20
+    if (params->has_cpu_throttle_tailslow) {
+        dest->cpu_throttle_tailslow =3D params->cpu_throttle_tailslow;
+    }
+
     if (params->has_tls_creds) {
         assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
         dest->tls_creds =3D g_strdup(params->tls_creds->u.s);
@@ -1415,6 +1421,10 @@ static void migrate_params_apply(MigrateSetParameter=
s *params, Error **errp)
         s->parameters.cpu_throttle_increment =3D params->cpu_throttle_incr=
ement;
     }
=20
+    if (params->has_cpu_throttle_tailslow) {
+        s->parameters.cpu_throttle_tailslow =3D params->cpu_throttle_tails=
low;
+    }
+
     if (params->has_tls_creds) {
         g_free(s->parameters.tls_creds);
         assert(params->tls_creds->type =3D=3D QTYPE_QSTRING);
@@ -3597,6 +3607,8 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("x-cpu-throttle-increment", MigrationState,
                       parameters.cpu_throttle_increment,
                       DEFAULT_MIGRATE_CPU_THROTTLE_INCREMENT),
+    DEFINE_PROP_BOOL("x-cpu-throttle-tailslow", MigrationState,
+                      parameters.cpu_throttle_tailslow, false),
     DEFINE_PROP_SIZE("x-max-bandwidth", MigrationState,
                       parameters.max_bandwidth, MAX_THROTTLE),
     DEFINE_PROP_UINT64("x-downtime-limit", MigrationState,
@@ -3703,6 +3715,7 @@ static void migration_instance_init(Object *obj)
     params->has_throttle_trigger_threshold =3D true;
     params->has_cpu_throttle_initial =3D true;
     params->has_cpu_throttle_increment =3D true;
+    params->has_cpu_throttle_tailslow =3D true;
     params->has_max_bandwidth =3D true;
     params->has_downtime_limit =3D true;
     params->has_x_checkpoint_delay =3D true;
diff --git a/migration/ram.c b/migration/ram.c
index 53166fc279..52fc032b83 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -616,20 +616,34 @@ static size_t save_page_header(RAMState *rs, QEMUFile=
 *f,  RAMBlock *block,
  * able to complete migration. Some workloads dirty memory way too
  * fast and will not effectively converge, even with auto-converge.
  */
-static void mig_throttle_guest_down(void)
+static void mig_throttle_guest_down(uint64_t bytes_dirty_period,
+                                    uint64_t bytes_dirty_threshold)
 {
     MigrationState *s =3D migrate_get_current();
     uint64_t pct_initial =3D s->parameters.cpu_throttle_initial;
-    uint64_t pct_icrement =3D s->parameters.cpu_throttle_increment;
+    uint64_t pct_increment =3D s->parameters.cpu_throttle_increment;
+    bool pct_tailslow =3D s->parameters.cpu_throttle_tailslow;
     int pct_max =3D s->parameters.max_cpu_throttle;
=20
+    uint64_t throttle_now =3D cpu_throttle_get_percentage();
+    uint64_t cpu_now, cpu_ideal, throttle_inc;
+
     /* We have not started throttling yet. Let's start it. */
     if (!cpu_throttle_active()) {
         cpu_throttle_set(pct_initial);
     } else {
         /* Throttling already on, just increase the rate */
-        cpu_throttle_set(MIN(cpu_throttle_get_percentage() + pct_icrement,
-                         pct_max));
+        if (!pct_tailslow) {
+            throttle_inc =3D pct_increment;
+        } else {
+            /* Compute the ideal CPU percentage used by Guest, which may
+             * make the dirty rate match the dirty rate threshold. */
+            cpu_now =3D 100 - throttle_now;
+            cpu_ideal =3D cpu_now * (bytes_dirty_threshold * 1.0 /
+                        bytes_dirty_period);
+            throttle_inc =3D MIN(cpu_now - cpu_ideal, pct_increment);
+        }
+        cpu_throttle_set(MIN(throttle_now + throttle_inc, pct_max));
     }
 }
=20
@@ -919,7 +933,8 @@ static void migration_trigger_throttle(RAMState *rs)
             (++rs->dirty_rate_high_cnt >=3D 2)) {
             trace_migration_throttle();
             rs->dirty_rate_high_cnt =3D 0;
-            mig_throttle_guest_down();
+            mig_throttle_guest_down(bytes_dirty_period,
+                                    bytes_dirty_threshold);
         }
     }
 }
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 1552dee489..ade1f85e0c 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -420,6 +420,10 @@ void hmp_info_migrate_parameters(Monitor *mon, const Q=
Dict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_INCREM=
ENT),
             params->cpu_throttle_increment);
+        assert(params->has_cpu_throttle_tailslow);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_CPU_THROTTLE_TAILSL=
OW),
+            params->cpu_throttle_tailslow ? "on" : "off");
         assert(params->has_max_cpu_throttle);
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
@@ -1275,6 +1279,10 @@ void hmp_migrate_set_parameter(Monitor *mon, const Q=
Dict *qdict)
         p->has_cpu_throttle_increment =3D true;
         visit_type_int(v, param, &p->cpu_throttle_increment, &err);
         break;
+    case MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW:
+        p->has_cpu_throttle_tailslow =3D true;
+        visit_type_bool(v, param, &p->cpu_throttle_tailslow, &err);
+        break;
     case MIGRATION_PARAMETER_MAX_CPU_THROTTLE:
         p->has_max_cpu_throttle =3D true;
         visit_type_int(v, param, &p->max_cpu_throttle, &err);
diff --git a/qapi/migration.json b/qapi/migration.json
index eca2981d0a..ee6c5a0cae 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -552,6 +552,21 @@
 #                          auto-converge detects that migration is not mak=
ing
 #                          progress. The default value is 10. (Since 2.7)
 #
+# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
+#                         At the tail stage of throttling, the Guest is ve=
ry
+#                         sensitive to CPU percentage while the @cpu-throt=
tle
+#                         -increment is excessive usually at tail stage.
+#                         If this parameter is true, we will compute the i=
deal
+#                         CPU percentage used by the Guest, which may exac=
tly make
+#                         the dirty rate match the dirty rate threshold. T=
hen we
+#                         will choose a smaller throttle increment between=
 the
+#                         one specified by @cpu-throttle-increment and the=
 one
+#                         generated by ideal CPU percentage.
+#                         Therefore, it is compatible to traditional throt=
tling,
+#                         meanwhile the throttle increment won't be excess=
ive
+#                         at tail stage.
+#                         The default value is false. (Since 5.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials for
 #             establishing a TLS connection over the migration data channe=
l.
 #             On the outgoing side of the migration, the credentials must
@@ -631,6 +646,7 @@
            'compress-level', 'compress-threads', 'decompress-threads',
            'compress-wait-thread', 'throttle-trigger-threshold',
            'cpu-throttle-initial', 'cpu-throttle-increment',
+           'cpu-throttle-tailslow',
            'tls-creds', 'tls-hostname', 'tls-authz', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay', 'block-incremental',
            'multifd-channels',
@@ -676,6 +692,21 @@
 #                          auto-converge detects that migration is not mak=
ing
 #                          progress. The default value is 10. (Since 2.7)
 #
+# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
+#                         At the tail stage of throttling, the Guest is ve=
ry
+#                         sensitive to CPU percentage while the @cpu-throt=
tle
+#                         -increment is excessive usually at tail stage.
+#                         If this parameter is true, we will compute the i=
deal
+#                         CPU percentage used by the Guest, which may exac=
tly make
+#                         the dirty rate match the dirty rate threshold. T=
hen we
+#                         will choose a smaller throttle increment between=
 the
+#                         one specified by @cpu-throttle-increment and the=
 one
+#                         generated by ideal CPU percentage.
+#                         Therefore, it is compatible to traditional throt=
tling,
+#                         meanwhile the throttle increment won't be excess=
ive
+#                         at tail stage.
+#                         The default value is false. (Since 5.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #             for establishing a TLS connection over the migration data
 #             channel. On the outgoing side of the migration, the credenti=
als
@@ -763,6 +794,7 @@
             '*throttle-trigger-threshold': 'int',
             '*cpu-throttle-initial': 'int',
             '*cpu-throttle-increment': 'int',
+            '*cpu-throttle-tailslow': 'bool',
             '*tls-creds': 'StrOrNull',
             '*tls-hostname': 'StrOrNull',
             '*tls-authz': 'StrOrNull',
@@ -834,6 +866,21 @@
 #                          auto-converge detects that migration is not mak=
ing
 #                          progress. (Since 2.7)
 #
+# @cpu-throttle-tailslow: Make CPU throttling slower at tail stage
+#                         At the tail stage of throttling, the Guest is ve=
ry
+#                         sensitive to CPU percentage while the @cpu-throt=
tle
+#                         -increment is excessive usually at tail stage.
+#                         If this parameter is true, we will compute the i=
deal
+#                         CPU percentage used by the Guest, which may exac=
tly make
+#                         the dirty rate match the dirty rate threshold. T=
hen we
+#                         will choose a smaller throttle increment between=
 the
+#                         one specified by @cpu-throttle-increment and the=
 one
+#                         generated by ideal CPU percentage.
+#                         Therefore, it is compatible to traditional throt=
tling,
+#                         meanwhile the throttle increment won't be excess=
ive
+#                         at tail stage.
+#                         The default value is false. (Since 5.1)
+#
 # @tls-creds: ID of the 'tls-creds' object that provides credentials
 #             for establishing a TLS connection over the migration data
 #             channel. On the outgoing side of the migration, the credenti=
als
@@ -921,6 +968,7 @@
             '*throttle-trigger-threshold': 'uint8',
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
+            '*cpu-throttle-tailslow': 'bool',
             '*tls-creds': 'str',
             '*tls-hostname': 'str',
             '*tls-authz': 'str',
--=20
2.26.2



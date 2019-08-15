Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B3C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DEE0206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEE0206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJ5y-000518-L8
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjw-0002z2-4w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjs-0003Oj-4U
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjr-0003NN-TP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31F0F3001D30;
 Thu, 15 Aug 2019 16:36:35 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC9A6BAAC;
 Thu, 15 Aug 2019 16:36:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:55 +0100
Message-Id: <20190815163504.18937-25-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 15 Aug 2019 16:36:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 24/33] migration: always initialise ram_counters
 for a new migration
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

This patch fix a multifd migration bug in migration speed calculation, th=
is
problem can be reproduced as follows:
1. start a vm and give a heavy memory write stress to prevent the vm be
   successfully migrated to destination
2. begin a migration with multifd
3. migrate for a long time [actually, this can be measured by transferred=
 bytes]
4. migrate cancel
5. begin a new migration with multifd, the migration will directly run in=
to
   migration_completion phase

Reason as follows:

Migration update bandwidth and s->threshold_size in function
migration_update_counters after BUFFER_DELAY time:

    current_bytes =3D migration_total_bytes(s);
    transferred =3D current_bytes - s->iteration_initial_bytes;
    time_spent =3D current_time - s->iteration_start_time;
    bandwidth =3D (double)transferred / time_spent;
    s->threshold_size =3D bandwidth * s->parameters.downtime_limit;

In multifd migration, migration_total_bytes function return
qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
s->iteration_initial_bytes will be initialized to 0 at every new migratio=
n,
but ram_counters is a global variable, and history migration data will be
accumulated. So if the ram_counters.multifd_bytes is big enough, it may l=
ead
pending_size >=3D s->threshold_size become false in migration_iteration_r=
un
after the first migration_update_counters.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 25 +++++++++++++++++++------
 migration/savevm.c    |  1 +
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 12b8e5dbe5..c49e9dc035 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1911,6 +1911,11 @@ static bool migrate_prepare(MigrationState *s, boo=
l blk, bool blk_inc,
     }
=20
     migrate_init(s);
+    /*
+     * set ram_counters memory to zero for a
+     * new migration
+     */
+    memset(&ram_counters, 0, sizeof(ram_counters));
=20
     return true;
 }
@@ -3034,6 +3039,17 @@ static void migration_calculate_complete(Migration=
State *s)
     }
 }
=20
+static void update_iteration_initial_status(MigrationState *s)
+{
+    /*
+     * Update these three fields at the same time to avoid mismatch info=
 lead
+     * wrong speed calculation.
+     */
+    s->iteration_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    s->iteration_initial_bytes =3D migration_total_bytes(s);
+    s->iteration_initial_pages =3D ram_get_total_transferred_pages();
+}
+
 static void migration_update_counters(MigrationState *s,
                                       int64_t current_time)
 {
@@ -3069,9 +3085,7 @@ static void migration_update_counters(MigrationStat=
e *s,
=20
     qemu_file_reset_rate_limit(s->to_dst_file);
=20
-    s->iteration_start_time =3D current_time;
-    s->iteration_initial_bytes =3D current_bytes;
-    s->iteration_initial_pages =3D ram_get_total_transferred_pages();
+    update_iteration_initial_status(s);
=20
     trace_migrate_transferred(transferred, time_spent,
                               bandwidth, s->threshold_size);
@@ -3194,7 +3208,7 @@ static void *migration_thread(void *opaque)
     rcu_register_thread();
=20
     object_ref(OBJECT(s));
-    s->iteration_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    update_iteration_initial_status(s);
=20
     qemu_savevm_state_header(s->to_dst_file);
=20
@@ -3259,8 +3273,7 @@ static void *migration_thread(void *opaque)
              * the local variables. This is important to avoid
              * breaking transferred_bytes and bandwidth calculation
              */
-            s->iteration_start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REA=
LTIME);
-            s->iteration_initial_bytes =3D 0;
+            update_iteration_initial_status(s);
         }
=20
         current_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
diff --git a/migration/savevm.c b/migration/savevm.c
index 412768216c..1ac15301ad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1456,6 +1456,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **e=
rrp)
     }
=20
     migrate_init(ms);
+    memset(&ram_counters, 0, sizeof(ram_counters));
     ms->to_dst_file =3D f;
=20
     qemu_mutex_unlock_iothread();
--=20
2.21.0



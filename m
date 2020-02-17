Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFFC76199
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A1420857
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A1420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3V88-0004pB-WF
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 20:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j3V6M-0001t2-69
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1j3V6K-0006T4-MF
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:33 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2784 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1j3V6K-0006GT-4H
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:21:32 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B752BA4F68B8FC3D09C2;
 Mon, 17 Feb 2020 09:21:24 +0800 (CST)
Received: from huawei.com (10.133.214.142) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Feb 2020
 09:21:18 +0800
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/3] COLO: Migrate dirty pages during the gap of checkpointing
Date: Mon, 17 Feb 2020 09:20:48 +0800
Message-ID: <20200217012049.22988-3-zhang.zhanghailiang@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
References: <20200217012049.22988-1-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.214.142]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: danielcho@qnap.com, chen.zhang@intel.com,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can migrate some dirty pages during the gap of checkpointing,
by this way, we can reduce the amount of ram migrated during checkpointin=
g.

Signed-off-by: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
---
 migration/colo.c       | 69 +++++++++++++++++++++++++++++++++++++++---
 migration/migration.h  |  1 +
 migration/trace-events |  1 +
 qapi/migration.json    |  4 ++-
 4 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 93c5a452fb..d30c6bc4ad 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -46,6 +46,13 @@ static COLOMode last_colo_mode;
=20
 #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
=20
+#define DEFAULT_RAM_PENDING_CHECK 1000
+
+/* should be calculated by bandwidth and max downtime ? */
+#define THRESHOLD_PENDING_SIZE (100 * 1024 * 1024UL)
+
+static int checkpoint_request;
+
 bool migration_in_colo_state(void)
 {
     MigrationState *s =3D migrate_get_current();
@@ -516,6 +523,20 @@ static void colo_compare_notify_checkpoint(Notifier =
*notifier, void *data)
     colo_checkpoint_notify(data);
 }
=20
+static bool colo_need_migrate_ram_background(MigrationState *s)
+{
+    uint64_t pending_size, pend_pre, pend_compat, pend_post;
+    int64_t max_size =3D THRESHOLD_PENDING_SIZE;
+
+    qemu_savevm_state_pending(s->to_dst_file, max_size, &pend_pre,
+                              &pend_compat, &pend_post);
+    pending_size =3D pend_pre + pend_compat + pend_post;
+
+    trace_colo_need_migrate_ram_background(pending_size);
+    return (pending_size >=3D max_size);
+}
+
+
 static void colo_process_checkpoint(MigrationState *s)
 {
     QIOChannelBuffer *bioc;
@@ -571,6 +592,8 @@ static void colo_process_checkpoint(MigrationState *s=
)
=20
     timer_mod(s->colo_delay_timer,
             current_time + s->parameters.x_checkpoint_delay);
+    timer_mod(s->pending_ram_check_timer,
+        current_time + DEFAULT_RAM_PENDING_CHECK);
=20
     while (s->state =3D=3D MIGRATION_STATUS_COLO) {
         if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
@@ -583,10 +606,25 @@ static void colo_process_checkpoint(MigrationState =
*s)
         if (s->state !=3D MIGRATION_STATUS_COLO) {
             goto out;
         }
-        ret =3D colo_do_checkpoint_transaction(s, bioc, fb);
-        if (ret < 0) {
-            goto out;
-        }
+        if (atomic_xchg(&checkpoint_request, 0)) {
+            /* start a colo checkpoint */
+            ret =3D colo_do_checkpoint_transaction(s, bioc, fb);
+            if (ret < 0) {
+                goto out;
+            }
+        } else {
+            if (colo_need_migrate_ram_background(s)) {
+                colo_send_message(s->to_dst_file,
+                                  COLO_MESSAGE_MIGRATE_RAM_BACKGROUND,
+                                  &local_err);
+                if (local_err) {
+                    goto out;
+                }
+
+                qemu_savevm_state_iterate(s->to_dst_file, false);
+                qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
+            }
+         }
     }
=20
 out:
@@ -626,6 +664,8 @@ out:
     colo_compare_unregister_notifier(&packets_compare_notifier);
     timer_del(s->colo_delay_timer);
     timer_free(s->colo_delay_timer);
+    timer_del(s->pending_ram_check_timer);
+    timer_free(s->pending_ram_check_timer);
     qemu_sem_destroy(&s->colo_checkpoint_sem);
=20
     /*
@@ -643,6 +683,7 @@ void colo_checkpoint_notify(void *opaque)
     MigrationState *s =3D opaque;
     int64_t next_notify_time;
=20
+    atomic_inc(&checkpoint_request);
     qemu_sem_post(&s->colo_checkpoint_sem);
     s->colo_checkpoint_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
     next_notify_time =3D s->colo_checkpoint_time +
@@ -650,6 +691,19 @@ void colo_checkpoint_notify(void *opaque)
     timer_mod(s->colo_delay_timer, next_notify_time);
 }
=20
+static void colo_pending_ram_check_notify(void *opaque)
+{
+    int64_t next_notify_time;
+    MigrationState *s =3D opaque;
+
+    if (migration_in_colo_state()) {
+        next_notify_time =3D DEFAULT_RAM_PENDING_CHECK +
+                           qemu_clock_get_ms(QEMU_CLOCK_HOST);
+        timer_mod(s->pending_ram_check_timer, next_notify_time);
+        qemu_sem_post(&s->colo_checkpoint_sem);
+    }
+}
+
 void migrate_start_colo_process(MigrationState *s)
 {
     qemu_mutex_unlock_iothread();
@@ -657,6 +711,8 @@ void migrate_start_colo_process(MigrationState *s)
     s->colo_delay_timer =3D  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify, s);
=20
+    s->pending_ram_check_timer =3D timer_new_ms(QEMU_CLOCK_HOST,
+                                colo_pending_ram_check_notify, s);
     qemu_sem_init(&s->colo_exit_sem, 0);
     migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
@@ -805,6 +861,11 @@ static void colo_wait_handle_message(MigrationIncomi=
ngState *mis,
     case COLO_MESSAGE_CHECKPOINT_REQUEST:
         colo_incoming_process_checkpoint(mis, fb, bioc, errp);
         break;
+    case COLO_MESSAGE_MIGRATE_RAM_BACKGROUND:
+        if (qemu_loadvm_state_main(mis->from_src_file, mis) < 0) {
+            error_setg(errp, "Load ram background failed");
+        }
+        break;
     default:
         error_setg(errp, "Got unknown COLO message: %d", msg);
         break;
diff --git a/migration/migration.h b/migration/migration.h
index 8473ddfc88..5355259789 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -219,6 +219,7 @@ struct MigrationState
     QemuSemaphore colo_checkpoint_sem;
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;
+    QEMUTimer *pending_ram_check_timer;
=20
     /* The first error that has occurred.
        We used the mutex to be able to return the 1st error message */
diff --git a/migration/trace-events b/migration/trace-events
index 4ab0a503d2..f2ed0c8645 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -295,6 +295,7 @@ migration_tls_incoming_handshake_complete(void) ""
 colo_vm_state_change(const char *old, const char *new) "Change '%s' =3D>=
 '%s'"
 colo_send_message(const char *msg) "Send '%s' message"
 colo_receive_message(const char *msg) "Receive '%s' message"
+colo_need_migrate_ram_background(uint64_t pending_size) "Pending 0x%" PR=
Ix64 " dirty ram"
=20
 # colo-failover.c
 colo_failover_set_state(const char *new_state) "new state %s"
diff --git a/qapi/migration.json b/qapi/migration.json
index b7348d0c8b..ff7a4f18b0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -977,12 +977,14 @@
 #
 # @vmstate-loaded: VM's state has been loaded by SVM.
 #
+# @migrate-ram-background: Send some dirty pages during the gap of COLO =
checkpoint
+#
 # Since: 2.8
 ##
 { 'enum': 'COLOMessage',
   'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply'=
,
             'vmstate-send', 'vmstate-size', 'vmstate-received',
-            'vmstate-loaded' ] }
+            'vmstate-loaded', 'migrate-ram-background' ] }
=20
 ##
 # @COLOMode:
--=20
2.21.0




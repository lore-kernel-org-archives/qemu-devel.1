Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E2BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A45206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sdcnpge4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A45206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpSH-0000cw-9m
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMW-0007dm-1b
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49995
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMU-0000SO-OV
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i9cOhqO1L7Jwh3K0v3hi//aoSYGetnouMO5vLcBIC+k=;
 b=Sdcnpge4lYZ7bQoQBId3CvhQNHQm/nR25tiwpLltxp6pVfbGbLfyZ0iZzsJl0GLD4sj6xC
 QvFqrbapIHGFk4LpXxo9b3iGY068Gj1sYnqzFkFPc/19lTqWsMx6Tb4lHegthovC8ddRGC
 XRTYIO4qVCXBsd7C+pj4aAlOwWY2rY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-QsTvdVf_PG6vkxq60n3NmQ-1; Mon, 01 Jun 2020 14:40:26 -0400
X-MC-Unique: QsTvdVf_PG6vkxq60n3NmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A29908018A5;
 Mon,  1 Jun 2020 18:40:25 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 257F910016DA;
 Mon,  1 Jun 2020 18:40:23 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] migration/colo.c: Use event instead of semaphore
Date: Mon,  1 Jun 2020 19:39:59 +0100
Message-Id: <20200601184004.272784-8-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 11:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

If multiple packets miscompare in a short timeframe, the semaphore
value will be increased multiple times. This causes multiple
checkpoints even if one would be sufficient.

Fix this by using a event instead of a semaphore for triggering
checkpoints. Now, checkpoint requests will be ignored until the
checkpoint event is sent to colo-compare (which releases the
miscompared packets).

Benchmark results (iperf3):
Client-to-server tcp:
without patch: ~66 Mbit/s
with patch: ~61 Mbit/s
Server-to-client tcp:
without patch: ~702 Kbit/s
with patch: ~16 Mbit/s

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Message-Id: <fd601ba1beb524aada54ba66e87ebfc12cf4574b.1589193382.git.lukasstraub2@web.de>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c      | 9 +++++----
 migration/migration.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index d015d4f84e..fe0d6e93e5 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -436,6 +436,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         goto out;
     }
 
+    qemu_event_reset(&s->colo_checkpoint_event);
     colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT, &local_err);
     if (local_err) {
         goto out;
@@ -589,7 +590,7 @@ static void colo_process_checkpoint(MigrationState *s)
             goto out;
         }
 
-        qemu_sem_wait(&s->colo_checkpoint_sem);
+        qemu_event_wait(&s->colo_checkpoint_event);
 
         if (s->state != MIGRATION_STATUS_COLO) {
             goto out;
@@ -637,7 +638,7 @@ out:
     colo_compare_unregister_notifier(&packets_compare_notifier);
     timer_del(s->colo_delay_timer);
     timer_free(s->colo_delay_timer);
-    qemu_sem_destroy(&s->colo_checkpoint_sem);
+    qemu_event_destroy(&s->colo_checkpoint_event);
 
     /*
      * Must be called after failover BH is completed,
@@ -654,7 +655,7 @@ void colo_checkpoint_notify(void *opaque)
     MigrationState *s = opaque;
     int64_t next_notify_time;
 
-    qemu_sem_post(&s->colo_checkpoint_sem);
+    qemu_event_set(&s->colo_checkpoint_event);
     s->colo_checkpoint_time = qemu_clock_get_ms(QEMU_CLOCK_HOST);
     next_notify_time = s->colo_checkpoint_time +
                     s->parameters.x_checkpoint_delay;
@@ -664,7 +665,7 @@ void colo_checkpoint_notify(void *opaque)
 void migrate_start_colo_process(MigrationState *s)
 {
     qemu_mutex_unlock_iothread();
-    qemu_sem_init(&s->colo_checkpoint_sem, 0);
+    qemu_event_init(&s->colo_checkpoint_event, false);
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify, s);
 
diff --git a/migration/migration.h b/migration/migration.h
index 507284e563..f617960522 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -215,8 +215,8 @@ struct MigrationState
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
 
-    /* The semaphore is used to notify COLO thread to do checkpoint */
-    QemuSemaphore colo_checkpoint_sem;
+    /* The event is used to notify COLO thread to do checkpoint */
+    QemuEvent colo_checkpoint_event;
     int64_t colo_checkpoint_time;
     QEMUTimer *colo_delay_timer;
 
-- 
2.26.2



Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URG_BIZ
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6178C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801972464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 10:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKcn8MWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801972464F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icoPX-0007bT-LL
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 05:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1icoO4-0006P5-AV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1icoO2-0003sZ-8A
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:29:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1icoO1-0003nK-RY
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 05:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575541768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xu96EPFWmoZtJV6V8jS6USJTzrv8xoCmUuAVZ8HnkPw=;
 b=EKcn8MWj+sTnYRwlcuvicp0ynwOKXy9cP3caHGHucr9TnTz1/0NzpM6O47X9VicI+H4woM
 hF/jkyKPCmO3FHiWJpthcUf+9xOgxGQsx5DU7z3/yC1uIhNw6mRWK0ugIiNEJA5TlA+PaP
 FtF7fBMtF5nyCQO38nbjlsok6YHA2KY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-TaxYBOdxOXeAZQJ0ieEpoA-1; Thu, 05 Dec 2019 05:29:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CE00180369F;
 Thu,  5 Dec 2019 10:29:24 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF5B210013A1;
 Thu,  5 Dec 2019 10:29:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, LMa@suse.com, quintela@redhat.com, peterx@redhat.com
Subject: [PATCH] migration: Rate limit inside host pages
Date: Thu,  5 Dec 2019 10:29:18 +0000
Message-Id: <20191205102918.63294-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TaxYBOdxOXeAZQJ0ieEpoA-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When using hugepages, rate limiting is necessary within each huge
page, since a 1G huge page can take a significant time to send, so
you end up with bursty behaviour.

Fixes: 4c011c37ecb3 ("postcopy: Send whole huge pages")
Reported-by: Lin Ma <LMa@suse.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c  | 57 ++++++++++++++++++++++++------------------
 migration/migration.h  |  1 +
 migration/ram.c        |  2 ++
 migration/trace-events |  4 +--
 4 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..27500d09a9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3224,6 +3224,37 @@ void migration_consume_urgent_request(void)
     qemu_sem_wait(&migrate_get_current()->rate_limit_sem);
 }
=20
+/* Returns true if the rate limiting was broken by an urgent request */
+bool migration_rate_limit(void)
+{
+    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    MigrationState *s =3D migrate_get_current();
+
+    bool urgent =3D false;
+    migration_update_counters(s, now);
+    if (qemu_file_rate_limit(s->to_dst_file)) {
+        /*
+         * Wait for a delay to do rate limiting OR
+         * something urgent to post the semaphore.
+         */
+        int ms =3D s->iteration_start_time + BUFFER_DELAY - now;
+        trace_migration_rate_limit_pre(ms);
+        if (qemu_sem_timedwait(&s->rate_limit_sem, ms) =3D=3D 0) {
+            /*
+             * We were woken by one or more urgent things but
+             * the timedwait will have consumed one of them.
+             * The service routine for the urgent wake will dec
+             * the semaphore itself for each item it consumes,
+             * so add this one we just eat back.
+             */
+            qemu_sem_post(&s->rate_limit_sem);
+            urgent =3D true;
+        }
+        trace_migration_rate_limit_post(urgent);
+    }
+    return urgent;
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -3290,8 +3321,6 @@ static void *migration_thread(void *opaque)
     trace_migration_thread_setup_complete();
=20
     while (migration_is_active(s)) {
-        int64_t current_time;
-
         if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
             MigIterateState iter_state =3D migration_iteration_run(s);
             if (iter_state =3D=3D MIG_ITERATE_SKIP) {
@@ -3318,29 +3347,7 @@ static void *migration_thread(void *opaque)
             update_iteration_initial_status(s);
         }
=20
-        current_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-
-        migration_update_counters(s, current_time);
-
-        urgent =3D false;
-        if (qemu_file_rate_limit(s->to_dst_file)) {
-            /* Wait for a delay to do rate limiting OR
-             * something urgent to post the semaphore.
-             */
-            int ms =3D s->iteration_start_time + BUFFER_DELAY - current_ti=
me;
-            trace_migration_thread_ratelimit_pre(ms);
-            if (qemu_sem_timedwait(&s->rate_limit_sem, ms) =3D=3D 0) {
-                /* We were worken by one or more urgent things but
-                 * the timedwait will have consumed one of them.
-                 * The service routine for the urgent wake will dec
-                 * the semaphore itself for each item it consumes,
-                 * so add this one we just eat back.
-                 */
-                qemu_sem_post(&s->rate_limit_sem);
-                urgent =3D true;
-            }
-            trace_migration_thread_ratelimit_post(urgent);
-        }
+        urgent =3D migration_rate_limit();
     }
=20
     trace_migration_thread_after_loop();
diff --git a/migration/migration.h b/migration/migration.h
index 79b3dda146..aa9ff6f27b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -341,5 +341,6 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, vo=
id *opaque);
=20
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
+bool migration_rate_limit(void);
=20
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index a4ae3b3120..a9177c6a24 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2616,6 +2616,8 @@ static int ram_save_host_page(RAMState *rs, PageSearc=
hStatus *pss,
=20
         pages +=3D tmppages;
         pss->page++;
+        /* Allow rate limiting to happen in the middle of huge pages */
+        migration_rate_limit();
     } while ((pss->page & (pagesize_bits - 1)) &&
              offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BITS)=
);
=20
diff --git a/migration/trace-events b/migration/trace-events
index 6dee7b5389..2f9129e213 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -138,12 +138,12 @@ migrate_send_rp_recv_bitmap(char *name, int64_t size)=
 "block '%s' size 0x%"PRIi6
 migration_completion_file_err(void) ""
 migration_completion_postcopy_end(void) ""
 migration_completion_postcopy_end_after_complete(void) ""
+migration_rate_limit_pre(int ms) "%d ms"
+migration_rate_limit_post(int urgent) "urgent: %d"
 migration_return_path_end_before(void) ""
 migration_return_path_end_after(int rp_error) "%d"
 migration_thread_after_loop(void) ""
 migration_thread_file_err(void) ""
-migration_thread_ratelimit_pre(int ms) "%d ms"
-migration_thread_ratelimit_post(int urgent) "urgent: %d"
 migration_thread_setup_complete(void) ""
 open_return_path_on_source(void) ""
 open_return_path_on_source_continue(void) ""
--=20
2.23.0



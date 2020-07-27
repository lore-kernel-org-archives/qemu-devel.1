Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE145C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58EA2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT8E3EYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58EA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0AJK-0002t8-Tg
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAk-0005jG-Af
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58505
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAi-00050P-3Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHc0nQj+QkzuTabuTPWO7D1hcUTptMOxXx4vvq4SA+E=;
 b=OT8E3EYTTwrNRRSrKHUT9iISiuDEFivugy7VLXUgbENwFF300c4mO3gJfrGK6+U83HQ9pH
 ZtdPSCYDRyTENKWIa5YCzw/eke7pEx+pEVsfRTqy8zmZ7jg1lNDE3z4wocRlN7hOg06w0c
 8PnMDrnDC2qJhlm5cDM/XAXOFP25n1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-FEK2kFEsMJ6pBu0VvjupSg-1; Mon, 27 Jul 2020 16:56:27 -0400
X-MC-Unique: FEK2kFEsMJ6pBu0VvjupSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B42101C8A5;
 Mon, 27 Jul 2020 20:56:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6865119C66;
 Mon, 27 Jul 2020 20:56:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/24] migration/savevm: don't worry if bitmap migration
 postcopy failed
Date: Mon, 27 Jul 2020 15:55:37 -0500
Message-Id: <20200727205543.206624-19-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

First, if only bitmaps postcopy is enabled (and not ram postcopy)
postcopy_pause_incoming crashes on an assertion
assert(mis->to_src_file).

And anyway, bitmaps postcopy is not prepared to be somehow recovered.
The original idea instead is that if bitmaps postcopy failed, we just
lose some bitmaps, which is not critical. So, on failure we just need
to remove unfinished bitmaps and guest should continue execution on
destination.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727194236.19551-18-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/savevm.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 45c9dd9d8a6d..a843d202b5b4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1813,6 +1813,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     QEMUFile *f = mis->from_src_file;
     int load_res;
+    MigrationState *migr = migrate_get_current();
+
+    object_ref(OBJECT(migr));

     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
@@ -1839,11 +1842,24 @@ static void *postcopy_ram_listen_thread(void *opaque)

     trace_postcopy_ram_listen_thread_exit();
     if (load_res < 0) {
-        error_report("%s: loadvm failed: %d", __func__, load_res);
         qemu_file_set_error(f, load_res);
-        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                                       MIGRATION_STATUS_FAILED);
-    } else {
+        dirty_bitmap_mig_cancel_incoming();
+        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
+            !migrate_postcopy_ram() && migrate_dirty_bitmaps())
+        {
+            error_report("%s: loadvm failed during postcopy: %d. All states "
+                         "are migrated except dirty bitmaps. Some dirty "
+                         "bitmaps may be lost, and present migrated dirty "
+                         "bitmaps are correctly migrated and valid.",
+                         __func__, load_res);
+            load_res = 0; /* prevent further exit() */
+        } else {
+            error_report("%s: loadvm failed: %d", __func__, load_res);
+            migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
+                                           MIGRATION_STATUS_FAILED);
+        }
+    }
+    if (load_res >= 0) {
         /*
          * This looks good, but it's possible that the device loading in the
          * main thread hasn't finished yet, and so we might not be in 'RUN'
@@ -1879,6 +1895,8 @@ static void *postcopy_ram_listen_thread(void *opaque)
     mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);

+    object_unref(OBJECT(migr));
+
     return NULL;
 }

@@ -2437,6 +2455,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
 {
     trace_postcopy_pause_incoming();

+    assert(migrate_postcopy_ram());
+
     /* Clear the triggered bit to allow one recovery */
     mis->postcopy_recover_triggered = false;

@@ -2521,15 +2541,22 @@ out:
     if (ret < 0) {
         qemu_file_set_error(f, ret);

+        /* Cancel bitmaps incoming regardless of recovery */
+        dirty_bitmap_mig_cancel_incoming();
+
         /*
          * If we are during an active postcopy, then we pause instead
          * of bail out to at least keep the VM's dirty data.  Note
          * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
          * during which we're still receiving device states and we
          * still haven't yet started the VM on destination.
+         *
+         * Only RAM postcopy supports recovery. Still, if RAM postcopy is
+         * enabled, canceled bitmaps postcopy will not affect RAM postcopy
+         * recovering.
          */
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
-            postcopy_pause_incoming(mis)) {
+            migrate_postcopy_ram() && postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
             goto retry;
-- 
2.27.0



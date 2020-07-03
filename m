Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797DA207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsMbGbGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797DA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHfq-0006l0-NY
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHc5-000749-8F
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHc3-0004Ph-2I
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zm5yAzYb8Njf/7lXhPa4kHkewLVdbaNS9bfJJo2eVkw=;
 b=ZsMbGbGuosJhVGKiw/iDfuj9I/cjjtDa2u6Dif/mFbs+DQ2cHVjMaWM+BgEzPt6iAkXqWF
 taM6AdwxlfKUAebpIWyd4jlw5CeUZu3+7ymFmQmzWrfbPVdH/uElqaB56WH7W91WgetzuP
 ORE+LlMWQMwZc1spQvvT82HMdVrbWJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-eaEJnR4-PnSq0ljaVH2Ktg-1; Fri, 03 Jul 2020 05:03:58 -0400
X-MC-Unique: eaEJnR4-PnSq0ljaVH2Ktg-1
Received: by mail-wm1-f70.google.com with SMTP id v6so32315472wmg.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zm5yAzYb8Njf/7lXhPa4kHkewLVdbaNS9bfJJo2eVkw=;
 b=mlWd0iQhtciEnevtnYh1RCaUf+j0gaIe77G2HEGlSielCY5yLg9rMwuZqKQA/KL97T
 r+U2WKMVMFjSmt+tOENk7GbTasfrzwNxyS4iP5DCXSRYwIQJmQHz1+fu6nvj4bc2zTcf
 3a1cnaq2H+iWetFrxuscbISnqsOduOlOHV6MIG2ujPd6KnkHa54Ne8SzQJM25dmxdWFH
 SaRy2PXI0ZIYTtStcCjVpV/XT2VY1g/Qx6EAT1P/i1nJfXhf+RKmxOVhZNUAjp30mFNY
 M8rxIGsYctt15FcnWczM2rUMn3hHQ3o5qtY1xkc3Yyrbo76qneTSTOjLuz5VEdKsUk/r
 W90A==
X-Gm-Message-State: AOAM531YVu6audk4zeOYnp6RG37RxHy1t6fBaJ/GXp9DrwuVM7uCZWmw
 qbFcfOKPphFtkqNXc/vPIl67GH38p8Z7EVznjW1mVXB7FTtSH4fjDU1b0/lAXJ2yIi4TNwkPOdA
 ImzqEOGADDgTv7YQ=
X-Received: by 2002:adf:b312:: with SMTP id j18mr33621334wrd.195.1593767036776; 
 Fri, 03 Jul 2020 02:03:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoc2SLnAmxavs/V1L0Gt/mcTc8+oh7NxCl3MFrxWyaXbsKflvPf2rchkFGYn254VUSAmPXUQ==
X-Received: by 2002:adf:b312:: with SMTP id j18mr33621309wrd.195.1593767036481; 
 Fri, 03 Jul 2020 02:03:56 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r3sm15071975wrg.70.2020.07.03.02.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:55 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/41] virtio-balloon: Rip out qemu_balloon_inhibit()
Message-ID: <20200703090252.368694-10-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

The only remaining special case is postcopy. It cannot handle
concurrent discards yet, which would result in requesting already sent
pages from the source. Special-case it in virtio-balloon instead.

Introduce migration_in_incoming_postcopy(), to find out if incoming
postcopy is active.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-7-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/misc.h   |  2 ++
 include/sysemu/balloon.h   |  2 --
 balloon.c                  | 18 ------------------
 hw/virtio/virtio-balloon.c | 10 ++++++++--
 migration/migration.c      |  7 +++++++
 migration/postcopy-ram.c   | 23 -----------------------
 6 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index d2762257aa..34e7d75713 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -69,6 +69,8 @@ bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_global_dump(Monitor *mon);
+/* True if incomming migration entered POSTCOPY_INCOMING_DISCARD */
+bool migration_in_incoming_postcopy(void);
 
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index aea0c44985..20a2defe3a 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -23,7 +23,5 @@ typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
                              QEMUBalloonStatus *stat_func, void *opaque);
 void qemu_remove_balloon_handler(void *opaque);
-bool qemu_balloon_is_inhibited(void);
-void qemu_balloon_inhibit(bool state);
 
 #endif
diff --git a/balloon.c b/balloon.c
index 5fff79523a..354408c6ea 100644
--- a/balloon.c
+++ b/balloon.c
@@ -36,24 +36,6 @@
 static QEMUBalloonEvent *balloon_event_fn;
 static QEMUBalloonStatus *balloon_stat_fn;
 static void *balloon_opaque;
-static int balloon_inhibit_count;
-
-bool qemu_balloon_is_inhibited(void)
-{
-    return atomic_read(&balloon_inhibit_count) > 0 ||
-           ram_block_discard_is_disabled();
-}
-
-void qemu_balloon_inhibit(bool state)
-{
-    if (state) {
-        atomic_inc(&balloon_inhibit_count);
-    } else {
-        atomic_dec(&balloon_inhibit_count);
-    }
-
-    assert(atomic_read(&balloon_inhibit_count) >= 0);
-}
 
 static bool have_balloon(Error **errp)
 {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 8a84718490..ae31f0817a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -63,6 +63,12 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
     return pbp->base_gpa == base_gpa;
 }
 
+static bool virtio_balloon_inhibited(void)
+{
+    /* Postcopy cannot deal with concurrent discards, so it's special. */
+    return ram_block_discard_is_disabled() || migration_in_incoming_postcopy();
+}
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
                                  PartiallyBalloonedPage *pbp)
@@ -336,7 +342,7 @@ static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue *vq)
          * accessible by another device or process, or if the guest is
          * expecting it to retain a non-zero value.
          */
-        if (qemu_balloon_is_inhibited() || dev->poison_val) {
+        if (virtio_balloon_inhibited() || dev->poison_val) {
             goto skip_element;
         }
 
@@ -421,7 +427,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 
             trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                                pa);
-            if (!qemu_balloon_is_inhibited()) {
+            if (!virtio_balloon_inhibited()) {
                 if (vq == s->ivq) {
                     balloon_inflate_page(s, section.mr,
                                          section.offset_within_region, &pbp);
diff --git a/migration/migration.c b/migration/migration.c
index 481a590f72..d365d82209 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1772,6 +1772,13 @@ bool migration_in_postcopy_after_devices(MigrationState *s)
     return migration_in_postcopy() && s->postcopy_after_devices;
 }
 
+bool migration_in_incoming_postcopy(void)
+{
+    PostcopyState ps = postcopy_state_get();
+
+    return ps >= POSTCOPY_INCOMING_DISCARD && ps < POSTCOPY_INCOMING_END;
+}
+
 bool migration_is_idle(void)
 {
     MigrationState *s = current_migration;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a36402722b..b41a9fe2fd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -27,7 +27,6 @@
 #include "qemu/notify.h"
 #include "qemu/rcu.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/balloon.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/boards.h"
@@ -520,20 +519,6 @@ int postcopy_ram_incoming_init(MigrationIncomingState *mis)
     return 0;
 }
 
-/*
- * Manage a single vote to the QEMU balloon inhibitor for all postcopy usage,
- * last caller wins.
- */
-static void postcopy_balloon_inhibit(bool state)
-{
-    static bool cur_state = false;
-
-    if (state != cur_state) {
-        qemu_balloon_inhibit(state);
-        cur_state = state;
-    }
-}
-
 /*
  * At the end of a migration where postcopy_ram_incoming_init was called.
  */
@@ -565,8 +550,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         mis->have_fault_thread = false;
     }
 
-    postcopy_balloon_inhibit(false);
-
     if (enable_mlock) {
         if (os_mlock() < 0) {
             error_report("mlock: %s", strerror(errno));
@@ -1160,12 +1143,6 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
     }
     memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
 
-    /*
-     * Ballooning can mark pages as absent while we're postcopying
-     * that would cause false userfaults.
-     */
-    postcopy_balloon_inhibit(true);
-
     trace_postcopy_ram_enable_notify();
 
     return 0;
-- 
MST



Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF16C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3192072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnNgr+Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3192072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizPm-00039e-Ep
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jizJx-000330-RS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:55:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jizJw-0001wl-LY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 07:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591790103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8cmPlf+UhVmg+8r2ez85zjWAFR8fo9Gsptc/PSKHa0=;
 b=PnNgr+JzMDlYP+QoBKHgi1yYK2+kAvlUnyMjP958wLn8LO7ABbjbqBNFWtdIENEWvJvq7/
 4DdUgoIX7fn5rnVcXROYSqkM3vCVWICpxQXeoFjU2msVOMl3UDpPCdGTDyqC9e4j8NhN9e
 K5COg91elNkq0Fnc41q+Y3Yxxm3W02k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-EaRoQXwoMNGYgNQZz7DgTw-1; Wed, 10 Jun 2020 07:54:59 -0400
X-MC-Unique: EaRoQXwoMNGYgNQZz7DgTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD028107ACCA;
 Wed, 10 Jun 2020 11:54:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-42.ams2.redhat.com [10.36.114.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C9E5D9D3;
 Wed, 10 Jun 2020 11:54:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/21] virtio-balloon: Rip out qemu_balloon_inhibit()
Date: Wed, 10 Jun 2020 13:54:03 +0200
Message-Id: <20200610115419.51688-6-david@redhat.com>
In-Reply-To: <20200610115419.51688-1-david@redhat.com>
References: <20200610115419.51688-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only remaining special case is postcopy. It cannot handle
concurrent discards yet, which would result in requesting already sent
pages from the source. Special-case it in virtio-balloon instead.

Introduce migration_in_incoming_postcopy(), to find out if incoming
postcopy is active.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 balloon.c                  | 18 ------------------
 hw/virtio/virtio-balloon.c |  8 +++++++-
 include/migration/misc.h   |  2 ++
 include/sysemu/balloon.h   |  2 --
 migration/migration.c      |  7 +++++++
 migration/postcopy-ram.c   | 23 -----------------------
 6 files changed, 16 insertions(+), 44 deletions(-)

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
index 065cd450f1..5ce2f956df 100644
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
@@ -360,7 +366,7 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 
             trace_virtio_balloon_handle_output(memory_region_name(section.mr),
                                                pa);
-            if (!qemu_balloon_is_inhibited()) {
+            if (!virtio_balloon_inhibited()) {
                 if (vq == s->ivq) {
                     balloon_inflate_page(s, section.mr,
                                          section.offset_within_region, &pbp);
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
diff --git a/migration/migration.c b/migration/migration.c
index b63ad91d34..14856cc930 100644
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
2.26.2



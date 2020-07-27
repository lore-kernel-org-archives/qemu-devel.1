Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B06C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0926A20786
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjmriHEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ALr-0007sk-9U
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAj-0005gV-5B
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAh-00050C-8u
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zogdDvU2bj1UI7GHi+Qx4u1q8JzcQ4QUoc8I84kZS+g=;
 b=YjmriHEvVN9UzJM2BZoNjMttIKHu3N+BkoEfKdfKZIOeiIGUxU+X4i/rGAIvijnSVBRecM
 wdkvep1VdHLMZHAOR4H864m0ztOLhXfWR+fS4iWo33BVQoTdqMW0kDBNNM2U6pszeLchsC
 0NiSYt+XFNfae7yDf+rxuc+3RqXrAyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-6qgb5BfxNWmiRDZskimuTQ-1; Mon, 27 Jul 2020 16:56:26 -0400
X-MC-Unique: 6qgb5BfxNWmiRDZskimuTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23954101C8A7;
 Mon, 27 Jul 2020 20:56:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E11A019724;
 Mon, 27 Jul 2020 20:56:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] migration/block-dirty-bitmap: cancel migration on
 shutdown
Date: Mon, 27 Jul 2020 15:55:36 -0500
Message-Id: <20200727205543.206624-18-eblake@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Dirty Bitmaps" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If target is turned off prior to postcopy finished, target crashes
because busy bitmaps are found at shutdown.
Canceling incoming migration helps, as it removes all unfinished (and
therefore busy) bitmaps.

Similarly on source we crash in bdrv_close_all which asserts that all
bdrv states are removed, because bdrv states involved into dirty bitmap
migration are referenced by it. So, we need to cancel outgoing
migration as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200727194236.19551-17-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/migration.h          |  2 ++
 migration/block-dirty-bitmap.c | 16 ++++++++++++++++
 migration/migration.c          | 13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index ab20c756f549..6c6a931d0dc2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -335,6 +335,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);

 void dirty_bitmap_mig_before_vm_start(void);
+void dirty_bitmap_mig_cancel_outgoing(void);
+void dirty_bitmap_mig_cancel_incoming(void);
 void migrate_add_address(SocketAddress *address);

 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index f91015a4f88f..1f675b792fc9 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -657,6 +657,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
     s->bitmaps = NULL;
 }

+void dirty_bitmap_mig_cancel_outgoing(void)
+{
+    dirty_bitmap_do_save_cleanup(&dbm_state.save);
+}
+
+void dirty_bitmap_mig_cancel_incoming(void)
+{
+    DBMLoadState *s = &dbm_state.load;
+
+    qemu_mutex_lock(&s->lock);
+
+    cancel_incoming_locked(s);
+
+    qemu_mutex_unlock(&s->lock);
+}
+
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 {
     GSList *item;
diff --git a/migration/migration.c b/migration/migration.c
index 1c61428988e9..8fe36339dbe8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -188,6 +188,19 @@ void migration_shutdown(void)
      */
     migrate_fd_cancel(current_migration);
     object_unref(OBJECT(current_migration));
+
+    /*
+     * Cancel outgoing migration of dirty bitmaps. It should
+     * at least unref used block nodes.
+     */
+    dirty_bitmap_mig_cancel_outgoing();
+
+    /*
+     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
+     * are non-critical data, and their loss never considered as
+     * something serious.
+     */
+    dirty_bitmap_mig_cancel_incoming();
 }

 /* For outgoing */
-- 
2.27.0



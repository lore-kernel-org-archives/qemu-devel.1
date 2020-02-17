Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF6C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3D32070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3D32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i0P-0005Wm-Cp
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvf-0004k1-Jz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hve-0007Wu-DU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:47404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hve-0007L9-55; Mon, 17 Feb 2020 10:03:22 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvE-0007Zt-UW; Mon, 17 Feb 2020 18:02:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration on
 shutdown
Date: Mon, 17 Feb 2020 18:02:34 +0300
Message-Id: <20200217150246.29180-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, andrey.shinkevich@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If target is turned of prior to postcopy finished, target crashes
because busy bitmaps are found at shutdown.
Canceling incoming migration helps, as it removes all unfinished (and
therefore busy) bitmaps.

Similarly on source we crash in bdrv_close_all which asserts that all
bdrv states are removed, because bdrv states involved into dirty bitmap
migration are referenced by it. So, we need to cancel outgoing
migration as well.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/migration.h          |  2 ++
 migration/block-dirty-bitmap.c | 16 ++++++++++++++++
 migration/migration.c          | 13 +++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/migration/migration.h b/migration/migration.h
index 2948f2387b..2de6b8bbe2 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -332,6 +332,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
+void dirty_bitmap_mig_cancel_outgoing(void);
+void dirty_bitmap_mig_cancel_incoming(void);
 void migrate_add_address(SocketAddress *address);
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index aea5326804..3ca425d95e 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -585,6 +585,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
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
index 515047932c..7c605ba218 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -181,6 +181,19 @@ void migration_shutdown(void)
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
2.21.0



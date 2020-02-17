Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477CEC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9A320801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9A320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i9n-0003If-BH
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvn-00057Q-VQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvj-0007a4-1f
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:31 -0500
Received: from relay.sw.ru ([185.231.240.75]:47526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvi-0007RT-Ot; Mon, 17 Feb 2020 10:03:26 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvD-0007Zt-7p; Mon, 17 Feb 2020 18:02:55 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/22] migration/block-dirty-bitmap: move mutex init to
 dirty_bitmap_mig_init
Date: Mon, 17 Feb 2020 18:02:28 +0300
Message-Id: <20200217150246.29180-5-vsementsov@virtuozzo.com>
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

No reasons to keep two public init functions.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/migration.h          | 1 -
 migration/block-dirty-bitmap.c | 6 +-----
 migration/migration.c          | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 8473ddfc88..2948f2387b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -332,7 +332,6 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
-void init_dirty_bitmap_incoming_migration(void);
 void migrate_add_address(SocketAddress *address);
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 4e8959ae52..49d4cf8810 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -148,11 +148,6 @@ typedef struct LoadBitmapState {
 static GSList *enabled_bitmaps;
 QemuMutex finish_lock;
 
-void init_dirty_bitmap_incoming_migration(void)
-{
-    qemu_mutex_init(&finish_lock);
-}
-
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
 {
     uint8_t flags = qemu_get_byte(f);
@@ -733,6 +728,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
 void dirty_bitmap_mig_init(void)
 {
     QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
+    qemu_mutex_init(&finish_lock);
 
     register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
diff --git a/migration/migration.c b/migration/migration.c
index 8fb68795dc..515047932c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -158,8 +158,6 @@ void migration_object_init(void)
     qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
     qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
 
-    init_dirty_bitmap_incoming_migration();
-
     if (!migration_object_check(current_migration, &err)) {
         error_report_err(err);
         exit(1);
-- 
2.21.0



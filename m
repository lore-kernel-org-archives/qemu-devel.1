Received: from eggs.gnu.org ([2001:4830:134:3::10]:33707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ffhcz-0003yt-JW
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1ffhcs-0001of-BV
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:16:03 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:45357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1ffhcs-0001nm-4Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:15:58 -0400
Received: by mail-pl0-x22e.google.com with SMTP id 94-v6so1709437ple.12
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 01:15:58 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 18 Jul 2018 16:15:41 +0800
Message-Id: <1531901741-8382-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v2] migration: release MigrationIncomingState
 in migration_object_finalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Qemu initialize the MigrationIncomingState structure in migration_object_init,
but not release it. this patch release it in migration_object_finalize.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8d56d56930..37048d9dad 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -161,6 +161,12 @@ void migration_object_init(void)
 void migration_object_finalize(void)
 {
     object_unref(OBJECT(current_migration));
+
+    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_fault);
+    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_dst);
+    qemu_event_destroy(&current_incoming->main_thread_load_event);
+    qemu_mutex_destroy(&current_incoming->rp_mutex);
+    g_free(current_incoming);
 }
 
 /* For outgoing */
-- 
2.15.2 (Apple Git-101.1)

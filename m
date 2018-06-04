Received: from eggs.gnu.org ([2001:4830:134:3::10]:46287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fPmD0-00073u-Ul
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fPmCw-0000hL-1E
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:55:27 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fPmCv-0000h6-QH
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:55:21 -0400
Received: by mail-pf0-x244.google.com with SMTP id e9-v6so15723149pfi.4
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:55:21 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Mon,  4 Jun 2018 17:55:13 +0800
Message-Id: <1528106113-32692-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH] migration: release MigrationIncomingState in
 migration_object_finalize
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
 migration/migration.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 05aec2c..e009a05 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -156,6 +156,13 @@ void migration_object_init(void)
 void migration_object_finalize(void)
 {
     object_unref(OBJECT(current_migration));
+
+    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_fault);
+    qemu_sem_destroy(&current_incoming->postcopy_pause_sem_dst);
+    qemu_event_destroy(&current_incoming->main_thread_load_event);
+    qemu_mutex_destroy(&current_incoming->rp_mutex);
+    g_array_free(current_incoming->postcopy_remote_fds, true);
+    g_free(current_incoming);
 }
 
 /* For outgoing */
-- 
1.8.3.1

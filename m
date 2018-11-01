Received: from eggs.gnu.org ([2001:4830:134:3::10]:57617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gIA33-0007A6-Ck
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gIA32-0007y1-HO
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:17:57 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:50095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gIA32-0007xX-7r
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:17:56 -0400
From: Fei Li <fli@suse.com>
Date: Thu,  1 Nov 2018 18:17:11 +0800
Message-Id: <20181101101715.9443-6-fli@suse.com>
In-Reply-To: <20181101101715.9443-1-fli@suse.com>
References: <20181101101715.9443-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH RFC v7 5/9] migration: fix the multifd code
 when sending less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, peterx@redhat.com, quintela@redhat.com

Set the migration state to "failed" instead of "setup" when failing
to send packet via some channel.

Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 migration/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4db3b3e8f4..c84d164fc8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1072,6 +1072,7 @@ out:
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
     MultiFDSendParams *p = opaque;
+    MigrationState *s = migrate_get_current();
     QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err = NULL;
 
@@ -1083,6 +1084,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         if (multifd_save_cleanup(&local_err) != 0) {
             migrate_set_error(migrate_get_current(), local_err);
         }
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     } else {
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
-- 
2.13.7

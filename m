Received: from eggs.gnu.org ([2001:4830:134:3::10]:35074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fhwF5-0003cm-2R
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fhwF1-0005ER-Um
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:16:39 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fhwF1-0005EE-NV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:16:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id y4-v6so2781287pgp.9
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 05:16:35 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Tue, 24 Jul 2018 20:16:24 +0800
Message-Id: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: fix the Unknown ending state
 error log
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

When cancelling migration, the state is MIGRATION_STATUS_CANCELLING.
The state change to MIGRATION_STATUS_CANCELLED when cleanup_bh is scheduled.
So when migration_iteration_finish is invoked, the state should be
MIGRATION_STATUS_CANCELLING.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8d56d56..ff05422 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2876,7 +2876,7 @@ static void migration_iteration_finish(MigrationState *s)
         s->vm_was_running = true;
         /* Fallthrough */
     case MIGRATION_STATUS_FAILED:
-    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_CANCELLING:
         if (s->vm_was_running) {
             vm_start();
         } else {
-- 
1.8.3.1

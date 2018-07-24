Received: from eggs.gnu.org ([2001:4830:134:3::10]:45946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29H-0008Rp-TX
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29G-0002hv-H0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29G-0002gQ-A4
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:02 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:49 +0100
Message-Id: <20180724183454.120276-3-dgilbert@redhat.com>
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] migrate: Fix cancelling state warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, kraxel@redhat.com, lidongchen@tencent.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've been getting the warning:

migration_iteration_finish: Unknown ending state 2

on a cancel.

I think that's originally due to 39b9e17905c;  although
I've only seen the warning, I think that in some cases
that we could find the VM stays paused after a cancel where
it should restart.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180719092257.12703-1-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8d56d56930..db6bde7453 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2877,6 +2877,7 @@ static void migration_iteration_finish(MigrationState *s)
         /* Fallthrough */
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_CANCELLING:
         if (s->vm_was_running) {
             vm_start();
         } else {
-- 
2.17.1

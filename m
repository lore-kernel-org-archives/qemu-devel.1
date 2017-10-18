Received: from eggs.gnu.org ([2001:4830:134:3::10]:60520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4sKi-0005cr-Iw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e4sKh-0001kc-RY
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:40:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e4sKh-0001kC-LT
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 13:40:43 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 18 Oct 2017 18:40:12 +0100
Message-Id: <20171018174013.22709-7-dgilbert@redhat.com>
In-Reply-To: <20171018174013.22709-1-dgilbert@redhat.com>
References: <20171018174013.22709-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] migration: allow cancel to unpause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, quintela@redhat.com, peterx@redhat.com, mreitz@redhat.com
Cc: berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

If a migration_cancel is issued during the new paused state,
kick the pause_sem to get to unpause so it can cancel.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index c9a3ee9efd..756deb3e2c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1108,6 +1108,10 @@ static void migrate_fd_cancel(MigrationState *s)
         if (!migration_is_setup_or_active(old_state)) {
             break;
         }
+        /* If the migration is paused, kick it out of the pause */
+        if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
+            qemu_sem_post(&s->pause_sem);
+        }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
 
-- 
2.13.6

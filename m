Received: from eggs.gnu.org ([2001:4830:134:3::10]:42300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTEF-0000bD-J1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ezTED-0003q3-T5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ezTED-0003pn-Oq
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:23:57 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 23 Mar 2018 20:23:44 +0000
Message-Id: <20180323202344.70640-6-dgilbert@redhat.com>
In-Reply-To: <20180323202344.70640-1-dgilbert@redhat.com>
References: <20180323202344.70640-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] migration: Fix block migration flag case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, berrange@redhat.com, lidongchen@tencent.com, pl@kamp.de, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix the case where when a migration with a bad protocol is tried,
we leave the block migration capability set.

(This is a cut down version of my 'migration: Fix block failure cases'
where it's other case was fixed by Peter's dd0ee30caeebbd )

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180316202114.32345-1-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index fc629e5965..52a5092add 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1428,6 +1428,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
+        block_cleanup_parameters(s);
         return;
     }
 
-- 
2.14.3

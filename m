Received: from eggs.gnu.org ([2001:4830:134:3::10]:36766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewvr7-0003cP-7y
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewvr3-0001Az-1g
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:21:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewvr2-00019e-TZ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 16:21:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C43ACEB702
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 20:21:21 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Mar 2018 20:21:14 +0000
Message-Id: <20180316202114.32345-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Fix block migration flag case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Fix the case where when a migration with a bad protocol is tried,
we leave the block migration capability set.

(This is a cut down version of my 'migration: Fix block failure cases'
where it's other case was fixed by Peter's dd0ee30caeebbd )

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 1f22f463d3..20084b32dd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1423,6 +1423,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
+        block_cleanup_parameters(s);
         return;
     }
 
-- 
2.14.3

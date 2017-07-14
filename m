Received: from eggs.gnu.org ([2001:4830:134:3::10]:40099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVzE9-0002Il-Bc
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVzE8-0003bt-E2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:57:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVzE8-0003bf-7e
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:57:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CE9BC0587F1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:57:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 14 Jul 2017 12:57:33 +0100
Message-Id: <20170714115736.13693-3-dgilbert@redhat.com>
In-Reply-To: <20170714115736.13693-1-dgilbert@redhat.com>
References: <20170714115736.13693-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/5] migration: Close file on failed
 migration load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Closing the file before exit on a failure allows
the source to cleanup better, especially with RDMA.

Partial fix for https://bugs.launchpad.net/qemu/+bug/1545052

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index a0db40d364..8552f54ab4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -348,6 +348,7 @@ static void process_incoming_migration_co(void *opaque)
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
+        qemu_fclose(mis->from_src_file);
         exit(EXIT_FAILURE);
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
-- 
2.13.0

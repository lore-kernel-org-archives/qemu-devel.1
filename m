Received: from eggs.gnu.org ([2001:4830:134:3::10]:47545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82u-00064v-Iy
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82r-0002uL-IO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY82r-0002u6-Dr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4A62401EF04
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:51:28 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 18:51:10 +0800
Message-Id: <20180627105112.31401-4-peterx@redhat.com>
In-Reply-To: <20180627105112.31401-1-peterx@redhat.com>
References: <20180627105112.31401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] migration: do explicit incoming setup
 for rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

RDMA does not support postcopy recovery, so no need to go into such
logic.  Instead of calling migration_fd_process_incoming(), let's call
the two functions that setup the incoming migration.  There should have
no functional change at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 8bd7159059..217cdd7dd8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3687,7 +3687,8 @@ static void rdma_accept_incoming_migration(void *opaque)
     }
 
     rdma->migration_started_on_destination = 1;
-    migration_fd_process_incoming(f);
+    migration_incoming_setup(f);
+    migration_incoming_process();
 }
 
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
-- 
2.17.1

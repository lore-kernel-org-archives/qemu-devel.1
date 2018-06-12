Received: from eggs.gnu.org ([2001:4830:134:3::10]:54944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fSf0t-00070o-AH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fSf0o-0004o2-Fg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:50:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fSf0o-0004nd-5C
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:50:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5C8nqKM043423
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 04:50:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jj7s40n62-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 04:50:44 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 12 Jun 2018 09:50:42 +0100
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Tue, 12 Jun 2018 14:20:09 +0530
In-Reply-To: <20180612085009.17594-1-bala24@linux.vnet.ibm.com>
References: <20180612085009.17594-1-bala24@linux.vnet.ibm.com>
Message-Id: <20180612085009.17594-2-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/1] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, david@gibson.dropbear.id.au, lvivier@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>

expected_downtime value is not accurate with dirty_pages_rate * page_size,
using ram_bytes_remaining() would yeild it resonable.

consider to read the remaining ram just after having updated the dirty
pages count later migration_bitmap_sync_range() in migration_bitmap_sync()
and reuse the `remaining` field in ram_counters to hold ram_bytes_remaining()
for calculating expected_downtime.

Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/migration.c | 3 +--
 migration/ram.c       | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ea9a6cbb87..cb14dadb26 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2739,8 +2739,7 @@ static void migration_update_counters(MigrationState *s,
      * recalculate. 10000 is a small enough number for our purposes
      */
     if (ram_counters.dirty_pages_rate && transferred > 10000) {
-        s->expected_downtime = ram_counters.dirty_pages_rate *
-            qemu_target_page_size() / bandwidth;
+        s->expected_downtime = ram_counters.remaining / bandwidth;
     }
 
     qemu_file_reset_rate_limit(s->to_dst_file);
diff --git a/migration/ram.c b/migration/ram.c
index a500015a2f..a94a2b829e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1159,6 +1159,7 @@ static void migration_bitmap_sync(RAMState *rs)
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
+    ram_counters.remaining = ram_bytes_remaining();
     rcu_read_unlock();
     qemu_mutex_unlock(&rs->bitmap_mutex);
 
-- 
2.14.3

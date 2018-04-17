Received: from eggs.gnu.org ([2001:4830:134:3::10]:43756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f8Qad-0008E8-FH
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1f8QaY-0004Dx-Sy
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:24:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53142
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1f8QaY-0004De-Ne
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 09:24:02 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3HDJe4J058072
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 09:24:02 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hdekvhs9y-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 09:23:59 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 17 Apr 2018 14:23:52 +0100
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 18:53:17 +0530
In-Reply-To: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
References: <20180417132317.6910-1-bala24@linux.vnet.ibm.com>
Message-Id: <20180417132317.6910-2-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] migration: calculate expected_downtime
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
Cc: quintela@redhat.com, dgilbert@redhat.com, dgibson@redhat.com, amit.shah@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>

expected_downtime value is not accurate with dirty_pages_rate * page_size,
using ram_bytes_remaining would yeild it correct.

Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 migration/migration.c | 6 +++---
 migration/migration.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 52a5092add..4d866bb920 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     }
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
-        info->ram->remaining = ram_bytes_remaining();
+        info->ram->remaining = s->ram_bytes_remaining;
         info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
     }
 }
@@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationState *s,
     transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
     time_spent = current_time - s->iteration_start_time;
     bandwidth = (double)transferred / time_spent;
+    s->ram_bytes_remaining = ram_bytes_remaining();
     s->threshold_size = bandwidth * s->parameters.downtime_limit;
 
     s->mbps = (((double) transferred * 8.0) /
@@ -2237,8 +2238,7 @@ static void migration_update_counters(MigrationState *s,
      * recalculate. 10000 is a small enough number for our purposes
      */
     if (ram_counters.dirty_pages_rate && transferred > 10000) {
-        s->expected_downtime = ram_counters.dirty_pages_rate *
-            qemu_target_page_size() / bandwidth;
+        s->expected_downtime = s->ram_bytes_remaining / bandwidth;
     }
 
     qemu_file_reset_rate_limit(s->to_dst_file);
diff --git a/migration/migration.h b/migration/migration.h
index 8d2f320c48..8584f8e22e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -128,6 +128,7 @@ struct MigrationState
     int64_t downtime_start;
     int64_t downtime;
     int64_t expected_downtime;
+    int64_t ram_bytes_remaining;
     bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
     /*
-- 
2.14.3

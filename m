Received: from eggs.gnu.org ([209.51.188.92]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gm14g-0004NB-Dw
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1gm14e-0005BL-EY
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58550
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1gm14c-0004FL-BA
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:58 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MF5i2d091377
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:06:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q63kq5kf5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:06:29 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 22 Jan 2019 15:06:11 -0000
From: bala24@linux.vnet.ibm.com
Date: Tue, 22 Jan 2019 20:35:43 +0530
In-Reply-To: <20190122150543.16889-1-bala24@linux.vnet.ibm.com>
References: <20190122150543.16889-1-bala24@linux.vnet.ibm.com>
Message-Id: <20190122150543.16889-2-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] migration: calculate expected_downtime
 considering redirtied ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, dgilbert@redhat.com, peterx@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

From: Balamuruhan S <bala24@linux.vnet.ibm.com>

currently we calculate expected_downtime by time taken to transfer
remaining ram, but during the time we had transferred remaining ram
few pages of ram might be redirtied and we need to retransfer it,
so it is better to consider them for calculating expected_downtime
for getting more accurate values.

Total ram to be transferred = remaining ram + (redirtied ram at the
                                               time when the remaining
                                               ram gets transferred)

redirtied ram = dirty_pages_rate * time taken to transfer remaining ram

redirtied ram = dirty_pages_rate * (remaining ram / bandwidth)

expected_downtime = (remaining ram + redirtied ram) / bandwidth

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 migration/migration.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index ffc4d9e556..dc38e9a380 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2903,7 +2903,13 @@ static void migration_update_counters(MigrationState *s,
      * recalculate. 10000 is a small enough number for our purposes
      */
     if (ram_counters.dirty_pages_rate && transferred > 10000) {
-        s->expected_downtime = ram_counters.remaining / bandwidth;
+        /* Time required to transfer remaining ram */
+        remaining_ram_transfer_time = ram_counters.remaining / bandwidth
+
+        /* redirty of ram at the time remaining ram gets transferred*/
+        newly_dirtied_ram = ram_counters.dirty_pages_rate * remaining_ram_transfer_time
+
+        s->expected_downtime = (ram_counters.remaining + newly_dirtied_ram) / bandwidth;
     }
 
     qemu_file_reset_rate_limit(s->to_dst_file);
-- 
2.14.5

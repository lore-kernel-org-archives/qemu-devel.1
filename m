Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0628986faa=bala24@linux.vnet.ibm.com>)
	id 1f2Lft-0001Mz-6C
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 14:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0628986faa=bala24@linux.vnet.ibm.com>)
	id 1f2Lfq-0002zt-0N
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 14:56:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0628986faa=bala24@linux.vnet.ibm.com>)
	id 1f2Lfp-0002vf-Mb
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 14:56:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2VIsUfa044799
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 14:56:18 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h2eu3ssp3-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 14:56:18 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Sat, 31 Mar 2018 19:56:16 +0100
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Sun,  1 Apr 2018 00:25:36 +0530
Message-Id: <20180331185536.4835-1-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] migration: calculate expected_downtime with
 ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, amit.shah@redhat.com, Balamuruhan S <bala24@linux.vnet.ibm.com>

expected_downtime value is not accurate with dirty_pages_rate * page_size,
using ram_bytes_remaining would yeild it correct.

Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
---
 migration/migration.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 58bd382730..4e43dc4f92 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2245,8 +2245,7 @@ static void migration_update_counters(MigrationState *s,
      * recalculate. 10000 is a small enough number for our purposes
      */
     if (ram_counters.dirty_pages_rate && transferred > 10000) {
-        s->expected_downtime = ram_counters.dirty_pages_rate *
-            qemu_target_page_size() / bandwidth;
+        s->expected_downtime = ram_bytes_remaining() / bandwidth;
     }
 
     qemu_file_reset_rate_limit(s->to_dst_file);
-- 
2.14.3

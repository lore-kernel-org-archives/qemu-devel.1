Received: from eggs.gnu.org ([2001:4830:134:3::10]:54913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fSf0m-0006yQ-Hg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fSf0h-0004lF-L0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:50:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fSf0h-0004kE-B2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 04:50:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5C8nqR8043431
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 04:50:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jj7s40n03-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 04:50:36 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 12 Jun 2018 09:50:34 +0100
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
Date: Tue, 12 Jun 2018 14:20:08 +0530
Message-Id: <20180612085009.17594-1-bala24@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/1] migration: calculate expected_downtime
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

V4:

Read the remaining ram after updating dirty pages count and reuse
existing `remaining` field in ram_counters to hold ram_bytes_remaining()

Thank you Laurent for your time and help to investigate and correct my
changes.

V3:

* commit message to be updated with the changes done by the patch since
v1, review comment by David Gibson.

* Included Michael Roth as ``Reported-by:`` for bringing up the concern.

v2:

There is some difference in expected_downtime value due to following
reason,

1. bandwidth and expected_downtime value are calculated in
migration_update_counters() during each iteration from
migration_thread()

2. remaining ram is calculated in qmp_query_migrate() when we actually
call "info migrate"

This v2 patch where bandwidth, expected_downtime and remaining ram are
calculated in migration_update_counters(), retrieve the same value
during
"info migrate". By this approach we get almost close enough value,

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
capabilities: xbzrle: off rdma-pin-all: off auto-converge: off
zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off
release-ram: off block: off return-path: off pause-before-switchover:
off x-multifd: off dirty-bitmaps: off
Migration status: active
total time: 319737 milliseconds
expected downtime: 1054 milliseconds
setup: 16 milliseconds
transferred ram: 3669862 kbytes
throughput: 108.92 mbps
remaining ram: 14016 kbytes
total ram: 8388864 kbytes
duplicate: 2296276 pages
skipped: 0 pages
normal: 910639 pages
normal bytes: 3642556 kbytes
dirty sync count: 249
page size: 4 kbytes
dirty pages rate: 4626 pages

Calculation:
calculated value = (14016 * 8 ) / 108.92 = 1029.452809401 milliseconds
actual value = 1054 milliseconds

since v1:
use ram_bytes_remaining() instead of dirty_pages_rate * page_size to
calculate expected_downtime to be more accurate.

Regards,
Bala

Balamuruhan S (1):
  migration: calculate expected_downtime with ram_bytes_remaining()

 migration/migration.c | 3 +--
 migration/ram.c       | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.14.3

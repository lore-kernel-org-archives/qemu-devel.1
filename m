Received: from eggs.gnu.org ([2001:4830:134:3::10]:56905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFe-0002wF-SV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFa-0003wM-Tv
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPZFa-0003vh-MR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:26 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78D16C05681D
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:28:26 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  6 Jan 2017 18:28:08 +0000
Message-Id: <20170106182823.1960-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 00/15] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  The existing postcopy code, and the userfault kernel
code that supports it, only works for normal anonymous memory.
Kernel support for userfault on hugetlbfs is working
it's way upstream; it's just gone into the linux-mm tree,
You can get a version at:
   git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git
on the origin/userfault branch (currently at ref 7284072f).

Note that while this code supports arbitrary sized hugepages,
it doesn't make sense with pages above the few-MB region,
so while 2MB is fine, 1GB is probably a bad idea;
this code waits for and transmits whole huge pages, and a
1GB page would take about 1 second to transfer over a 10Gbps
link - which is way too long to pause the destination for.

Dave


Dr. David Alan Gilbert (15):
  postcopy: Transmit and compare individual page sizes
  postcopy: Transmit ram size summary word
  postcopy: Chunk discards for hugepages
  Fold postcopy_ram_discard_range into ram_discard_range
  postcopy: enhance ram_discard_range for hugepages
  postcopy: Record largest page size
  postcopy: Plumb pagesize down into place helpers
  postcopy: Use temporary for placing zero huge pages
  postcopy: Load huge pages in one go
  postcopy: Mask fault addresses to huge page boundary
  postcopy: Send whole huge pages
  postcopy: Allow hugepages
  postcopy: Update userfaultfd.h header
  postcopy: Check for userfault+hugepage feature
  postcopy: Add doc about hugepages and postcopy

 docs/migration.txt                |  13 ++++
 exec.c                            |  13 ++++
 include/exec/cpu-common.h         |   1 +
 include/exec/memory.h             |   1 -
 include/migration/migration.h     |   3 +
 include/migration/postcopy-ram.h  |  13 ++--
 linux-headers/linux/userfaultfd.h |  81 +++++++++++++++++++---
 migration/migration.c             |   1 +
 migration/postcopy-ram.c          | 139 +++++++++++++++++---------------------
 migration/ram.c                   | 110 ++++++++++++++++++++++++------
 migration/savevm.c                |  32 ++++++---
 migration/trace-events            |   2 +-
 12 files changed, 280 insertions(+), 129 deletions(-)

-- 
2.9.3

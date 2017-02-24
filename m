Received: from eggs.gnu.org ([2001:4830:134:3::10]:53374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKbq-0000qo-LM
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1chKbn-0007sh-Go
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1chKbn-0007sF-AW
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:28:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E7533D940
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 18:28:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 24 Feb 2017 18:28:28 +0000
Message-Id: <20170224182844.32452-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  The existing postcopy code, and the userfault kernel
code that supports it, only works for normal anonymous memory.
Kernel support for userfault on hugetlbfs has just
been merged in Linus's tree for 4.11 (see 4c9a7831b11 merge)

Note that while this code supports arbitrary sized hugepages,
it doesn't make sense with pages above the few-MB region,
so while 2MB is fine, 1GB is probably a bad idea;
this code waits for and transmits whole huge pages, and a
1GB page would take about 1 second to transfer over a 10Gbps
link - which is way too long to pause the destination for.

Note: 'postcopy: Update userfaultfd.h header' is now from
Paolo's recent header update run; it can be dropped as
soon as Paolo's goes in.

Dave

v3
  Added an extra check in 'postcopy: Add extra check for COPY function'
  Updates from Laurent's review:
    moved the CONFIG_FALLOCATE_PUNCH_HOLE from 'ram_block_discard_range'
    into the following 'enhance ram_block_discard_range for hugepages'
    Merged the ram_block_discard_range / Fold postcopy_ram_discard_range
    into ram_discard_range  patches
    Removed the excess rcu_read_lock in ram_block_discard_range
    Removed a removal of a blank line in 'Mask fault address'
  Updated the 'Update userfaultfd.h header' - that's now from Paolo's update


Dr. David Alan Gilbert (16):
  postcopy: Transmit ram size summary word
  postcopy: Transmit and compare individual page sizes
  postcopy: Chunk discards for hugepages
  exec: ram_block_discard_range
  postcopy: enhance ram_block_discard_range for hugepages
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
  postcopy: Add extra check for COPY function

 docs/migration.txt                |  13 ++++
 exec.c                            |  83 ++++++++++++++++++++++
 include/exec/cpu-common.h         |   2 +
 include/migration/migration.h     |   3 +
 include/migration/postcopy-ram.h  |  13 ++--
 linux-headers/linux/userfaultfd.h |  67 +++++++++++++++---
 migration/migration.c             |   1 +
 migration/postcopy-ram.c          | 142 ++++++++++++++++++--------------------
 migration/ram.c                   | 109 ++++++++++++++++++-----------
 migration/savevm.c                |  32 ++++++---
 migration/trace-events            |   2 +-
 11 files changed, 319 insertions(+), 148 deletions(-)

-- 
2.9.3

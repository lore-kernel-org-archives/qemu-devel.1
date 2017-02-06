Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canMA-0006FO-Md
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canM7-0002Tt-Ib
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:45:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canM7-0002Tj-AC
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:45:35 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58BB361BAC
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:45:34 +0000 (UTC)
Date: Mon, 6 Feb 2017 17:45:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170206174529.GI2524@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   The existing postcopy code, and the userfault kernel
> code that supports it, only works for normal anonymous memory.
> Kernel support for userfault on hugetlbfs is working
> it's way upstream; it's in the linux-mm tree,
> You can get a version at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git
> on the origin/userfault branch.
> 
> Note that while this code supports arbitrary sized hugepages,
> it doesn't make sense with pages above the few-MB region,
> so while 2MB is fine, 1GB is probably a bad idea;
> this code waits for and transmits whole huge pages, and a
> 1GB page would take about 1 second to transfer over a 10Gbps
> link - which is way too long to pause the destination for.
> 
> Dave

Oops I missed the v2 changes from the message:

v2
  Flip ram-size summary word/compare individual page size patches around
  Individual page size comparison is done in ram_load if 'advise' has been
    received rather than checking migrate_postcopy_ram()
  Moved discard code into exec.c, reworked ram_discard_range

Dave

> Dr. David Alan Gilbert (16):
>   postcopy: Transmit ram size summary word
>   postcopy: Transmit and compare individual page sizes
>   postcopy: Chunk discards for hugepages
>   exec: ram_block_discard_range
>   postcopy: enhance ram_block_discard_range for hugepages
>   Fold postcopy_ram_discard_range into ram_discard_range
>   postcopy: Record largest page size
>   postcopy: Plumb pagesize down into place helpers
>   postcopy: Use temporary for placing zero huge pages
>   postcopy: Load huge pages in one go
>   postcopy: Mask fault addresses to huge page boundary
>   postcopy: Send whole huge pages
>   postcopy: Allow hugepages
>   postcopy: Update userfaultfd.h header
>   postcopy: Check for userfault+hugepage feature
>   postcopy: Add doc about hugepages and postcopy
> 
>  docs/migration.txt                |  13 ++++
>  exec.c                            |  83 +++++++++++++++++++++++
>  include/exec/cpu-common.h         |   2 +
>  include/exec/memory.h             |   1 -
>  include/migration/migration.h     |   3 +
>  include/migration/postcopy-ram.h  |  13 ++--
>  linux-headers/linux/userfaultfd.h |  81 +++++++++++++++++++---
>  migration/migration.c             |   1 +
>  migration/postcopy-ram.c          | 138 +++++++++++++++++---------------------
>  migration/ram.c                   | 109 ++++++++++++++++++------------
>  migration/savevm.c                |  32 ++++++---
>  migration/trace-events            |   2 +-
>  12 files changed, 328 insertions(+), 150 deletions(-)
> 
> -- 
> 2.9.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

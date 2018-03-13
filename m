Received: from eggs.gnu.org ([2001:4830:134:3::10]:34570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrFk-0000g3-8u
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1evrFg-0005fo-5R
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1evrFf-0005fa-V8
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 17:14:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AA074023BB3
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 21:14:28 +0000 (UTC)
Date: Tue, 13 Mar 2018 23:14:16 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180313231057-mutt-send-email-mst@kernel.org>
References: <20180312172124.56461-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312172124.56461-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Mon, Mar 12, 2018 at 05:20:55PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
>   This set enables postcopy migration with shared memory to a vhost user process.
> It's based off current head.
>  
>   Testing is mostly performed with dpdk, with corresponding modifications by
> Maxime.
>  
>   v5 is mostly just fixes from comments received during review of v4.
> The only notable one is that the 'advise' message no longer has any
> data.

I plan to apply this. Could you pls rebase on top of
pci branch in my tree? Or wait till it's merged and rebase.
And pls fix the minor whitespace issue git warns about.

> Dave
> 
> Dr. David Alan Gilbert (29):
>   migrate: Update ram_block_discard_range for shared
>   qemu_ram_block_host_offset
>   postcopy: use UFFDIO_ZEROPAGE only when available
>   postcopy: Add notifier chain
>   postcopy: Add vhost-user flag for postcopy and check it
>   vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
>   libvhost-user: Support sending fds back to qemu
>   libvhost-user: Open userfaultfd
>   postcopy: Allow registering of fd handler
>   vhost+postcopy: Register shared ufd with postcopy
>   vhost+postcopy: Transmit 'listen' to slave
>   postcopy+vhost-user: Split set_mem_table for postcopy
>   migration/ram: ramblock_recv_bitmap_test_byte_offset
>   libvhost-user+postcopy: Register new regions with the ufd
>   vhost+postcopy: Send address back to qemu
>   vhost+postcopy: Stash RAMBlock and offset
>   vhost+postcopy: Helper to send requests to source for shared pages
>   vhost+postcopy: Resolve client address
>   postcopy: helper for waking shared
>   postcopy: postcopy_notify_shared_wake
>   vhost+postcopy: Add vhost waker
>   vhost+postcopy: Call wakeups
>   libvhost-user: mprotect & madvises for postcopy
>   vhost-user: Add VHOST_USER_POSTCOPY_END message
>   vhost+postcopy: Wire up POSTCOPY_END notify
>   vhost: Huge page align and merge
>   postcopy: Allow shared memory
>   libvhost-user: Claim support for postcopy
>   postcopy shared docs
> 
>  contrib/libvhost-user/libvhost-user.c | 302 ++++++++++++++++++++++++-
>  contrib/libvhost-user/libvhost-user.h |  11 +
>  docs/devel/migration.rst              |  41 ++++
>  docs/interop/vhost-user.txt           |  52 +++++
>  exec.c                                |  86 +++++--
>  hw/virtio/trace-events                |  16 +-
>  hw/virtio/vhost-user.c                | 411 +++++++++++++++++++++++++++++++++-
>  hw/virtio/vhost.c                     |  66 +++++-
>  include/exec/cpu-common.h             |   4 +
>  migration/migration.c                 |   6 +
>  migration/migration.h                 |   4 +
>  migration/postcopy-ram.c              | 354 +++++++++++++++++++++++------
>  migration/postcopy-ram.h              |  73 ++++++
>  migration/ram.c                       |   5 +
>  migration/ram.h                       |   1 +
>  migration/savevm.c                    |  13 ++
>  migration/trace-events                |   6 +
>  trace-events                          |   3 +-
>  vl.c                                  |   2 +
>  19 files changed, 1358 insertions(+), 98 deletions(-)
> 
> -- 
> 2.14.3

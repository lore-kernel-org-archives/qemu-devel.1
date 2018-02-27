Received: from eggs.gnu.org ([2001:4830:134:3::10]:44630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eqfon-0003I6-KR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eqfoj-0008B4-MQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:01:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eqfoj-0008Aw-Fv
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68569813F6FF
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:01:16 +0000 (UTC)
Date: Tue, 27 Feb 2018 16:01:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227155825-mutt-send-email-mst@kernel.org>
References: <20180216131625.9639-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216131625.9639-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, imammedo@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Fri, Feb 16, 2018 at 01:15:56PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   This is the first non-RFC version of this patch set that
> enables postcopy migration with shared memory to a vhost user process.
> It's based off current head.
> 
> I've tested with vhost-user-bridge and a modified dpdk; both very
> lightly.
> 
> Compared to v2 we're now using the just-merged reworks to the vhost
> code (suggested by Igor), so that the huge page region merging is now a lot simpler
> in this series. The handshake between the client and the qemu for the
> set-mem-table is now a bit more complex to resolve a previous race where
> the client would start sending requests to the qemu prior to the qemu
> being ready to accept them.
> 
> Dave

>From vhost-user POV this seems mostly fine to me.

I would like to have dependency of specific messages on the
protocol features documented, and the order of messages
documented a bit more explicitly.




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
>   vhost+postcopy: Transmit 'listen' to client
>   postcopy+vhost-user: Split set_mem_table for postcopy
>   migration/ram: ramblock_recv_bitmap_test_byte_offset
>   libvhost-user+postcopy: Register new regions with the ufd
>   vhost+postcopy: Send address back to qemu
>   vhost+postcopy: Stash RAMBlock and offset
>   vhost+postcopy: Send requests to source for shared pages
>   vhost+postcopy: Resolve client address
>   postcopy: wake shared
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
>  contrib/libvhost-user/libvhost-user.c | 303 ++++++++++++++++++++++++-
>  contrib/libvhost-user/libvhost-user.h |   8 +
>  docs/devel/migration.rst              |  41 ++++
>  docs/interop/vhost-user.txt           |  42 ++++
>  exec.c                                |  85 +++++--
>  hw/virtio/trace-events                |  16 +-
>  hw/virtio/vhost-user.c                | 411 +++++++++++++++++++++++++++++++++-
>  hw/virtio/vhost.c                     |  66 +++++-
>  include/exec/cpu-common.h             |   4 +
>  migration/migration.c                 |   6 +
>  migration/migration.h                 |   4 +
>  migration/postcopy-ram.c              | 350 +++++++++++++++++++++++------
>  migration/postcopy-ram.h              |  69 ++++++
>  migration/ram.c                       |   5 +
>  migration/ram.h                       |   1 +
>  migration/savevm.c                    |  13 ++
>  migration/trace-events                |   6 +
>  trace-events                          |   3 +-
>  vl.c                                  |   2 +
>  19 files changed, 1337 insertions(+), 98 deletions(-)
> 
> -- 
> 2.14.3

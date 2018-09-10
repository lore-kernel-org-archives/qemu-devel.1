Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fzHLl-0000Cx-02
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fzHFU-0003bz-Ak
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:08:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42098 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fzHFU-0003ba-3c
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 04:08:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A75164B765
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 08:08:42 +0000 (UTC)
Date: Mon, 10 Sep 2018 09:08:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180910080831.GA2482@work-vm>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180907163253-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907163253-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com, aarcange@redhat.com

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Thu, Mar 08, 2018 at 07:57:42PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> >   This set enables postcopy migration with shared memory to a vhost user process.
> > It's based off current head.
> > 
> >   Testing is mostly performed with dpdk, with corresponding modifications by
> > Maxime.
> > 
> >   v4 is mostly just fixes from comments received during review of v3,
> > and the normal updating of all the virtio enum's to catch up with other
> > things getting in before us.
> > 
> > Dave
> 
> For vhost bits:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> So how is all this going to be merged?
> If it's through my tree pls let me know.
> I'm fine with another tree though.

You already merged it!  Back in March in ed627b2ad37469eeba9e
Maxime has a dpdk set to be merged, but we're just working a bug
at the moment that we've not figured out yet (could be either side).

Dave

> 
> > 
> > Dr. David Alan Gilbert (29):
> >   migrate: Update ram_block_discard_range for shared
> >   qemu_ram_block_host_offset
> >   postcopy: use UFFDIO_ZEROPAGE only when available
> >   postcopy: Add notifier chain
> >   postcopy: Add vhost-user flag for postcopy and check it
> >   vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
> >   libvhost-user: Support sending fds back to qemu
> >   libvhost-user: Open userfaultfd
> >   postcopy: Allow registering of fd handler
> >   vhost+postcopy: Register shared ufd with postcopy
> >   vhost+postcopy: Transmit 'listen' to client
> >   postcopy+vhost-user: Split set_mem_table for postcopy
> >   migration/ram: ramblock_recv_bitmap_test_byte_offset
> >   libvhost-user+postcopy: Register new regions with the ufd
> >   vhost+postcopy: Send address back to qemu
> >   vhost+postcopy: Stash RAMBlock and offset
> >   vhost+postcopy: Send requests to source for shared pages
> >   vhost+postcopy: Resolve client address
> >   postcopy: helper for waking shared
> >   postcopy: postcopy_notify_shared_wake
> >   vhost+postcopy: Add vhost waker
> >   vhost+postcopy: Call wakeups
> >   libvhost-user: mprotect & madvises for postcopy
> >   vhost-user: Add VHOST_USER_POSTCOPY_END message
> >   vhost+postcopy: Wire up POSTCOPY_END notify
> >   vhost: Huge page align and merge
> >   postcopy: Allow shared memory
> >   libvhost-user: Claim support for postcopy
> >   postcopy shared docs
> > 
> >  contrib/libvhost-user/libvhost-user.c | 303 ++++++++++++++++++++++++-
> >  contrib/libvhost-user/libvhost-user.h |  11 +
> >  docs/devel/migration.rst              |  41 ++++
> >  docs/interop/vhost-user.txt           |  51 +++++
> >  exec.c                                |  86 +++++--
> >  hw/virtio/trace-events                |  16 +-
> >  hw/virtio/vhost-user.c                | 411 +++++++++++++++++++++++++++++++++-
> >  hw/virtio/vhost.c                     |  66 +++++-
> >  include/exec/cpu-common.h             |   4 +
> >  migration/migration.c                 |   6 +
> >  migration/migration.h                 |   4 +
> >  migration/postcopy-ram.c              | 354 +++++++++++++++++++++++------
> >  migration/postcopy-ram.h              |  69 ++++++
> >  migration/ram.c                       |   5 +
> >  migration/ram.h                       |   1 +
> >  migration/savevm.c                    |  13 ++
> >  migration/trace-events                |   6 +
> >  trace-events                          |   3 +-
> >  vl.c                                  |   2 +
> >  19 files changed, 1354 insertions(+), 98 deletions(-)
> > 
> > -- 
> > 2.14.3
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

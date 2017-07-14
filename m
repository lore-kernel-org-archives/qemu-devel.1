Received: from eggs.gnu.org ([2001:4830:134:3::10]:40728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqh9-0006rP-R1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVqh6-0001oG-Lm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:51:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVqh6-0001o6-Cg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:51:04 -0400
Date: Fri, 14 Jul 2017 10:51:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714025100.GC27284@pxdev.xzpeter.org>
References: <20170704184915.31586-1-dgilbert@redhat.com>
	<20170704184915.31586-3-dgilbert@redhat.com>
	<20170712032046.GD29326@pxdev.xzpeter.org>
	<20170712110021.GA30658@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170712110021.GA30658@work-vm>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Close file on failed
 migration load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Wed, Jul 12, 2017 at 12:00:22PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Jul 04, 2017 at 07:49:12PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Closing the file before exit on a failure allows
> > > the source to cleanup better, especially with RDMA.
> > > 
> > > Partial fix for https://bugs.launchpad.net/qemu/+bug/1545052
> > 
> > In above bug reported, the issue is that both dst and src VMs hanged
> > when migration failed (which is a by-design failure). On destination,
> > it hangs at (copied from the link):
> > 
> > #0 0x00007ffff39141cd in write () at ../sysdeps/unix/syscall-template.S:81
> > #1 0x00007ffff27fe795 in rdma_get_cm_event.part.15 () from /lib64/librdmacm.so.1
> > #2 0x000055555593e445 in qemu_rdma_cleanup (rdma=0x7fff9647e010) at migration/rdma.c:2210
> > #3 0x000055555593ea45 in qemu_rdma_close (opaque=0x555557796770) at migration/rdma.c:2652
> > #4 0x00005555559397cc in qemu_fclose (f=f@entry=0x5555564b1450) at migration/qemu-file.c:270
> > #5 0x0000555555936b88 in process_incoming_migration_co (opaque=0x5555564b1450) at migration/migration.c:361
> > #6 0x0000555555a25a1a in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:79
> > #7 0x00007fffef5b3110 in ?? () from /lib64/libc.so.6
> > 
> > So looks like at that time we have qemu_fclose() for the incoming fd,
> > and that's the thing that caused trouble.
> 
> I never saw that hang in the current world; I saw the source hang
> rather than the destination.   A hung destination is annoying but
> since it's a failed migration anyway it's no big problem; the much
> bigger problem is a failed migration which breaks the source.
> 
> > (just to mention that the version caused failure is commit fc1ec1acf,
> >  which is mentioned in the first comment in the bz)
> > 
> > Now the situation is: we don't have qemu_flose() now in current QEMU
> > master on the failure path (see below, we just exit() directly). Then
> > would the bz still valid now? And, if we apply this fix (then we do
> > qemu_fclose() again), would it hang again instead of fixing anything?
> 
> It doesn't seem to - but the big benefit we get from doing the close
> is that we trigger the 'Early Error. Sending error.' case in
> qemu_rdma_cleanup - by sending that error flag we cause the
> received_error flag to be set on the source, and that causes the
> migration to cleanly fail.
> 
> Also, since it sets that received_error flag on the source, my patch 3/5
> would exit it's qemu_rdma_wait_comp_channel loop so theoretically the
> other side of the hang seen in lp1545052 couldn't happen.

I see. Thanks.

I see there is a new version of the series. Will reply in that thread.

-- 
Peter Xu

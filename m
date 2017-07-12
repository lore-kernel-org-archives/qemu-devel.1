Received: from eggs.gnu.org ([2001:4830:134:3::10]:35210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVFNh-0002wX-Sc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVFNd-00058L-P4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVFNd-000586-FY
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:00:29 -0400
Date: Wed, 12 Jul 2017 12:00:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170712110021.GA30658@work-vm>
References: <20170704184915.31586-1-dgilbert@redhat.com>
	<20170704184915.31586-3-dgilbert@redhat.com>
	<20170712032046.GD29326@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712032046.GD29326@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, lvivier@redhat.com, berrange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Jul 04, 2017 at 07:49:12PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Closing the file before exit on a failure allows
> > the source to cleanup better, especially with RDMA.
> > 
> > Partial fix for https://bugs.launchpad.net/qemu/+bug/1545052
> 
> In above bug reported, the issue is that both dst and src VMs hanged
> when migration failed (which is a by-design failure). On destination,
> it hangs at (copied from the link):
> 
> #0 0x00007ffff39141cd in write () at ../sysdeps/unix/syscall-template.S:81
> #1 0x00007ffff27fe795 in rdma_get_cm_event.part.15 () from /lib64/librdmacm.so.1
> #2 0x000055555593e445 in qemu_rdma_cleanup (rdma=0x7fff9647e010) at migration/rdma.c:2210
> #3 0x000055555593ea45 in qemu_rdma_close (opaque=0x555557796770) at migration/rdma.c:2652
> #4 0x00005555559397cc in qemu_fclose (f=f@entry=0x5555564b1450) at migration/qemu-file.c:270
> #5 0x0000555555936b88 in process_incoming_migration_co (opaque=0x5555564b1450) at migration/migration.c:361
> #6 0x0000555555a25a1a in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:79
> #7 0x00007fffef5b3110 in ?? () from /lib64/libc.so.6
> 
> So looks like at that time we have qemu_fclose() for the incoming fd,
> and that's the thing that caused trouble.

I never saw that hang in the current world; I saw the source hang
rather than the destination.   A hung destination is annoying but
since it's a failed migration anyway it's no big problem; the much
bigger problem is a failed migration which breaks the source.

> (just to mention that the version caused failure is commit fc1ec1acf,
>  which is mentioned in the first comment in the bz)
> 
> Now the situation is: we don't have qemu_flose() now in current QEMU
> master on the failure path (see below, we just exit() directly). Then
> would the bz still valid now? And, if we apply this fix (then we do
> qemu_fclose() again), would it hang again instead of fixing anything?

It doesn't seem to - but the big benefit we get from doing the close
is that we trigger the 'Early Error. Sending error.' case in
qemu_rdma_cleanup - by sending that error flag we cause the
received_error flag to be set on the source, and that causes the
migration to cleanly fail.

Also, since it sets that received_error flag on the source, my patch 3/5
would exit it's qemu_rdma_wait_comp_channel loop so theoretically the
other side of the hang seen in lp1545052 couldn't happen.

Dave

> 
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/migration.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 51ccd1a4c5..21d6902a29 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -355,6 +355,7 @@ static void process_incoming_migration_co(void *opaque)
> >                            MIGRATION_STATUS_FAILED);
> >          error_report("load of migration failed: %s", strerror(-ret));
> >          migrate_decompress_threads_join();
> > +        qemu_fclose(mis->from_src_file);
> >          exit(EXIT_FAILURE);
> >      }
> >  
> > -- 
> > 2.13.0
> > 
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

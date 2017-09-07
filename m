Received: from eggs.gnu.org ([2001:4830:134:3::10]:56937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dpvWS-00042I-Sz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dpvWN-0005P4-Kn
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dpvWN-0005OQ-C7
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:02:59 -0400
Date: Thu, 7 Sep 2017 20:02:27 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170907120227.GE23040@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170906145043.GG15535@stefanha-x1.localdomain>
	<20170906151436.GF2215@work-vm>
	<CAJSP0QUu45oPTL2JErTWAt7OFrHpcB-88EvGBwVAKxn0CE=ebg@mail.gmail.com>
	<20170907093546.GE2098@work-vm>
	<CAJSP0QWA2gci=PxKDVEWQNhxDv-9pDdJzyWdQut=Zkr+rCb+3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QWA2gci=PxKDVEWQNhxDv-9pDdJzyWdQut=Zkr+rCb+3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Sep 07, 2017 at 11:09:29AM +0100, Stefan Hajnoczi wrote:
> On Thu, Sep 7, 2017 at 10:35 AM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> > * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> >> On Wed, Sep 6, 2017 at 4:14 PM, Dr. David Alan Gilbert
> >> <dgilbert@redhat.com> wrote:
> >> > * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> >> >> On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> >> >> > The root problem is that, monitor commands are all handled in main
> >> >> > loop thread now, no matter how many monitors we specify. And, if main
> >> >> > loop thread hangs due to some reason, all monitors will be stuck.
> >> >>
> >> >> I see a larger issue with postcopy: existing QEMU code assumes that
> >> >> guest memory access is instantaneous.
> >> >>
> >> >> Postcopy breaks this assumption and introduces blocking points that can
> >> >> now take unbounded time.
> >> >>
> >> >> This problem isn't specific to the monitor.  It can also happen to other
> >> >> components in QEMU like the gdbstub.
> >> >>
> >> >> Do we need an asynchronous memory API?  Synchronous memory access should
> >> >> only be allowed in vcpu threads.
> >> >
> >> > It would probably be useful for gdbstub where the overhead of async
> >> > doesn't matter;  but doing that for all IO emulation is hard.
> >>
> >> Why is it hard?
> >>
> >> Memory access can be synchronous in the vcpu thread.  That eliminates
> >> a lot of code straight away.
> >>
> >> Anything using dma-helpers.c is already async.  They just don't know
> >> that the memory access part is being made async too :).
> >
> > Can you point me to some info on that ?
> 
> IDE and SCSI use dma-helpers.c to perform I/O:
> hw/ide/core.c:892:        s->bus->dma->aiocb =
> dma_blk_io(blk_get_aio_context(s->blk),
> hw/ide/macio.c:189:        s->bus->dma->aiocb =
> dma_blk_io(blk_get_aio_context(s->blk), &s->sg,
> hw/scsi/scsi-disk.c:348:        r->req.aiocb =
> dma_blk_io(blk_get_aio_context(s->qdev.conf.blk),
> hw/scsi/scsi-disk.c:551:        r->req.aiocb =
> dma_blk_io(blk_get_aio_context(s->qdev.conf.blk),
> 
> They pass a scatter-gather list of guest RAM addresses to
> dma-helpers.c.  They receive a callback when I/O has finished.
> 
> Try following the code path.  Request submission may be from a vcpu
> thread or IOThread.  Completion occurs in the main loop or an
> IOThread.
> 
> The main point is that this API is already asynchronous.  If any
> changes are needed for async guest memory access (not sure, I haven't
> checked), then at least the dma-helpers.c users do not need to be
> modified.
> 
> >> The remaining cases are virtio and some other devices.
> >>
> >> If you are worried about performance, the first rule is that async
> >> memory access is only needed on the destination side when post-copy is
> >> active.  Maybe use setjmp to return from the signal handler and queue
> >> a callback for when the page has been loaded.
> >
> > I'm not sure it's worth trying to be too clever at avoiding this;
> > I see the fact that we're doing IO with the bql held as a more
> > fundamental problem.
> 
> QEMU should be doing I/O syscalls in async fashion or threadpool
> workers (no BQL) so the BQL is not an issue.  Anything else could
> cause unbounded waits even without postcopy.

E.g. when vcpu got page faulted with BQL taken, while the main thread
needs the BQL to dispatch anything, including monitor commands.

So I think it's a multiplex problem - we need to solve both (1) main
thread accessing guest memories which is still missing, and (2) BQL
deadlocks between vcpu threads and main thread.

Thanks,

-- 
Peter Xu

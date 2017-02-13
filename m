Received: from eggs.gnu.org ([2001:4830:134:3::10]:45896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdLAY-0002j7-GN
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:16:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdLAV-00047W-9D
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:16:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdLAV-00047I-0F
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 13:16:07 -0500
Date: Mon, 13 Feb 2017 18:16:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170213181601.GG3086@work-vm>
References: <20170206173306.20603-1-dgilbert@redhat.com>
	<20170206174529.GI2524@work-vm>
	<CGME20170213171108eucas1p147999fc8b6980ff89a67626b78b12e44@eucas1p1.samsung.com>
	<20170213171058.GA4246@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213171058.GA4246@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Postcopy: Hugepage support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, aarcange@redhat.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
>  Hello David!

Hi Alexey,

> I have checked you series with 1G hugepage, but only in 1 Gbit/sec network
> environment.

Can you show the qemu command line you're using?  I'm just trying
to make sure I understand where your hugepages are; running 1G hostpages
across a 1Gbit/sec network for postcopy would be pretty poor - it would take
~10 seconds to transfer the page.

> I started Ubuntu just with console interface and gave to it only 1G of
> RAM, inside Ubuntu I started stress command

> (stress --cpu 4 --io 4 --vm 4 --vm-bytes 256000000 &)
> in such environment precopy live migration was impossible, it never
> being finished, in this case it infinitely sends pages (it looks like
> dpkg scenario).
> 
> Also I modified stress utility
> http://people.seas.harvard.edu/~apw/stress/stress-1.0.4.tar.gz
> due to it wrote into memory every time the same value `Z`. My
> modified version writes every allocation new incremented value.

I use google's stressapptest normally; although remember to turn
off the bit where it pauses.

> I'm using Arcangeli's kernel only at the destination.
> 
> I got controversial results. Downtime for 1G hugepage is close to 2Mb
> hugepage and it took around 7 ms (in 2Mb hugepage scenario downtime was
> around 8 ms).
> I made that opinion by query-migrate.
> {"return": {"status": "completed", "setup-time": 6, "downtime": 6, "total-time": 9668, "ram": {"total": 1091379200, "postcopy-requests": 1, "dirty-sync-count": 2, "remaining": 0, "mbps": 879.786851, "transferred": 1063007296, "duplicate": 7449, "dirty-pages-rate": 0, "skipped": 0, "normal-bytes": 1060868096, "normal": 259001}}}
> 
> Documentation says about downtime field - measurement unit is ms.

The downtime measurement field is pretty meaningless for postcopy; it's only
the time from stopping the VM until the point where we tell the destination it
can start running.  Meaningful measurements are only from inside the guest
really, or the place latencys.

> So I traced it (I added additional trace into postcopy_place_page
> trace_postcopy_place_page_start(host, from, pagesize); )
> 
> postcopy_ram_fault_thread_request Request for HVA=7f6dc0000000 rb=/objects/mem offset=0
> postcopy_place_page_start host=0x7f6dc0000000 from=0x7f6d70000000, pagesize=40000000
> postcopy_place_page_start host=0x7f6e0e800000 from=0x55b665969619, pagesize=1000
> postcopy_place_page_start host=0x7f6e0e801000 from=0x55b6659684e8, pagesize=1000
> several pages with 4Kb step ...
> postcopy_place_page_start host=0x7f6e0e817000 from=0x55b6659694f0, pagesize=1000
> 
> 4K pages, started from 0x7f6e0e800000 address it's
> vga.ram, /rom@etc/acpi/tables etc.
> 
> Frankly saying, right now, I don't have any ideas why hugepage wasn't
> resent. Maybe my expectation of it is wrong as well as understanding )

That's pretty much what I expect to see - before you get into postcopy
mode everything is sent as individual 4k pages (in order); once we're
in postcopy mode we send each page no more than once.  So you're
huge page comes across once - and there it is.

> stress utility also duplicated for me value into appropriate file:
> sec_since_epoch.microsec:value
> 1487003192.728493:22
> 1487003197.335362:23
> *1487003213.367260:24*
> *1487003238.480379:25*
> 1487003243.315299:26
> 1487003250.775721:27
> 1487003255.473792:28
> 
> It mean rewriting 256Mb of memory per byte took around 5 sec, but at
> the moment of migration it took 25 sec.

right, now this is the thing that's more useful to measure.
That's not too surprising; when it migrates that data is changing rapidly
so it's going to have to pause and wait for that whole 1GB to be transferred.
Your 1Gbps network is going to take about 10 seconds to transfer that
1GB page - and that's if you're lucky and it saturates the network.
SO it's going to take at least 10 seconds longer than it normally
would, plus any other overheads - so at least 15 seconds.
This is why I say it's a bad idea to use 1GB host pages with postcopy.
Of course it would be fun to find where the other 10 seconds went!

You might like to add timing to the tracing so you can see the time between the
fault thread requesting the page and it arriving.

> Another one request.
> QEMU could use mem_path in hugefs with share key simultaneously
> (-object memory-backend-file,id=mem,size=${mem_size},mem-path=${mem_path},share=on) and vm
> in this case will start and will properly work (it will allocate memory
> with mmap), but in case of destination for postcopy live migration
> UFFDIO_COPY ioctl will fail for
> such region, in Arcangeli's git tree there is such prevent check
> (if (!vma_is_shmem(dst_vma) && dst_vma->vm_flags & VM_SHARED).
> Is it possible to handle such situation at qemu?

Imagine that you had shared memory; what semantics would you like
to see ?  What happens to the other process?

Dave

> On Mon, Feb 06, 2017 at 05:45:30PM +0000, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Hi,
> > >   The existing postcopy code, and the userfault kernel
> > > code that supports it, only works for normal anonymous memory.
> > > Kernel support for userfault on hugetlbfs is working
> > > it's way upstream; it's in the linux-mm tree,
> > > You can get a version at:
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git
> > > on the origin/userfault branch.
> > > 
> > > Note that while this code supports arbitrary sized hugepages,
> > > it doesn't make sense with pages above the few-MB region,
> > > so while 2MB is fine, 1GB is probably a bad idea;
> > > this code waits for and transmits whole huge pages, and a
> > > 1GB page would take about 1 second to transfer over a 10Gbps
> > > link - which is way too long to pause the destination for.
> > > 
> > > Dave
> > 
> > Oops I missed the v2 changes from the message:
> > 
> > v2
> >   Flip ram-size summary word/compare individual page size patches around
> >   Individual page size comparison is done in ram_load if 'advise' has been
> >     received rather than checking migrate_postcopy_ram()
> >   Moved discard code into exec.c, reworked ram_discard_range
> > 
> > Dave
> 
> Thank your, right now it's not necessary to set
> postcopy-ram capability on destination machine.
> 
> 
> > 
> > > Dr. David Alan Gilbert (16):
> > >   postcopy: Transmit ram size summary word
> > >   postcopy: Transmit and compare individual page sizes
> > >   postcopy: Chunk discards for hugepages
> > >   exec: ram_block_discard_range
> > >   postcopy: enhance ram_block_discard_range for hugepages
> > >   Fold postcopy_ram_discard_range into ram_discard_range
> > >   postcopy: Record largest page size
> > >   postcopy: Plumb pagesize down into place helpers
> > >   postcopy: Use temporary for placing zero huge pages
> > >   postcopy: Load huge pages in one go
> > >   postcopy: Mask fault addresses to huge page boundary
> > >   postcopy: Send whole huge pages
> > >   postcopy: Allow hugepages
> > >   postcopy: Update userfaultfd.h header
> > >   postcopy: Check for userfault+hugepage feature
> > >   postcopy: Add doc about hugepages and postcopy
> > > 
> > >  docs/migration.txt                |  13 ++++
> > >  exec.c                            |  83 +++++++++++++++++++++++
> > >  include/exec/cpu-common.h         |   2 +
> > >  include/exec/memory.h             |   1 -
> > >  include/migration/migration.h     |   3 +
> > >  include/migration/postcopy-ram.h  |  13 ++--
> > >  linux-headers/linux/userfaultfd.h |  81 +++++++++++++++++++---
> > >  migration/migration.c             |   1 +
> > >  migration/postcopy-ram.c          | 138 +++++++++++++++++---------------------
> > >  migration/ram.c                   | 109 ++++++++++++++++++------------
> > >  migration/savevm.c                |  32 ++++++---
> > >  migration/trace-events            |   2 +-
> > >  12 files changed, 328 insertions(+), 150 deletions(-)
> > > 
> > > -- 
> > > 2.9.3
> > > 
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

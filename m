Received: from eggs.gnu.org ([2001:4830:134:3::10]:46846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOOmc-0006yD-U3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOOmb-00030o-KX
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:42:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOOmb-00030e-Dz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:42:29 -0400
Date: Thu, 31 May 2018 15:42:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180531144217.GE2755@work-vm>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<20180531131858.GL27838@stefanha-x1.localdomain>
	<HK2PR06MB05315C48C2D953449EC5A0A7EB630@HK2PR06MB0531.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK2PR06MB05315C48C2D953449EC5A0A7EB630@HK2PR06MB0531.apcprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Junyan He <junyan.he@gmx.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Haozhong Zhang <haozhong.zhang@intel.com>, "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>, "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, Junyan He <junyan.he@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

* Junyan He (junyan.he@gmx.com) wrote:
> > Also, there was a discussion about leaving the code unchanged but adding
> > an nvdimm_flush() call at the very end of migration.  I think someone
> > benchmarked it but can't find the email.  Please post a link or
> > summarize the results, because that approach would be much less
> > invasive.  Thanks!
> 
> 
> And previous comments:
> 
> 
> > > > 2. The migration/ram code is invasive.  Is it really necessary to
> > > >    persist data each time pages are loaded from a migration stream?  It
> > > >    seems simpler to migrate as normal and call pmem_persist() just once
> > > >    after RAM has been migrated but before the migration completes.
> > >
> > > The concern is about the overhead of cache flush.
> > >
> > > In this patch series, if possible, QEMU will use pmem_mem{set,cpy}_nodrain
> > > APIs to copy NVDIMM blocks. Those APIs use movnt (if it's available) and
> > > can avoid the subsequent cache flush.
> > >
> > > Anyway, I'll make some microbenchmark to check which one will be better.
> 
> > The problem is not just the overhead; the problem is the code
> > complexity; this series makes all the paths through the migration code
> > more complex in places we wouldn't expect to change.
> 
> I already use the migration info tool and list the result in the Mail just after this patch set sent:
> 
> Disable all haozhong's pmem_drain and  pmem_memset_nodrain  kind function call
> and make the cleanup function do the flush job like this:
> 
> static int ram_load_cleanup(void *opaque)
> {
>     RAMBlock *rb;
>     RAMBLOCK_FOREACH(rb) {
>         if (ramblock_is_pmem(rb)) {
>             pmem_persist(rb->host, rb->used_length);
>          }
>     }
> 
>     xbzrle_load_cleanup();
>     compress_threads_load_cleanup();
> 
>     RAMBLOCK_FOREACH(rb) {
>         g_free(rb->receivedmap);
>         rb->receivedmap = NULL;
>     }
>     return 0;
> }
> 
> 
> The migrate info result is:
> 
> Haozhong's Manner
> 
> (qemu) migrate -d tcp:localhost:4444
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
> Migration status: completed
> total time: 333668 milliseconds
> downtime: 17 milliseconds
> setup: 50 milliseconds
> transferred ram: 10938039 kbytes
> throughput: 268.55 mbps
> remaining ram: 0 kbytes
> total ram: 11027272 kbytes
> duplicate: 35533 pages
> skipped: 0 pages
> normal: 2729095 pages
> normal bytes: 10916380 kbytes
> dirty sync count: 4
> page size: 4 kbytes
> (qemu)
> 
> 
> flush before complete
> 
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu) migrate -d tcp:localhost:4444
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> send-configuration: on
> send-section-footer: on
> capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-blocks: off compress: off events: off postcopy-ram: off x-colo: off release-ram: off block: off return-path: off pause-before-switchover: off x-multifd: off dirty-bitmaps: off postcopy-blocktime: off
> Migration status: completed
> total time: 334836 milliseconds
> downtime: 17 milliseconds
> setup: 49 milliseconds
> transferred ram: 10978886 kbytes
> throughput: 268.62 mbps
> remaining ram: 0 kbytes
> total ram: 11027272 kbytes
> duplicate: 23149 pages
> skipped: 0 pages
> normal: 2739314 pages
> normal bytes: 10957256 kbytes
> dirty sync count: 4
> page size: 4 kbytes
> (qemu)
> 
> 
> So Haozhong's manner seems to be a little faster and I choose to keep that.
> 
> If you want to choose this manner, the code will be clean and no need for
> 
> >   typedef struct {
> >       void (*memset)(void *s, int c, size_t n);
> >       void (*memcpy)(void *dest, const void *src, size_t n);
> >   } MemoryOperations;
> 
> 
> performance is close, and I am a little new in Qemu:), so both options are OK for me,
> 
> Which one do you prefer to?

The one with the least impact;  the migration code is getting more and
more complex, so having to do the 'if (is_pmem)' check everywhere isn't
nice,  passing an 'ops' pointer in is better.  However if you can do the
'flush before complete' instead then the amount of code change is a LOT
smaller.
The only other question is whether from your pmem view, the
flush-before-complete causes any problems;  in the worst case, how long
could the flush take?

Dave

> ________________________________
> From: Stefan Hajnoczi <stefanha@gmail.com>
> Sent: Thursday, May 31, 2018 1:18:58 PM
> To: junyan.he@gmx.com
> Cc: qemu-devel@nongnu.org; Haozhong Zhang; xiaoguangrong.eric@gmail.com; crosthwaite.peter@gmail.com; mst@redhat.com; dgilbert@redhat.com; ehabkost@redhat.com; quintela@redhat.com; Junyan He; stefanha@redhat.com; pbonzini@redhat.com; imammedo@redhat.com; rth@twiddle.net
> Subject: Re: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of QEMU writes to persistent memory
> 
> David Gilbert previously suggested a memory access interface.  I guess
> it would look something like this:
> 
>   typedef struct {
>       void (*memset)(void *s, int c, size_t n);
>       void (*memcpy)(void *dest, const void *src, size_t n);
>   } MemoryOperations;
> 
> That way code doesn't need if (pmem) A else B.  It can just do
> mem_ops->foo().  Have you looked into this idea?
> 
> Also, there was a discussion about leaving the code unchanged but adding
> an nvdimm_flush() call at the very end of migration.  I think someone
> benchmarked it but can't find the email.  Please post a link or
> summarize the results, because that approach would be much less
> invasive.  Thanks!
> 
> Stefan
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

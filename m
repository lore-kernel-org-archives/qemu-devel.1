Received: from eggs.gnu.org ([2001:4830:134:3::10]:58178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dBFhm-0004EQ-3U
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dBFhi-0002X8-RI
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:18:38 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:33063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dBFhi-0002Wc-Gp
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:18:34 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQ5007OF0AS0440@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Thu, 18 May 2017 08:18:28 +0100 (BST)
Date: Thu, 18 May 2017 10:18:24 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170518071824.GB8752@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170516113416.GD2839@work-vm>
References: <1494595886-30912-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170512133147eucas1p1eaa21aac3a0b9d45be0ef8ea903b6824@eucas1p1.samsung.com>
	<1494595886-30912-8-git-send-email-a.perevalov@samsung.com>
	<20170516113416.GD2839@work-vm>
Subject: Re: [Qemu-devel] [PATCH V5 7/9] migration: calculate vCPU blocktime
 on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, peterx@redhat.com

On Tue, May 16, 2017 at 12:34:16PM +0100, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > This patch provides blocktime calculation per vCPU,
> > as a summary and as a overlapped value for all vCPUs.
> > 
> > This approach was suggested by Peter Xu, as an improvements of
> > previous approch where QEMU kept tree with faulted page address and cpus bitmask
> > in it. Now QEMU is keeping array with faulted page address as value and vCPU
> > as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> > list for blocktime per vCPU (could be traced with page_fault_addr)
> > 
> > Blocktime will not calculated if postcopy_blocktime field of
> > MigrationIncomingState wasn't initialized.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> 
> I have some multi-threading/ordering worries still.
> 
> The fault thread receives faults over the ufd and calls
> mark_postcopy_blocktime_being.  That's fine.
> 
> The receiving thread receives pages, calls place page, and
> calls mark_postcopy_blocktime_end.  That's also fine.
> 
> However, remember that we send pages from the source without
> them being requested as background transfers; consider:
> 
> 
>     Source           receive-thread          fault-thread
> 
>   1  Send A
>   2                  Receive A
>   3                                            Access A
>   4                                            Report on UFD
>   5                  Place
>   6                                            Read UFD entry
> 
> 
>  Placing and reading UFD race - and up till now that's been fine;
> so we can read off the ufd an address that's already on it's way from
> the source, and which we might just be receiving, or that we might
> have already placed.
> 
> In this code at (6) won't you call mark_postcopy_blocktime_start
> even though it's already been placed at (5) ? Then that blocktime
> will stay set until the end of the run?
> 
> Perhaps that's not a problem; if mark_postcopy_blocktime_end is called
> for a different address it wont count the blocktime; and when
> mark_postcopy_blocktime_start is called for a different address it'll
> remove the addres that was a problem above - so perhaps that's fine?
It's not 100% fine, but I'm going to clarify my previous answer to that
email where I wrote "forever". That mechanism will think vCPU is blocked
until the same vCPU will block/page copied again.
Unfortunately we don't know vCPU index at *_end time, and I don't want
to extend struct uffdio_copy and add pid into it. But now I have only
expensive and robust or not expensive and not robust solution, like
keeping list of page addressed which was faulted (or just one page
address, the latest, taking into account _end, _start sequence should be
quick, and no other pages interpose, but it's assumption).

BTW with tree based solution, proposed in the first version, was possible to
lookup node by pageaddr in _end and mark it as populated.



> 
> 
> > ---
> >  migration/postcopy-ram.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++-
> >  migration/trace-events   |  5 ++-
> >  2 files changed, 90 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index a1f1705..e2660ae 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -23,6 +23,7 @@
> >  #include "migration/postcopy-ram.h"
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/balloon.h"
> > +#include <sys/param.h>
> >  #include "qemu/error-report.h"
> >  #include "trace.h"
> >  
> > @@ -542,6 +543,86 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
> >      return 0;
> >  }
> >  
> > +static int get_mem_fault_cpu_index(uint32_t pid)
> > +{
> > +    CPUState *cpu_iter;
> > +
> > +    CPU_FOREACH(cpu_iter) {
> > +        if (cpu_iter->thread_id == pid) {
> > +            return cpu_iter->cpu_index;
> > +        }
> > +    }
> > +    trace_get_mem_fault_cpu_index(pid);
> > +    return -1;
> > +}
> > +
> > +static void mark_postcopy_blocktime_begin(uint64_t addr, int cpu)
> > +{
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    PostcopyBlocktimeContext *dc;
> > +    int64_t now_ms;
> > +    if (!mis->blocktime_ctx || cpu < 0) {
> > +        return;
> > +    }
> 
> You might consider:
> 
>  PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>  int64_t now_ms;
>  if (!dc || cpu < 0) {
>      return;
>  }
> 
> it gets rid of the two reads of mis->blocktime_ctx
> (You do something similar in a few places)
> 
> > +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > +    dc = mis->blocktime_ctx;
> > +    if (dc->vcpu_addr[cpu] == 0) {
> > +        atomic_inc(&dc->smp_cpus_down);
> > +    }
> > +
> > +    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
> > +    atomic_xchg__nocheck(&dc->last_begin, now_ms);
> > +    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
> > +
> > +    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
> > +            cpu);
> > +}
> > +
> > +static void mark_postcopy_blocktime_end(uint64_t addr)
> > +{
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    PostcopyBlocktimeContext *dc;
> > +    int i, affected_cpu = 0;
> > +    int64_t now_ms;
> > +    bool vcpu_total_blocktime = false;
> > +
> > +    if (!mis->blocktime_ctx) {
> > +        return;
> > +    }
> > +    dc = mis->blocktime_ctx;
> > +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > +
> > +    /* lookup cpu, to clear it,
> > +     * that algorithm looks straighforward, but it's not
> > +     * optimal, more optimal algorithm is keeping tree or hash
> > +     * where key is address value is a list of  */
> > +    for (i = 0; i < smp_cpus; i++) {
> > +        uint64_t vcpu_blocktime = 0;
> > +        if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr) {
> > +            continue;
> > +        }
> > +        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
> > +        vcpu_blocktime = now_ms -
> > +            atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
> > +        affected_cpu += 1;
> > +        /* we need to know is that mark_postcopy_end was due to
> > +         * faulted page, another possible case it's prefetched
> > +         * page and in that case we shouldn't be here */
> > +        if (!vcpu_total_blocktime &&
> > +            atomic_fetch_add(&dc->smp_cpus_down, 0) == smp_cpus) {
> > +            vcpu_total_blocktime = true;
> > +        }
> > +        /* continue cycle, due to one page could affect several vCPUs */
> > +        dc->vcpu_blocktime[i] += vcpu_blocktime;
> > +    }
> > +
> > +    atomic_sub(&dc->smp_cpus_down, affected_cpu);
> > +    if (vcpu_total_blocktime) {
> > +        dc->total_blocktime += now_ms - atomic_fetch_add(&dc->last_begin, 0);
> 
> This total_blocktime calculation is a little odd; the 'last_begin' is
> not necessarily related to the same CPU or same block.
> 
> Dave
> 
> > +    }
> > +    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime);
> > +}
> > +
> >  /*
> >   * Handle faults detected by the USERFAULT markings
> >   */
> > @@ -619,8 +700,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >          rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
> >          trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
> >                                                  qemu_ram_get_idstr(rb),
> > -                                                rb_offset);
> > +                                                rb_offset,
> > +                                                msg.arg.pagefault.feat.ptid);
> >  
> > +        mark_postcopy_blocktime_begin((uintptr_t)(msg.arg.pagefault.address),
> > +                         get_mem_fault_cpu_index(msg.arg.pagefault.feat.ptid));
> >          /*
> >           * Send the request to the source - we want to request one
> >           * of our host page sizes (which is >= TPS)
> > @@ -715,6 +799,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> >  
> >          return -e;
> >      }
> > +    mark_postcopy_blocktime_end((uint64_t)(uintptr_t)host);
> >  
> >      trace_postcopy_place_page(host);
> >      return 0;
> > diff --git a/migration/trace-events b/migration/trace-events
> > index b8f01a2..9424e3e 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -110,6 +110,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> >  process_incoming_migration_co_postcopy_end_main(void) ""
> >  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> >  migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> > +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
> > +mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time) "addr 0x%" PRIx64 " dd %p time %" PRId64
> >  
> >  # migration/rdma.c
> >  qemu_rdma_accept_incoming_migration(void) ""
> > @@ -186,7 +188,7 @@ postcopy_ram_enable_notify(void) ""
> >  postcopy_ram_fault_thread_entry(void) ""
> >  postcopy_ram_fault_thread_exit(void) ""
> >  postcopy_ram_fault_thread_quit(void) ""
> > -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
> > +postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=%" PRIx64 " rb=%s offset=%zx %u"
> >  postcopy_ram_incoming_cleanup_closeuf(void) ""
> >  postcopy_ram_incoming_cleanup_entry(void) ""
> >  postcopy_ram_incoming_cleanup_exit(void) ""
> > @@ -195,6 +197,7 @@ save_xbzrle_page_skipping(void) ""
> >  save_xbzrle_page_overflow(void) ""
> >  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> >  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
> > +get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
> >  
> >  # migration/exec.c
> >  migration_exec_outgoing(const char *cmd) "cmd=%s"
> > -- 
> > 1.9.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

-- 

BR
Alexey

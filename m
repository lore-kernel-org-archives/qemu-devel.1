Received: from eggs.gnu.org ([2001:4830:134:3::10]:55640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDR6e-0002Gq-8E
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDR6Z-0007tY-HH
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:53:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDR6Z-0007tD-78
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:53:15 -0400
Date: Wed, 24 May 2017 15:53:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170524075305.GG3873@pxdev.xzpeter.org>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113131eucas1p24a041de6004237e437f97a24340507e2@eucas1p2.samsung.com>
	<1495539071-12995-9-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495539071-12995-9-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V6 08/10] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, eblake@redhat.com, dgilbert@redhat.com

On Tue, May 23, 2017 at 02:31:09PM +0300, Alexey Perevalov wrote:
> This patch provides blocktime calculation per vCPU,
> as a summary and as a overlapped value for all vCPUs.
> 
> This approach was suggested by Peter Xu, as an improvements of
> previous approch where QEMU kept tree with faulted page address and cpus bitmask
> in it. Now QEMU is keeping array with faulted page address as value and vCPU
> as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> list for blocktime per vCPU (could be traced with page_fault_addr)
> 
> Blocktime will not calculated if postcopy_blocktime field of
> MigrationIncomingState wasn't initialized.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  migration/postcopy-ram.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++-
>  migration/trace-events   |   5 ++-
>  2 files changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index d647769..e70c44b 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -23,6 +23,7 @@
>  #include "postcopy-ram.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/balloon.h"
> +#include <sys/param.h>
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  
> @@ -577,6 +578,101 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
>      return 0;
>  }
>  
> +static int get_mem_fault_cpu_index(uint32_t pid)
> +{
> +    CPUState *cpu_iter;
> +
> +    CPU_FOREACH(cpu_iter) {
> +        if (cpu_iter->thread_id == pid) {
> +            return cpu_iter->cpu_index;
> +        }
> +    }
> +    trace_get_mem_fault_cpu_index(pid);
> +    return -1;
> +}
> +
> +static void mark_postcopy_blocktime_begin(uint64_t addr, uint32_t ptid,
> +        RAMBlock *rb)
> +{
> +    int cpu;
> +    unsigned long int nr_bit;
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
> +    int64_t now_ms;
> +
> +    if (!dc || ptid == 0) {
> +        return;
> +    }
> +    cpu = get_mem_fault_cpu_index(ptid);
> +    if (cpu < 0) {
> +        return;
> +    }
> +    nr_bit = get_copied_bit_offset(addr);
> +    if (test_bit(nr_bit, mis->copied_pages)) {
> +        return;
> +    }
> +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (dc->vcpu_addr[cpu] == 0) {
> +        atomic_inc(&dc->smp_cpus_down);
> +    }
> +
> +    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
> +    atomic_xchg__nocheck(&dc->last_begin, now_ms);
> +    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);

Looks like this is not what you and Dave have discussed?

(Btw, sorry to have not followed the thread recently, so I just went
 over the discussion again...)

What I see that Dave suggested is (I copied from Dave's email):

blocktime_start:
   set CPU stall address
   check bitmap entry
     if set then zero stall-address

While here it is:

blocktime_start:
   check bitmap entry
     if set then return
   set CPU stall address

I don't think current version can really solve the risk condition. See
this possible sequence:

       receive-thread             fault-thread 
       --------------             ------------
                                  blocktime_start
                                    check bitmap entry,
                                      if set then return
       blocktime_end
         set bitmap entry
         read CPU stall address,
           if none-0 then zero it
                                    set CPU stall address [1]
        
Then imho the address set at [1] will be stall again until forever.

I think we should follow exactly what Dave has suggested.

And.. after a second thought, I am afraid even this would not satisfy
all risk conditions. What if we consider the UFFDIO_COPY ioctl in?
AFAIU after UFFDIO_COPY the faulted vcpu can be running again, then
the question is, can it quickly trigger another page fault?

Firstly, a workable sequence is (adding UFFDIO_COPY ioctl in, and
showing vcpu-thread X as well):

  receive-thread       fault-thread        vcpu-thread X
  --------------       ------------        -------------
                                           fault at addr A1
                       fault_addr[X]=A1
  UFFDIO_COPY page A1
  check fault_addr[X] with A1
    if match, clear fault_addr[X]
                                           vcpu X starts

This is fine.

While since "vcpu X starts" can be right after UFFDIO_COPY, can this
be possible?

  receive-thread       fault-thread        vcpu-thread X
  --------------       ------------        -------------
                                           fault at addr A1
                       fault_addr[X]=A1
  UFFDIO_COPY page A1
                                           vcpu X starts
                                           fault at addr A2
                       fault_addr[X]=A2
  check fault_addr[X] with A1
    if match, clear fault_addr[X]
        ^
        |
        +---------- here it will not match since now fault_addr[X]==A2

Then looks like fault_addr[X], which is currently A1, will stall
again?

(I feel like finally we may need something like a per-cpu lock... or I
 must have missed something)

> +
> +    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
> +            cpu);
> +}
> +
> +static void mark_postcopy_blocktime_end(uint64_t addr)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
> +    int i, affected_cpu = 0;
> +    int64_t now_ms;
> +    bool vcpu_total_blocktime = false;
> +    unsigned long int nr_bit;
> +
> +    if (!dc) {
> +        return;
> +    }
> +    /* mark that page as copied */
> +    nr_bit = get_copied_bit_offset(addr);
> +    set_bit_atomic(nr_bit, mis->copied_pages);
> +
> +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +
> +    /* lookup cpu, to clear it,
> +     * that algorithm looks straighforward, but it's not
> +     * optimal, more optimal algorithm is keeping tree or hash
> +     * where key is address value is a list of  */
> +    for (i = 0; i < smp_cpus; i++) {
> +        uint64_t vcpu_blocktime = 0;
> +        if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr) {
> +            continue;
> +        }
> +        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);

Why use *__nocheck() rather than atomic_xchg() or even atomic_read()?
Same thing happened a lot in current patch.

Thanks,

> +        vcpu_blocktime = now_ms -
> +            atomic_fetch_add(&dc->page_fault_vcpu_time[i], 0);
> +        affected_cpu += 1;
> +        /* we need to know is that mark_postcopy_end was due to
> +         * faulted page, another possible case it's prefetched
> +         * page and in that case we shouldn't be here */
> +        if (!vcpu_total_blocktime &&
> +            atomic_fetch_add(&dc->smp_cpus_down, 0) == smp_cpus) {
> +            vcpu_total_blocktime = true;
> +        }
> +        /* continue cycle, due to one page could affect several vCPUs */
> +        dc->vcpu_blocktime[i] += vcpu_blocktime;
> +    }
> +
> +    atomic_sub(&dc->smp_cpus_down, affected_cpu);
> +    if (vcpu_total_blocktime) {
> +        dc->total_blocktime += now_ms - atomic_fetch_add(&dc->last_begin, 0);
> +    }
> +    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime);
> +}
> +
>  /*
>   * Handle faults detected by the USERFAULT markings
>   */
> @@ -654,8 +750,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
>          rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
>          trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
>                                                  qemu_ram_get_idstr(rb),
> -                                                rb_offset);
> +                                                rb_offset,
> +                                                msg.arg.pagefault.feat.ptid);
>  
> +        mark_postcopy_blocktime_begin((uintptr_t)(msg.arg.pagefault.address),
> +                msg.arg.pagefault.feat.ptid, rb);
>          /*
>           * Send the request to the source - we want to request one
>           * of our host page sizes (which is >= TPS)
> @@ -750,6 +849,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>  
>          return -e;
>      }
> +    mark_postcopy_blocktime_end((uint64_t)(uintptr_t)host);
>  
>      trace_postcopy_place_page(host);
>      return 0;
> diff --git a/migration/trace-events b/migration/trace-events
> index 5b8ccf3..7bdadbb 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -112,6 +112,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
> +mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time) "addr 0x%" PRIx64 " dd %p time %" PRId64
>  
>  # migration/rdma.c
>  qemu_rdma_accept_incoming_migration(void) ""
> @@ -188,7 +190,7 @@ postcopy_ram_enable_notify(void) ""
>  postcopy_ram_fault_thread_entry(void) ""
>  postcopy_ram_fault_thread_exit(void) ""
>  postcopy_ram_fault_thread_quit(void) ""
> -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
> +postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=%" PRIx64 " rb=%s offset=%zx %u"
>  postcopy_ram_incoming_cleanup_closeuf(void) ""
>  postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
> @@ -197,6 +199,7 @@ save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
>  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
>  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
> +get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
>  
>  # migration/exec.c
>  migration_exec_outgoing(const char *cmd) "cmd=%s"
> -- 
> 1.8.3.1
> 

-- 
Peter Xu

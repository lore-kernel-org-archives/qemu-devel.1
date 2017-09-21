Received: from eggs.gnu.org ([2001:4830:134:3::10]:36259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv07E-0006jv-Du
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv079-0004Pk-I2
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:58:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv079-0004Oy-8C
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:57:55 -0400
Date: Thu, 21 Sep 2017 12:57:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921115746.GB2717@work-vm>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164825eucas1p213639e95387bf054270d020f1d7dbfe9@eucas1p2.samsung.com>
	<1505839684-10046-8-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505839684-10046-8-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH v10 07/10] migration: calculate vCPU
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
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
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
>  migration/postcopy-ram.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++-
>  migration/trace-events   |   5 +-
>  2 files changed, 140 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index cc78981..9a5133f 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -110,7 +110,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>  
>      ctx->exit_notifier.notify = migration_exit_cb;
>      qemu_add_exit_notifier(&ctx->exit_notifier);
> -    add_migration_state_change_notifier(&ctx->postcopy_notifier);
>      return ctx;
>  }
>  
> @@ -559,6 +558,136 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
>      return 0;
>  }
>  
> +static int get_mem_fault_cpu_index(uint32_t pid)
> +{
> +    CPUState *cpu_iter;
> +
> +    CPU_FOREACH(cpu_iter) {
> +        if (cpu_iter->thread_id == pid) {
> +            trace_get_mem_fault_cpu_index(cpu_iter->cpu_index, pid);
> +            return cpu_iter->cpu_index;
> +        }
> +    }
> +    trace_get_mem_fault_cpu_index(-1, pid);
> +    return -1;
> +}
> +
> +/*
> + * This function is being called when pagefault occurs. It
> + * tracks down vCPU blocking time.
> + *
> + * @addr: faulted host virtual address
> + * @ptid: faulted process thread id
> + * @rb: ramblock appropriate to addr
> + */
> +static void mark_postcopy_blocktime_begin(uint64_t addr, uint32_t ptid,
> +                                          RAMBlock *rb)
> +{
> +    int cpu, already_received;
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
> +
> +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (dc->vcpu_addr[cpu] == 0) {
> +        atomic_inc(&dc->smp_cpus_down);
> +    }
> +
> +    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
> +    atomic_xchg__nocheck(&dc->last_begin, now_ms);
> +    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
> +
> +    already_received = ramblock_recv_bitmap_test(rb, (void *)addr);
> +    if (already_received) {
> +        atomic_xchg__nocheck(&dc->vcpu_addr[cpu], 0);
> +        atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], 0);
> +        atomic_sub(&dc->smp_cpus_down, 1);
> +    }
> +    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
> +                                        cpu, already_received);
> +}
> +
> +/*
> + *  This function just provide calculated blocktime per cpu and trace it.
> + *  Total blocktime is calculated in mark_postcopy_blocktime_end.
> + *
> + *
> + * Assume we have 3 CPU
> + *
> + *      S1        E1           S1               E1
> + * -----***********------------xxx***************------------------------> CPU1
> + *
> + *             S2                E2
> + * ------------****************xxx---------------------------------------> CPU2
> + *
> + *                         S3            E3
> + * ------------------------****xxx********-------------------------------> CPU3
> + *
> + * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
> + * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
> + * S3,S1,E2 - sequence includes all CPUs, in this case overlap will be S1,E2 -
> + *            it's a part of total blocktime.
> + * S1 - here is last_begin
> + * Legend of the picture is following:
> + *              * - means blocktime per vCPU
> + *              x - means overlapped blocktime (total blocktime)
> + *
> + * @addr: host virtual address
> + */
> +static void mark_postcopy_blocktime_end(uint64_t addr)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
> +    int i, affected_cpu = 0;
> +    int64_t now_ms;
> +    bool vcpu_total_blocktime = false;
> +
> +    if (!dc) {
> +        return;
> +    }
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

Unfortunately this still isn't thread safe; consider the code in
mark_postcopy_blocktime_begin is:

 1 check vcpu_addr
 2 write vcpu_addr
 3 write last_begin
 4 write vcpu_time
 5 smp_cpus_down++

 6  already_received:
 7     write addr = 0
 8     write vcpu_time = 0
 9     smp_cpus_down--

and this code is:
 a check vcpu_addr
 b write vcpu_addr
 c read vcpu_time
 d read smp_cpus_down

 e dec smp_cpus_down

if (a) happens after (2) but before (3), (c) and (d) can also
happen before (3), and so you end up reading a bogus
vcpu_time.

This is tricky to get right; if you changed the source to do:
 1 check vcpu_addr
 3 write last_begin
 4 write vcpu_time
 5 smp_cpus_down++
 2 write vcpu_addr

 6  already_received:
 7     write addr = 0
 8     write vcpu_time = 0
 9     smp_cpus_down--

I think it's safer;  if you read a good vcpu_addr you know
that the vcpu_time has already been written.

However, can this check (a) happen between  the new (2) and (7) ?
It's slim but I think possibly; on the receiving side we've
just set the bitmap flag to say received - if a fault comes
in at about the same time then we could end up with

1,3,4,5,2 ab 6 7 8 9 cde

So again we end up reading a bogus vcpu_time and double decrement
smp_cpus_down.

So I think we have to have:

  a'  read vcpu_addr
  b'  read vcpu_time
  c'  if vcpu_addr == addr && vcpu_time != 0 ...
  d'    clear vcpu_addr
  e'    read/dec smp_cpus_down

You should comment to say where the order is important as well;
because we'll never remember this - it's hairy!
(Better suggestions welcome)

Dave

> +    atomic_sub(&dc->smp_cpus_down, affected_cpu);
> +    if (vcpu_total_blocktime) {
> +        dc->total_blocktime += now_ms - atomic_fetch_add(&dc->last_begin, 0);
> +    }
> +    trace_mark_postcopy_blocktime_end(addr, dc, dc->total_blocktime,
> +                                      affected_cpu);
> +}
> +
>  /*
>   * Handle faults detected by the USERFAULT markings
>   */
> @@ -636,8 +765,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
>          rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
>          trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
>                                                  qemu_ram_get_idstr(rb),
> -                                                rb_offset);
> +                                                rb_offset,
> +                                                msg.arg.pagefault.feat.ptid);
>  
> +        mark_postcopy_blocktime_begin((uintptr_t)(msg.arg.pagefault.address),
> +                                      msg.arg.pagefault.feat.ptid, rb);
>          /*
>           * Send the request to the source - we want to request one
>           * of our host page sizes (which is >= TPS)
> @@ -727,6 +859,8 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
>      if (!ret) {
>          ramblock_recv_bitmap_set_range(rb, host_addr,
>                                         pagesize / qemu_target_page_size());
> +        mark_postcopy_blocktime_end((uint64_t)(uintptr_t)host_addr);
> +
>      }
>      return ret;
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index d2910a6..01f30fe 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -114,6 +114,8 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
>  process_incoming_migration_co_postcopy_end_main(void) ""
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> +mark_postcopy_blocktime_begin(uint64_t addr, void *dd, int64_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", cpu: %d, already_received: %d"
> +mark_postcopy_blocktime_end(uint64_t addr, void *dd, int64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %" PRId64 ", affected_cpu: %d"
>  
>  # migration/rdma.c
>  qemu_rdma_accept_incoming_migration(void) ""
> @@ -190,7 +192,7 @@ postcopy_ram_enable_notify(void) ""
>  postcopy_ram_fault_thread_entry(void) ""
>  postcopy_ram_fault_thread_exit(void) ""
>  postcopy_ram_fault_thread_quit(void) ""
> -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=0x%" PRIx64 " rb=%s offset=0x%zx"
> +postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, uint32_t pid) "Request for HVA=0x%" PRIx64 " rb=%s offset=0x%zx pid=%u"
>  postcopy_ram_incoming_cleanup_closeuf(void) ""
>  postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
> @@ -199,6 +201,7 @@ save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
>  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
>  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
> +get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
>  
>  # migration/exec.c
>  migration_exec_outgoing(const char *cmd) "cmd=%s"
> -- 
> 1.9.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d1dam-0007iF-W2
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 14:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d1daj-00030c-0B
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 14:47:41 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:27869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d1dai-0002zo-KF
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 14:47:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OOR00ML9W77CU40@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 21 Apr 2017 19:47:31 +0100 (BST)
Date: Fri, 21 Apr 2017 21:47:27 +0300
From: Alexey <a.perevalov@samsung.com>
Message-id: <20170421184727.GA17218@aperevalov-ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20170421120031.GB2098@work-vm>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131740eucas1p27eba648b990a93a627265c740e7ff118@eucas1p2.samsung.com>
	<1492175840-5021-5-git-send-email-a.perevalov@samsung.com>
	<20170421120031.GB2098@work-vm>
Subject: Re: [Qemu-devel] [PATCH 4/6] migration: calculate downtime on dst
 side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org

Hello, David!


I apologize, forgot to check patches with checkpatch.pl script, but now I checked,
and I fixed code styles in patches, however I checked also files,
migration.c has code style errors and glib-compat.h too.
I could send that patches to qemu-trivial, if you not against.


On Fri, Apr 21, 2017 at 01:00:32PM +0100, Dr. David Alan Gilbert wrote:
> * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > This patch provides downtime calculation per vCPU,
> > as a summary and as a overlapped value for all vCPUs.
> > 
> > This approach just keeps tree with page fault addr as a key,
> > and t1-t2 interval of pagefault time and page copy time, with
> > affected vCPU bit mask.
> > For more implementation details please see comment to
> > get_postcopy_total_downtime function.
> > 
> > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > ---
> >  include/migration/migration.h |  14 +++
> >  migration/migration.c         | 280 +++++++++++++++++++++++++++++++++++++++++-
> >  migration/postcopy-ram.c      |  24 +++-
> >  migration/qemu-file.c         |   1 -
> >  migration/trace-events        |   9 +-
> >  5 files changed, 323 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > index 5720c88..5d2c628 100644
> > --- a/include/migration/migration.h
> > +++ b/include/migration/migration.h
> > @@ -123,10 +123,24 @@ struct MigrationIncomingState {
> >  
> >      /* See savevm.c */
> >      LoadStateEntry_Head loadvm_handlers;
> > +
> > +    /*
> > +     *  Tree for keeping postcopy downtime,
> > +     *  necessary to calculate correct downtime, during multiple
> > +     *  vm suspends, it keeps host page address as a key and
> > +     *  DowntimeDuration as a data
> > +     *  NULL means kernel couldn't provide process thread id,
> > +     *  and QEMU couldn't identify which vCPU raise page fault
> > +     */
> > +    GTree *postcopy_downtime;
> >  };
> >  
> >  MigrationIncomingState *migration_incoming_get_current(void);
> >  void migration_incoming_state_destroy(void);
> > +void mark_postcopy_downtime_begin(uint64_t addr, int cpu);
> > +void mark_postcopy_downtime_end(uint64_t addr);
> > +uint64_t get_postcopy_total_downtime(void);
> > +void destroy_downtime_duration(gpointer data);
> >  
> >  /*
> >   * An outstanding page request, on the source, having been received
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 79f6425..5bac434 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -38,6 +38,8 @@
> >  #include "io/channel-tls.h"
> >  #include "migration/colo.h"
> >  
> > +#define DEBUG_VCPU_DOWNTIME 1
> > +
> >  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
> >  
> >  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
> > @@ -77,6 +79,19 @@ static NotifierList migration_state_notifiers =
> >  
> >  static bool deferred_incoming;
> >  
> > +typedef struct {
> > +    int64_t begin;
> > +    int64_t end;
> > +    uint64_t *cpus; /* cpus bit mask array, QEMU bit functions support
> > +     bit operation on memory regions, but doesn't check out of range */
> > +} DowntimeDuration;
> > +
> > +typedef struct {
> > +    int64_t tp; /* point in time */
> > +    bool is_end;
> > +    uint64_t *cpus;
> > +} OverlapDowntime;
> > +
> >  /*
> >   * Current state of incoming postcopy; note this is not part of
> >   * MigrationIncomingState since it's state is used during cleanup
> > @@ -117,6 +132,13 @@ MigrationState *migrate_get_current(void)
> >      return &current_migration;
> >  }
> >  
> > +void destroy_downtime_duration(gpointer data)
> > +{
> > +    DowntimeDuration *dd = (DowntimeDuration *)data;
> > +    g_free(dd->cpus);
> > +    g_free(data);
> > +}
> > +
> >  MigrationIncomingState *migration_incoming_get_current(void)
> >  {
> >      static bool once;
> > @@ -138,10 +160,13 @@ void migration_incoming_state_destroy(void)
> >      struct MigrationIncomingState *mis = migration_incoming_get_current();
> >  
> >      qemu_event_destroy(&mis->main_thread_load_event);
> > +    if (mis->postcopy_downtime) {
> > +        g_tree_destroy(mis->postcopy_downtime);
> > +        mis->postcopy_downtime = NULL;
> > +    }
> >      loadvm_free_handlers(mis);
> >  }
> >  
> > -
> >  typedef struct {
> >      bool optional;
> >      uint32_t size;
> > @@ -1754,7 +1779,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> >       */
> >      ms->postcopy_after_devices = true;
> >      notifier_list_notify(&migration_state_notifiers, ms);
> > -
> 
> Stray deletion
> 
> >      ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
> >  
> >      qemu_mutex_unlock_iothread();
> > @@ -2117,3 +2141,255 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
> >      return atomic_xchg(&incoming_postcopy_state, new_state);
> >  }
> >  
> > +#define SIZE_TO_KEEP_CPUBITS (1 + smp_cpus/sizeof(guint64))
> 
> Split out your cpu-sets so that you have an 'alloc_cpu_set',
> a 'set bit' a 'set all bits', dup etc
> (I see Linux has cpumask.h that has a 'cpu_set' that's
> basically the same thing, but we need something portablish.)
> 
> > +void mark_postcopy_downtime_begin(uint64_t addr, int cpu)
> > +{
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    DowntimeDuration *dd;
> > +    if (!mis->postcopy_downtime) {
> > +        return;
> > +    }
> > +
> > +    dd = g_tree_lookup(mis->postcopy_downtime, (gpointer)addr); /* !!! cast */
> > +    if (!dd) {
> > +        dd = (DowntimeDuration *)g_new0(DowntimeDuration, 1);
> > +        dd->cpus = g_new0(guint64, SIZE_TO_KEEP_CPUBITS);
> > +        g_tree_insert(mis->postcopy_downtime, (gpointer)addr, (gpointer)dd);
> > +    }
> > +
> > +    if (cpu < 0) {
> > +        /* assume in this situation all vCPUs are sleeping */
> > +        int i;
> > +        for (i = 0; i < SIZE_TO_KEEP_CPUBITS; i++) {
> > +            dd->cpus[i] = ~(uint64_t)0u;
> > +        }
> > +    } else
> > +        set_bit(cpu, dd->cpus);
> 
> Qemu coding style: Use {}'s even on one line blocks
> 
> > +
> > +    /*
> > +     *  overwrite previously set dd->begin, if that page already was
> > +     *     faulted on another cpu
> > +     */
> > +    dd->begin = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> 
> OK, so this is making a decision that needs to be documented;
> that is that if one CPU was already paused at time (a), then a second
> CPU we see is paused at time (b), then the time  we record only starts
> at (b) and ignores the time from a..b  - is that the way you want to do it?
Yes, time interval when at least one of vCPU is running isn't counted.

> As I say, it should be documented somewhere; it's probably worth
> adding something to docs/migration.txt about how this measurement works.
> 
> 
> > +    trace_mark_postcopy_downtime_begin(addr, dd, dd->begin, cpu);
> > +}
> > +
> > +void mark_postcopy_downtime_end(uint64_t addr)
> > +{
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    DowntimeDuration *dd;
> > +    if (!mis->postcopy_downtime) {
> > +        return;
> > +    }
> > +
> > +    dd = g_tree_lookup(mis->postcopy_downtime, (gpointer)addr);
> > +    if (!dd) {
> > +        /* error_report("Could not populate downtime duration completion time \n\
> > +                        There is no downtime duration for 0x%"PRIx64, addr); */
> 
> Error or no error - decide!   Is this happening for pages that arrive before
> they've been requested?
> 
> > +        return;
> > +    }
> > +
> > +    dd->end = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> > +    trace_mark_postcopy_downtime_end(addr, dd, dd->end);
> > +}
> > +
> > +struct downtime_overlay_cxt {
> > +    GPtrArray *downtime_points;
> > +    size_t number_of_points;
> > +};
> 
> Why 'cxt' ? If you mean as an abbreviation to context, then we normally use ctxt.
> 
> > +/*
> > + * This function split each DowntimeDuration, which represents as start/end
> > + * pointand makes a points of it, then fill array with points,
> > + * to sort it in future.
> > + */
> > +static gboolean split_duration_and_fill_points(gpointer key, gpointer value,
> > +                                        gpointer data)
> > +{
> > +    struct downtime_overlay_cxt *ctx = (struct downtime_overlay_cxt *)data;
> > +    DowntimeDuration *dd = (DowntimeDuration *)value;
> > +    GPtrArray *interval = ctx->downtime_points;
> > +    if (dd->begin) {
> > +        OverlapDowntime *od_begin = g_new0(OverlapDowntime, 1);
> > +        od_begin->cpus = g_memdup(dd->cpus, sizeof(uint64_t) * SIZE_TO_KEEP_CPUBITS);
> > +        od_begin->tp = dd->begin;
> > +        od_begin->is_end = false;
> > +        g_ptr_array_add(interval, od_begin);
> > +        ctx->number_of_points += 1;
> > +    }
> > +
> > +    if (dd->end) {
> > +        OverlapDowntime *od_end = g_new0(OverlapDowntime, 1);
> > +        od_end->cpus = g_memdup(dd->cpus, sizeof(uint64_t) * SIZE_TO_KEEP_CPUBITS);
> > +        od_end->tp = dd->end;
> > +        od_end->is_end = true;
> > +        g_ptr_array_add(interval, od_end);
> > +        ctx->number_of_points += 1;
> > +    }
> > +
> > +    if (dd->end && dd->begin)
> > +        trace_split_duration_and_fill_points(dd->end - dd->begin, (uint64_t)key);
> 
> again, need {}'s
> 
> > +    return FALSE;
> > +}
> > +
> > +#ifdef DEBUG_VCPU_DOWNTIME
> > +static gboolean calculate_per_cpu(gpointer key, gpointer value,
> > +                                  gpointer data)
> > +{
> > +    int *downtime_cpu = (int *)data;
> > +    DowntimeDuration *dd = (DowntimeDuration *)value;
> > +    int cpu_iter;
> > +    for (cpu_iter = 0; cpu_iter < smp_cpus; cpu_iter++) {
> > +        if (test_bit(cpu_iter, dd->cpus) && dd->end && dd->begin)
> > +            downtime_cpu[cpu_iter] += dd->end - dd->begin;
> > +    }
> > +    return FALSE;
> > +}
> > +#endif /* DEBUG_VCPU_DOWNTIME */
> > +
> > +static gint compare_downtime(gconstpointer a, gconstpointer b)
> > +{
> > +    DowntimeDuration *dda = (DowntimeDuration *)a;
> > +    DowntimeDuration *ddb = (DowntimeDuration *)b;
> > +    return dda->begin - ddb->begin;
> > +}
> > +
> > +static void destroy_overlap_downtime(gpointer data)
> > +{
> > +    OverlapDowntime *od = (OverlapDowntime *)data;
> > +    g_free(od->cpus);
> > +    g_free(data);
> > +}
> > +
> > +static int check_overlap(uint64_t *b)
> > +{
> > +    unsigned long zero_bit = find_first_zero_bit(b, BITS_PER_LONG * SIZE_TO_KEEP_CPUBITS);
> 
> Line's too long.
> 
> > +    return zero_bit >= smp_cpus;
> 
> So this is really 'all cpus are blocked'?
yes, that condition for it
> 
> > +}
> > +
> > +/*
> > + * This function calculates downtime per cpu and trace it
> > + *
> > + *  Also it calculates total downtime as an interval's overlap,
> > + *  for many vCPU.
> > + *
> > + *  The approach is following:
> > + *  Initially intervals are represented in tree where key is
> > + *  pagefault address, and values:
> > + *   begin - page fault time
> > + *   end   - page load time
> > + *   cpus  - bit mask shows affected cpus
> > + *
> > + *  To calculate overlap on all cpus, intervals converted into
> > + *  array of points in time (downtime_points), the size of
> > + *  array is 2 * number of nodes in tree of intervals (2 array
> > + *  elements per one in element of interval).
> > + *  Each element is marked as end (E) or as start (S) of interval.
> > + *  The overlap downtime will be calculated for SE, only in case
> > + *  there is sequence S(0..N)E(M) for every vCPU.
> > + *
> > + * As example we have 3 CPU
> > + *
> > + *      S1        E1           S1               E1
> > + * -----***********------------xxx***************------------------------> CPU1
> > + *
> > + *             S2                E2
> > + * ------------****************xxx---------------------------------------> CPU2
> > + *
> > + *                         S3            E3
> > + * ------------------------****xxx********-------------------------------> CPU3
> > + *
> > + * We have sequence S1,S2,E1,S3,S1,E2,E3,E1
> > + * S2,E1 - doesn't match condition due to sequence S1,S2,E1 doesn't include CPU3
> > + * S3,S1,E2 - sequenece includes all CPUs, in this case overlap will be S1,E2
>                        ^ typo
> 
> > + * Legend of picture is following: * - means downtime per vCPU
> > + *                                 x - means overlapped downtime
> > + */
> > +uint64_t get_postcopy_total_downtime(void)
> > +{
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +    uint64_t total_downtime = 0; /* for total overlapped downtime */
> > +    const int intervals = g_tree_nnodes(mis->postcopy_downtime);
> > +    int point_iter, start_point_iter, i;
> > +    struct downtime_overlay_cxt dp_ctx = { 0 };
> > +    /*
> > +     * array will contain 2 * interval points or less, if
> > +     * it was not page fault finalization for page,
> > +     * real count will be in ctx.number_of_points
> > +     */
> > +    dp_ctx.downtime_points = g_ptr_array_new_full(2 * intervals,
> > +                                                     destroy_overlap_downtime);
> 
> Is the g_ptr_array giving you anything here over a plain-old C array of pointers?
> You're not dynamically growing it.
Yes, I know upper bound of that array, at that time, and GPtrArray maybe
is little bit heavy structure here. Ok I'll use plain array.

> 
> > +    if (!mis->postcopy_downtime) {
> > +        goto out;
> > +    }
> > +
> > +#ifdef DEBUG_VCPU_DOWNTIME
> > +    {
> > +        gint *downtime_cpu = g_new0(int, smp_cpus);
> > +        g_tree_foreach(mis->postcopy_downtime, calculate_per_cpu, downtime_cpu);
> > +        for (point_iter = 0; point_iter < smp_cpus; point_iter++)
> > +        {
> > +            trace_downtime_per_cpu(point_iter, downtime_cpu[point_iter]);
> > +        }
> > +        g_free(downtime_cpu);
> > +    }
> > +#endif /* DEBUG_VCPU_DOWNTIME */
> 
> You mgight want to make that:
>   if (TRACE_DOWNTIME_PER_CPU_ENABLED) {
>   }
> 
> and remove the ifdef.
> 
> > +    /* make downtime points S/E from interval */
> > +    g_tree_foreach(mis->postcopy_downtime, split_duration_and_fill_points,
> > +                   &dp_ctx);
> > +    g_ptr_array_sort(dp_ctx.downtime_points, compare_downtime);
> > +
> > +    for (point_iter = 1; point_iter < dp_ctx.number_of_points;
> > +         point_iter++) {
> > +        OverlapDowntime *od = g_ptr_array_index(dp_ctx.downtime_points,
> > +                point_iter);
> > +        uint64_t *cur_cpus;
> > +        int smp_cpus_i = smp_cpus;
> > +        OverlapDowntime *prev_od = g_ptr_array_index(dp_ctx.downtime_points,
> > +                                                     point_iter - 1);
> > +        if (!od || !prev_od)
> > +            continue;
> 
> Why would that happen?
Now cycle goes till dp_ctx.number_of_points, so in this version it looks
impossible.
> 
> > +        /* we need sequence SE */
> > +        if (!od->is_end || prev_od->is_end)
> > +            continue;
> > +
> > +        cur_cpus = g_memdup(od->cpus, sizeof(uint64_t) * SIZE_TO_KEEP_CPUBITS);
> > +        for (start_point_iter = point_iter - 1;
> > +             start_point_iter >= 0 && smp_cpus_i;
> > +             start_point_iter--, smp_cpus_i--) {
> 
> I think I see what you're doing in this loop, although it's a bit hairy;
> I don't think I understand why we needed to get prev_od  if this loop is searching
> backwards?
Just for condition,
if (!od->is_end || prev_od->is_end) {
    continue;
}
to skip any other sequences, like EE,
do you think following condition more readable?
!(od->is_end && !prev_od->is_end) 
    continue;

Also prev_od is  nearest point to end, so time since that point to end
is interesting.
I depicted that.
> 
> > +            OverlapDowntime *t_od = g_ptr_array_index(dp_ctx.downtime_points,
> > +                                                      start_point_iter);
> > +            if (!t_od)
> > +                break;
> > +            /* should be S */
> > +            if (t_od->is_end)
> > +                break;
> > +
> > +            /* points were sorted, it's possible when
> > +             * end is not occured, but this points were ommited
> > +             * in split_duration_and_fill_points */
> > +            if (od->tp <= prev_od->tp) {
> 
> Why is this checking od and prev_od in this loop - isn't this
> loop mainly t_od ?
right, that code shouldn't be here.
> 
> > +                break;
> > +            }
> > +
> > +            for (i = 0; i < SIZE_TO_KEEP_CPUBITS; i++) {
> > +                cur_cpus[i] |= t_od->cpus[i];
> > +            }
> > +
> > +            /* check_overlap - just count number of bits in cur_cpus,
> > +             * and compare it with smp_cpus */
> > +            if (check_overlap(cur_cpus)) {
> > +                total_downtime += od->tp - prev_od->tp;
> > +                /* situation when one S point represents all vCPU is possible */
> > +                break;
> > +            }
> > +        }
> > +        g_free(cur_cpus);
> > +    }
> > +    trace_get_postcopy_total_downtime(g_tree_nnodes(mis->postcopy_downtime),
> > +        total_downtime);
> > +out:
> > +    g_ptr_array_free(dp_ctx.downtime_points, TRUE);
> > +    return total_downtime;
> > +}
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 70f0480..ea89f4e 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -23,8 +23,10 @@
> >  #include "migration/postcopy-ram.h"
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/balloon.h"
> > +#include <sys/param.h>
> >  #include "qemu/error-report.h"
> >  #include "trace.h"
> > +#include "glib/glib-helper.h"
> >  
> >  /* Arbitrary limit on size of each discard command,
> >   * keeps them around ~200 bytes
> > @@ -81,6 +83,11 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
> >          return false;
> >      }
> >  
> > +    if (mis && UFFD_FEATURE_THREAD_ID & api_struct.features) {
> 
> That's a very weird way of writing that test!  Also, I think you need
> to still make this user-selectable given the complexity/cost.
>
Like that?
{"execute": "migrate-set-capabilities" , "arguments":
{ "capabilities": [ { "capability": "calculate-postcopy-downtime", "state": true } ]
} }                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^

I tried to put heavy operations much after hot path (page requesting and
copying). The algorithm complexity is NumberOfPage*NumberOfvCPU, in case
of hugepages it's not so many.
Ok, if it's conditionally obtained from kernel, why not to give a user
ability to choose.

> > +        mis->postcopy_downtime = g_tree_new_full(g_int_cmp64,
> > +                                         NULL, NULL, destroy_downtime_duration);
> > +    }
> > +
> >      if (getpagesize() != ram_pagesize_summary()) {
> >          bool have_hp = false;
> >          /* We've got a huge page */
> > @@ -404,6 +411,18 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
> >      return 0;
> >  }
> >  
> > +static int get_mem_fault_cpu_index(uint32_t pid)
> > +{
> > +    CPUState *cpu_iter;
> > +
> > +    CPU_FOREACH(cpu_iter) {
> > +        if (cpu_iter->thread_id == pid)
> > +           return cpu_iter->cpu_index;
> > +    }
> > +    trace_get_mem_fault_cpu_index(pid);
> > +    return -1;
> > +}
> > +
> >  /*
> >   * Handle faults detected by the USERFAULT markings
> >   */
> > @@ -481,8 +500,10 @@ static void *postcopy_ram_fault_thread(void *opaque)
> >          rb_offset &= ~(qemu_ram_pagesize(rb) - 1);
> >          trace_postcopy_ram_fault_thread_request(msg.arg.pagefault.address,
> >                                                  qemu_ram_get_idstr(rb),
> > -                                                rb_offset);
> > +                                                rb_offset, msg.arg.pagefault.feat.ptid);
> 
> Line length!
> 
> >  
> > +        mark_postcopy_downtime_begin(msg.arg.pagefault.address,
> > +                            get_mem_fault_cpu_index(msg.arg.pagefault.feat.ptid));
> >          /*
> >           * Send the request to the source - we want to request one
> >           * of our host page sizes (which is >= TPS)
> > @@ -577,6 +598,7 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
> >  
> >          return -e;
> >      }
> > +    mark_postcopy_downtime_end((uint64_t)host);
> >  
> >      trace_postcopy_place_page(host);
> >      return 0;
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index 195fa94..c9f3e47 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -547,7 +547,6 @@ size_t qemu_get_buffer_in_place(QEMUFile *f, uint8_t **buf, size_t size)
> >  int qemu_peek_byte(QEMUFile *f, int offset)
> >  {
> >      int index = f->buf_index + offset;
> > -
> 
> Stray!
> 
> >      assert(!qemu_file_is_writable(f));
> >      assert(offset < IO_BUF_SIZE);
> >  
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 7372ce2..ab2e1e4 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -110,6 +110,12 @@ process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> >  process_incoming_migration_co_postcopy_end_main(void) ""
> >  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> >  migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> > +mark_postcopy_downtime_begin(uint64_t addr, void *dd, int64_t time, int cpu) "addr 0x%" PRIx64 " dd %p time %" PRId64 " cpu %d"
> > +mark_postcopy_downtime_end(uint64_t addr, void *dd, int64_t time) "addr 0x%" PRIx64 " dd %p time %" PRId64
> > +get_postcopy_total_downtime(int num, uint64_t total) "faults %d, total downtime %" PRIu64
> > +split_duration_and_fill_points(int64_t downtime, uint64_t addr) "downtime %" PRId64 " addr 0x%" PRIx64
> > +downtime_per_cpu(int cpu_index, int downtime) "downtime cpu[%d]=%d"
> > +source_return_path_thread_downtime(uint64_t downtime) "downtime %" PRIu64
> >  
> >  # migration/rdma.c
> >  qemu_rdma_accept_incoming_migration(void) ""
> > @@ -186,7 +192,7 @@ postcopy_ram_enable_notify(void) ""
> >  postcopy_ram_fault_thread_entry(void) ""
> >  postcopy_ram_fault_thread_exit(void) ""
> >  postcopy_ram_fault_thread_quit(void) ""
> > -postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset) "Request for HVA=%" PRIx64 " rb=%s offset=%zx"
> > +postcopy_ram_fault_thread_request(uint64_t hostaddr, const char *ramblock, size_t offset, int pid) "Request for HVA=%" PRIx64 " rb=%s offset=%zx %d"
> >  postcopy_ram_incoming_cleanup_closeuf(void) ""
> >  postcopy_ram_incoming_cleanup_entry(void) ""
> >  postcopy_ram_incoming_cleanup_exit(void) ""
> > @@ -195,6 +201,7 @@ save_xbzrle_page_skipping(void) ""
> >  save_xbzrle_page_overflow(void) ""
> >  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
> >  ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
> > +get_mem_fault_cpu_index(uint32_t pid) "pid %u is not vCPU"
> >  
> >  # migration/exec.c
> >  migration_exec_outgoing(const char *cmd) "cmd=%s"
> > -- 
> > 1.8.3.1
> > 
> 
> Dave
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

-- 

BR
Alexey

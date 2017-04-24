Received: from eggs.gnu.org ([2001:4830:134:3::10]:41452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2hYA-0005TJ-2q
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2hY5-0008LT-8L
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2hY4-0008LB-VN
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 13:13:17 -0400
Date: Mon, 24 Apr 2017 18:13:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424171312.GN2362@work-vm>
References: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170414131740eucas1p27eba648b990a93a627265c740e7ff118@eucas1p2.samsung.com>
	<1492175840-5021-5-git-send-email-a.perevalov@samsung.com>
	<20170421120031.GB2098@work-vm>
	<20170422094911.GA6094@aperevalov-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170422094911.GA6094@aperevalov-ubuntu>
Subject: Re: [Qemu-devel] [PATCH 4/6] migration: calculate downtime on dst
 side (CPUMASK)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey <a.perevalov@samsung.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org

* Alexey (a.perevalov@samsung.com) wrote:
> Hello David,
> this mail just for CPUMASK discussion.
> 
> On Fri, Apr 21, 2017 at 01:00:32PM +0100, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > This patch provides downtime calculation per vCPU,
> > > as a summary and as a overlapped value for all vCPUs.
> > > 
> > > This approach just keeps tree with page fault addr as a key,
> > > and t1-t2 interval of pagefault time and page copy time, with
> > > affected vCPU bit mask.
> > > For more implementation details please see comment to
> > > get_postcopy_total_downtime function.
> > > 
> > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > ---
> > >  include/migration/migration.h |  14 +++
> > >  migration/migration.c         | 280 +++++++++++++++++++++++++++++++++++++++++-
> > >  migration/postcopy-ram.c      |  24 +++-
> > >  migration/qemu-file.c         |   1 -
> > >  migration/trace-events        |   9 +-
> > >  5 files changed, 323 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/migration/migration.h b/include/migration/migration.h
> > > index 5720c88..5d2c628 100644
> > > --- a/include/migration/migration.h
> > > +++ b/include/migration/migration.h
> > > @@ -123,10 +123,24 @@ struct MigrationIncomingState {
> > >  
> > >      /* See savevm.c */
> > >      LoadStateEntry_Head loadvm_handlers;
> > > +
> > > +    /*
> > > +     *  Tree for keeping postcopy downtime,
> > > +     *  necessary to calculate correct downtime, during multiple
> > > +     *  vm suspends, it keeps host page address as a key and
> > > +     *  DowntimeDuration as a data
> > > +     *  NULL means kernel couldn't provide process thread id,
> > > +     *  and QEMU couldn't identify which vCPU raise page fault
> > > +     */
> > > +    GTree *postcopy_downtime;
> > >  };
> > >  
> > >  MigrationIncomingState *migration_incoming_get_current(void);
> > >  void migration_incoming_state_destroy(void);
> > > +void mark_postcopy_downtime_begin(uint64_t addr, int cpu);
> > > +void mark_postcopy_downtime_end(uint64_t addr);
> > > +uint64_t get_postcopy_total_downtime(void);
> > > +void destroy_downtime_duration(gpointer data);
> > >  
> > >  /*
> > >   * An outstanding page request, on the source, having been received
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 79f6425..5bac434 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -38,6 +38,8 @@
> > >  #include "io/channel-tls.h"
> > >  #include "migration/colo.h"
> > >  
> > > +#define DEBUG_VCPU_DOWNTIME 1
> > > +
> > >  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
> > >  
> > >  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
> > > @@ -77,6 +79,19 @@ static NotifierList migration_state_notifiers =
> > >  
> > >  static bool deferred_incoming;
> > >  
> > > +typedef struct {
> > > +    int64_t begin;
> > > +    int64_t end;
> > > +    uint64_t *cpus; /* cpus bit mask array, QEMU bit functions support
> > > +     bit operation on memory regions, but doesn't check out of range */
> > > +} DowntimeDuration;
> > > +
> > > +typedef struct {
> > > +    int64_t tp; /* point in time */
> > > +    bool is_end;
> > > +    uint64_t *cpus;
> > > +} OverlapDowntime;
> > > +
> > >  /*
> > >   * Current state of incoming postcopy; note this is not part of
> > >   * MigrationIncomingState since it's state is used during cleanup
> > > @@ -117,6 +132,13 @@ MigrationState *migrate_get_current(void)
> > >      return &current_migration;
> > >  }
> > >  
> > > +void destroy_downtime_duration(gpointer data)
> > > +{
> > > +    DowntimeDuration *dd = (DowntimeDuration *)data;
> > > +    g_free(dd->cpus);
> > > +    g_free(data);
> > > +}
> > > +
> > >  MigrationIncomingState *migration_incoming_get_current(void)
> > >  {
> > >      static bool once;
> > > @@ -138,10 +160,13 @@ void migration_incoming_state_destroy(void)
> > >      struct MigrationIncomingState *mis = migration_incoming_get_current();
> > >  
> > >      qemu_event_destroy(&mis->main_thread_load_event);
> > > +    if (mis->postcopy_downtime) {
> > > +        g_tree_destroy(mis->postcopy_downtime);
> > > +        mis->postcopy_downtime = NULL;
> > > +    }
> > >      loadvm_free_handlers(mis);
> > >  }
> > >  
> > > -
> > >  typedef struct {
> > >      bool optional;
> > >      uint32_t size;
> > > @@ -1754,7 +1779,6 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> > >       */
> > >      ms->postcopy_after_devices = true;
> > >      notifier_list_notify(&migration_state_notifiers, ms);
> > > -
> > 
> > Stray deletion
> > 
> > >      ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
> > >  
> > >      qemu_mutex_unlock_iothread();
> > > @@ -2117,3 +2141,255 @@ PostcopyState postcopy_state_set(PostcopyState new_state)
> > >      return atomic_xchg(&incoming_postcopy_state, new_state);
> > >  }
> > >  
> > > +#define SIZE_TO_KEEP_CPUBITS (1 + smp_cpus/sizeof(guint64))
> > 
> > Split out your cpu-sets so that you have an 'alloc_cpu_set',
> > a 'set bit' a 'set all bits', dup etc
> > (I see Linux has cpumask.h that has a 'cpu_set' that's
> > basically the same thing, but we need something portablish.)
> > 
> Agree, the way I'm working with cpumask is little bit naive.
> instead of set all_cpumask in case when all vCPU are sleeping with precision
> ((1 << smp_cpus) - 1), I just set ~0 it all, because I didn't use
> functions like cpumask_and.
> If you think, this patch should use cpumask, cpumask patchset/separate
> thread should be introduced before, and then this patchset should be
> rebased on top of it.

Yes, some functions like that - because then it makes this code
clearer; and there's less repetition.

Dave

> 
> BR
> Alexey
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

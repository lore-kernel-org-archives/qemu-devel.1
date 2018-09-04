Received: from eggs.gnu.org ([2001:4830:134:3::10]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fxINP-00041l-VP
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fxINM-0006DQ-KU
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:56:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fxINM-0006CV-AR
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 16:56:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w84KuTvK138417
	for <qemu-devel@nongnu.org>; Tue, 4 Sep 2018 16:56:39 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ma0gcu3em-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 16:56:38 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Tue, 4 Sep 2018 16:56:35 -0400
Date: Tue, 4 Sep 2018 17:56:31 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-3-cota@braap.org>
	<20180904173734.GA18515@kermit-br-ibm-com>
	<20180904193538.GA30725@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904193538.GA30725@flamenco>
Message-Id: <20180904205631.GB18515@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH 2/6] test-rcu-list: avoid torn accesses to
 n_reclaims and n_nodes_removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi, Emilio.

On Tue, Sep 04, 2018 at 03:35:38PM -0400, Emilio G. Cota wrote:
> On Tue, Sep 04, 2018 at 14:37:34 -0300, Murilo Opsfelder Araujo wrote:
> > Hi, Emilio.
> > 
> > On Mon, Sep 03, 2018 at 01:18:27PM -0400, Emilio G. Cota wrote:
> > > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > > ---
> > >  tests/test-rcu-list.c | 67 +++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 59 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
> > > index 192bfbf02e..2606b7c19d 100644
> > > --- a/tests/test-rcu-list.c
> > > +++ b/tests/test-rcu-list.c
> > > @@ -25,6 +25,23 @@
> > >  #include "qemu/rcu.h"
> > >  #include "qemu/thread.h"
> > >  #include "qemu/rcu_queue.h"
> > > +#include "qemu/seqlock.h"
> > > +
> > > +/*
> > > + * Abstraction to avoid torn accesses when there is a single thread updating
> > > + * the count.
> > > + *
> > > + * If CONFIG_ATOMIC64 is defined, we simply use atomic accesses. Otherwise, we
> > > + * use a seqlock without a lock, since only one thread can update the count.
> > > + */
> > > +struct Count {
> > > +    long long val;
> > > +#ifndef CONFIG_ATOMIC64
> > > +    QemuSeqLock sequence;
> > > +#endif
> > > +};
> > > +
> > > +typedef struct Count Count;
> > >
> > >  /*
> > >   * Test variables.
> > > @@ -33,8 +50,8 @@
> > >  static QemuMutex counts_mutex;
> > >  static long long n_reads = 0LL;
> > >  static long long n_updates = 0LL;
> > > -static long long n_reclaims = 0LL;
> > > -static long long n_nodes_removed = 0LL;
> > > +static Count n_reclaims;
> > > +static Count n_nodes_removed;
> > 
> > Don't we need to init the seqlocks?
> > 
> >   seqlock_init(&n_reclaims.sequence);
> >   seqlock_init(&n_nodes_removed.sequence);
> > 
> > Don't we need to init ->val with 0LL as well?
> 
> These are all zeroed out due to being static.
> 
> We could add seqlock_init calls just to be more clear, but seqlock_init
> would not have any actual effect (it just sets the sequence to 0).
> 
> > >  static long long n_nodes = 0LL;
> > >  static int g_test_in_charge = 0;
> > >
> > > @@ -60,6 +77,38 @@ static int select_random_el(int max)
> > >      return (rand() % max);
> > >  }
> > >
> > > +static inline long long count_read(Count *c)
> > > +{
> > > +#ifdef CONFIG_ATOMIC64
> > > +    /* use __nocheck because sizeof(void *) might be < sizeof(long long) */
> > > +    return atomic_read__nocheck(&c->val);
> > > +#else
> > > +    unsigned int version;
> > > +    long long val;
> > > +
> > > +    do {
> > > +        version = seqlock_read_begin(&c->sequence);
> > > +        val = c->val;
> > > +    } while (seqlock_read_retry(&c->sequence, version));
> > > +    return val;
> > > +#endif
> > > +}
> > > +
> > > +static inline void count_add(Count *c, long long val)
> > > +{
> > > +#ifdef CONFIG_ATOMIC64
> > > +    atomic_set__nocheck(&c->val, c->val + val);
> > > +#else
> > > +    seqlock_write_begin(&c->sequence);
> > > +    c->val += val;
> > > +    seqlock_write_end(&c->sequence);
> > > +#endif
> > > +}
> > > +
> > > +static inline void count_inc(Count *c)
> > > +{
> > > +    count_add(c, 1);
> > > +}
> > 
> > Are these `#ifdef CONFIG_ATOMIC64` required?
> > 
> > The bodies of
> > 
> >   seqlock_read_begin()
> >   seqlock_read_retry()
> >   seqlock_write_begin()
> >   seqlock_write_end()
> > 
> > in include/qemu/seqlock.h make me think that they already use atomic operations.
> > What am I missing?
> 
> atomic_read/set(*foo), as defined in qemu/atomic.h, are as wide as
> foo. The sequence number in a seqlock is an "unsigned", so those
> atomics won't be larger than 32 bits.
> 
> The counts we're dealing with here are 64-bits, so with
> #ifdef CONFIG_ATOMIC64 we ensure that the host can actually
> perform those 64-bit atomic accesses.
> 
> > >
> > >  static void create_thread(void *(*func)(void *))
> > >  {
> > > @@ -104,7 +153,7 @@ static void reclaim_list_el(struct rcu_head *prcu)
> > >      struct list_element *el = container_of(prcu, struct list_element, rcu);
> > >      g_free(el);
> > >      /* Accessed only from call_rcu thread.  */
> > > -    n_reclaims++;
> > > +    count_inc(&n_reclaims);
> > >  }
> > >
> > >  #if TEST_LIST_TYPE == 1
> > > @@ -232,7 +281,7 @@ static void *rcu_q_updater(void *arg)
> > >      qemu_mutex_lock(&counts_mutex);
> > >      n_nodes += n_nodes_local;
> > >      n_updates += n_updates_local;
> > > -    n_nodes_removed += n_removed_local;
> > > +    count_add(&n_nodes_removed, n_removed_local);
> > 
> > I'm just curious why n_nodes and n_updates don't need seqlocks.  Are
> > n_nodes_removed and n_reclaims some kind of special that seqlocks are required?
> 
> n_nodes and n_updates are serialized by counts_mutex.
> 
> n_nodes_removed and n_reclaims don't really need the lock (even though
> some accesses to it are protected by it; more on this below), since
> they're updated by a single thread at a time. This is why just using
> atomic_set is enough for these, and why we use seqlocks if the host
> cannot do 64-bit atomic accesses.
> 
> Note that these "atomics" are not "read-modify-write"; they are
> atomic in the sense that they prevent torn accesses, but
> otherwise imply no memory fences or synchronization.
> 
> > >      qemu_mutex_unlock(&counts_mutex);
> > >      return NULL;
> > >  }
> > > @@ -286,19 +335,21 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
> > >          n_removed_local++;
> > >      }
> > >      qemu_mutex_lock(&counts_mutex);
> > > -    n_nodes_removed += n_removed_local;
> > > +    count_add(&n_nodes_removed, n_removed_local);
> > >      qemu_mutex_unlock(&counts_mutex);
> > 
> > Does this count_add() need to be guarded by a mutex?
> 
> No. In fact, accesses to n_nodes_removed don't need the mutex
> at all, because only one thread writes to it at a time (first
> the updater thread, then the main thread joins the updater
> thread, and then the main thread updates it).
> 
> Performance-wise, this change wouldn't change much though, which
> is why I decided not to include it. The main purpose of this
> patch is to avoid undefined behaviour when different threads
> access the same variable with regular accesses without always
> holding the same lock, as is the case with the two variables
> converted to Count.
> 
> Cheers,
> 
> 		Emilio
> 

The explanations you provided made a lot of difference on understanding the why
of your patch.  Thank you!

Is it possible to enhance commit message and add the explanations?

-- 
Murilo

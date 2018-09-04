Received: from eggs.gnu.org ([2001:4830:134:3::10]:33501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fxFGv-0008IL-Dz
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fxFGs-0007uf-26
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:37:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fxFGr-0007u1-Oa
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 13:37:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w84HY8w7110541
	for <qemu-devel@nongnu.org>; Tue, 4 Sep 2018 13:37:43 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m9v99en6e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 13:37:43 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Tue, 4 Sep 2018 11:37:42 -0600
Date: Tue, 4 Sep 2018 14:37:34 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-3-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903171831.15446-3-cota@braap.org>
Message-Id: <20180904173734.GA18515@kermit-br-ibm-com>
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

On Mon, Sep 03, 2018 at 01:18:27PM -0400, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tests/test-rcu-list.c | 67 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
> index 192bfbf02e..2606b7c19d 100644
> --- a/tests/test-rcu-list.c
> +++ b/tests/test-rcu-list.c
> @@ -25,6 +25,23 @@
>  #include "qemu/rcu.h"
>  #include "qemu/thread.h"
>  #include "qemu/rcu_queue.h"
> +#include "qemu/seqlock.h"
> +
> +/*
> + * Abstraction to avoid torn accesses when there is a single thread updating
> + * the count.
> + *
> + * If CONFIG_ATOMIC64 is defined, we simply use atomic accesses. Otherwise, we
> + * use a seqlock without a lock, since only one thread can update the count.
> + */
> +struct Count {
> +    long long val;
> +#ifndef CONFIG_ATOMIC64
> +    QemuSeqLock sequence;
> +#endif
> +};
> +
> +typedef struct Count Count;
>
>  /*
>   * Test variables.
> @@ -33,8 +50,8 @@
>  static QemuMutex counts_mutex;
>  static long long n_reads = 0LL;
>  static long long n_updates = 0LL;
> -static long long n_reclaims = 0LL;
> -static long long n_nodes_removed = 0LL;
> +static Count n_reclaims;
> +static Count n_nodes_removed;

Don't we need to init the seqlocks?

  seqlock_init(&n_reclaims.sequence);
  seqlock_init(&n_nodes_removed.sequence);

Don't we need to init ->val with 0LL as well?

>  static long long n_nodes = 0LL;
>  static int g_test_in_charge = 0;
>
> @@ -60,6 +77,38 @@ static int select_random_el(int max)
>      return (rand() % max);
>  }
>
> +static inline long long count_read(Count *c)
> +{
> +#ifdef CONFIG_ATOMIC64
> +    /* use __nocheck because sizeof(void *) might be < sizeof(long long) */
> +    return atomic_read__nocheck(&c->val);
> +#else
> +    unsigned int version;
> +    long long val;
> +
> +    do {
> +        version = seqlock_read_begin(&c->sequence);
> +        val = c->val;
> +    } while (seqlock_read_retry(&c->sequence, version));
> +    return val;
> +#endif
> +}
> +
> +static inline void count_add(Count *c, long long val)
> +{
> +#ifdef CONFIG_ATOMIC64
> +    atomic_set__nocheck(&c->val, c->val + val);
> +#else
> +    seqlock_write_begin(&c->sequence);
> +    c->val += val;
> +    seqlock_write_end(&c->sequence);
> +#endif
> +}
> +
> +static inline void count_inc(Count *c)
> +{
> +    count_add(c, 1);
> +}

Are these `#ifdef CONFIG_ATOMIC64` required?

The bodies of

  seqlock_read_begin()
  seqlock_read_retry()
  seqlock_write_begin()
  seqlock_write_end()

in include/qemu/seqlock.h make me think that they already use atomic operations.
What am I missing?

>
>  static void create_thread(void *(*func)(void *))
>  {
> @@ -104,7 +153,7 @@ static void reclaim_list_el(struct rcu_head *prcu)
>      struct list_element *el = container_of(prcu, struct list_element, rcu);
>      g_free(el);
>      /* Accessed only from call_rcu thread.  */
> -    n_reclaims++;
> +    count_inc(&n_reclaims);
>  }
>
>  #if TEST_LIST_TYPE == 1
> @@ -232,7 +281,7 @@ static void *rcu_q_updater(void *arg)
>      qemu_mutex_lock(&counts_mutex);
>      n_nodes += n_nodes_local;
>      n_updates += n_updates_local;
> -    n_nodes_removed += n_removed_local;
> +    count_add(&n_nodes_removed, n_removed_local);

I'm just curious why n_nodes and n_updates don't need seqlocks.  Are
n_nodes_removed and n_reclaims some kind of special that seqlocks are required?

>      qemu_mutex_unlock(&counts_mutex);
>      return NULL;
>  }
> @@ -286,19 +335,21 @@ static void rcu_qtest(const char *test, int duration, int nreaders)
>          n_removed_local++;
>      }
>      qemu_mutex_lock(&counts_mutex);
> -    n_nodes_removed += n_removed_local;
> +    count_add(&n_nodes_removed, n_removed_local);
>      qemu_mutex_unlock(&counts_mutex);

Does this count_add() need to be guarded by a mutex?

>      synchronize_rcu();
> -    while (n_nodes_removed > n_reclaims) {
> +    while (count_read(&n_nodes_removed) > count_read(&n_reclaims)) {
>          g_usleep(100);
>          synchronize_rcu();
>      }
>      if (g_test_in_charge) {
> -        g_assert_cmpint(n_nodes_removed, ==, n_reclaims);
> +        g_assert_cmpint(count_read(&n_nodes_removed), ==,
> +                        count_read(&n_reclaims));
>      } else {
>          printf("%s: %d readers; 1 updater; nodes read: "  \
>                 "%lld, nodes removed: %lld; nodes reclaimed: %lld\n",
> -               test, nthreadsrunning - 1, n_reads, n_nodes_removed, n_reclaims);
> +               test, nthreadsrunning - 1, n_reads,
> +               count_read(&n_nodes_removed), count_read(&n_reclaims));
>          exit(0);
>      }
>  }
> --
> 2.17.1
>
>

--
Murilo

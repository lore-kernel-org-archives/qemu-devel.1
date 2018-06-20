Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVW5w-0006AF-0h
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVW5r-0004Py-4m
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:55:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVW5q-0004Pq-UE
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:55:47 -0400
Date: Wed, 20 Jun 2018 13:55:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180620055535.GF18985@xz-mi>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-10-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:

[...]

(Some more comments/questions for the MP implementation...)

> +static inline int ring_mp_put(Ring *ring, void *data)
> +{
> +    unsigned int index, in, in_next, out;
> +
> +    do {
> +        in = atomic_read(&ring->in);
> +        out = atomic_read(&ring->out);

[0]

Do we need to fetch "out" with load_acquire()?  Otherwise what's the
pairing of below store_release() at [1]?

This barrier exists in SP-SC case which makes sense to me, I assume
that's also needed for MP-SC case, am I right?

> +
> +        if (__ring_is_full(ring, in, out)) {
> +            if (atomic_read(&ring->in) == in &&
> +                atomic_read(&ring->out) == out) {

Why read again?  After all the ring API seems to be designed as
non-blocking.  E.g., I see the poll at [2] below makes more sense
since when reaches [2] it means that there must be a producer that is
_doing_ the queuing, so polling is very possible to complete fast.
However here it seems to be a pure busy poll without any hint.  Then
not sure whether we should just let the caller decide whether it wants
to call ring_put() again.

> +                return -ENOBUFS;
> +            }
> +
> +            /* a entry has been fetched out, retry. */
> +            continue;
> +        }
> +
> +        in_next = in + 1;
> +    } while (atomic_cmpxchg(&ring->in, in, in_next) != in);
> +
> +    index = ring_index(ring, in);
> +
> +    /*
> +     * smp_rmb() paired with the memory barrier of (A) in ring_mp_get()
> +     * is implied in atomic_cmpxchg() as we should read ring->out first
> +     * before fetching the entry, otherwise this assert will fail.

Thanks for all these comments!  These are really helpful for
reviewers.

However I'm not sure whether I understand it correctly here on MB of
(A) for ring_mp_get() - AFAIU that should corresponds to a smp_rmb()
at [0] above when reading the "out" variable rather than this
assertion, and that's why I thought at [0] we should have something
like a load_acquire() there (which contains a rmb()).

>From content-wise, I think the code here is correct, since
atomic_cmpxchg() should have one implicit smp_mb() after all so we
don't need anything further barriers here.

> +     */
> +    assert(!atomic_read(&ring->data[index]));
> +
> +    /*
> +     * smp_mb() paired with the memory barrier of (B) in ring_mp_get() is
> +     * implied in atomic_cmpxchg(), that is needed here as  we should read
> +     * ring->out before updating the entry, it is the same as we did in
> +     * __ring_put().
> +     *
> +     * smp_wmb() paired with the memory barrier of (C) in ring_mp_get()
> +     * is implied in atomic_cmpxchg(), that is needed as we should increase
> +     * ring->in before updating the entry.
> +     */
> +    atomic_set(&ring->data[index], data);
> +
> +    return 0;
> +}
> +
> +static inline void *ring_mp_get(Ring *ring)
> +{
> +    unsigned int index, in;
> +    void *data;
> +
> +    do {
> +        in = atomic_read(&ring->in);
> +
> +        /*
> +         * (C) should read ring->in first to make sure the entry pointed by this
> +         * index is available
> +         */
> +        smp_rmb();
> +
> +        if (!__ring_is_empty(in, ring->out)) {
> +            break;
> +        }
> +
> +        if (atomic_read(&ring->in) == in) {
> +            return NULL;
> +        }
> +        /* new entry has been added in, retry. */
> +    } while (1);
> +
> +    index = ring_index(ring, ring->out);
> +
> +    do {
> +        data = atomic_read(&ring->data[index]);
> +        if (data) {
> +            break;
> +        }
> +        /* the producer is updating the entry, retry */
> +        cpu_relax();

[2]

> +    } while (1);
> +
> +    atomic_set(&ring->data[index], NULL);
> +
> +    /*
> +     * (B) smp_mb() is needed as we should read the entry out before
> +     * updating ring->out as we did in __ring_get().
> +     *
> +     * (A) smp_wmb() is needed as we should make the entry be NULL before
> +     * updating ring->out (which will make the entry be visible and usable).
> +     */
> +    atomic_store_release(&ring->out, ring->out + 1);

[1]

> +
> +    return data;
> +}
> +
> +static inline int ring_put(Ring *ring, void *data)
> +{
> +    if (ring->flags & RING_MULTI_PRODUCER) {
> +        return ring_mp_put(ring, data);
> +    }
> +    return __ring_put(ring, data);
> +}
> +
> +static inline void *ring_get(Ring *ring)
> +{
> +    if (ring->flags & RING_MULTI_PRODUCER) {
> +        return ring_mp_get(ring);
> +    }
> +    return __ring_get(ring);
> +}
> +#endif
> -- 
> 2.14.4
> 

Thanks,

-- 
Peter Xu

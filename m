Received: from eggs.gnu.org ([2001:4830:134:3::10]:42488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVcNx-0004fl-Lx
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVcNu-0002Y9-GG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:38:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVcNu-0002Xu-8R
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:38:50 -0400
Date: Wed, 20 Jun 2018 15:38:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620152407-mutt-send-email-mst@kernel.org>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> It's the simple lockless ring buffer implement which supports both
> single producer vs. single consumer and multiple producers vs.
> single consumer.
> 
> Many lessons were learned from Linux Kernel's kfifo (1) and DPDK's
> rte_ring (2) before i wrote this implement. It corrects some bugs of
> memory barriers in kfifo and it is the simpler lockless version of
> rte_ring as currently multiple access is only allowed for producer.
> 
> If has single producer vs. single consumer, it is the traditional fifo,
> If has multiple producers, it uses the algorithm as followings:
> 
> For the producer, it uses two steps to update the ring:
>    - first step, occupy the entry in the ring:
> 
> retry:
>       in = ring->in
>       if (cmpxhg(&ring->in, in, in +1) != in)
>             goto retry;
> 
>      after that the entry pointed by ring->data[in] has been owned by
>      the producer.
> 
>      assert(ring->data[in] == NULL);
> 
>      Note, no other producer can touch this entry so that this entry
>      should always be the initialized state.
> 
>    - second step, write the data to the entry:
> 
>      ring->data[in] = data;
> 
> For the consumer, it first checks if there is available entry in the
> ring and fetches the entry from the ring:
> 
>      if (!ring_is_empty(ring))
>           entry = &ring[ring->out];
> 
>      Note: the ring->out has not been updated so that the entry pointed
>      by ring->out is completely owned by the consumer.
> 
> Then it checks if the data is ready:
> 
> retry:
>      if (*entry == NULL)
>             goto retry;
> That means, the producer has updated the index but haven't written any
> data to it.
> 
> Finally, it fetches the valid data out, set the entry to the initialized
> state and update ring->out to make the entry be usable to the producer:
> 
>       data = *entry;
>       *entry = NULL;
>       ring->out++;
> 
> Memory barrier is omitted here, please refer to the comment in the code.
>
>
>
> (1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
> (2) http://dpdk.org/doc/api/rte__ring_8h.html
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

So instead of all this super-optimized trickiness, how about
a simple port of ptr_ring from linux?

That one isn't lockless but it's known to outperform
most others for a single producer/single consumer case.
And with a ton of networking going on,
who said it's such a hot spot? OTOH this implementation
has more barriers which slows down each individual thread.
It's also a source of bugs.

Further, atomic tricks this one uses are not fair so some threads can get
completely starved while others make progress. There's also no
chance to mix aggressive polling and sleeping with this
kind of scheme, so the starved thread will consume lots of
CPU.

So I'd like to see a simple ring used, and then a patch on top
switching to this tricky one with performance comparison
along with that.

> ---
>  migration/ring.h | 265 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 265 insertions(+)
>  create mode 100644 migration/ring.h
> 
> diff --git a/migration/ring.h b/migration/ring.h
> new file mode 100644
> index 0000000000..da9b8bdcbb
> --- /dev/null
> +++ b/migration/ring.h
> @@ -0,0 +1,265 @@
> +/*
> + * Ring Buffer
> + *
> + * Multiple producers and single consumer are supported with lock free.
> + *
> + * Copyright (c) 2018 Tencent Inc
> + *
> + * Authors:
> + *  Xiao Guangrong <xiaoguangrong@tencent.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef _RING__
> +#define _RING__

Prefix Ring is too short.


> +
> +#define CACHE_LINE  64
> +#define cache_aligned __attribute__((__aligned__(CACHE_LINE)))
> +
> +#define RING_MULTI_PRODUCER 0x1
> +
> +struct Ring {
> +    unsigned int flags;
> +    unsigned int size;
> +    unsigned int mask;
> +
> +    unsigned int in cache_aligned;
> +
> +    unsigned int out cache_aligned;
> +
> +    void *data[0] cache_aligned;
> +};
> +typedef struct Ring Ring;
> +
> +/*
> + * allocate and initialize the ring
> + *
> + * @size: the number of element, it should be power of 2
> + * @flags: set to RING_MULTI_PRODUCER if the ring has multiple producer,
> + *         otherwise set it to 0, i,e. single producer and single consumer.
> + *
> + * return the ring.
> + */
> +static inline Ring *ring_alloc(unsigned int size, unsigned int flags)
> +{
> +    Ring *ring;
> +
> +    assert(is_power_of_2(size));
> +
> +    ring = g_malloc0(sizeof(*ring) + size * sizeof(void *));
> +    ring->size = size;
> +    ring->mask = ring->size - 1;
> +    ring->flags = flags;
> +    return ring;
> +}
> +
> +static inline void ring_free(Ring *ring)
> +{
> +    g_free(ring);
> +}
> +
> +static inline bool __ring_is_empty(unsigned int in, unsigned int out)
> +{
> +    return in == out;
> +}
> +
> +static inline bool ring_is_empty(Ring *ring)
> +{
> +    return ring->in == ring->out;
> +}
> +
> +static inline unsigned int ring_len(unsigned int in, unsigned int out)
> +{
> +    return in - out;
> +}
> +
> +static inline bool
> +__ring_is_full(Ring *ring, unsigned int in, unsigned int out)
> +{
> +    return ring_len(in, out) > ring->mask;
> +}
> +
> +static inline bool ring_is_full(Ring *ring)
> +{
> +    return __ring_is_full(ring, ring->in, ring->out);
> +}
> +
> +static inline unsigned int ring_index(Ring *ring, unsigned int pos)
> +{
> +    return pos & ring->mask;
> +}
> +
> +static inline int __ring_put(Ring *ring, void *data)
> +{
> +    unsigned int index, out;
> +
> +    out = atomic_load_acquire(&ring->out);
> +    /*
> +     * smp_mb()
> +     *
> +     * should read ring->out before updating the entry, see the comments in
> +     * __ring_get().
> +     */
> +
> +    if (__ring_is_full(ring, ring->in, out)) {
> +        return -ENOBUFS;
> +    }
> +
> +    index = ring_index(ring, ring->in);
> +
> +    atomic_set(&ring->data[index], data);
> +
> +    /*
> +     * should make sure the entry is updated before increasing ring->in
> +     * otherwise the consumer will get a entry but its content is useless.
> +     */
> +    smp_wmb();
> +    atomic_set(&ring->in, ring->in + 1);
> +    return 0;
> +}
> +
> +static inline void *__ring_get(Ring *ring)
> +{
> +    unsigned int index, in;
> +    void *data;
> +
> +    in = atomic_read(&ring->in);
> +
> +    /*
> +     * should read ring->in first to make sure the entry pointed by this
> +     * index is available, see the comments in __ring_put().
> +     */
> +    smp_rmb();
> +    if (__ring_is_empty(in, ring->out)) {
> +        return NULL;
> +    }
> +
> +    index = ring_index(ring, ring->out);
> +
> +    data = atomic_read(&ring->data[index]);
> +
> +    /*
> +     * smp_mb()
> +     *
> +     * once the ring->out is updated the entry originally indicated by the
> +     * the index is visible and usable to the producer so that we should
> +     * make sure reading the entry out before updating ring->out to avoid
> +     * the entry being overwritten by the producer.
> +     */
> +    atomic_store_release(&ring->out, ring->out + 1);
> +
> +    return data;
> +}
> +
> +static inline int ring_mp_put(Ring *ring, void *data)
> +{
> +    unsigned int index, in, in_next, out;
> +
> +    do {
> +        in = atomic_read(&ring->in);
> +        out = atomic_read(&ring->out);
> +
> +        if (__ring_is_full(ring, in, out)) {
> +            if (atomic_read(&ring->in) == in &&
> +                atomic_read(&ring->out) == out) {
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

I can't say I understand this all.
And the interaction of acquire/release semantics with smp_*
barriers is even scarier.

> +    atomic_store_release(&ring->out, ring->out + 1);
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


A bunch of tricky barriers retries etc all over the place.  This sorely
needs *a lot of* unit tests. Where are they?



> -- 
> 2.14.4

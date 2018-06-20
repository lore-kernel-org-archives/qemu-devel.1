Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVV6T-0008Ji-Lb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fVV6Q-0006BX-Ih
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:52:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fVV6K-00065W-SO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:52:18 -0400
Date: Wed, 20 Jun 2018 12:52:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180620045203.GE18985@xz-mi>
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

Could you provide some more information about the kfifo bug?  Any
pointer would be appreciated.

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
> (1) https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/kfifo.h
> (2) http://dpdk.org/doc/api/rte__ring_8h.html
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ring.h | 265 +++++++++++++++++++++++++++++++++++++++++++++++++++++++

If this is a very general implementation, not sure whether we can move
this to util/ directory so that it can be used even outside migration
codes.

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
> +
> +#define CACHE_LINE  64

Is this for x86_64?  Is the cache line size the same for all arch?

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

(some of the helpers are a bit confusing to me like this one; I would
 prefer some of the helpers be directly squashed into code, but it's a
 personal preference only)

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

(this too)

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

Nit: here I think it means the comment in [1] below.  Maybe:

  "see the comments in __ring_get() when calling
   atomic_store_release()"

?

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

Pure question: could we use store_release() instead of a mixture of
store/release and raw memory barriers in the function?  Or is there
any performance consideration behind?

It'll be nice to mention the performance considerations if there is.

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

Nit: similar to above, maybe mention about which comment would be a
bit nicer.

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

[1]

> +
> +    return data;
> +}

Regards,

-- 
Peter Xu

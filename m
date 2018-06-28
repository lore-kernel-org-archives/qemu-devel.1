Received: from eggs.gnu.org ([2001:4830:134:3::10]:35306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYXT3-0002AN-Ad
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYXT0-0005jS-7Q
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:00:13 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYXSz-0005iO-UR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:00:10 -0400
Received: by mail-pl0-x242.google.com with SMTP id d10-v6so2815083plo.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:00:09 -0700 (PDT)
From: Xiao Guangrong <guangrong.xiao@gmail.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620055535.GF18985@xz-mi>
Message-ID: <f483f3d3-f9a3-2bf2-5123-d79c43d72762@gmail.com>
Date: Thu, 28 Jun 2018 22:00:03 +0800
MIME-Version: 1.0
In-Reply-To: <20180620055535.GF18985@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/20/2018 01:55 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 05:55:17PM +0800, guangrong.xiao@gmail.com wrote:
> 
> [...]
> 
> (Some more comments/questions for the MP implementation...)
> 
>> +static inline int ring_mp_put(Ring *ring, void *data)
>> +{
>> +    unsigned int index, in, in_next, out;
>> +
>> +    do {
>> +        in = atomic_read(&ring->in);
>> +        out = atomic_read(&ring->out);
> 
> [0]
> 
> Do we need to fetch "out" with load_acquire()?  Otherwise what's the
> pairing of below store_release() at [1]?
> 

The barrier paired with [1] is the full barrier implied in atomic_cmpxchg(),

> This barrier exists in SP-SC case which makes sense to me, I assume
> that's also needed for MP-SC case, am I right?

We needn't put a memory here as we do not need to care the order between
these two indexes (in and out), instead, the memory barrier (and for
SP-SC as well) is used to make the order between ring->out and updating
ring->data[] as we explained in previous mail.

> 
>> +
>> +        if (__ring_is_full(ring, in, out)) {
>> +            if (atomic_read(&ring->in) == in &&
>> +                atomic_read(&ring->out) == out) {
> 
> Why read again?  After all the ring API seems to be designed as
> non-blocking.  E.g., I see the poll at [2] below makes more sense
> since when reaches [2] it means that there must be a producer that is
> _doing_ the queuing, so polling is very possible to complete fast.
> However here it seems to be a pure busy poll without any hint.  Then
> not sure whether we should just let the caller decide whether it wants
> to call ring_put() again.
> 

Without it we can easily observe a "strange" behavior that the thread will
put the result to the global ring failed even if we allocated enough room
for the global ring (its capability >= total requests), that's because
these two indexes can be updated at anytime, consider the case that multiple
get and put operations can be finished between reading ring->in and ring->out
so that very possibly ring->in can pass the value readed from ring->out.

Having this code, the negative case only happens if these two indexes (32 bits)
overflows to the same value, that can help us to catch potential bug in the
code.

>> +                return -ENOBUFS;
>> +            }
>> +
>> +            /* a entry has been fetched out, retry. */
>> +            continue;
>> +        }
>> +
>> +        in_next = in + 1;
>> +    } while (atomic_cmpxchg(&ring->in, in, in_next) != in);
>> +
>> +    index = ring_index(ring, in);
>> +
>> +    /*
>> +     * smp_rmb() paired with the memory barrier of (A) in ring_mp_get()
>> +     * is implied in atomic_cmpxchg() as we should read ring->out first
>> +     * before fetching the entry, otherwise this assert will fail.
> 
> Thanks for all these comments!  These are really helpful for
> reviewers.
> 
> However I'm not sure whether I understand it correctly here on MB of
> (A) for ring_mp_get() - AFAIU that should corresponds to a smp_rmb()
> at [0] above when reading the "out" variable rather than this
> assertion, and that's why I thought at [0] we should have something
> like a load_acquire() there (which contains a rmb()).

Memory barrier (A) in ring_mp_get() makes sure the order between:
    ring->data[index] = NULL;
    smp_wmb();
    ring->out = out + 1;

And the memory barrier at [0] makes sure the order between:
    out = ring->out;
    /* smp_rmb() */
    compxchg();
    value = ring->data[index];
    assert(value);

[ note: the assertion and reading ring->out are across cmpxchg(). ]

Did i understand your question clearly?

> 
>  From content-wise, I think the code here is correct, since
> atomic_cmpxchg() should have one implicit smp_mb() after all so we
> don't need anything further barriers here.

Yes, it is.

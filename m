Received: from eggs.gnu.org ([2001:4830:134:3::10]:41804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyph2-0001U7-KZ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyph0-00024v-Ba
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 21:06:32 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
	<d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
	<e00ab029-cf9f-5aca-9786-581915dd5189@openvz.org>
	<20170413094454.GB5095@noname.redhat.com>
	<1cc754f6-6718-edbc-96ef-ab0e0e10fd56@openvz.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <d34a20e9-8cb7-3b83-e96f-4631f91045cd@redhat.com>
Date: Thu, 13 Apr 2017 21:06:19 -0400
MIME-Version: 1.0
In-Reply-To: <1cc754f6-6718-edbc-96ef-ab0e0e10fd56@openvz.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [RFC] Proposed qcow2 extension:
 subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 04/13/2017 06:19 AM, Denis V. Lunev wrote:
> On 04/13/2017 12:44 PM, Kevin Wolf wrote:
>> Am 12.04.2017 um 21:02 hat Denis V. Lunev geschrieben:
>>> On 04/12/2017 09:20 PM, Eric Blake wrote:
>>>> On 04/12/2017 12:55 PM, Denis V. Lunev wrote:
>>>>> Let me rephrase a bit.
>>>>>
>>>>> The proposal is looking very close to the following case:
>>>>> - raw sparse file
>>>>>
>>>>> In this case all writes are very-very-very fast and from the
>>>>> guest point of view all is OK. Sequential data is really sequential.
>>>>> Though once we are starting to perform any sequential IO, we
>>>>> have real pain. Each sequential operation becomes random
>>>>> on the host file system and the IO becomes very slow. This
>>>>> will not be observed with the test, but the performance will
>>>>> degrade very soon.
>>>>>
>>>>> This is why raw sparse files are not used in the real life.
>>>>> Hypervisor must maintain guest OS invariants and the data,
>>>>> which is nearby from the guest point of view should be kept
>>>>> nearby in host.
>>>>>
>>>>> This is why actually that 64kb data blocks are extremely
>>>>> small :) OK. This is offtopic.
>>>> Not necessarily. Using subclusters may allow you to ramp up to larger
>>>> cluster sizes. We can also set up our allocation (and pre-allocation
>>>> schemes) so that we always reserve an entire cluster on the host at the
>>>> time we allocate the cluster, even if we only plan to write to
>>>> particular subclusters within that cluster.  In fact, 32 subclusters to
>>>> a 2M cluster results in 64k subclusters, where you are still writing at
>>>> 64k data chunks but could now have guaranteed 2M locality, compared to
>>>> the current qcow2 with 64k clusters that writes in 64k data chunks but
>>>> with no locality.
>>>>
>>>> Just because we don't write the entire cluster up front does not mean
>>>> that we don't have to allocate (or have a mode that allocates) the
>>>> entire cluster at the time of the first subcluster use.
>>> this is something that I do not understand. We reserve the entire cluster at
>>> allocation. Why do we need sub-clusters at cluster "creation" without COW?
>>> fallocate() and preallocation completely covers this stage for now in
>>> full and
>>> solve all botllenecks we have. 4k/8k granularity of L2 cache solves metadata
>>> write problem. But IMHO it is not important. Normally we sync metadata
>>> at guest sync.
>>>
>>> The only difference I am observing in this case is "copy-on-write" pattern
>>> of the load with backing store or snapshot, where we copy only partial
>>> cluster.
>>> Thus we should clearly define that this is the only area of improvement and
>>> start discussion from this point. Simple cluster creation is not the problem
>>> anymore. I think that this reduces the scope of the proposal a lot.
>> I think subclusters have two different valid use cases:
>>
>> 1. The first one is what you describe and what I was mostly interested
>>    in: By reducing the subcluster size to the file system block size, we
>>    can completely avoid any COW because there won't be partial writes
>>    any more.
>>
>>    You attended my KVM Forum talk two years ago where I described how
>>    COW is the biggest pain point for qcow2 performance, costing about
>>    50% of performance for initial writes after taking a snapshot. So
>>    while you're right that many other improvements are possible, I think
>>    this is one of the most important points to address.
>>
>> 2. The other use case is what Berto had in mind: Keep subclusters at the
>>    current cluster size (to avoid getting even larger COWs), but
>>    increase the cluster size. This reduces the metadata size and allows
>>    to cover a larger range with the same L2 cache size. Additionally, it
>>    can possibly reduce fragmentation of the image on the file system
>>    level.
>>
>> The fundamental observation in both cases is that it's impractical to
>> use the same granularity for cluster mapping (want larger sizes) and for
>> status tracking (want small sizes to avoid partial writes).
> Fragmented images are very good at the initial moment once the
> IO is coming first time in small pieces. But it becomes real
> pain later on once guest will REUSE this area for sequential
> data written in big chunks. Or the guest could even read this
> data sequentially later on.
> 
> You will have random read in host instead of sequential read in
> guest. This would be serious performance problem. The guest
> really believes that the data with similar LBAs are adjacent and
> optimize IO keeping this in mind. With clusters/subclusters/etc
> you break this fundamental assumption. This is not visible initially,
> but will trigger later on.
> 

Hi Denis,

I've read this entire thread now and I really like Berto's summary which
I think is one of the best recaps of existing qcow2 problems and this
discussion so far.

I understand your opinion that we should focus on compatible changes
before incompatible ones, and I also understand that you are very
concerned about physical fragmentation for reducing long-term IO.

What I don't understand is why you think that subclusters will increase
fragmentation. If we admit that fragmentation is a problem now, surely
increasing cluster sizes to 1 or 2 MB will only help to *reduce*
physical fragmentation, right?

Subclusters as far as I am understanding them will not actually allow
subclusters to be located at virtually disparate locations, we will
continue to allocate clusters as normal -- we'll just keep track of
which portions of the cluster we've written to to help us optimize COW*.

So if we have a 1MB cluster with 64k subclusters as a hypothetical, if
we write just the first subcluster, we'll have a map like:

X---------------

Whatever actually happens to exist in this space, whether it be a hole
we punched via fallocate or literal zeroes, this space is known to the
filesystem to be contiguous.

If we write to the last subcluster, we'll get:

X--------------X

And again, maybe the dashes are a fallocate hole, maybe they're zeroes.
but the last subcluster is located virtually exactly 15 subclusters
behind the first, they're not physically contiguous. We've saved the
space between them. Future out-of-order writes won't contribute to any
fragmentation, at least at this level.

You might be able to reduce COW from 5 IOPs to 3 IOPs, but if we tune
the subclusters right, we'll have *zero*, won't we?

As far as I can tell, this lets us do a lot of good things all at once:

(1) We get some COW optimizations (for reasons Berto and Kevin have
detailed)
(2) We can increase our cluster size
(3) L2 cache can cover bigger files with less memory
(4) Fragmentation decreases.

Is this not a win all around? We can improve throughput for a lot of
different reasons all at once, here. Have I misunderstood the discussion
so far, anyone?

Please correct me where I am wrong and _ELI5_.

Thanks,
-John

> 
>>> Initial proposal starts from stating 2 problems:
>>>
>>> "1) Reading from or writing to a qcow2 image involves reading the
>>>    corresponding entry on the L2 table that maps the guest address to
>>>    the host address. This is very slow because it involves two I/O
>>>    operations: one on the L2 table and the other one on the actual
>>>    data cluster.
>>>
>>> 2) A cluster is the smallest unit of allocation. Therefore writing a
>>>    mere 512 bytes to an empty disk requires allocating a complete
>>>    cluster and filling it with zeroes (or with data from the backing
>>>    image if there is one). This wastes more disk space and also has a
>>>    negative impact on I/O."
>>>
>>> With pre-allocation (2) would be exactly the same as now and all
>>> gain with sub-clusters will be effectively 0 as we will have to
>>> preallocate entire cluster.
>> To be honest, I'm not sure if we should do preallocation or whether
>> that's the file system's job.
>>
>> In any case, the big improvement is that we don't have to read from the
>> backing file, so even if we keep preallocating the whole cluster, we'd
>> gain something there. I also think that preallocating would use
>> something like fallocate() rather than pwrite(), so it should involve a
>> lot less I/O.
>>
> yes. fallocate() works pretty well and we will have almost
> the same amount of IO as submitted from the guest. This
> also helps a lot for sequential writes not aligned to the
> cluster boundary.
> 
> 
>>> (1) is also questionable. I think that the root of the problem
>>> is the cost of L2 cache miss, which is giant. With 1 Mb or 2 Mb
>>> cluster the cost of the cache miss is not acceptable at all.
>>> With page granularity of L2 cache this problem is seriously
>>> reduced. We can switch to bigger blocks without much problem.
>>> Again, the only problem is COW.
>> Yes, with larger cluster sizes, the L2 cache sucks currently. It needs
>> to be able to cache partial tables.
>>
>> With the currently common cluster sizes, I don't think it makes a big
>> difference, though. As long as you end up making a single request, 4k or
>> 64k size isn't that different, and three 4k requests are almost certainly
>> slower than one 64k request.
>>
>> So I agree, for use case 2, some work on the cache is required in
>> addition to increasing the cluster size.
> This helps even with 64kb cluster size. For the case of the fragmented guest
> filesystem the dataset could be quite fragmented and we an technically use
> much less memory to cover it if we'll use pages clusters.
> 
> 
>>> There are really a lot of other possibilities for viable optimizations,
>>> which
>>> are not yet done on top of proposed ones:
>>> - IO plug/unplug support at QCOW2 level. plug in controller is definitely
>>>   not enough. This affects only the first IO operation while we could have
>>>   a bunch of them
>>> - sort and merge requests list in submit
>>> - direct AIO read/write support to avoid extra coroutine creation for
>>>   read-write ops if we are doing several operations in parallel in
>>>   qcow2_co_readv/writev. Right now AIO operations are emulated
>>>   via coroutines which have some impact
>>> - offload compression/decompression/encryption to side thread
>>> - optimize sequential write operation not aligned to the cluster boundary
>>>   if cluster is not allocated initially
>>>
>>> May be it would be useful to create intermediate DIO structure for IO
>>> operation which will carry offset/iovec on it like done in kernel. I do
>>> think
>>> that such compatible changes could improve raw performance even
>>> with the current format 2-3 times, which is brought out by the proposal.
>> Well, if you can show a concrete optimisation and ideally also numbers,
>> that would certainly be interesting. I am very skeptical of 2-3 times
>> improvement (not the least because we would be well over native
>> performance then...), but I'm happy to be convinced otherwise. Maybe
>> start a new thread like this one if/when you think you have a detailled
>> idea for one of them that is ready for discussion.
>>
>> The one that I actually think could make a big difference for its use
>> case is the compression/decompression/encryption one, but honestly, if
>> someone really cared about these, I think there would be lower hanging
>> fruit (e.g. we're currently reading in data only cluster by cluster for
>> compressed images).
> In progress. Compression has a lot of troubles ;)
> 
> Den
> 
> 

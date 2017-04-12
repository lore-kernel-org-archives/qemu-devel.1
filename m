Received: from eggs.gnu.org ([2001:4830:134:3::10]:60548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyThd-0005se-2E
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cyThZ-0000St-Rk
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:37:41 -0400
Received: from mail-eopbgr30100.outbound.protection.outlook.com
	([40.107.3.100]:35097
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cyThZ-0000ST-29
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 21:37:37 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<b55603db-5215-ac30-29e4-f4764f17c14e@openvz.org>
	<d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <e00ab029-cf9f-5aca-9786-581915dd5189@openvz.org>
Date: Wed, 12 Apr 2017 22:02:30 +0300
MIME-Version: 1.0
In-Reply-To: <d77e0178-8898-3583-ca2c-adf43bf9e0f4@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 04/12/2017 09:20 PM, Eric Blake wrote:
> On 04/12/2017 12:55 PM, Denis V. Lunev wrote:
>> Let me rephrase a bit.
>>
>> The proposal is looking very close to the following case:
>> - raw sparse file
>>
>> In this case all writes are very-very-very fast and from the
>> guest point of view all is OK. Sequential data is really sequential.
>> Though once we are starting to perform any sequential IO, we
>> have real pain. Each sequential operation becomes random
>> on the host file system and the IO becomes very slow. This
>> will not be observed with the test, but the performance will
>> degrade very soon.
>>
>> This is why raw sparse files are not used in the real life.
>> Hypervisor must maintain guest OS invariants and the data,
>> which is nearby from the guest point of view should be kept
>> nearby in host.
>>
>> This is why actually that 64kb data blocks are extremely
>> small :) OK. This is offtopic.
> Not necessarily. Using subclusters may allow you to ramp up to larger
> cluster sizes. We can also set up our allocation (and pre-allocation
> schemes) so that we always reserve an entire cluster on the host at the=

> time we allocate the cluster, even if we only plan to write to
> particular subclusters within that cluster.  In fact, 32 subclusters to=

> a 2M cluster results in 64k subclusters, where you are still writing at=

> 64k data chunks but could now have guaranteed 2M locality, compared to
> the current qcow2 with 64k clusters that writes in 64k data chunks but
> with no locality.
>
> Just because we don't write the entire cluster up front does not mean
> that we don't have to allocate (or have a mode that allocates) the
> entire cluster at the time of the first subcluster use.

this is something that I do not understand. We reserve the entire cluster=
 at
allocation. Why do we need sub-clusters at cluster "creation" without COW=
?
fallocate() and preallocation completely covers this stage for now in
full and
solve all botllenecks we have. 4k/8k granularity of L2 cache solves metad=
ata
write problem. But IMHO it is not important. Normally we sync metadata
at guest sync.

The only difference I am observing in this case is "copy-on-write" patter=
n
of the load with backing store or snapshot, where we copy only partial
cluster.
Thus we should clearly define that this is the only area of improvement a=
nd
start discussion from this point. Simple cluster creation is not the prob=
lem
anymore. I think that this reduces the scope of the proposal a lot.

Initial proposal starts from stating 2 problems:

"1) Reading from or writing to a qcow2 image involves reading the
   corresponding entry on the L2 table that maps the guest address to
   the host address. This is very slow because it involves two I/O
   operations: one on the L2 table and the other one on the actual
   data cluster.

2) A cluster is the smallest unit of allocation. Therefore writing a
   mere 512 bytes to an empty disk requires allocating a complete
   cluster and filling it with zeroes (or with data from the backing
   image if there is one). This wastes more disk space and also has a
   negative impact on I/O."

With pre-allocation (2) would be exactly the same as now and all
gain with sub-clusters will be effectively 0 as we will have to
preallocate entire cluster.

(1) is also questionable. I think that the root of the problem
is the cost of L2 cache miss, which is giant. With 1 Mb or 2 Mb
cluster the cost of the cache miss is not acceptable at all.
With page granularity of L2 cache this problem is seriously
reduced. We can switch to bigger blocks without much problem.
Again, the only problem is COW.

Thus I think that the proposal should be seriously re-analyzed and refine=
d
with this input.

>> One can easily recreate this case using the following simple
>> test:
>> - write each even 4kb page of the disk, one by one
>> - write each odd 4 kb page of the disk
>> - run sequential read with f.e. 1 MB data block
>>
>> Normally we should still have native performance, but
>> with raw sparse files and (as far as understand the
>> proposal) sub-clusters we will have the host IO pattern
>> exactly like random.
> Only if we don't pre-allocate entire clusters at the point that we firs=
t
> touch the cluster.
>
>> This seems like a big and inevitable problem of the approach
>> for me. We still have the potential to improve current
>> algorithms and not introduce non-compatible changes.
>>
>> Sorry if this is too emotional. We have learned above in a
>> very hard way.
> And your experience is useful, as a way to fine-tune this proposal.  Bu=
t
> it doesn't mean we should entirely ditch this proposal.  I also
> appreciate that you have patches in the works to reduce bottlenecks
> (such as turning sub-cluster writes into 3 IOPs rather than 5, by doing=

> read-head, read-tail, write-cluster, instead of the current read-head,
> write-head, write-body, read-tail, write-tail), but think that both
> approaches are complimentary, not orthogonal.
>
Thank you :) I just prefer to dead end with compatible changes and start
incompatible ones after that.

There are really a lot of other possibilities for viable optimizations,
which
are not yet done on top of proposed ones:
- IO plug/unplug support at QCOW2 level. plug in controller is definitely=

  not enough. This affects only the first IO operation while we could hav=
e
  a bunch of them
- sort and merge requests list in submit
- direct AIO read/write support to avoid extra coroutine creation for
  read-write ops if we are doing several operations in parallel in
  qcow2_co_readv/writev. Right now AIO operations are emulated
  via coroutines which have some impact
- offload compression/decompression/encryption to side thread
- optimize sequential write operation not aligned to the cluster boundary=

  if cluster is not allocated initially

May be it would be useful to create intermediate DIO structure for IO
operation which will carry offset/iovec on it like done in kernel. I do
think
that such compatible changes could improve raw performance even
with the current format 2-3 times, which is brought out by the proposal.

Den

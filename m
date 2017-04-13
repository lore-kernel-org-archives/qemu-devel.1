Received: from eggs.gnu.org ([2001:4830:134:3::10]:36260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyegt-0006Wc-4y
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cyegp-0006xo-6b
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 09:21:39 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<2b915695-29b5-df8d-4d89-080eeaaaff13@openvz.org>
	<w51shlcv7sb.fsf@maestria.local.igalia.com>
	<565c1e1b-b9e1-e9c5-790e-283d04afc747@openvz.org>
Date: Thu, 13 Apr 2017 15:21:30 +0200
Message-ID: <w51poggv3xh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 13 Apr 2017 02:44:51 PM CEST, Denis V. Lunev wrote:
>>> 1) current L2 cache management seems very wrong to me. Each cache
>>>     miss means that we have to read entire L2 cache block. This means
>>>     that in the worst case (when dataset of the test does not fit L2
>>>     cache size we read 64kb of L2 table for each 4 kb read).
>>>
>>>     The situation is MUCH worse once we are starting to increase
>>>     cluster size. For 1 Mb blocks we have to read 1 Mb on each cache
>>>     miss.
>>>
>>>     The situation can be cured immediately once we will start reading
>>>     L2 cache with 4 or 8kb chunks. We have patchset for this for our
>>>     downstream and preparing it for upstream.
>> Correct, although the impact of this depends on whether you are using
>> SDD or HDD.
>>
>> With an SSD what you want is to minimize is the number of unnecessary
>> reads, so reading small chunks will likely increase the performance when
>> there's a cache miss.
>>
>> With an HDD what you want is to minimize the number of seeks. Once you
>> have moved the disk head to the location where the cluster is, reading
>> the whole cluster is relatively inexpensive, so (leaving the memory
>> requirements aside) you generally want to read as much as possible.
> no! This greatly helps for HDD too!
>
> The reason is that you cover areas of the virtual disk much more
> precise.  There is very simple example. Let us assume that I have
> f.e. 1 TB virtual HDD with 1 MB block size. As far as I understand
> right now L2 cache for the case consists of 4 L2 clusters.
>
> So, I can exhaust current cache only with 5 requests and each actual
> read will costs L2 table read. This is a read problem. This condition
> could happen on fragmented FS without a problem.

But what you're saying is that this makes a more efficient use of cache
memory.

If the guest OS has a lot of unused space but is very fragmented then
you don't want to fill up your cache with L2 entries that are not going
to be used. It's better to read smaller chunks from the L2 table so
there are fewer chances of having to evict entries from the
cache. Therefore this results in less cache misses and better I/O
performance.

Ok, this sounds perfectly reasonable to me.

If the cache is however big enough for the whole disk then you never
need to evict entries, so with an HDD you actually want to take
advantage of disk seeks and read as many L2 entries as possible.

However it's true that in this case this will only affect the initial
reads. Once the cache is full there's no need to read the L2 tables from
disk anymore and the performance will be the same, so your point remains
valid.

Still, one of the goals from my proposal is to reduce the amount of
metadata needed for the image. No matter how efficient you make the
cache, the only way to reduce the amount of L2 entries is to increase
the cluster size. And increasing the cluster size results in slower COW
and less efficient use of disk space.

>>>     Another problem is the amount of data written. We are writing
>>>     entire cluster in write operation and this is also insane. It is
>>>     possible to perform fallocate() and actual data write on normal
>>>     modern filesystem.
>> But that only works when filling the cluster with zeroes, doesn't it? If
>> there's a backing image you need to bring all the contents from there.
>
> Yes. Backing images are problems. Though, even with sub-clusters, we
> will suffer exactly the same with the amount of IOPSes as even with
> that head and tail have to be read. If you are spoken about
> subclusters equals to FS block size and avoid COW at all, this would
> be terribly slow later on with sequential reading. In such an approach
> sequential reading will result in random read.
>
> Guest OSes are written keeping in mind that adjacent LBAs are really
> adjacent and reading them sequentially is a very good idea. This
> invariant will be broken for the case of subclusters.

This invariant is already broken by the very design of the qcow2 format,
subclusters don't really add anything new there. For any given cluster
size you can write 4k in every odd cluster, then do the same in every
even cluster, and you'll get an equally fragmented image.

Berto

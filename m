Received: from eggs.gnu.org ([2001:4830:134:3::10]:49082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cGi2x-00077X-Jw
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cGi2w-00018w-Jo
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:02:47 -0500
References: <cover.1481290956.git.berto@igalia.com>
	<468dbeb8-5b1b-669f-f7e5-0d24a4308da8@redhat.com>
	<w51bmwhck1c.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <756cfb05-61e1-7ee3-435b-93759438a52d@redhat.com>
Date: Tue, 13 Dec 2016 09:02:34 +0100
MIME-Version: 1.0
In-Reply-To: <w51bmwhck1c.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 2016-12-12 at 15:13, Alberto Garcia wrote:
> On Fri 09 Dec 2016 03:21:08 PM CET, Max Reitz wrote:
>
>>> In some scenarios, however, there's a different alternative: if the
>>> qcow2 image is stored in a slow backend (eg. HDD), we could save
>>> memory by putting the L2 cache in a faster one (SSD) instead of in
>>> RAM.
>
>> Well, from a full design standpoint, it doesn't make a lot of sense to
>> me:
>>
>> We have a two-level on-disk structure for cluster mapping so as to not
>> waste memory for unused areas and so that we don't need to keep one
>> large continuous chunk of metadata. Accessing the disk is slow, so we
>> also have an in-memory cache which is just a single level fully
>> associative cache replicating the same data (but just a part of it).
>>
>> Now you want to replicate all of it and store it on disk. My mind
>> tells me that is duplicate data: We already have all of the metadata
>> elsewhere on disk, namely in the qcow2 file, and even better, it is
>> not stored in a fully associative structure there but directly mapped,
>> making finding the correct entry much quicker.
>
> Yes but the use case is that the qcow2 image is stored in a slow disk,
> so things will be faster if we avoid having to read it too often.
>
> But the data is there and it needs to be read, so we have three options:
>
>   1) Read it everytime we need it. It slows things down.
>   2) Keep (part of) it in memory. It can use a lot of memory.
>   3) Keep it in a faster disk.
>
> We're talking about 3) here, and this it not about creating new
> structures, but about changing the storage backend of the existing L2
> cache (disk rather than RAM).

I'm arguing that we already have an on-disk L2 structure and that is 
called simply the L1-L2 structure in the qcow2 file. The cache only 
makes sense because it is in RAM.

>> However, the thing is that the existing structures also only exist in
>> the original qcow2 file and cannot be just placed anywhere else, as
>> opposed to our cache. In order to solve this, we would need to
>> (incompatibly) modify the qcow2 format to allow storing data
>> independently from metadata. I think this would be certainly doable,
>> but the question is whether it is worth the effort.
>
> You mean split the qcow2 file in two: data and metadata? I don't think
> it's worth the effort.

That's the thing. I don't know.

I definitely like how simple your approach is, but from a design 
standpoint it is not exactly optimal, because O(n) for a cluster lookup 
is simply worse than O(1).

>> Maybe we can at least make the cache directly mapped if it is supposed
>> to cover the whole image? That is, we would basically just load all of
>> the L2 tables into memory and bypass the existing cache.
>
> I don't see how this addresses the original use case that I described.

It just fixes the issue that the cache is fully associative and then the 
only issue I would have with your approach is that we are keeping 
duplicate data.

> But leaving that aside, would that improve anything? I don't think the
> cache itself adds any significant overhead here, IIRC even in your
> presentation at KVM Forum 2015 qcow2 was comparable to raw as long as
> all L2 tables were cached in memory.

I haven't compared CPU usage, though. That may have gone up quite a bit, 
I don't know. For large enough images, it may even become a bottleneck.

Max

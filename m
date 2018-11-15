Received: from eggs.gnu.org ([2001:4830:134:3::10]:36919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNKRn-0004nx-MS
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNKRm-0004DB-Oz
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:24:51 -0500
References: <20181113230319.1008531-1-eblake@redhat.com>
	<20181113230319.1008531-2-eblake@redhat.com>
	<w51bm6qgyjo.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b60f4624-17d6-c4f9-d6c8-124184470f40@redhat.com>
Date: Thu, 15 Nov 2018 10:24:37 -0600
MIME-Version: 1.0
In-Reply-To: <w51bm6qgyjo.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qcow2: Document some maximum size
 constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On 11/15/18 9:17 AM, Alberto Garcia wrote:
> On Wed 14 Nov 2018 12:03:17 AM CET, Eric Blake wrote:
>> @@ -427,7 +451,9 @@ Standard Cluster Descriptor:
>>   Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>>
>>       Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
>> -                    cluster or sector boundary!
>> +                    cluster or sector boundary!  If cluster_bits is
>> +                    small enough that this field includes bits beyond
>> +                    55, those upper bits must be set to 0.
> 
> While I think that it's good to have a 56 bits upper limit for both
> compressed and uncompressed clusters, I'm wondering: is it theoretically
> possible to have data clusters above 64PB if they're all compressed?

The question is only applicable for cluster sizes of 8k and smaller. 
With an 8k cluster image and the qcow2.h limit of a 32MiB L1 table (4096 
clusters, each of which holds 1024 L2 entries, and each L2 table holds 
1024 cluster entries), you can have up to 4k * 1k * 1k * 8k == 32T of 
guest size.  You'd need a LOT of metadata (for example, over 2000 
internal snapshots) before the host file would reach 64PB to even need 
to store compressed clusters at a host offset that large.  At the same 
time, qemu would limit you to an 8MiB refcount table (1024 clusters, 
each of which holds 1024 refblocks, which in turn hold a default of 4096 
refcounts, but with a refcount_order of 0 could hold 64k refcounts), 
which results in qemu allowing your maximum host offset to be 1k * 1k * 
64k * 8k == 512T, which means qemu will refuse to generate or open such 
an image in the first place.  So if you have an image that tries to 
store a compressed data cluster above host offset 64PB, qemu is unable 
to process that image.

But your question does mean this other part of my patch:

 >
 >            24 - 31:   size
 > -                    Virtual disk size in bytes
 > +                    Virtual disk size in bytes.
 > +
 > +                    Note: with a 2 MB cluster size, the maximum
 > +                    virtual size is 2 EB (61 bits) for a fully sparse
 > +                    file; however, L1/L2 table layouts limit an image
 > +                    to no more than 64 PB (56 bits) of populated
 > +                    clusters, and an image may hit other limits first
 > +                    (such as a file system's maximum size).  With a
 > +                    512 byte cluster size, the maximum virtual size
 > +                    drops to 128 GB (37 bits).

is misleading.  Elsewhere, we mention for cluster_bits:

                     Note: qemu as of today has an implementation limit 
of 2 MB
                     as the maximum cluster size and won't be able to 
open images
                     with larger cluster sizes.

and looking at the code in qcow2.h, the 2EB limits on maximum virtual 
size is NOT an inherent limit in the qcow2 file format, but rather a 
result of qemu's implementation refusing to size the L1 table larger 
than 32MiB.  If you allow a larger L1 table, you can get to larger 
virtual addresses.  So I need to fix this patch [again] to add in 
wording about this being a qemu limit.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnOyZ-0005NL-P8
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnOyT-000344-PB
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:58:11 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f1197908-f00f-1c2b-b63c-3339e39488c5@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-3-lbloch@janustech.com>
	<w51d0utt4kk.fsf@maestria.local.igalia.com>
	<f1197908-f00f-1c2b-b63c-3339e39488c5@janustech.com>
Date: Wed, 08 Aug 2018 15:58:02 +0200
Message-ID: <w517el1t0yd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/5] qcow2: Make the default L2 cache
 sufficient to cover the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 08 Aug 2018 03:07:10 PM CEST, Leonid Bloch wrote:
> On 08/08/2018 03:39 PM, Alberto Garcia wrote:
>> On Wed 08 Aug 2018 09:10:48 AM CEST, Leonid Bloch wrote:
>>> Sufficient L2 cache can noticeably improve the performance when using
>>> large images with frequent I/O. The memory overhead is not significant
>>> in most cases, as the cache size is only 1 MB for each 8 GB of virtual
>>> image size (with the default cluster size of 64 KB). For cases with very
>>> large images and/or small cluster sizes, there is an upper limit on the
>>> default L2 cache: 32 MB.
>> 
>> I find this description a bit confusing.
>> 
>> First of all, because it's not true that the default will cover the
>> whole image: we're just increasing it, but any image > 256GB is going to
>> need more than 32MB (with 64KB clusters, that is).
>
> How about the following:
>
> qcow2: Make the default L2 cache try to cover the entire image

That's what I think it's misleading, the patch only increases the
default cache size value. The current 1MB cache also tries to cover the
entire image, if the entire image is <= 8GB. But there's no new feature
that extends the cache size to cover the entire image. There's no "we
used to cover 8GB images by default, but now we cover all images".

In other words, the message that I think the user should get is: set
l2-cache-size as high as the maximum amount of memory you're willing to
use for the cache, and QEMU will ensure that it will only use as much as
it needs and no extra memory will be wasted. If you're working with a
100GB image it doesn't matter if you set l2-cache-size to 32MB or
1GB. It will use the exact same amount of RAM.

>> The way I see it: there are two simple changes from the user's point of
>> view (they can even be two separate patches).
>> 
>> 1) The default l2-cache-size is now 32MB. DEFAULT_L2_CACHE_CLUSTERS is
>>     useless now and disappears.
> I don't think that it can be a separate patch, because unless the other 
> logic is changed, the cache will occupy 32 MB *always*, regardless of 
> the image size, and that's quite a big and unneeded overhead.

Change the order of both patches then :-)

 1) If l2-cache-size > l2_metadata_size, then make l2-cache-size =
    l2_metadata_size. This is already useful on its own, even with the
    current default of 1MB.

 2) Increase the default to 32MB. This won't waste additional memory for
    small images because of the previous patch, and will cover images up
    to 256GB. If you have larger images you would need to increase
    l2-cache-size manually if you want to cache all the L2 metadata.

The way I see it is that the important change is (1): it's safe to
increase l2-cache-size, it won't waste memory[*]. (2) is nice too
because it will cover larger images by default, but if you're running
VMs with disk images larger than 256GB (which is not an extreme
scenario) you still need to increase the cache.

[*] In practice it's not wasting too much memory even now, because even
if you allocate a 32MB cache but only need 1MB, those extra 31MB are
going to be uninitialized and unused, and therefore not taking up any
physical memory. But you still need to have Qcow2CachedTable structures
for those entries, and any loop that needs to walk Qcow2Cache.entries is
going to be slower. So it's a good idea not to allocate unneeded memory
and to make this an explicit promise to the user.

Berto

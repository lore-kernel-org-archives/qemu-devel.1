Received: from eggs.gnu.org ([2001:4830:134:3::10]:33003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnmuj-0005Au-02
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnmuf-00019e-T8
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:31:48 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4e5aaa3e-0ad5-74b1-2569-7d3cbec279eb@janustech.com>
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-3-lbloch@janustech.com>
	<w51r2j7butk.fsf@maestria.local.igalia.com>
	<4e5aaa3e-0ad5-74b1-2569-7d3cbec279eb@janustech.com>
Date: Thu, 09 Aug 2018 17:31:42 +0200
Message-ID: <w51k1ozblpd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Assign the L2 cache
 relatively to image size
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

On Thu 09 Aug 2018 04:04:23 PM CEST, Leonid Bloch wrote:
>>> -    int min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>>> +    uint64_t min_refcount_cache = MIN_REFCOUNT_CACHE_SIZE * s->cluster_size;
>> 
>> Why do you need to change this data type here? min_refcount_cache is
>> guaranteed to fit in an int.
>
> No necessity here, just it participates in arithmetics with other
> uint64_t's afterwards, so it might as well be uint64_t from the
> get-go.

The compiler already does that when needed, so it's not so important
(and it adds noise to the patch).

>>> -                *refcount_cache_size =
>>> -                    MIN(combined_cache_size, min_refcount_cache);
>>> +                *refcount_cache_size = MIN(combined_cache_size,
>>> +                                           min_refcount_cache);
>> 
>> There are no functional changes, why do you need to change the
>> indentation here?
>
> It's in the "immediate area (few lines) of the lines [I'm] changing".

But there's no need to change those lines unless there's an obvious
mistake. In this case it's just a matter of style so they just add noise
to the patch.

>>> +QEMU will use a default L2 cache sufficient to cover the entire virtual
>>> +size of an image, which with the default cluster size will result in 1 MB
>>> +of cache for every 8 GB of virtual image size:
>> 
>> This is not true. QEMU will use a default size of 32MB, which may or
>> may not cover the entire image.
>
> But no, QEMU will not use a default size of 32MB. It will use a
> default size which is just enough to cover the image, unless the
> needed size is larger than 32 MB.

Now: QEMU will use a default L2 cache of up to 32MB, which may or may
not be enough to cover the entire image.

Previously: QEMU will use a default L2 cache of 1MB, which may or may
not be enough to cover the entire image.

>> I would prefer if you would say "we increased the default cache size
>> so now we cover larger images" instead of "the default cache size
>> will now cover the entire image", because the latter is not true.
>
> But it's not correct: we did not increase the default size, we made
> the default size fit the image size, and set a maximum. It's not the
> same, do you agree?

I don't think we made the default size fit the image size, because if
you override the default size QEMU will still adjust it if it's too
large. What we did is guarantee that QEMU will use *up to* l2-cache-size
bytes, regardless of whether l2-cache-size is set by the user or is the
default value. Plus, we increased that default value to 32MB.

>From the end user's point of view, who had a VM with images of 8GB,
200GB and 2TB, the most visible result is that the L2 cache is now
larger, enough for the first two images but still not enough for the
third. That's the big change, both in terms of performance and memory
usage, and it's easy to measure.

The other change (the cache size fits the image size) is not immediately
visible, and certainly not with a 32MB cache.

Let's make an experiment:

   - Take QEMU stable or master (without these patches)
   - Create a 16GB qcow2 image and fill it completely with data
   - Run QEMU and attach that image with l2-cache-size=2M (2 MB L2 cache)
   - Read the complete image to make sure that all L2 tables are cached
   - Measure the amount of memory that QEMU is using, e.g. with smem
     (you can do that before and after caching the L2 tables)

Repeat the same experiment with l2-cache-size=2G (2 GB L2 cache). Do you
see any difference?

Berto

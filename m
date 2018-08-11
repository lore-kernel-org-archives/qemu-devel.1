Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1foZQZ-0004W3-7W
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 15:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1foZQX-0001hh-Si
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 15:19:55 -0400
References: <20180810062647.23211-1-lbloch@janustech.com>
	<20180810062647.23211-6-lbloch@janustech.com>
	<w51sh3m70ca.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <1475efc2-86af-48d1-5887-bb8a1a3997a7@janustech.com>
Date: Sat, 11 Aug 2018 22:19:31 +0300
MIME-Version: 1.0
In-Reply-To: <w51sh3m70ca.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 5/9] qcow2: Assign the L2 cache
 relatively to the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On 8/10/18 5:39 PM, Alberto Garcia wrote:
> On Fri 10 Aug 2018 08:26:43 AM CEST, Leonid Bloch wrote:
>> Previously, the L2 cache was allocated without considering the image
>> size, and an option existed to manually determine its size.
> 
> This is not quite correct: the L2 cache was set to the maximum needed
> for the image when "cache-size" was large enough:
> 
>          if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
>                  *l2_cache_size = max_l2_cache;
>          } ...
> 
> See below for an example.

You're right. I'll fix that.

> 
>>           } else {
>> -            uint64_t virtual_disk_size = bs->total_sectors * BDRV_SECTOR_SIZE;
>> -            uint64_t max_l2_cache = virtual_disk_size / (s->cluster_size / 8);
>> -
>>               /* Assign as much memory as possible to the L2 cache, and
>>                * use the remainder for the refcount cache */
>> -            if (combined_cache_size >= max_l2_cache + min_refcount_cache) {
>> -                *l2_cache_size = max_l2_cache;
>> +            if (combined_cache_size >= *l2_cache_size + min_refcount_cache) {
> 
> This has an (unintended?) side effect:
> 
> If you have a 1TB qcow2 image and open it with e.g. cache-size=200M,
> with the previous code you would get a 128MB L2 cache (max_l2_cache).
> With the new code you only get 32MB.

Good catch!! Thanks!

> 
> The rest of the function looks good to me now. We're getting close :)
> 
>> - - The default L2 cache size is 8 clusters or 1MB (whichever is more),
>> -   and the minimum is 2 clusters (or 2 cache entries, see below).
>> + - The default L2 cache size will cover the entire virtual size of an
>> +   image, up to a certain maximum. This maximum is 1 MB by default
>> +   (enough for image sizes of up to 8 GB with the default cluster size)
>> +   and it can be reduced or enlarged using the "l2-cache-size" option.
>> +   The minimum is 2 clusters (or 2 cache entries, see below).
> 
> It's not clear with this wording if this "certain maximum" refers to the
> cache size or the image size.

"This maximum is 1 MB by default (enough for image sizes of up to 8 GB 
..." - to me it's quite clear that it speaks of the image size. But I 
guess I can change the wording.

> 
> I'm thinking that perhaps it's clearer if you leave that item unchanged
> and add a new one below, something like:

I can't leave it unchanged for two reasons: (1) "8 clusters or 1MB 
(whichever is more)" (2) "default" - now it is not default, but maximal.
OK, I'll change it to be more clear, incorporating your suggestion from 
below.

> 
> - The L2 cache size setting (regardless of whether it takes the default
>    value or it's set by the user) refers to the maximum size of the L2
>    cache. If QEMU needs less memory to hold all of the image's L2 tables,
>    then that's the actual size of the cache that will be allocated. >
>>    - If the L2 cache is big enough to hold all of the image's L2 tables
>> -   (as explained in the "Choosing the right cache sizes" section
>> -   earlier in this document) then none of this is necessary and you
>> -   can omit the "l2-cache-entry-size" parameter altogether.
>> +   (the default behavior for images of up to 8 GB in size) then none
>> +   of this is necessary and you can omit the "l2-cache-entry-size"
>> +   parameter altogether.
> 
> I think this change is unnecessary :-?

Maybe I'll just mention the default here? Or refer to the section which 
speaks of the defaults ('as explained in the "Choosing the right cache 
sizes" and "How to configure the cache sizes" sections ...")?

> 
>>   @item refcount-cache-size
>>   The maximum size of the refcount block cache in bytes
>> diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
>> index 87965625d8..e3fb078588 100755
>> --- a/tests/qemu-iotests/137
>> +++ b/tests/qemu-iotests/137
>> @@ -109,7 +109,6 @@ $QEMU_IO \
>>       -c "reopen -o cache-size=1M,l2-cache-size=64k,refcount-cache-size=64k" \
>>       -c "reopen -o cache-size=1M,l2-cache-size=2M" \
>>       -c "reopen -o cache-size=1M,refcount-cache-size=2M" \
>> -    -c "reopen -o l2-cache-size=256T" \
> 
> The "L2 cache size too big" error can still be tested, but you will need
> to create an image large enough to allow such a big cache.
> 
> $ qemu-img create -f qcow2 -o cluster_size=256k hd.qcow2 32P
> $ $QEMU -drive file=hd.qcow2,l2-cache-entry-size=512,l2-cache-size=1T

* 32P qcow2 will take 33M - is it OK to create it just for a test?
* Is it worth to create a special test scenario, with a separate image 
creation, just for that case?

Leonid.

> 
> Berto
> 

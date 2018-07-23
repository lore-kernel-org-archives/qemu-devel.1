Received: from eggs.gnu.org ([2001:4830:134:3::10]:47718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhWOa-0007vF-4h
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhWOU-0007tH-NK
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:40:42 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:46549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhWOU-0007sw-En
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:40:38 -0400
Received: by mail-io0-x244.google.com with SMTP id i18-v6so14864135ioj.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 01:40:38 -0700 (PDT)
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-4-xiaoguangrong@tencent.com>
	<20180723043634.GC2491@xz-mi>
	<8ae4beeb-0c6d-04a1-189a-972bcf342656@gmail.com>
	<20180723080559.GI2491@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <5c288e81-6bd0-2dea-942c-287c30f74d8a@gmail.com>
Date: Mon, 23 Jul 2018 16:40:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180723080559.GI2491@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/23/2018 04:05 PM, Peter Xu wrote:
> On Mon, Jul 23, 2018 at 03:39:18PM +0800, Xiao Guangrong wrote:
>>
>>
>> On 07/23/2018 12:36 PM, Peter Xu wrote:
>>> On Thu, Jul 19, 2018 at 08:15:15PM +0800, guangrong.xiao@gmail.com wrote:
>>>> @@ -1597,6 +1608,24 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>>>>                rs->xbzrle_cache_miss_prev) / iter_count;
>>>>            rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>>>>        }
>>>> +
>>>> +    if (migrate_use_compression()) {
>>>> +        uint64_t comp_pages;
>>>> +
>>>> +        compression_counters.busy_rate = (double)(compression_counters.busy -
>>>> +            rs->compress_thread_busy_prev) / iter_count;
>>>
>>> Here I'm not sure it's correct...
>>>
>>> "iter_count" stands for ramstate.iterations.  It's increased per
>>> ram_find_and_save_block(), so IMHO it might contain multiple guest
>>
>> ram_find_and_save_block() returns if a page is successfully posted and
>> it only posts 1 page out at one time.
> 
> ram_find_and_save_block() calls ram_save_host_page(), and we should be
> sending multiple guest pages in ram_save_host_page() if the host page
> is a huge page?
> 

You're right, thank you for pointing it out.

So, how about introduce a filed, posted_pages, into RAMState that is used
to track total pages posted out.

Then will use this filed to replace 'iter_count' for compression and use
'RAMState.posted_pages - ram_counters.duplicate' to calculate
xbzrle_cache_miss as the zero page is not handled by xbzrle.

Or introduce a new function, total_posted_pages, which returns the
sum of all page counts:

    static total_posted_pages(void)
    {
        return ram_counters.normal + ram_counters.duplicate + compression_counters.pages
               +  xbzrle_counters.pages;
    }

that would be a bit more complexity...

>>
>>> pages.  However compression_counters.busy should be per guest page.
>>>
>>
>> Actually, it's derived from xbzrle_counters.cache_miss_rate:
>>          xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
>>              rs->xbzrle_cache_miss_prev) / iter_count;
> 
> Then this is suspecious to me too...
> 
>>
>>>> +        rs->compress_thread_busy_prev = compression_counters.busy;
>>>> +
>>>> +        comp_pages = compression_counters.pages - rs->compress_pages_prev;
>>>> +        if (comp_pages) {
>>>> +            compression_counters.compression_rate =
>>>> +                (double)(compression_counters.reduced_size -
>>>> +                rs->compress_reduced_size_prev) /
>>>> +                (comp_pages * TARGET_PAGE_SIZE);
>>>> +            rs->compress_pages_prev = compression_counters.pages;
>>>> +            rs->compress_reduced_size_prev = compression_counters.reduced_size;
>>>> +        }
>>>> +    }
>>>>    }
>>>>    static void migration_bitmap_sync(RAMState *rs)
>>>> @@ -1872,6 +1901,9 @@ static void flush_compressed_data(RAMState *rs)
>>>>            qemu_mutex_lock(&comp_param[idx].mutex);
>>>>            if (!comp_param[idx].quit) {
>>>>                len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>>>> +            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
>>>> +            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;
>>>
>>> I would agree with Dave here - why we store the "reduced size" instead
>>> of the size of the compressed data (which I think should be len - 8)?
>>>
>>
>> len-8 is the size of data after compressed rather than the data improved
>> by compression that is not straightforward for the user to see how much
>> the improvement is by applying compression.
>>
>> Hmm... but it is not a big deal to me... :)
> 
> Yeah it might be a personal preference indeed. :)
> 
> It's just natural to do that this way for me since AFAIU the
> compression ratio is defined as:
> 
>                             compressed data size
>    compression ratio =    ------------------------
>                              original data size
> 

Er, we do it as following:
             compression_counters.compression_rate =
                 (double)(compression_counters.reduced_size -
                 rs->compress_reduced_size_prev) /
                 (comp_pages * TARGET_PAGE_SIZE);

We use reduced_size, i.e,:

                              original data size - compressed data size
     compression ratio =    ------------------------
                               original data size

for example, for 100 bytes raw data, if we posted 99 bytes out, then
the compression ration should be 1%.

So if i understand correctly, the reduced_size is really you want? :)

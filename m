Received: from eggs.gnu.org ([2001:4830:134:3::10]:49863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhWaq-00038p-Qi
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhWan-0005Fl-Nt
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:53:24 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:50530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhWan-0005Fg-Hg
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:53:21 -0400
Received: by mail-it0-x243.google.com with SMTP id w16-v6so362579ita.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 01:53:21 -0700 (PDT)
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-9-xiaoguangrong@tencent.com>
	<20180723054903.GH2491@xz-mi>
	<5447275f-fe48-ec8f-399c-1a5530417f65@gmail.com>
	<20180723083551.GK2491@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <b4c7fc2c-5cfe-c207-9c35-060ad0d35f59@gmail.com>
Date: Mon, 23 Jul 2018 16:53:11 +0800
MIME-Version: 1.0
In-Reply-To: <20180723083551.GK2491@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] migration: do not
 flush_compressed_data at the end of each iteration
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



On 07/23/2018 04:35 PM, Peter Xu wrote:
> On Mon, Jul 23, 2018 at 04:05:21PM +0800, Xiao Guangrong wrote:
>>
>>
>> On 07/23/2018 01:49 PM, Peter Xu wrote:
>>> On Thu, Jul 19, 2018 at 08:15:20PM +0800, guangrong.xiao@gmail.com wrote:
>>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>
>>>> flush_compressed_data() needs to wait all compression threads to
>>>> finish their work, after that all threads are free until the
>>>> migration feeds new request to them, reducing its call can improve
>>>> the throughput and use CPU resource more effectively
>>>>
>>>> We do not need to flush all threads at the end of iteration, the
>>>> data can be kept locally until the memory block is changed or
>>>> memory migration starts over in that case we will meet a dirtied
>>>> page which may still exists in compression threads's ring
>>>>
>>>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>> ---
>>>>    migration/ram.c | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index 89305c7af5..fdab13821d 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -315,6 +315,8 @@ struct RAMState {
>>>>        uint64_t iterations;
>>>>        /* number of dirty bits in the bitmap */
>>>>        uint64_t migration_dirty_pages;
>>>> +    /* last dirty_sync_count we have seen */
>>>> +    uint64_t dirty_sync_count;
>>>
>>> Better suffix it with "_prev" as well?  So that we can quickly
>>> identify that it's only a cache and it can be different from the one
>>> in the ram_counters.
>>
>> Indeed, will update it.
>>
>>>
>>>>        /* protects modification of the bitmap */
>>>>        QemuMutex bitmap_mutex;
>>>>        /* The RAMBlock used in the last src_page_requests */
>>>> @@ -2532,6 +2534,7 @@ static void ram_save_cleanup(void *opaque)
>>>>        }
>>>>        xbzrle_cleanup();
>>>> +    flush_compressed_data(*rsp);
>>>
>>> Could I ask why do we need this considering that we have
>>> compress_threads_save_cleanup() right down there?
>>
>> Dave ask it too. :(
>>
>> "This is for the error condition, if any error occurred during live migration,
>> there is no chance to call ram_save_complete. After using the lockless
>> multithreads model, we assert all requests have been handled before destroy
>> the work threads."
>>
>> That makes sure there is nothing left in the threads before doing
>> compress_threads_save_cleanup() as current behavior. For lockless
>> mutilthread model, we check if all requests are free before destroy
>> them.
> 
> But why do we need to explicitly flush it here?  Now in
> compress_threads_save_cleanup() we have qemu_fclose() on the buffers,
> which logically will flush the data and clean up everything too.
> Would that suffice?
> 

Yes, it's sufficient for current thread model, will drop it for now
and add it at the time when the lockless mutilthread model is applied. :)

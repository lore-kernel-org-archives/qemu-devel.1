Received: from eggs.gnu.org ([2001:4830:134:3::10]:49407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f16Qn-0000zJ-UM
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f16Qj-000842-N9
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:27:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:21512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f16Qj-00082c-9R
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 04:27:37 -0400
Message-ID: <5ABB5290.5030801@intel.com>
Date: Wed, 28 Mar 2018 16:30:08 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
	<286AC319A985734F985F78AFA26841F73948919A@shsmsx102.ccr.corp.intel.com>
	<92c7e013-9496-519b-94ff-b1215c6b452d@gmail.com>
	<5ABB447E.5070308@intel.com> <20180328073723.GD29554@xz-mi>
In-Reply-To: <20180328073723.GD29554@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Xiao Guangrong <xiaoguangrong@tencent.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 03/28/2018 03:37 PM, Peter Xu wrote:
> On Wed, Mar 28, 2018 at 03:30:06PM +0800, Wei Wang wrote:
>> On 03/27/2018 11:24 PM, Xiao Guangrong wrote:
>>>
>>> On 03/28/2018 11:01 AM, Wang, Wei W wrote:
>>>> On Tuesday, March 13, 2018 3:58 PM, Xiao Guangrong wrote:
>>>>> As compression is a heavy work, do not do it in migration
>>>>> thread, instead, we
>>>>> post it out as a normal page
>>>>>
>>>>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>>
>>>> Hi Guangrong,
>>>>
>>>> Dave asked me to help review your patch, so I will just drop my 2
>>>> cents wherever possible, and hope that could be inspiring for your
>>>> work.
>>> Thank you both for the nice help on the work. :)
>>>
>>>>
>>>>> ---
>>>>>    migration/ram.c | 32 ++++++++++++++++----------------
>>>>>    1 file changed, 16 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/migration/ram.c b/migration/ram.c index
>>>>> 7266351fd0..615693f180 100644
>>>>> --- a/migration/ram.c
>>>>> +++ b/migration/ram.c
>>>>> @@ -1132,7 +1132,7 @@ static int ram_save_compressed_page(RAMState
>>>>> *rs, PageSearchStatus *pss,
>>>>>        int pages = -1;
>>>>>        uint64_t bytes_xmit = 0;
>>>>>        uint8_t *p;
>>>>> -    int ret, blen;
>>>>> +    int ret;
>>>>>        RAMBlock *block = pss->block;
>>>>>        ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
>>>>>
>>>>> @@ -1162,23 +1162,23 @@ static int
>>>>> ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>>>>>            if (block != rs->last_sent_block) {
>>>>>                flush_compressed_data(rs);
>>>>>                pages = save_zero_page(rs, block, offset);
>>>>> -            if (pages == -1) {
>>>>> -                /* Make sure the first page is sent out before
>>>>> other pages */
>>>>> -                bytes_xmit = save_page_header(rs, rs->f, block,
>>>>> offset |
>>>>> - RAM_SAVE_FLAG_COMPRESS_PAGE);
>>>>> -                blen = qemu_put_compression_data(rs->f, p,
>>>>> TARGET_PAGE_SIZE,
>>>>> - migrate_compress_level());
>>>>> -                if (blen > 0) {
>>>>> -                    ram_counters.transferred += bytes_xmit + blen;
>>>>> -                    ram_counters.normal++;
>>>>> -                    pages = 1;
>>>>> -                } else {
>>>>> -                    qemu_file_set_error(rs->f, blen);
>>>>> -                    error_report("compressed data failed!");
>>>>> -                }
>>>>> -            }
>>>>>                if (pages > 0) {
>>>>>                    ram_release_pages(block->idstr, offset, pages);
>>>>> +            } else {
>>>>> +                /*
>>>>> +                 * Make sure the first page is sent out before
>>>>> other pages.
>>>>> +                 *
>>>>> +                 * we post it as normal page as compression
>>>>> will take much
>>>>> +                 * CPU resource.
>>>>> +                 */
>>>>> +                ram_counters.transferred +=
>>>>> save_page_header(rs, rs->f, block,
>>>>> +                                                offset |
>>>>> RAM_SAVE_FLAG_PAGE);
>>>>> +                qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
>>>>> +                                      migrate_release_ram() &
>>>>> + migration_in_postcopy());
>>>>> +                ram_counters.transferred += TARGET_PAGE_SIZE;
>>>>> +                ram_counters.normal++;
>>>>> +                pages = 1;
>>>>>                }
>>>>>            } else {
>>>>>                pages = save_zero_page(rs, block, offset);
>>>>> -- 
>>>> I agree that this patch is an improvement for the current
>>>> implementation. So just pile up mine here:
>>>> Reviewed-by: Wei Wang <wei.w.wang@intel.com>
>>> Thanks.
>>>
>>>>
>>>> If you are interested in something more aggressive, I can share an
>>>> alternative approach, which I think would be better. Please see
>>>> below.
>>>>
>>>> Actually, we can use the multi-threaded compression for the first
>>>> page as well, which will not block the migration thread progress.
>>>> The advantage is that we can enjoy the compression benefit for the
>>>> first page and meanwhile not blocking the migration thread - the
>>>> page is given to a compression thread and compressed asynchronously
>>>> to the migration thread execution.
>>>>
>>> Yes, it is a good point.
>>>
>>>> The main barrier to achieving the above that is that we need to make
>>>> sure the first page of each block is sent first in the
>>>> multi-threaded environment. We can twist the current implementation
>>>> to achieve that, which is not hard:
>>>>
>>>> For example, we can add a new flag to RAMBlock - bool
>>>> first_page_added. In each thread of compression, they need
>>>> 1) check if this is the first page of the block.
>>>> 2) If it is the first page, set block->first_page_added after
>>>> sending the page;
>>>> 3) If it is not the first the page, wait to send the page only when
>>>> block->first_page_added is set.
>>>
>>> So there is another barrier introduced which hurts the parallel...
>>>
>>> Hmm, we need more deliberate consideration on this point, let me think
>>> it over after this work.
>>>
>> Sure. Just a reminder, this doesn't have to be a barrier to the compression,
>> it is just used to serialize sending the pages.
>>
>> Btw, this reminds me a possible bug in this patch (also in the current
>> upstream code): there appears to be no guarantee that the first page will be
>> sent before others. The migration thread and the compression thread use
>> different buffers. The migration thread just puts the first page into its
>> buffer first,  the second page is put to the compression thread buffer
>> later. There appears to be no guarantee that the migration thread will flush
>> its buffer before the compression thread.
> IIUC finally the compression buffers will be queued into the migration
> IO stream, so they are still serialized.
>
> In compress_page_with_multi_thread() there is:
>
>          bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>
> comp_param[idx].file should be the compression buffer.
>
> rs->f should be the migration IO stream.

OK, thanks. It turns out that the comp_param[idx].file is not writable 
currently. This needs an extra copy, which could be avoided with the 
above approach.

Best,
Wei

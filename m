Received: from eggs.gnu.org ([2001:4830:134:3::10]:49476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dL3Oh-00047v-A9
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dL3Oe-0006cR-2O
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:11:27 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:65115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dL3Od-0006bk-OH
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:11:23 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORJ005ZK2QTIJ20@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:11:17 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <333c1e15-6c3c-5668-58cc-280bcf941692@samsung.com>
Date: Wed, 14 Jun 2017 11:11:14 +0300
MIME-version: 1.0
In-reply-to: <20170614065313.GJ11751@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1497346593-8791-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170613093801eucas1p1e2b34c1a72b7150a28007d5b187da82e@eucas1p1.samsung.com>
	<1497346593-8791-3-git-send-email-a.perevalov@samsung.com>
	<20170614051223.GH11751@pxdev.xzpeter.org>
	<516e826e-5469-81b6-b23b-12f9b759bd64@samsung.com>
	<20170614065313.GJ11751@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

On 06/14/2017 09:53 AM, Peter Xu wrote:
> On Wed, Jun 14, 2017 at 09:39:53AM +0300, Alexey Perevalov wrote:
>> On 06/14/2017 08:12 AM, Peter Xu wrote:
>>> On Tue, Jun 13, 2017 at 12:36:33PM +0300, Alexey Perevalov wrote:
>>>> This patch adds ability to track down already copied
>>>> pages, it's necessary for calculation vCPU block time in
>>>> postcopy migration feature, maybe for restore after
>>>> postcopy migration failure.
>>>> Also it's necessary to solve shared memory issue in
>>>> postcopy livemigration. Information about copied pages
>>>> will be transferred to the software virtual bridge
>>>> (e.g. OVS-VSWITCHD), to avoid fallocate (unmap) for
>>>> already copied pages. fallocate syscall is required for
>>>> remmaped shared memory, due to remmaping itself blocks
>>>> ioctl(UFFDIO_COPY, ioctl in this case will end with EEXIT
>>>> error (struct page is exists after remmap).
>>>>
>>>> Bitmap is placed into RAMBlock as another postcopy/precopy
>>>> related bitmaps.
>>>>
>>>> copied bitmap is not releasing due to ramblocks is not releasing
>>>> too.
>>>>
>>>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>>>> ---
>>>>   include/exec/ram_addr.h       |  3 +++
>>>>   include/migration/migration.h |  3 +++
>>>>   migration/postcopy-ram.c      |  7 ++++++
>>>>   migration/ram.c               | 54 ++++++++++++++++++++++++++++++++++++++++++-
>>>>   migration/ram.h               |  5 ++++
>>>>   migration/savevm.c            |  1 +
>>>>   6 files changed, 72 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>>>> index 140efa8..56cdf16 100644
>>>> --- a/include/exec/ram_addr.h
>>>> +++ b/include/exec/ram_addr.h
>>>> @@ -47,6 +47,9 @@ struct RAMBlock {
>>>>        * of the postcopy phase
>>>>        */
>>>>       unsigned long *unsentmap;
>>>> +    /* bitmap of already copied pages in postcopy */
>>>> +    unsigned long *copiedmap;
>>>> +    size_t nr_copiedmap;
>>> Do we really need this?
>> This and question about
>>
>> ram_discard_range Juan already asked.
>> I just repeat nr_copiedmap - premature optimization )
>> ram_discard_range - I forgot to clean up patch.
>>
>>>>   };
>>>>   static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
>>>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>>>> index 79b5484..8005c11 100644
>>>> --- a/include/migration/migration.h
>>>> +++ b/include/migration/migration.h
>>>> @@ -226,4 +226,7 @@ void savevm_skip_configuration(void);
>>>>   int global_state_store(void);
>>>>   void global_state_store_running(void);
>>>> +size_t get_copiedmap_size(RAMBlock *rb);
>>>> +void movecopiedmap(void *dst, RAMBlock *rb, size_t len);
>>>> +
>>>>   #endif
>>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>>> index f6244ee..e13b22e 100644
>>>> --- a/migration/postcopy-ram.c
>>>> +++ b/migration/postcopy-ram.c
>>>> @@ -576,6 +576,13 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
>>>>       copy_struct.len = pagesize;
>>>>       copy_struct.mode = 0;
>>>> +
>>>> +    /* copied page isn't feature of blocktime calculation,
>>>> +     * it's more general entity, so keep it here,
>>>> +     * but gup betwean two following operation could be high,
>>>> +     * and in this case blocktime for such small interval will be lost */
>>>> +    set_copiedmap_by_addr(host, rb);
>>>> +
>>> I guess this is not enough?
>> yes, zero pages were missed
>>> For postcopy, you may have missed to trap in
>>> postcopy_place_page_zero() when pagesize == getpagesize() (we used
>>> UFFDIO_ZEROPAGE there)?
>>>
>>> (Btw, why not we trap all these in ram_load_postcopy()?)
>> I tried to place
>>
>> set_copiedmap_by_addr as closer as possible to ioctl. It could be important to reduce probability of
>> race, also when I inform OVS-VSWITCH (patches not yet published), it's important to reduce time between
>> mark page as copied and really coping.
> If so, I would suggest we comment this in the codes.
>
> Btw, could you elaborate a bit in detail on why you need to "reduce
> the time" here? IMHO the ordering should matter and I can understand
> (and actually we can also achieve the ordering requirement if we put
> this handling in ram_load_postcopy()), but I cannot really understand
> when you say "it's important to reduce time between A and B"...
Yes, it worth to describe it in details,
on one hand we decided to call mark_postcopy_blocktime_end before ioctl, 
because
we worried about another page fault between ioctl and 
mark_postcopy_blocktime_end
(on the same vCPU as for page fault for current ioctl)
previous pagefault ( details here Message-ID: 
<20170524112220.GJ3873@pxdev.xzpeter.org>)
on other hand I'm sending copied bitmap to the OVS-VSWITCHD, that bitmap 
is necessary to make
fallocate there, otherwise ioctl UFFDIO_COPY will return EEXITS,
page will be remmaped after VHOST_USER_SET_MEM_TABLE on OVS side (second 
mmap of currently discarded page).

Above, I described problem of shared memory with OVS,
we discussed it with David, but not yet, publicly in qemu-devel list 
(may on redhat's bugzilla).
Sorry, it's not a topic of that discussion, but...

Of course reducing time between mark page as copied and real ioctl is 
not solution, here could be following
solutions:
     1. bitmap which indicates that page was really copied successfully, 
but it's yet another bit map.
     2. every time after ioctl UFFDIO_COPY, send notification to 
OVS-VSWITCH, OVS is discarding that page
if it was an EEXIST error,
and postcopy_place_page is repeats copying page.


>
> Thanks,
>

-- 
Best regards,
Alexey Perevalov

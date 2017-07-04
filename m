Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSJBR-0001ta-PZ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSJBN-0000Nj-PZ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:27:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSJBN-0000Mb-Fq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:27:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v648Pd7a015970
	for <qemu-devel@nongnu.org>; Tue, 4 Jul 2017 04:27:39 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bfurjsjh8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:27:39 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 4 Jul 2017 04:27:38 -0400
References: <75a4c5ff-385e-31ac-5f86-883b082cd94e@de.ibm.com>
	<20170424143516.GD2075@work-vm>
	<5c0608dd-ba22-dc09-71a1-bb95c977f77d@de.ibm.com>
	<20170424191202.GQ2362@work-vm>
	<097a5085-1128-cf2d-abc4-54660a608f36@de.ibm.com>
	<20170426110144.GF2098@work-vm>
	<cbf8c55d-9473-9f6f-eb89-779afe7c1fd2@de.ibm.com>
	<cec279c5-9900-ca28-103b-b95c36d9d989@de.ibm.com>
	<20170630163139.GC2437@work-vm>
	<20170703192353-mutt-send-email-mst@kernel.org>
	<20170703190728.GE2206@work-vm>
	<55708cff-cdda-9b1d-2106-1c6d2774f890@de.ibm.com>
	<20170704101643.3c20f745@mschwideX1>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 4 Jul 2017 10:27:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170704101643.3c20f745@mschwideX1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <28943fd0-65f1-732c-884c-0958da6bd510@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, thuth@redhat.com, Andrea Arcangeli <aarcange@redhat.com>

On 07/04/2017 10:16 AM, Martin Schwidefsky wrote:
> On Tue, 4 Jul 2017 09:48:11 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 07/03/2017 09:07 PM, Dr. David Alan Gilbert wrote:
>>> * Michael S. Tsirkin (mst@redhat.com) wrote:  
>>>> On Fri, Jun 30, 2017 at 05:31:39PM +0100, Dr. David Alan Gilbert wrote:  
>>>>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:  
>>>>>> On 04/26/2017 01:45 PM, Christian Borntraeger wrote:
>>>>>>  
>>>>>>>> Hmm, I have a theory, if the flags field has bit 1 set, i.e. RAM_SAVE_FLAG_COMPRESS
>>>>>>>> then try changing ram_handle_compressed to always do the memset.  
>>>>>>>
>>>>>>> FWIW, changing ram_handle_compressed to always memset makes the problem go away.  
>>>>>>
>>>>>> It is still running fine now with the "always memset change"  
>>>>>
>>>>> Did we ever nail down a fix for this; as I remember Andrea said
>>>>> we shouldn't need to do that memset, but we came to the conclusion
>>>>> it was something specific to how s390 protection keys worked.
>>>>>
>>>>> Dave  
>>>>
>>>> No we didn't. Let's merge that for now, with a comment that
>>>> we don't really understand what's going on?  
>>>
>>> Hmm no, I don't really want to change the !s390 behaviour, especially
>>> since it causes allocation that we otherwise avoid and Andrea's
>>> reply tothe original post pointed out it's not necessary.  
>>
>>
>> Since storage keys are per physical page we must not have shared pages.
>> Therefore in s390_enable_skey we already do a break_ksm (via ksm_madvise),
>> in other words we already allocate pages on the keyless->keyed switch.
>>
>> So why not do the same for zero pages - instead of invalidating the page
>> table entry, lets just do a proper COW.
>>
>> Something like this maybe (Andrea, Martin any better way to do that?)
>>
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 4fb3d3c..11475c7 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -2149,13 +2149,18 @@ EXPORT_SYMBOL_GPL(s390_enable_sie);
>>  static int __s390_enable_skey(pte_t *pte, unsigned long addr,
>>                               unsigned long next, struct mm_walk *walk)yy
>>  {
>> +       struct page *page;
>>         /*
>> -        * Remove all zero page mappings,
>> +        * Remove all zero page mappings with a COW
>>          * after establishing a policy to forbid zero page mappings
>>          * following faults for that page will get fresh anonymous pages
>>          */
>> -       if (is_zero_pfn(pte_pfn(*pte)))
>> -               ptep_xchg_direct(walk->mm, addr, pte, __pte(_PAGE_INVALID));
>> +       if (is_zero_pfn(pte_pfn(*pte))) {
>> +               if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
>> +                       put_page(page);
>> +               else
>> +                       return -ENOMEM;
>> +       }
>>         /* Clear storage key */
>>         ptep_zap_key(walk->mm, addr, pte);
>>         return 0;
> 
> I do not quite get the problem here. The zero-page mappings are always
> marked as _PAGE_SPECIAL. These should be safe to replace with an empty
> pte. We do mark all VMAs as unmergeable prior to the page table walk
> that replaces all zero-page mappings. What is the get_user_pages() call
> supposed to do?

the problem is that postcopy migration will do a read on the target system
for zero pages (to fault in zero pages).
The logic in postcopy then relies on this page never ever delivering a 
userfault again.

If we now enable keys on the target host, we will break the zero pages with
an empty PTE (lazy faulting).
With an empty pte we will get a userfault for this if this page is accesses
again on the target. Now postcopy "knows" that this page was already transferred
and bascially ignores this fault. Since postcopy will never resolve this
userfault the guest will hang.

Received: from eggs.gnu.org ([208.118.235.92]:60173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gfIqO-0006dG-Ew
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 01:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gfIqL-00038j-8q
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 01:20:32 -0500
Received: from m50-112.126.com ([123.125.50.112]:56792)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gfIqK-00036o-GF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 01:20:29 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-11-fli@suse.com>
	<20190102023609.GC27457@umbus.fritz.box>
	<2c10669c-2f43-6b98-ef02-c4b2edbd21ad@126.com>
	<20190103034305.GQ10853@umbus.fritz.box>
	<76ea4ac2-e60f-b762-a365-5924445ccd6c@126.com>
	<20190104052101.GE2801@umbus.fritz.box>
From: Fei Li <lifei1214@126.com>
Message-ID: <6a32da60-86c9-da75-0ac7-fbac93be5370@126.com>
Date: Fri, 4 Jan 2019 14:20:10 +0800
MIME-Version: 1.0
In-Reply-To: <20190104052101.GE2801@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 10/16] qemu_thread: supplement
 error handling for h_resize_hpt_prepare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, shirley17fei@gmail.com, Markus Armbruster <armbru@redhat.com>


在 2019/1/4 下午1:21, David Gibson 写道:
> On Thu, Jan 03, 2019 at 09:41:49PM +0800, Fei Li wrote:
>> 在 2019/1/3 上午11:43, David Gibson 写道:
>>> On Wed, Jan 02, 2019 at 02:44:17PM +0800, 李菲 wrote:
>>>> 在 2019/1/2 上午10:36, David Gibson 写道:
>>>>> On Tue, Dec 25, 2018 at 10:04:43PM +0800, Fei Li wrote:
>>>>>> Add a local_err to hold the error, and return the corresponding
>>>>>> error code to replace the temporary &error_abort.
>>>>>>
>>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>> Cc: David Gibson <david@gibson.dropbear.id.au>
>>>>>> Signed-off-by: Fei Li <fli@suse.com>
>>>>> This looks like a good change, but it no longer applies due to a
>>>>> change in the qemu_thread_create() signature.
>>>> Sorry that I am not sure whether I understand. Do you mean using
>>>> &error_abort is more suitable for this handling, rather than report
>>>> the &local_err & return a failure reason?
>>> No, I just mean that context has been altered by a global change and
>>> the patch will need to be fixed up to cope with that.
>> Just to be clearer: does the "global change" mean the "[patch 06/16]
>> qemu_thread: Make qemu_thread_create() handle errors properly", or another
>> patch not in this patch series?
>>
>> If it means the [patch 06/16], I want to explain more: the 06/16 handles all
>> qemu_thread_create() by passing &error_abort as the parameter, and the
>> following patches are to improve on the &error_abort for callers who can
>> handle more properly. E.g. if qemu_thread_create() fails in
>> h_resize_hpt_prepare(),
>> I think reporting the &local_err & returning the failure reason is more
>> proper
>> than just abort() inside qemu_thread_create() when calls error_setg_errno().
>>
>> In other words, this patch is actually written to apply to patch 06. And I
>> have
>> no clue where it needs to be fixed up. Please correct me if I understand
>> wrong.
>>
>>
>> Have a nice day, thanks :)
> Ah, sorry.  Since I was only CCed on this patch, not the rest of the
> series, I assumed it was independent and didn't think to check the
> earlier patches of the series.
A good reminder, CCing all during the review stage seems more reasonable. :)
>
> So, yes, I think the global change I'm referring to is 6/16, which I
> didn't have, so that explains the problem.
>
> In that case it's probably best if this goes in via the same tree the
> rest of the series is going to.  So, with the H_HARDWARE change made:
>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks for the review!

Have a nice day ;)
Fei
>
>
>> Fei
>>
>>
>>>>>> ---
>>>>>>     hw/ppc/spapr_hcall.c | 12 ++++++++----
>>>>>>     1 file changed, 8 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>>>>> index 5bc2cf4540..7c16ade04a 100644
>>>>>> --- a/hw/ppc/spapr_hcall.c
>>>>>> +++ b/hw/ppc/spapr_hcall.c
>>>>>> @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>>>>>>         sPAPRPendingHPT *pending = spapr->pending_hpt;
>>>>>>         uint64_t current_ram_size;
>>>>>>         int rc;
>>>>>> +    Error *local_err = NULL;
>>>>>>         if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
>>>>>>             return H_AUTHORITY;
>>>>>> @@ -538,10 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>>>>>>         pending->shift = shift;
>>>>>>         pending->ret = H_HARDWARE;
>>>>>> -    /* TODO: let the further caller handle the error instead of abort() here */
>>>>>> -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
>>>>>> -                       hpt_prepare_thread, pending,
>>>>>> -                       QEMU_THREAD_DETACHED, &error_abort);
>>>>>> +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
>>>>>> +                            hpt_prepare_thread, pending,
>>>>>> +                            QEMU_THREAD_DETACHED, &local_err)) {
>>>>>> +        error_reportf_err(local_err, "failed to create hpt_prepare_thread: ");
>>>>>> +        g_free(pending);
>>>>>> +        return H_RESOURCE;
>>>>> I also think H_HARDWARE would be a better choice here.  Although the
>>>>> failure is due to a resource constraint, it's not because the guest
>>>>> asked for too much, just because the host is in dire straits.  From
>>>>> the guest's point of view it's basically a hardware failure.
>>>> Ok, thanks. Will use H_HARDWARE instead.
>>>>
>>>> Have a nice day, thanks for the review. :)
>>>> Fei
>>>>>> +    }
>>>>>>         spapr->pending_hpt = pending;

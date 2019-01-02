Received: from eggs.gnu.org ([208.118.235.92]:59533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1geaGf-0002Tm-Kw
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 01:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1geaGc-0003He-EX
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 01:44:41 -0500
Received: from m50-111.126.com ([123.125.50.111]:32935)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1geaGb-0002wu-Of
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 01:44:38 -0500
References: <20181225140449.15786-1-fli@suse.com>
	<20181225140449.15786-11-fli@suse.com>
	<20190102023609.GC27457@umbus.fritz.box>
From: =?UTF-8?B?5p2O6I+y?= <lifei1214@126.com>
Message-ID: <2c10669c-2f43-6b98-ef02-c4b2edbd21ad@126.com>
Date: Wed, 2 Jan 2019 14:44:17 +0800
MIME-Version: 1.0
In-Reply-To: <20190102023609.GC27457@umbus.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: David Gibson <david@gibson.dropbear.id.au>, Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, shirley17fei@gmail.com, Markus Armbruster <armbru@redhat.com>


在 2019/1/2 上午10:36, David Gibson 写道:
> On Tue, Dec 25, 2018 at 10:04:43PM +0800, Fei Li wrote:
>> Add a local_err to hold the error, and return the corresponding
>> error code to replace the temporary &error_abort.
>>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Fei Li <fli@suse.com>
> This looks like a good change, but it no longer applies due to a
> change in the qemu_thread_create() signature.
Sorry that I am not sure whether I understand. Do you mean using
&error_abort is more suitable for this handling, rather than report
the &local_err & return a failure reason?
>
>> ---
>>   hw/ppc/spapr_hcall.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 5bc2cf4540..7c16ade04a 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>>       sPAPRPendingHPT *pending = spapr->pending_hpt;
>>       uint64_t current_ram_size;
>>       int rc;
>> +    Error *local_err = NULL;
>>   
>>       if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
>>           return H_AUTHORITY;
>> @@ -538,10 +539,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
>>       pending->shift = shift;
>>       pending->ret = H_HARDWARE;
>>   
>> -    /* TODO: let the further caller handle the error instead of abort() here */
>> -    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
>> -                       hpt_prepare_thread, pending,
>> -                       QEMU_THREAD_DETACHED, &error_abort);
>> +    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
>> +                            hpt_prepare_thread, pending,
>> +                            QEMU_THREAD_DETACHED, &local_err)) {
>> +        error_reportf_err(local_err, "failed to create hpt_prepare_thread: ");
>> +        g_free(pending);
>> +        return H_RESOURCE;
> I also think H_HARDWARE would be a better choice here.  Although the
> failure is due to a resource constraint, it's not because the guest
> asked for too much, just because the host is in dire straits.  From
> the guest's point of view it's basically a hardware failure.

Ok, thanks. Will use H_HARDWARE instead.

Have a nice day, thanks for the review. :)
Fei
>
>> +    }
>>   
>>       spapr->pending_hpt = pending;
>>   

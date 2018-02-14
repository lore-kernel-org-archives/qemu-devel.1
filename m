Received: from eggs.gnu.org ([2001:4830:134:3::10]:37262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1elzP7-00077U-MJ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1elzP2-0002Ih-Pf
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:55:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56952
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1elz3X-0004c1-JR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:33:12 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EFUYIZ147274
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:33:10 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g4pqv3ka5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:33:09 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 10:33:09 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
	<8259c694-3f9a-ce9e-9d1d-252568f3e73a@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 10:33:05 -0500
MIME-Version: 1.0
In-Reply-To: <8259c694-3f9a-ce9e-9d1d-252568f3e73a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ad1e16df-8ebe-5271-b62c-76924c758cbc@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/12] s390-ccw: clear
 pending irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 02/14/2018 05:57 AM, David Hildenbrand wrote:
> On 05.02.2018 21:57, Collin L. Walling wrote:
>> It is possible while waiting for multiple types of external
>> interrupts that we might have pending irqs remaining between
>> irq consumption and irq disabling. Those interrupts could
>> propagate to the guest after IPL completes and cause unwanted
>> behavior.
>>
>> To avoid this, we clear the write event mask to prevent further
>> service interrupts from ASCII events and then consume all pending
>> irqs for a miniscule duration. Once finished, we reset the write
>> event mask and resume business as usual.
>>
>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>> ---
>>   pc-bios/s390-ccw/menu.c | 16 ++++++++++++++++
>>   pc-bios/s390-ccw/sclp.c | 12 ++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index 85d285f..971f6b6 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -64,6 +64,20 @@ static inline bool check_clock_int(void)
>>       return *code == 0x1004;
>>   }
>>   
>> +static void clear_pending_irqs(void)
>> +{
>> +    uint64_t time = 50 * TOD_CLOCK_SECOND / 0x3e8;
>> +
>> +    sclp_clear_write_mask();
>> +
>> +    set_clock_comparator(get_clock() + time);
>> +    enable_clock_int();
>> +    consume_sclp_int();
>> +    disable_clock_int();
>> +
>> +    sclp_setup(); /* re-enable write mask */
>> +}
>> +
>>   static int read_prompt(char *buf, size_t len)
>>   {
>>       char inp[2] = {};
>> @@ -165,6 +179,8 @@ static int get_boot_index(int entries)
>>       sclp_print("\nBooting entry #");
>>       sclp_print(itostr(boot_index, tmp, sizeof(tmp)));
>>   
>> +    clear_pending_irqs();
>> +
>>       return boot_index;
>>   }
>>   
>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>> index 5902d5b..025eb2d 100644
>> --- a/pc-bios/s390-ccw/sclp.c
>> +++ b/pc-bios/s390-ccw/sclp.c
>> @@ -46,6 +46,18 @@ static int sclp_service_call(unsigned int command, void *sccb)
>>           return 0;
>>   }
>>   
>> +void sclp_clear_write_mask(void)
>> +{
>> +    WriteEventMask *sccb = (void *)_sccb;
>> +
>> +    sccb->h.length = sizeof(WriteEventMask);
>> +    sccb->mask_length = sizeof(unsigned int);
>> +    sccb->cp_receive_mask = 0;
>> +    sccb->cp_send_mask = 0;
>> +
>> +    sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
>> +}
>> +
>>   static void sclp_set_write_mask(void)
>>   {
>>       WriteEventMask *sccb = (void *)_sccb;
>>
> 1. CKC interrupts can be cleared by resetting the CKC
> 2. SCLP interrupts can be cleared only via delivery (apart from CPU reset)
>
> So if you have CKC and SCLP pending at the same time, you get the CKC
> delivered first and the SCLP remains pending.
>
> Now, the easiest way to clear that (if you don't know if any is
> pending!) is to simply print a string. Then you know that you have
> exactly one SCLP interrupt pending.
>
> So simply printing a string after potentially reading should be
> sufficient to clear the SCLP interrupt deterministically :)
>


Perhaps it is due to my lack of understanding of how irqs are queued, 
but is it
possible that we could still end up with service interrupts pending in 
the SCLP?
Specifically if we're still accepting external interrupts from 
keystrokes but we
aren't reading anything from the SCLP.

Let's say we have 1 service signal pending and we go to print something. 
This
executes the sclp service call instruction and generates a new service 
signal.
The SCLP would consume one of the service interrupts and write to the 
console.
We still have 1 interrupt pending that we need to deal with.

That 1 pending interrupt could have been generated at any time we're still
listening to activity from the keyboard.

In my next update to this patch, I setup the control program receive mask in
the SCLP only when we need to get input from the user and then clear the 
mask
when we're done. Doing so will make it so we generate an interrupt from
keystrokes ONLY when the mask is set. No external interrupts from 
keystrokes
will be generated when the cp_receive mask is NOT set.

After I clear the cp_receive mask, we consume any leftover interrupts by
calling consume_sclp_int (I also fixup the patch to make sure we only end
irq-clearing on a ckc interrupt -- oops).

Am I at least in the ballpark regarding the problem this patch aims to 
solve?

-- 
- Collin L Walling

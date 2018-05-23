Received: from eggs.gnu.org ([2001:4830:134:3::10]:47495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1fLXqf-00028Y-TN
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1fLXqb-00022T-WE
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:46:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:40704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1fLXqb-00022A-Kj
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:46:49 -0400
Received: by mail-pf0-x244.google.com with SMTP id f189-v6so10869247pfa.7
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:46:49 -0700 (PDT)
References: <1524670052-28373-1-git-send-email-minyard@acm.org>
	<1524670052-28373-3-git-send-email-minyard@acm.org>
	<CAJ+F1C+xyDCjjVhm1ypAEHQ6gSqbHVijYtoJ8n27mTqx+SXTWw@mail.gmail.com>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <d3e4a085-b7ad-82b3-5288-201af7819bce@mvista.com>
Date: Wed, 23 May 2018 12:46:45 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+xyDCjjVhm1ypAEHQ6gSqbHVijYtoJ8n27mTqx+SXTWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v3 2/3] ipmi: Use proper struct reference
 for KCS vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Corey Minyard <minyard@acm.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 05/18/2018 10:45 AM, Marc-André Lureau wrote:
> Hi Corey
>
> On Wed, Apr 25, 2018 at 5:27 PM,  <minyard@acm.org> wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
>> instead create a kcs structure separate and use that.
>>
>> There were also some issues in the state transfer.  The inlen field
>> was not being transferred, so if a transaction was in process during
>> the transfer it would be messed up.  And the use_irq field was
>> transferred, but that should come from the configuration.
>>
>> To fix this, the new VMS_VSTRUCT macros are used so the exact
>> version of the structure can be specified, depending on what
>> version was being received.  So an upgrade should work for KCS.
> Looks good overall,
>
> You could easily split this patch further to help review/bisecting etc.
>
> Introduce VMSTATE_STRUCT, unuse use_irq, introduce version 2, add the
> postload checks.

That's probably fair.  I'll do that for v4.

> You could also help reviewers by giving your test setup, so we can
> more easily reproduce the fix and/or try variants.

Hmm.  That's a little hard.  I'll see what I can do.  Maybe it's not too 
bad,
most distros should have the openipmi library available.

>
> I also wonder if you could have used subsections, but the VSTRUCT type
> seems a good approach to me, David would have to review it though.

Yeah, I think we talked about subsections at one point, but this seemed 
better.
That will have to wait for David.

Thanks,

-corey

>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/ipmi/isa_ipmi_kcs.c | 81 ++++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 66 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
>> index 689587b..a794315 100644
>> --- a/hw/ipmi/isa_ipmi_kcs.c
>> +++ b/hw/ipmi/isa_ipmi_kcs.c
>> @@ -22,6 +22,7 @@
>>    * THE SOFTWARE.
>>    */
>>   #include "qemu/osdep.h"
>> +#include "qemu/log.h"
>>   #include "qapi/error.h"
>>   #include "hw/hw.h"
>>   #include "hw/ipmi/ipmi.h"
>> @@ -422,24 +423,69 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
>>       isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
>>   }
>>
>> -const VMStateDescription vmstate_ISAIPMIKCSDevice = {
>> +static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
>> +{
>> +    IPMIKCS *ik = opaque;
>> +
>> +    /* Make sure all the values are sane. */
>> +    if (ik->outpos >= MAX_IPMI_MSG_SIZE || ik->outlen >= MAX_IPMI_MSG_SIZE ||
>> +        ik->outpos >= ik->outlen) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "ipmi:kcs: vmstate transfer received bad out values: %d %d\n",
>> +                      ik->outpos, ik->outlen);
>> +        ik->outpos = 0;
>> +        ik->outlen = 0;
>> +    }
>> +
>> +    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "ipmi:kcs: vmstate transfer received bad in value: %d\n",
>> +                      ik->inlen);
>> +        ik->inlen = 0;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool vmstate_kcs_before_version2(void *opaque, int version)
>> +{
>> +    return version <= 1;
>> +}
>> +
>> +static const VMStateDescription vmstate_IPMIKCS = {
>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
>> +    .version_id = 2,
>> +    .minimum_version_id = 1,
>> +    .post_load = ipmi_kcs_vmstate_post_load,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
>> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
>> +        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was use_irq */
>> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
>> +        VMSTATE_UINT32(outpos, IPMIKCS),
>> +        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
>> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>> +        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
>> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>> +        VMSTATE_BOOL(write_end, IPMIKCS),
>> +        VMSTATE_UINT8(status_reg, IPMIKCS),
>> +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
>> +        VMSTATE_INT16(data_in_reg, IPMIKCS),
>> +        VMSTATE_INT16(cmd_reg, IPMIKCS),
>> +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
>>       .name = TYPE_IPMI_INTERFACE,
>> -    .version_id = 1,
>> +    .version_id = 2,
>>       .minimum_version_id = 1,
>>       .fields      = (VMStateField[]) {
>> -        VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
>> -        VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
>> -        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
>> -        VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
>> -        VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
>> -        VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
>> -        VMSTATE_UINT8_ARRAY(kcs.inmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
>> -        VMSTATE_BOOL(kcs.write_end, ISAIPMIKCSDevice),
>> -        VMSTATE_UINT8(kcs.status_reg, ISAIPMIKCSDevice),
>> -        VMSTATE_UINT8(kcs.data_out_reg, ISAIPMIKCSDevice),
>> -        VMSTATE_INT16(kcs.data_in_reg, ISAIPMIKCSDevice),
>> -        VMSTATE_INT16(kcs.cmd_reg, ISAIPMIKCSDevice),
>> -        VMSTATE_UINT8(kcs.waiting_rsp, ISAIPMIKCSDevice),
>> +        VMSTATE_VSTRUCT_TEST(kcs, ISAIPMIKCSDevice, vmstate_kcs_before_version2,
>> +                             0, vmstate_IPMIKCS, IPMIKCS, 1),
>> +        VMSTATE_VSTRUCT_V(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS,
>> +                          IPMIKCS, 2),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> @@ -450,6 +496,11 @@ static void isa_ipmi_kcs_init(Object *obj)
>>
>>       ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
>>
>> +    /*
>> +     * Version 1 had an incorrect name, it clashed with the BT
>> +     * IPMI device, so receive it, but transmit a different
>> +     * version.
>> +     */
>>       vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
>>   }
>>
>> --
>> 2.7.4
>>
>>
>
>

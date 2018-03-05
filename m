Received: from eggs.gnu.org ([2001:4830:134:3::10]:41557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1esyyT-0004Rp-3E
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:52:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1esyyP-00088q-4J
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:52:53 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:45208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1esyyO-00087f-Th
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 17:52:49 -0500
Received: by mail-oi0-x22e.google.com with SMTP id j79so13386369oib.12
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 14:52:48 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
	<1520004397-28521-2-git-send-email-minyard@acm.org>
	<20180305140926.GK3131@work-vm>
From: Corey Minyard <minyard@acm.org>
Message-ID: <88433e7c-2e0c-cef8-20a6-4fc9d3cacffb@acm.org>
Date: Mon, 5 Mar 2018 16:52:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180305140926.GK3131@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ipmi: Use proper struct reference
 for KCS vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

On 03/05/2018 08:09 AM, Dr. David Alan Gilbert wrote:
> * minyard@acm.org (minyard@acm.org) wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
>> instead create a kcs structure separate and use that.
>>
>> There were also some issues in the state transfer.  The inlen field
>> was not being transferred, so if a transaction was in process during
>> the transfer it would be messed up.  And the use_irq field was
>> transferred, but that should come from the configuration.
>> And the
>> name on the man VMStateDescription was incorrect, it needed to be
>> differentiated from the BT one.
> I think that's a bigger problem; lets see below.
>
>> To fix this, a new VMStateDescription is added that is hopefully
>> correct, and the old one is kept (modified to remove use_irq) in
>> a way that it can be received from the remote but will not be sent.
>> So an upgrade should work for KCS.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 75 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
>> index 689587b..2a2784d 100644
>> --- a/hw/ipmi/isa_ipmi_kcs.c
>> +++ b/hw/ipmi/isa_ipmi_kcs.c
>> @@ -422,14 +422,86 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
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
>> +        ik->outpos = 0;
>> +        ik->outlen = 0;
>> +    }
>> +
>> +    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
>> +        ik->inlen = 0;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_IPMIKCS = {
>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = ipmi_kcs_vmstate_post_load,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
>> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
>> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
>> +        VMSTATE_UINT32(outpos, IPMIKCS),
>> +        VMSTATE_UINT32(outlen, IPMIKCS),
>> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>> +        VMSTATE_UINT32(inlen, IPMIKCS),
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
>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
>> +    .version_id = 2,
>> +    .minimum_version_id = 2,
>> +    .fields      = (VMStateField[]) {
>> +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
> I've got the following, which is only build tested but:
>
> +static const VMStateDescription vmstate_IPMIKCS = {
> +    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
> +    .version_id = 2,
> +    .minimum_version_id = 1,
> +    .post_load = ipmi_kcs_vmstate_post_load,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> +        VMSTATE_UNUSED(1), /* Was use_irq */
> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> +        VMSTATE_UINT32(outpos, IPMIKCS),
> +        VMSTATE_UINT32_V(outlen, IPMIKCS,2),
> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT32_V(inlen, IPMIKCS,2),
> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_BOOL(write_end, IPMIKCS),
> +        VMSTATE_UINT8(status_reg, IPMIKCS),
> +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
> +        VMSTATE_INT16(data_in_reg, IPMIKCS),
> +        VMSTATE_INT16(cmd_reg, IPMIKCS),
> +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
> +    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
> +    .version_id = 2,
> +    .minimum_version_id = 2,
> +    .fields      = (VMStateField[]) {
> +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS, IPMIKCS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
>
> Note how the outlen and inlen fields use the _V modifier and are only
> bound to v2, and I leave the UNUSED in for use_irq, that means we can
> then mae the vmstate_v1_ISAIPMIKCSDevice just have:
>
> const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
>      .name = TYPE_IPMI_INTERFACE,
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .post_load = ipmi_kcs_v1_vmstate_post_load,
>      .needed = ipmi_kcs_v1_vmstate_needed,
>      .fields      = (VMStateField[]) {
>          VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
>          VMSTATE_END_OF_LIST()
>      }
> };
>
> Note the '1'. in the VMSTATE_STRUCT.
> As I say, that's untested, but if it works it saves a lot of
> duplication.
>

Ah I misunderstood something.  The version is sent for the section, and 
the version
in the VMSTATE_STRUCT() is passed down when the structure is encoded and
decoded.  I was thinking the version was transferred in the protocol, 
but I can see
now that is not the case.

But....

I implement that, and it doesn't work.  It turns out that there is the 
following in
vmstate_load_state():

                } else if (field->flags & VMS_STRUCT) {
                     ret = vmstate_load_state(f, field->vmsd, curr_elem,
field->vmsd->version_id);

So it doesn't matter what is in field->version_id, (which is where you 
say "Note
the '1' in the VMSTATE_STRUCT).  It passes in whatever the most current
version is from the vmsd.

Plus that field value is used to compare for the incoming version. If you
expect that the be the field passed down to the sub-structure, it's going
to need to be a different field.

So this is not going to work, and the fix is not going to be easy, it 
appears.

>> +
>> +/*
>> + * Old version of the vmstate transfer that has a number of issues.
>> + * We changed the vm state description name, so we need a separate
>> + * structure and need to register it separately.
>> + */
>> +static int ipmi_kcs_v1_vmstate_post_load(void *opaque, int version)
>> +{
>> +    ISAIPMIKCSDevice *iik = opaque;
>> +
>> +    return ipmi_kcs_vmstate_post_load(&iik->kcs, version);
>> +}
>> +
>> +static bool ipmi_kcs_v1_vmstate_needed(void *opaque)
>> +{
>> +    /* Never transmit this, it is just for receiving old versions. */
>> +    return false;
>> +}
>> +
>> +const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
>>       .name = TYPE_IPMI_INTERFACE,
>>       .version_id = 1,
>>       .minimum_version_id = 1,
>> +    .post_load = ipmi_kcs_v1_vmstate_post_load,
>> +    .needed = ipmi_kcs_v1_vmstate_needed,
>>       .fields      = (VMStateField[]) {
>>           VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
>>           VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
>> -        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
>> +        VMSTATE_UNUSED(1), /* Was use_irq */
>>           VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
>>           VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
>>           VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
>> @@ -451,6 +523,7 @@ static void isa_ipmi_kcs_init(Object *obj)
>>       ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
>>   
>>       vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
>> +    vmstate_register(NULL, 0, &vmstate_v1_ISAIPMIKCSDevice, iik);
> OK, a bit scary - I don't think anyone else does that trick of
> registering it under two names with a '_needed' always saying false.

Yes, I was wondering if I was abusing that interface.

> So I think we have the istuation where the old version had two things
> with the same name, and if you instantiated both device types you
> probably lost one of them?

Yes, something like that.  Or more likely, the transfer would just fail.

> In the new world both the 'bt' one is incompatible and renamed,
> but this one has the hack to load the old kcs version;  so I guess
> that's OK.
>
> Could you just add a comment above that second vmstate_register
>    ' old version had different (clashing) name, register both'

Certainly.

> However it's worth asking if it's really worth it, if you just ekpt this
> one called TYPE_IPMI_INTERFACE then you wouldn't need that hack, and the
> only downside I can see is that loading an image that had a ipmi-bt
> would fail badly, as opposed to failing clearly.

I was wondering that, too.  I'd be ok with that.

But with the above bug I'm not sure it's possible to fix.  There's no 
way to pass the
version being processed to the handling of vmstate_IPMIKCS.

-corey

>
> Dave
>
>>   }
>>   
>>   static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
>> -- 
>> 2.7.4
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

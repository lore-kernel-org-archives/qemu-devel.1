Received: from eggs.gnu.org ([2001:4830:134:3::10]:52968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1fB5B3-0000T1-OO
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cminyard@mvista.com>) id 1fB5B0-0000WV-Ga
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:08:41 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1fB5B0-0000WF-7I
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 17:08:38 -0400
Received: by mail-oi0-x22e.google.com with SMTP id 11-v6so3456586ois.8
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 14:08:37 -0700 (PDT)
References: <1520004397-28521-1-git-send-email-minyard@acm.org>
	<1520004397-28521-2-git-send-email-minyard@acm.org>
	<20180305140926.GK3131@work-vm>
	<88433e7c-2e0c-cef8-20a6-4fc9d3cacffb@acm.org>
	<20180424153213.GE2521@work-vm>
From: Corey Minyard <cminyard@mvista.com>
Message-ID: <4ba4fef4-b6bd-af54-dbc5-ae4107839da9@mvista.com>
Date: Tue, 24 Apr 2018 16:08:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180424153213.GE2521@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 04/24/2018 10:32 AM, Dr. David Alan Gilbert wrote:
> * Corey Minyard (minyard@acm.org) wrote:
>> On 03/05/2018 08:09 AM, Dr. David Alan Gilbert wrote:
>>> * minyard@acm.org (minyard@acm.org) wrote:
>>>> From: Corey Minyard <cminyard@mvista.com>
>>>>
>>>> The vmstate for isa_ipmi_kcs was referencing into the kcs structure,
>>>> instead create a kcs structure separate and use that.
>>>>
>>>> There were also some issues in the state transfer.  The inlen field
>>>> was not being transferred, so if a transaction was in process during
>>>> the transfer it would be messed up.  And the use_irq field was
>>>> transferred, but that should come from the configuration.
>>>> And the
>>>> name on the man VMStateDescription was incorrect, it needed to be
>>>> differentiated from the BT one.
>>> I think that's a bigger problem; lets see below.
>>>
>>>> To fix this, a new VMStateDescription is added that is hopefully
>>>> correct, and the old one is kept (modified to remove use_irq) in
>>>> a way that it can be received from the remote but will not be sent.
>>>> So an upgrade should work for KCS.
>>>>
>>>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> ---
>>>>    hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 75 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
>>>> index 689587b..2a2784d 100644
>>>> --- a/hw/ipmi/isa_ipmi_kcs.c
>>>> +++ b/hw/ipmi/isa_ipmi_kcs.c
>>>> @@ -422,14 +422,86 @@ static void ipmi_isa_realize(DeviceState *dev, Error **errp)
>>>>        isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
>>>>    }
>>>> -const VMStateDescription vmstate_ISAIPMIKCSDevice = {
>>>> +static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
>>>> +{
>>>> +    IPMIKCS *ik = opaque;
>>>> +
>>>> +    /* Make sure all the values are sane. */
>>>> +    if (ik->outpos >= MAX_IPMI_MSG_SIZE || ik->outlen >= MAX_IPMI_MSG_SIZE ||
>>>> +        ik->outpos >= ik->outlen) {
>>>> +        ik->outpos = 0;
>>>> +        ik->outlen = 0;
>>>> +    }
>>>> +
>>>> +    if (ik->inlen >= MAX_IPMI_MSG_SIZE) {
>>>> +        ik->inlen = 0;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const VMStateDescription vmstate_IPMIKCS = {
>>>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .post_load = ipmi_kcs_vmstate_post_load,
>>>> +    .fields      = (VMStateField[]) {
>>>> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
>>>> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
>>>> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
>>>> +        VMSTATE_UINT32(outpos, IPMIKCS),
>>>> +        VMSTATE_UINT32(outlen, IPMIKCS),
>>>> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>>>> +        VMSTATE_UINT32(inlen, IPMIKCS),
>>>> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>>>> +        VMSTATE_BOOL(write_end, IPMIKCS),
>>>> +        VMSTATE_UINT8(status_reg, IPMIKCS),
>>>> +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
>>>> +        VMSTATE_INT16(data_in_reg, IPMIKCS),
>>>> +        VMSTATE_INT16(cmd_reg, IPMIKCS),
>>>> +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
>>>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
>>>> +    .version_id = 2,
>>>> +    .minimum_version_id = 2,
>>>> +    .fields      = (VMStateField[]) {
>>>> +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>> I've got the following, which is only build tested but:
>>>
>>> +static const VMStateDescription vmstate_IPMIKCS = {
>>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "kcs",
>>> +    .version_id = 2,
>>> +    .minimum_version_id = 1,
>>> +    .post_load = ipmi_kcs_vmstate_post_load,
>>> +    .fields      = (VMStateField[]) {
>>> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
>>> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
>>> +        VMSTATE_UNUSED(1), /* Was use_irq */
>>> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
>>> +        VMSTATE_UINT32(outpos, IPMIKCS),
>>> +        VMSTATE_UINT32_V(outlen, IPMIKCS,2),
>>> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>>> +        VMSTATE_UINT32_V(inlen, IPMIKCS,2),
>>> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
>>> +        VMSTATE_BOOL(write_end, IPMIKCS),
>>> +        VMSTATE_UINT8(status_reg, IPMIKCS),
>>> +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
>>> +        VMSTATE_INT16(data_in_reg, IPMIKCS),
>>> +        VMSTATE_INT16(cmd_reg, IPMIKCS),
>>> +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>> +static const VMStateDescription vmstate_ISAIPMIKCSDevice = {
>>> +    .name = TYPE_IPMI_INTERFACE_PREFIX "isa-kcs",
>>> +    .version_id = 2,
>>> +    .minimum_version_id = 2,
>>> +    .fields      = (VMStateField[]) {
>>> +        VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 2, vmstate_IPMIKCS, IPMIKCS),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>>
>>> Note how the outlen and inlen fields use the _V modifier and are only
>>> bound to v2, and I leave the UNUSED in for use_irq, that means we can
>>> then mae the vmstate_v1_ISAIPMIKCSDevice just have:
>>>
>>> const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
>>>       .name = TYPE_IPMI_INTERFACE,
>>>       .version_id = 1,
>>>       .minimum_version_id = 1,
>>>       .post_load = ipmi_kcs_v1_vmstate_post_load,
>>>       .needed = ipmi_kcs_v1_vmstate_needed,
>>>       .fields      = (VMStateField[]) {
>>>           VMSTATE_STRUCT(kcs, ISAIPMIKCSDevice, 1, vmstate_IPMIKCS, IPMIKCS),
>>>           VMSTATE_END_OF_LIST()
>>>       }
>>> };
>>>
>>> Note the '1'. in the VMSTATE_STRUCT.
>>> As I say, that's untested, but if it works it saves a lot of
>>> duplication.
>>>
>> Ah I misunderstood something.  The version is sent for the section, and the
>> version
>> in the VMSTATE_STRUCT() is passed down when the structure is encoded and
>> decoded.  I was thinking the version was transferred in the protocol, but I
>> can see
>> now that is not the case.
>>
>> But....
>>
>> I implement that, and it doesn't work.  It turns out that there is the
>> following in
>> vmstate_load_state():
>>
>>                 } else if (field->flags & VMS_STRUCT) {
>>                      ret = vmstate_load_state(f, field->vmsd, curr_elem,
>> field->vmsd->version_id);
>>
>> So it doesn't matter what is in field->version_id, (which is where you say
>> "Note
>> the '1' in the VMSTATE_STRUCT).  It passes in whatever the most current
>> version is from the vmsd.
>>
>> Plus that field value is used to compare for the incoming version. If you
>> expect that the be the field passed down to the sub-structure, it's going
>> to need to be a different field.
>>
>> So this is not going to work, and the fix is not going to be easy, it
>> appears.
> I think you're right; so rereading, the 'version' in the
> VMSTATE_STRUCT macro is behaving like as if it was VMSTATE_STRUCT_V
> (named like the other _V macros) - do you agree?
> (In actual fact I can see somewhere I used it like that)

Yes, I agree.

>
> <from your follow on mail>
>
>> I've spent some time looking at this, and my conclusion is that this only
>> works by accident.  There appears to be confusion about what this
>> field does all over the code.
>>
>> I'm willing to put together a patch that clears up the confusion, but it's
>> going to be big and messy.  I could also create a new vmstate type,
>> like VMSTATE_VSTRUCT(), which does what I need, and then we convert
>> everything else over a piece at a time.
> Can you give me some more detail about what you found?
> If as I say above the main problem is that field is really
> operating like a VMSTATE_STRUCT_V then we just need a rename there.
> Adding a new flag/macro like you say for actually selecting the version
> to use in the substructure would be doable if it fits nicely but
> that doesn't seem like as massive change.
> Have you found any places that you think are actually calling it
> with the wrong expectation.

After looking at it again, I'm not sure what I was referring to. But 
there are
places, like the VMSTATE_IDE_xxx() macros in include/hw/ide/internal.h, 
where
the versions seem to be referring to the versions in the target 
structure.  But
that would mean that the structure using the macros would have to be the
same version as what is in the macros for it to all work correctly. And 
I think
it is.

>>>> +
>>>> +/*
>>>> + * Old version of the vmstate transfer that has a number of issues.
>>>> + * We changed the vm state description name, so we need a separate
>>>> + * structure and need to register it separately.
>>>> + */
>>>> +static int ipmi_kcs_v1_vmstate_post_load(void *opaque, int version)
>>>> +{
>>>> +    ISAIPMIKCSDevice *iik = opaque;
>>>> +
>>>> +    return ipmi_kcs_vmstate_post_load(&iik->kcs, version);
>>>> +}
>>>> +
>>>> +static bool ipmi_kcs_v1_vmstate_needed(void *opaque)
>>>> +{
>>>> +    /* Never transmit this, it is just for receiving old versions. */
>>>> +    return false;
>>>> +}
>>>> +
>>>> +const VMStateDescription vmstate_v1_ISAIPMIKCSDevice = {
>>>>        .name = TYPE_IPMI_INTERFACE,
>>>>        .version_id = 1,
>>>>        .minimum_version_id = 1,
>>>> +    .post_load = ipmi_kcs_v1_vmstate_post_load,
>>>> +    .needed = ipmi_kcs_v1_vmstate_needed,
>>>>        .fields      = (VMStateField[]) {
>>>>            VMSTATE_BOOL(kcs.obf_irq_set, ISAIPMIKCSDevice),
>>>>            VMSTATE_BOOL(kcs.atn_irq_set, ISAIPMIKCSDevice),
>>>> -        VMSTATE_BOOL(kcs.use_irq, ISAIPMIKCSDevice),
>>>> +        VMSTATE_UNUSED(1), /* Was use_irq */
>>>>            VMSTATE_BOOL(kcs.irqs_enabled, ISAIPMIKCSDevice),
>>>>            VMSTATE_UINT32(kcs.outpos, ISAIPMIKCSDevice),
>>>>            VMSTATE_UINT8_ARRAY(kcs.outmsg, ISAIPMIKCSDevice, MAX_IPMI_MSG_SIZE),
>>>> @@ -451,6 +523,7 @@ static void isa_ipmi_kcs_init(Object *obj)
>>>>        ipmi_bmc_find_and_link(obj, (Object **) &iik->kcs.bmc);
>>>>        vmstate_register(NULL, 0, &vmstate_ISAIPMIKCSDevice, iik);
>>>> +    vmstate_register(NULL, 0, &vmstate_v1_ISAIPMIKCSDevice, iik);
>>> OK, a bit scary - I don't think anyone else does that trick of
>>> registering it under two names with a '_needed' always saying false.
>> Yes, I was wondering if I was abusing that interface.
>>
>>> So I think we have the istuation where the old version had two things
>>> with the same name, and if you instantiated both device types you
>>> probably lost one of them?
>> Yes, something like that.  Or more likely, the transfer would just fail.
>>
>>> In the new world both the 'bt' one is incompatible and renamed,
>>> but this one has the hack to load the old kcs version;  so I guess
>>> that's OK.
>>>
>>> Could you just add a comment above that second vmstate_register
>>>     ' old version had different (clashing) name, register both'
>> Certainly.
>>
>>> However it's worth asking if it's really worth it, if you just ekpt this
>>> one called TYPE_IPMI_INTERFACE then you wouldn't need that hack, and the
>>> only downside I can see is that loading an image that had a ipmi-bt
>>> would fail badly, as opposed to failing clearly.
>> I was wondering that, too.  I'd be ok with that.
>>
>> But with the above bug I'm not sure it's possible to fix.  There's no way to
>> pass the
>> version being processed to the handling of vmstate_IPMIKCS.
> I think I'd take a fix for that as long as it was relatively small;
> I've got less stomach for a big fix for that field all over the code -
> some well placed comemnts explaining what's going on to the unwary
> would be welcome though.

The use of the _version field in the macros is fairly inconsistent. 
VMSTATE_SINGLE_TEST
has _version, VMSTATE_POINTER has it, VMSTATE_POINTER_TEST does not have 
it, etc.
It would be nice to make it consistent, and I would be willing to work 
on it, but I can
understand why you wouldn't want to do that.  I don't think there is any 
way to do a
small fix that would make any sense, unless it was a bunch of small fixes.

I could add a comment, something like:

/* In the macros below, if there is a _version, that means the macro's
  * field will be processed only if the version being received is >=
  * the _version specified.  In general, if you add a new field, you
  * would increment the structure's version and put that version
  * number into the new field so it would only be processed with the
  * new version.
  *
  * In particular, for VMSTATE_STRUCT() and friends the _version does
  * *NOT* pick the version of the sub-structure.  It works just as
  * specified above.  The version of the top-level structure received
  * is passed down to all sub-structures.  This means that the
  * sub-structures must have version that are compatible with all the
  * structures that use them.
  */

Perhaps not ideal, but probably better than nothing.

I guess I need to re-post my updates to the IPMI driver, then.  I also have
a patch to add a VMSTATE_VSTRUCT() macro that lets you specify the
sub-structure version, and a modified IPMI driver to use it.  It does cut
out a bunch of code.  I'd prefer to wait on those and get the main
changes in first, though.

Thanks,

-corey

>
> Dave
>
>> -corey
>>
>>> Dave
>>>
>>>>    }
>>>>    static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
>>>> -- 
>>>> 2.7.4
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

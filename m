Received: from eggs.gnu.org ([2001:4830:134:3::10]:48466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIENA-0001AL-GY
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fIEN5-0006lt-1o
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fIEN4-0006ld-PA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:22:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4EEJaOE099613
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 10:22:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hyaqcvq4s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 10:22:36 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Mon, 14 May 2018 15:22:34 +0100
References: <20180510000712.6472-1-pasic@linux.ibm.com>
	<20180510000712.6472-2-pasic@linux.ibm.com>
	<20180514141808.78efe5c0.cohuck@redhat.com>
	<ea3c977e-de5c-ed68-fc8d-448efca1d463@linux.ibm.com>
	<20180514154515.056b605f.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 14 May 2018 16:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180514154515.056b605f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2b5d39df-ae97-5fe3-7a1a-658eff5db038@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio-ccw: add force unlimited prefetch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>



On 05/14/2018 03:45 PM, Cornelia Huck wrote:
> On Mon, 14 May 2018 14:40:13 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 05/14/2018 02:18 PM, Cornelia Huck wrote:
>>> On Thu, 10 May 2018 02:07:11 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>    
>>>> There is at least one control program (guest) that although it does not
>>>
>>> I'd drop 'control program' here as well, as it probably confuses more
>>> than helps.
>>>    
>>
>> Will do (everywhere).
>>
>>>> rely on the guarantees provided by ORB 1 word 9 bit (aka unlimited
>>>> prefetch, aka P bit) not being set, fails to tell this to the machine.
>>>>
>>>> Usually this ain't a big deal, as the story is usually about performance
>>>> optimizations only. But vfio-ccw can not provide the guarantees required
>>>> if the bit is not set.
>>>
>>> Isn't that also about channel program rewriting? Or am I mixing things
>>> up?
>>>    
>>
>> I don't understand the question. Can you rephrase it (maybe with more
>> details)?
> 
> If the caller doesn't allow prefetching, it may manipulate parts of the
> channel program that have not yet been fetched. For example, setting a
> suspend flag and manipulating ccws that come after that. (I think the
> ctc and lcs drivers do something like that, or at least did in the
> past.)
> 

Yes. Sorry I did not understand rewriting. I usually refer to the same
as self modifying channel programs. Typical example would be the ccw-IPL
scheme.

I think a suspend actually would not hurt us. The driver would
issue a RSCH and we can happily translate the new stuff. OTOH if the reads
modify the channel program we have no chance to do the translation for the
parts of the channel program that were not there at the beginning.

>>
>>>>
>>>> Since it is impossible to implement support for P bit not set (at
>>>> impossible least without transitioning to lower level protocols) in
>>>> vfio-ccw let's provide a manual override.
>>>
>>> Hm... so the basic idea seems to be "we don't support !PFCH, but we
>>> know that the guest will not rely on the guarantees, so we provide the
>>> host admin with a way to override the setting"?
>>>    
>>
>> That is the idea, although I'm not sure what 'the setting' is.
> 
> Lack of coffee :) I meant 'handling'.
> 

:)

Would you like your rephrasing somehow included in the commit message
or are we fine as is?

>>
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
>>>> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>> ---
>>>>    hw/s390x/css.c |  3 +--
>>>>    hw/vfio/ccw.c  | 13 +++++++++++++
>>>>    2 files changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>>> index 301bf1772f..32f1b2820d 100644
>>>> --- a/hw/s390x/css.c
>>>> +++ b/hw/s390x/css.c
>>>> @@ -1196,8 +1196,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>>>>         * Only support prefetch enable mode.
>>>>         * Only support 64bit addressing idal.
>>>>         */
>>>> -    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>>>> -        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>>>> +    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>>>>            warn_report("vfio-ccw requires PFCH and C64 flags set");
>>>
>>> Adapt this warning?
>>> 

Sorry I forgot this one. I would like to keep it as-is because it's going
away with #2 anyway. Introducing a new message seems like counter productive.
    
>>>>            sch_gen_unit_exception(sch);
>>>>            css_inject_io_interrupt(sch);
>>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>>> index e67392c5f9..32cf606a71 100644
>>>> --- a/hw/vfio/ccw.c
>>>> +++ b/hw/vfio/ccw.c
>>>> @@ -32,6 +32,8 @@ typedef struct VFIOCCWDevice {
>>>>        uint64_t io_region_offset;
>>>>        struct ccw_io_region *io_region;
>>>>        EventNotifier io_notifier;
>>>> +    /* force unlimited prefetch */
>>>> +    bool f_upfch;
>>>
>>> force_unlimited_prefetch? You only use it that often :)
>>>    
>>
>> I would have expected complaints for the property name in the
>> first place. I think we should first find a good name for the
>> property and then consider the rest.
> 
> What about 'force_pfch' (at least matches the name of the bit in the
> code)?
> 

I like upfch more as it really not about forcing any prefetch, but
allowing *unlimited* prefetch for the channel program.

>>
>>>>    } VFIOCCWDevice;
>>>>    
>>>>    static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
>>>> @@ -52,8 +54,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>>>>        S390CCWDevice *cdev = sch->driver_data;
>>>>        VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>>>>        struct ccw_io_region *region = vcdev->io_region;
>>>> +    bool upfch = sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH;
>>>
>>> Frankly, I'd drop that variable...
>>>    
>>>>        int ret;
>>>>    
>>>> +    if (!upfch && !vcdev->f_upfch) {
>>>> +        warn_report("vfio-ccw requires PFCH flag set");
>>>> +        sch_gen_unit_exception(sch);
>>>> +        css_inject_io_interrupt(sch);
>>>> +        return IOINST_CC_EXPECTED;
>>>> +    } else if (!upfch) {
>>>> +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>>>> +    }
>>>
>>> and do
>>>
>>> if (!(sch->orb.ctrl0 & ORB_CTR0_MASK_PFCH)) {
>>>     if (!vcdev->f_upfch) {
>>>       ...error...
>>>     } else {
>>>       ...set bit...
>>>     }
>>> }
>>>
>>> Avoids discussions around variable naming, as well :)
>>>    
>>
>> Seems like more indentation and more lies of code to me, but
>> no strong feelings. It may be easier to read.
> 
> Yes, I think this makes it easier to see which branch is taken.
> 

I will do as requested.

>>
>>>> +
>>>>        QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
>>>>        QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
>>>>        QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
>>>> @@ -429,6 +441,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>>>>    
>>>>    static Property vfio_ccw_properties[] = {
>>>>        DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>>>> +    DEFINE_PROP_BOOL("f-upfch", VFIOCCWDevice, f_upfch, false),
>>>
>>> Any particular reason you want to control this on a device-by-device
>>> level?
>>>    
>>
>> It seemed natural for me. What are our options here? I don't like
>> machine property, as it is not a machine thing.
> 
> On the one hand, we want to accommodate certain guests; on the other
> hand, the guest is free to address different devices in different ways
> (although I would expect the difference to be more by different device
> types).
> 
> In the end, it seems that a per-device property is the easiest approach
> after all. (The admin can probably set this globally, if desired.)

I'm pretty sure globally is doable (global driver.prop=value). Also
this could be a per device driver thing. In vfio-ccw we dont have stuff
like device type modeled. So I think this is really the best we can
do.
  
> 
> Another thought: Should there be a warning logged somewhere if we
> actually force pfch (i.e., not just set the property)?
> 

I don't think so. With libvirt the cmd line gets logged. So we can
tell if the machine was running with this forced or not. This knob
is really (an opt-in) for expert users only.

Furthermore a warning about this may not be very constructive,
as there is not much that can be done to make the warning go away.
IMHO getting used to warnings is not a good thing.

Or am I missing a reason for issuing a warning?

Regards,
Halil

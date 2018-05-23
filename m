Received: from eggs.gnu.org ([2001:4830:134:3::10]:46710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLUoA-0006cU-Le
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLUo6-00063k-Nh
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:32:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fLUo6-00063g-J8
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:32:02 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4NEUDZL120186
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:32:01 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j58g75935-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:32:01 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 23 May 2018 15:31:57 +0100
References: <20180522221655.78979-1-pasic@linux.ibm.com>
	<20180522221655.78979-2-pasic@linux.ibm.com>
	<20180523113708.50b21a77.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 23 May 2018 16:31:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180523113708.50b21a77.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a3ab7dfd-4cc1-5632-1590-bce4a40f063e@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 1/2] vfio-ccw: add force
 unlimited prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05/23/2018 11:37 AM, Cornelia Huck wrote:
> On Wed, 23 May 2018 00:16:54 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> There is at least one guest (OS) such that although it does not rely on
>> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
>> P bit) not being set, it fails to tell this to the machine.
>>
>> Usually this ain't a big deal, as the original purpose of the P bit is to
>> allow for performance optimizations. vfio-ccw however can not provide the
>> guarantees required if the bit is not set.
>>
>> It is impossible to implement support for P bit not set (at impossible
>> least without transitioning to lower level protocols) for vfio-ccw.
> 
> "It is not possible to implement support for the P bit not set without
> transitioning to lower level protocols for vfio-ccw."
> > ?

Sounds much better. My sentence is ungrammatical.

> 
>> So
>> let's give the user the opportunity to force the P bit to set, if the
> 
> s/to set/to be set/
> 

Why do we need the 'be'?

>> user knows this is safe.  For self modifying channel programs forcing the
>> P bit is not safe. If P bit is forced for a self modifying channel
> 
> s/P bit/the P bit/
> 

Right.

>> program things are expected to break in strange ways.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
>> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
>>
>> ---
>> v1 -> v2:
>> * reworded commit message
>> * re-factored the code (Connie)
>> * added warning when the P bit is forced the first time (Connie)
>>
>> ---
>>   hw/s390x/css.c |  3 +--
>>   hw/vfio/ccw.c  | 25 +++++++++++++++++++++++++
>>   2 files changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 56c3fa8c89..39ae5bbf7e 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -1204,8 +1204,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>>        * Only support prefetch enable mode.
>>        * Only support 64bit addressing idal.
>>        */
>> -    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>> -        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>> +    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>>           warn_report("vfio-ccw requires PFCH and C64 flags set");
>>           sch_gen_unit_exception(sch);
>>           css_inject_io_interrupt(sch);
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index e67392c5f9..62de4c9710 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -32,8 +32,20 @@ typedef struct VFIOCCWDevice {
>>       uint64_t io_region_offset;
>>       struct ccw_io_region *io_region;
>>       EventNotifier io_notifier;
>> +    bool force_orb_pfch;
>> +    bool warned_force_orb_pfch;
>>   } VFIOCCWDevice;
>>   
>> +#define WARN_ONCE(warned, fmt...) \
>> +({\
>> +if (!(warned)) {\
>> +    warn_report((fmt));\
>> +} \
>> +warned = true;\
>> +})
> 
> I think introducing a macro for the single user is overkill here.
> 
> We might contemplate a generic "print this error once, controlled by
> this flag" functionality, if there are more users.
>

I would prefer keeping the macro. If this generic functionality comes
along it will be easier to spot the home-brewn counterpart. Also it's
easier to read IMHO. BTW the macro could be an inline function like:

  static inline void warn_once(bool *warned, const char *fmt, ...)
{
     va_list ap;


     if (!warned || *warned) {
         return;
     }
     *warned= true;
     va_start(ap, fmt);
     vreport(REPORT_TYPE_WARNING, fmt, ap);
     va_end(ap);
}

if that's better.

>> +
>> +
>> +
>>   static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset = false;
>> @@ -54,6 +66,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>>       struct ccw_io_region *region = vcdev->io_region;
>>       int ret;
>>   
>> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
>> +        if (!(vcdev->force_orb_pfch)) {
>> +            warn_report("vfio-ccw requires PFCH flag set");
>> +            sch_gen_unit_exception(sch);
>> +            css_inject_io_interrupt(sch);
>> +            return IOINST_CC_EXPECTED;
>> +        } else {
>> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>> +            WARN_ONCE(vcdev->warned_force_orb_pfch, "PFCH flag forced");
> 
> This message should probably mention vfio-ccw as well as the subchannel
> id?
> 

I was thinking about this. I think all it would make sense to have a common
prefix for all reports coming form vfio-ccw (QEMU). But then I was like, that
is a separate patch.

Maybe something like:
vfio-ccw (xx.xx.xxxx): specific message

OTOH we don't seem to do that elsewhere (git grep -e 'warn\|error_report\|error_setg' -- hw/s390x/).
AFAIR the error_setg captures context (like, src, line, func) but does not
necessarily report it. Another question is if this should be extended to
hw/s390x/s390-ccw.c

What do you think?


>> +        }
>> +    }
>> +
>>       QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
>>       QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
>>       QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
>> @@ -429,6 +453,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>>   
>>   static Property vfio_ccw_properties[] = {
>>       DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>> +    DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
> 
> Otherwise, the changes look good.
> 

I guess there will be a v3 then.

Thanks!

Halil

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLWYR-0003oX-CP
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLWYM-00051W-BO
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:23:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fLWYM-00051F-1p
	for qemu-devel@nongnu.org; Wed, 23 May 2018 12:23:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4NGJA7w067434
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 12:23:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j5advctra-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 12:23:52 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Wed, 23 May 2018 17:23:50 +0100
References: <20180522221655.78979-1-pasic@linux.ibm.com>
	<20180522221655.78979-2-pasic@linux.ibm.com>
	<20180523113708.50b21a77.cohuck@redhat.com>
	<a3ab7dfd-4cc1-5632-1590-bce4a40f063e@linux.ibm.com>
	<20180523164640.225908a9.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 23 May 2018 18:23:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180523164640.225908a9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5de50b20-a331-78ea-a7f4-6fdd995ed083@linux.ibm.com>
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



On 05/23/2018 04:46 PM, Cornelia Huck wrote:
>>>> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
>>>> +        if (!(vcdev->force_orb_pfch)) {
>>>> +            warn_report("vfio-ccw requires PFCH flag set");
>>>> +            sch_gen_unit_exception(sch);
>>>> +            css_inject_io_interrupt(sch);
>>>> +            return IOINST_CC_EXPECTED;
>>>> +        } else {
>>>> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
>>>> +            WARN_ONCE(vcdev->warned_force_orb_pfch, "PFCH flag forced");
>>> This message should probably mention vfio-ccw as well as the subchannel
>>> id?
>>>    
>> I was thinking about this. I think all it would make sense to have a common
>> prefix for all reports coming form vfio-ccw (QEMU). But then I was like, that
>> is a separate patch.
>>
>> Maybe something like:
>> vfio-ccw (xx.xx.xxxx): specific message
>>
>> OTOH we don't seem to do that elsewhere (git grep -e 'warn\|error_report\|error_setg' -- hw/s390x/).
>> AFAIR the error_setg captures context (like, src, line, func) but does not
>> necessarily report it. Another question is if this should be extended to
>> hw/s390x/s390-ccw.c
>>
>> What do you think?
> I'm not sure that makes sense, especially as not everything might
> explicitly refer to a certain subchannel.
> 
> Let's just add the subchannel id here? In this case, this is really a
> useful piece of information (which device is showing this behaviour?)
> 

The same applies to  warn_report("vfio-ccw requires PFCH flag set") (that is,
on which device (that has no force-orb-pfch=on specified)  is the guest issuing
ORBs with the PFCH unset), or?
Should I go for
"vfio-ccw (xx.xx.xxxx): vfio-ccw requires PFCH flag set"
and
"vfio-ccw (xx.xx.xxxx): PFCH flag forced"
or just for the second one, or some third option?

Regards,
Halil

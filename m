Received: from eggs.gnu.org ([2001:4830:134:3::10]:44934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f6e3g-0003Sf-8v
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f6e3b-00042k-BS
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1f6e3b-00041s-25
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:22:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3CFLiUm124021
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:22:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ha6ag3dr6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:22:36 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 12 Apr 2018 11:22:34 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<3cb8a831-325e-2e1a-3dae-30864df27a75@linux.vnet.ibm.com>
	<20180409113244.380a32c4.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2018 11:22:27 -0400
MIME-Version: 1.0
In-Reply-To: <20180409113244.380a32c4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <17b4ab9b-a8c7-37ec-bae4-c57b146ba0b8@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, eskultet@redhat.com, David Hildenbrand <david@redhat.com>, peter.maydell@linaro.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 04/09/2018 05:32 AM, Cornelia Huck wrote:
> On Fri, 6 Apr 2018 18:07:56 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>
>> On 04/05/2018 06:38 PM, Tony Krowiak wrote:
>>> On 04/03/2018 05:36 AM, Cornelia Huck wrote:
>>>> On Mon, 2 Apr 2018 12:36:27 -0400
>>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>>   
>>>>> On 03/26/2018 05:03 AM, Pierre Morel wrote:
>>>>>> On 26/03/2018 10:32, David Hildenbrand wrote:
>>>>>>> On 16.03.2018 00:24, Tony Krowiak wrote:
>>>>>>>> +    /*
>>>>>>>> +     * The Query Configuration Information (QCI) function (fc == 4)
>>>>>>>> does not
>>>>>>>> +     * set a response code in reg 1, so check for that along with the
>>>>>>>> +     * AP feature.
>>>>>>>> +     */
>>>>>>>> +    if ((fc != 4) && s390_has_feat(S390_FEAT_AP)) {
>>>>>>>> +        env->regs[1] = 0x10000;
>>>>>>>> +
>>>>>>>> +        return 0;
>>>>>>>> +    }
>>>>>>> This would imply an operation exception in case fc==4, which sounds very
>>>>>>> wrong.
>>>>>> It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO must be
>>>>>> tested
>>>>>> to know what to answer.
>>>>>> If the feature is there, QCI must be answered correctly.
>>>>> This is an interesting proposition which raises several issues that will
>>>>> need to
>>>>> be addressed. The only time the PQAP(QCI) instruction is intercepted is
>>>>> when:
>>>>> * A vfio-ap device is NOT defined for the guest because the vfio_ap
>>>>> device driver
>>>>>      will set ECA.28 and the PQAP(QCI) instruction will be interpreted
>>>>> * STFLE.12 is set for the guest
>>>>>
>>>>> You say that the QCI must be answered correctly, but what is the correct
>>>>> response?
>>>>> If we return the matrix - i.e., APM, ADM and AQM - configured via the
>>>>> mediated
>>>>> matrix device's sysfs attributes files, then if any APQNs are defined in
>>>>> the matrix,
>>>>> we will have to handle *ALL* AP instructions by executing them on behalf
>>>>> of the
>>>>> guest. I suppose we could return an empty matrix in which case the AP
>>>>> bus will come
>>>>> up without any devices on the guest, but what is the expectation of an
>>>>> admin who
>>>>> deliberately configures the mediated matrix device? Should we forego
>>>>> handling interception
>>>>> of AP instructions and consider a guest configuration that turns on
>>>>> S390_FEAT_AP but
>>>>> does not define a vfio-ap device to be erroneous and terminate starting
>>>>> of the guest?
>>>>> Anybody have any thoughts?
>>>> Hard to really give good advice without access to the documentation, but:
>>>> - If we tell the guest that the feature is available, but it does not
>>>>     get any cards to use, returning an empty matrix makes the most sense
>>>>     to me.
>>>> - I would not tie starting the guest to the presence of a vfio-ap
>>>>     device. Having the feature available in theory but without any
>>>>     devices actually being usable by the guest does not really sound
>>>>     wrong (can we hotplug this later?)
>>> For this phase of development, it is my opinion that introducing AP instruction
>>> interception handlers is superfluous for the following reasons:
>>>
>>> 1. Interception handling was introduced solely to ensure an operation exception would
>>>     not be injected into the guest when CPU model feature for AP (i.e., ap=on)
>>>     is specified but a VFIO AP device (i.e., -device vfio-ap,sysfsdev=$path)
>>>     is not.
>> We can kind of (i.e. modulo EECA.28) ensure this in a different fashion I think. How
>> about proclaiming a 'has ap instructions, but nothing to see here' in the
>> SIE interpreted flavor (ECA.28 set) the default way of having ap instructions
>> under KVM. This should be easily accomplished with an all zero CRYCB and eca.28
>> set. The for the guest to actually get real work done with AP we would
>> still require some sort of driver to either provide a non-zero matrix by
>> altering the CRYCB or unsettling ECA.28 and doing the intercepted flavor.
>>
>> Please notice, the cpu facility ap would still keep it's semantic
>> 'has ap instructions' (opposed to 'has ap instructions implemented in
>> SIE interpreted flavor). And give us all the flexibility.
>>
>> Yet implementing what we want to have in absence of a driver would become
>> much easier (under the assumption that ECA.28 equals EECA.28).
>>
>> How about this?
> Unfortunately, this is really hard to follow without the AR... let me
> summarize it to check whether I got the gist of it :)
>
> - If the "ap" cpu feature is specified, set a bit that indicates "hey,
>    we basically have have AP support" and create the basics, but don't
>    enable actual SIE handling. This means the guest gets exceptions from
>    the SIE already and we don't need to emulate them.
> - Actually enable the missing pieces if a vfio device is created. This
>    would enable processing by the SIE, and we would not need to do
>    emulation, either (for most of it, IIRC).
>
> I may be all wrong, though... can we at least have a translation of
> ECA.28 and EECA.28 (the "ap is there" bit and the "ap instructions are
> interpreted" bit?)
I am not sure what you are asking here, but I'll attempt to answer the
question I think you are asking.

The ap=on|off flag indicates that AP instructions are installed on the 
guest.
This feature is enabled by the kernel only if AP instructions are installed
on the host. Since there is no facilities bit to query, this is determined
by attempting to execute an AP instruction using an exception table. If 
there
is an exception, it is assumed that the AP instructions are not installed.

The ECA.28 bit in the SIE state description indicates whether AP 
instructions
are interpreted. For level 1 guests, the ECA.28 bit specified in the SIE
state description is used directly. For guest level 2 guests, the value is
calculated by doing a logical AND of the guest level 1 ECA.28 bit and the
guest level 2 ECA.28 bit. This value is known by the term Effective
Execution Control A bit 28, or EECA.28. To the best of my knowledge, - 
as well
as verified empirically, ECA.28 for the linux host (i.e., guest level 1) is
set by default, so EECA.28 will effectively be whatever value is 
specified by
ECA.28 in the level 2 guest's SIE state description. This will not be the
case for guest level 3 when we implement VSIE support.
>

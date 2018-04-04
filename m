Received: from eggs.gnu.org ([2001:4830:134:3::10]:37562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f3olS-0008Fn-A9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 16:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f3olP-0003pP-3E
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 16:12:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1f3olO-0003oy-Rc
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 16:12:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w34KBODE075517
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 16:12:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h53am5ms1-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 16:12:08 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 4 Apr 2018 16:12:06 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<ce32e96c-f448-c375-cc25-96bb3cf35d69@linux.vnet.ibm.com>
	<3735c70a-2b6b-1962-08bb-8badcad7b487@linux.vnet.ibm.com>
	<4866a115-b34d-9a5c-6c73-0d066a9b09b8@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 16:12:00 -0400
MIME-Version: 1.0
In-Reply-To: <4866a115-b34d-9a5c-6c73-0d066a9b09b8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <1dc47cbd-876c-7fb4-defe-cefe95c16b41@linux.vnet.ibm.com>
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 04/04/2018 09:43 AM, Pierre Morel wrote:
> On 04/04/2018 15:33, Tony Krowiak wrote:
>> On 04/04/2018 07:09 AM, Pierre Morel wrote:
>>> On 02/04/2018 18:36, Tony Krowiak wrote:
>>>> On 03/26/2018 05:03 AM, Pierre Morel wrote:
>>>>> On 26/03/2018 10:32, David Hildenbrand wrote:
>>>>>> On 16.03.2018 00:24, Tony Krowiak wrote:
>>>>>>> If the CPU model indicates that AP facility is installed on
>>>>>>> the guest (i.e., -cpu xxxx,ap=on), then the expectation is that
>>>>>>> the AP bus running in the guest will initialize; however, if the
>>>>>>> AP instructions are not being interpreted by the firmware, then
>>>>>>> they will be intercepted and routed back to QEMU for handling.
>>>>>>> If a handler is not defined to process the intercepted instruciton,
>>>>>>> t
>>>>> ...snip...
>>>>>>
>>>>>>> +int ap_device_handle_nqap(S390CPU *cpu)
>>>>>>> +{
>>>>>>> +    CPUS390XState *env = &cpu->env;
>>>>>>> +
>>>>>>> +    if (s390_has_feat(S390_FEAT_AP)) {
>>>>>>> +        env->regs[1] = 0x10000;
>>>>>>> +
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return -EOPNOTSUPP;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int ap_device_handle_dqap(S390CPU *cpu)
>>>>>>> +{
>>>>>>> +    CPUS390XState *env = &cpu->env;
>>>>>>> +
>>>>>>> +    if (s390_has_feat(S390_FEAT_AP)) {
>>>>>>> +        env->regs[1] = 0x10000;
>>>>>>> +
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return -EOPNOTSUPP;
>>>>>>> +}
>>>>>>> +
>>>>>>> +int ap_device_handle_pqap(S390CPU *cpu)
>>>>>>> +{
>>>>>>> +    CPUS390XState *env = &cpu->env;
>>>>>>> +    int fc = 4 & (env->regs[0] >> 24);
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * The Query Configuration Information (QCI) function (fc 
>>>>>>> == 4) does not
>>>>>>> +     * set a response code in reg 1, so check for that along 
>>>>>>> with the
>>>>>>> +     * AP feature.
>>>>>>> +     */
>>>>>>> +    if ((fc != 4) && s390_has_feat(S390_FEAT_AP)) {
>>>>>>> +        env->regs[1] = 0x10000;
>>>>>>> +
>>>>>>> +        return 0;
>>>>>>> +    }
>>>>>> This would imply an operation exception in case fc==4, which 
>>>>>> sounds very
>>>>>> wrong.
>>>>>
>>>>> It depends but I think that the S390_FEAT_AP_QUERY_CONFIG_INFO 
>>>>> must be tested
>>>>> to know what to answer.
>>>>> If the feature is there, QCI must be answered correctly.
>>>> This is an interesting proposition which raises several issues that 
>>>> will need to
>>>> be addressed. The only time the PQAP(QCI) instruction is 
>>>> intercepted is when:
>>>> * A vfio-ap device is NOT defined for the guest because the vfio_ap 
>>>> device driver
>>>>   will set ECA.28 and the PQAP(QCI) instruction will be interpreted
>>>> * STFLE.12 is set for the guest
>>>>
>>>> You say that the QCI must be answered correctly, but what is the 
>>>> correct response?
>>>> If we return the matrix - i.e., APM, ADM and AQM - configured via 
>>>> the mediated
>>>> matrix device's sysfs attributes files, then if any APQNs are 
>>>> defined in the matrix,
>>>> we will have to handle *ALL* AP instructions by executing them on 
>>>> behalf of the
>>>> guest. I suppose we could return an empty matrix in which case the 
>>>> AP bus will come
>>>> up without any devices on the guest, but what is the expectation of 
>>>> an admin who
>>>> deliberately configures the mediated matrix device? Should we 
>>>> forego handling interception
>>>> of AP instructions and consider a guest configuration that turns on 
>>>> S390_FEAT_AP but
>>>> does not define a vfio-ap device to be erroneous and terminate 
>>>> starting of the guest?
>>>> Anybody have any thoughts?
>>>>>
>>>>>
>>>>> there are also some error situations to handle in all three 
>>>>> functions.
>>>> To what error situations are you referring?
>>>
>>> program exceptions, like access, privilege or specification exceptions.
>> Are you suggesting that these handlers need to verify that the 
>> instruction
>> specification is correct? For example, the NQAP instruction - NQAP 
>> r1,r2 -
>> expects an even-odd pair of general registers in the r1 and r2 and must
>> designate an even register; otherwise a specification exception is
>> recognized. Are you saying that the handler for NQAP must verify this
>> requirement and inject a specification exception if it is not met? If 
>> not,
>> then can you provide a specific example of what you are talking about?
>
> Yes I mean this.
>
> But one other thing.
> Returning code 0x01 seems wrong for me, this is right if no AP card
> are in the system but I do not thing that it is what we mean.
I disagree .... for the guest, this is exactly what we mean. In my 
opinion, assigning
AP devices to the mediated matrix device is like assigning AP devices to 
an LPAR.
If no vfio-ap device is defined for the guest, then it is effectively 
the same as
starting a linux host in an LPAR without any AP devices assigned to it.
>
> I think we should return code 0x03 stating that the AP card is not in 
> configured state

>
>
> The difference is that we can get out of a not-configured state with a 
> SCLP command but
> we can not recover from an un-existing APQN.
Remember, this state will occur only when the AP feature of the CPU 
model is turned on for
the guest and no vfio-ap device is defined, so there is no configuration 
to recover for
the guest because no AP devices will be configured for the guest.
>
>
>
>>>
>>>
>>>
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Hard to review without access to documentation. (hard to 
>>>>>> understand why
>>>>>> such stuff is to be kept confidential for decades)
>>>>>>
>>>>>>> +
>>>>>>> +    return -EOPNOTSUPP;
>>>>>>> +}
>>>>>>> +
>>>>>>>   static Property vfio_ap_properties[] = {
>>>>>>>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>>>>>>>       DEFINE_PROP_END_OF_LIST(),
>>>>>>> diff --git a/include/hw/s390x/ap-device.h 
>>>>>>> b/include/hw/s390x/ap-device.h
>>>>>>> index 693df90..d45ae38 100644
>>>>>>> --- a/include/hw/s390x/ap-device.h
>>>>>>> +++ b/include/hw/s390x/ap-device.h
>>>>>>> @@ -11,6 +11,8 @@
>>>>>>>   #ifndef HW_S390X_AP_DEVICE_H
>>>>>>>   #define HW_S390X_AP_DEVICE_H
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
>

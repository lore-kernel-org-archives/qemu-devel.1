Received: from eggs.gnu.org ([2001:4830:134:3::10]:35481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1erqUT-0005KN-9m
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1erqUP-0003vp-TA
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:37:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1erqUP-0003vZ-Jz
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:37:09 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22JYqnk119879
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 14:37:08 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gfbaxkqvc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 14:37:07 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 14:37:05 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
	<c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 14:36:58 -0500
MIME-Version: 1.0
In-Reply-To: <c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ef012d7c-33b8-2a68-070a-65bf881b5e63@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

On 03/01/2018 09:36 AM, David Hildenbrand wrote:
> On 01.03.2018 15:12, Pierre Morel wrote:
>> On 28/02/2018 12:40, Cornelia Huck wrote:
>>> On Wed, 28 Feb 2018 11:26:30 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> Then I request the following change in KVM:
>>>>
>>>> If KVM_S390_VM_CPU_FEAT_AP is enabled in KVM, ECA.28 is _always_ set
>>>> (not just if an AP device is configured). This especially makes things a
>>>> lot easier when it comes to handling hotplugged CPUs and avoiding race
>>>> conditions when enabling these bits as mentioned in the KVM series.
>>>>
>>>> KVM_S390_VM_CPU_FEAT_AP == AP instructions available for the guest
>>>> (don't throw an operation exception).
>>>>
>>>> So this feature then really is guest ABI. The instructions are
>>>> available. If there is no device configured, bad luck.
>>> Sounds sensible from my POV.
>>>
>> I have a concern with this proposition and with the original code:
> Very good, this is exactly what I talked to Conny about yesterday.
>
> Short version: CPU model is guest ABI, everything else is configuration.
>
>> 1) ap=on is a guest ABI feature saying to the guest you can use AP
>> instructions
> Indeed, that's what belongs into the CPU model.
>
>> 2) How we provide AP instructions to the guest can be done in three
>> different ways:
>>    - SIE Interpretation
>>    - interception with VFIO
>>    - interception with emulation
>>
> Due to bad AP design we can't handle this like zPCI - completely in
> QEMU. That's what should control it.
>
>> 3) We implement this with a device in QEMU and a certain level kernel
>> support.
>>
>> It seems possible to set or not ECA.28 , based on the type of kernel device:
>> - SIE interpretation -> MATRIX KVM device -> ECA.28
>> - Interception with VFIO and virtualization -> no ECA.28
>> - interception with emulation -> no ECA.28
>>
>> I understand the concern with the vCPU but I think we can handle it with
>> an indirect variable
>> like:
>>
>> SIE interpretation Device + KVM_S390_VM_CPU_FEAT_AP -> set the variable
>> ap_to_be_sie_interpreted=1
>> Then in vCPU initialization set ECA.28 based on this variable.
> That's exactly why we have the cpu feature interface. E.g. CMMA -> if
> not enabled, not interpreted by HW (however also not intercepted to user
> space - no sense in doing that right now).
I'm not sure I am interpreting what you are saying here correctly, but
in the case of AP, if ECA.28 is not set, the AP instructions will not be
interpreted by HW but WILL be intercepted and forwarded to user space.
>
>> I think it let us more doors open, what is your opinion?
> In general, for now we don't care. The kernel is the only AP bus provider.
>
> If KVM presents AP support -> AP feature can be enabled. And it should
> always enable it.
>
> Once we have a QEMU AP bus implementation, things get more complicated.
> We could provide the AP feature also without KVM (like zPCI).
>
> But weather or not to enable the KVM control has to be concluded from
> the other configuration. Only user space can now that and has to decide
> before enabling AP in KVM.
>
> So I think for now we are fine. Later, this might be tricky to check but
> not impossible.
Maybe we are applying the wrong semantics to this feature. The
premise for this feature was to control the setting of ECA.28.
It grew beyond this premise because of observations related to
future considerations about emulation and full virtualization (i.e.,
the things Pierre mentioned above). Instead of this feature
indicating AP facilities are installed on the guest, it might
behoove us to return to its original intended purpose which was
to indicate that AP instructions executed by the guest are
interpreted by HW. In this case, we can resume setting it in
the vcpu setup like it was in the earlier patch series.
>
>> Regards,
>>
>> Pierre
>>
>>
>

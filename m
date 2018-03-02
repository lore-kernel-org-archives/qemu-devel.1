Received: from eggs.gnu.org ([2001:4830:134:3::10]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ernDs-00061f-Ak
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ernDp-0002Pk-Q3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52588
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1ernDp-0002Lk-Kj
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:07:49 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w22FxoZW109848
	for <qemu-devel@nongnu.org>; Fri, 2 Mar 2018 11:07:48 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gf826ngn9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 11:07:47 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Fri, 2 Mar 2018 11:07:47 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 11:07:41 -0500
MIME-Version: 1.0
In-Reply-To: <b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <176de47c-cc57-79dc-17fe-19079a4e742b@linux.vnet.ibm.com>
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 03/01/2018 09:12 AM, Pierre Morel wrote:
> On 28/02/2018 12:40, Cornelia Huck wrote:
>> On Wed, 28 Feb 2018 11:26:30 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> Then I request the following change in KVM:
>>>
>>> If KVM_S390_VM_CPU_FEAT_AP is enabled in KVM, ECA.28 is _always_ set
>>> (not just if an AP device is configured). This especially makes 
>>> things a
>>> lot easier when it comes to handling hotplugged CPUs and avoiding race
>>> conditions when enabling these bits as mentioned in the KVM series.
>>>
>>> KVM_S390_VM_CPU_FEAT_AP == AP instructions available for the guest
>>> (don't throw an operation exception).
>>>
>>> So this feature then really is guest ABI. The instructions are
>>> available. If there is no device configured, bad luck.
>> Sounds sensible from my POV.
>>
>
> I have a concern with this proposition and with the original code:
>
> 1) ap=on is a guest ABI feature saying to the guest you can use AP 
> instructions
>
> 2) How we provide AP instructions to the guest can be done in three 
> different ways:
>  - SIE Interpretation
>  - interception with VFIO
>  - interception with emulation
>
> 3) We implement this with a device in QEMU and a certain level kernel 
> support.
>
> It seems possible to set or not ECA.28 , based on the type of kernel 
> device:
> - SIE interpretation -> MATRIX KVM device -> ECA.28
> - Interception with VFIO and virtualization -> no ECA.28
> - interception with emulation -> no ECA.28
>
> I understand the concern with the vCPU but I think we can handle it 
> with an indirect variable
> like:
>
> SIE interpretation Device + KVM_S390_VM_CPU_FEAT_AP -> set the 
> variable  ap_to_be_sie_interpreted=1
> Then in vCPU initialization set ECA.28 based on this variable.
>
> I think it let us more doors open, what is your opinion?
I've already implemented a proof of concept similar to what you suggest 
to verify whether it would.
I wasn't completely sure of the flow of control between the KVM 
notification to the device driver
and the vcpu setup. If the variable is set when the device driver is 
notified about KVM,
it has to happen before vcpu setup for this to work. I was able to 
verify that with my proof
of concept. This discussion really belongs in the KVM/kernel patches, so 
I am going to continue
the discussion of my proposal there.
>
> Regards,
>
> Pierre
>
>

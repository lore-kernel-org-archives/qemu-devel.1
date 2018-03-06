Received: from eggs.gnu.org ([2001:4830:134:3::10]:49275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1etGC5-0000dA-WE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1etGC2-0002qU-Oc
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:16:05 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
	<c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
	<c0ff3874-e933-e30b-bc37-60abc4732a23@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <05cd3b46-1fa6-6cf6-b414-5dfa2af13105@redhat.com>
Date: Tue, 6 Mar 2018 18:15:47 +0100
MIME-Version: 1.0
In-Reply-To: <c0ff3874-e933-e30b-bc37-60abc4732a23@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net


>>> 1) ap=on is a guest ABI feature saying to the guest you can use AP
>>> instructions
>> Indeed, that's what belongs into the CPU model.
>>
>>> 2) How we provide AP instructions to the guest can be done in three
>>> different ways:
>>>    - SIE Interpretation
> AP instructions executed on the guest will be interpreted and passed 
> directly
> through to a real AP device installed on the host according to the APQN
> specified in the instruction, so the AP instructions must be available 
> on the
> host.
>>>    - interception with VFIO
> AP instructions executed on the guest will be intercepted, and 
> interpreted by
> QEMU then forwarded to a real AP device installed on the host according 
> to how
> the AP devices are configured in userspace - i.e., whether there is 
> remapping,
> multiplexing or sharing of adapters/domains etc. This also requires that AP
> instructions be available on the host.

See my other mail: I think this is a conflict with vSIE.

>>>    - interception with emulation
> AP instructions executed on the guest will be intercepted, interpreted 
> by QEMU
> and emulated. This will not require AP instructions be available on the 
> host.

See my other mail: I think this is a conflict with vSIE.

> 
> In all cases above, the need to set ECA_APIE is dependent upon the device
> type configured for the guest.
>>>
>> Due to bad AP design we can't handle this like zPCI - completely in
>> QEMU. That's what should control it.
>>
>>> 3) We implement this with a device in QEMU and a certain level kernel
>>> support.
>>>
>>> It seems possible to set or not ECA.28 , based on the type of kernel device:
>>> - SIE interpretation -> MATRIX KVM device -> ECA.28
>>> - Interception with VFIO and virtualization -> no ECA.28
>>> - interception with emulation -> no ECA.28
>>>
>>> I understand the concern with the vCPU but I think we can handle it with
>>> an indirect variable
>>> like:
>>>
>>> SIE interpretation Device + KVM_S390_VM_CPU_FEAT_AP -> set the variable
>>> ap_to_be_sie_interpreted=1
>>> Then in vCPU initialization set ECA.28 based on this variable.
>> That's exactly why we have the cpu feature interface. E.g. CMMA -> if
>> not enabled, not interpreted by HW (however also not intercepted to user
>> space - no sense in doing that right now).
> There are two factors at play here, the device type (i.e., -device 
> vfio_ap) and
> the KVM_S390_VM_CPU_FEAT_AP feature. Setting ECA_APIE makes no sense if the
> vfio_ap device is not configured. For the passthrough implementation, this
> means that the AP bus will successfully load on the guest, but there will
> be no AP devices detected. If the expectation is that ap=on will allow 
> access
> to AP devices on the guest, that would be a mistaken assumption.
> 
> If down the road a new guest AP device is introduced that allows 
> multiplexing,
> device remapping etc., then it will be necessary to intercept AP 
> instructions
> executed on the guest. In this case, if ap=on results in setting ECA_APIE,
> then the instructions will be interpreted and passed through to a device
> that does not exist because it won't be defined in the guest's CRYCB.

Again, see my other mail, this discussion is superfluous if we can't get
vSIE to work with emulated devices. And it smells like this is the case.
But I don't have access to documentation.

> 
> Based on these two scenarios, I think what we are really saying with ap=on
> is that the guest will require use of the AP instructions installed on the
> host. Whether those instructions are executed as a result of interpretation
> by the hardware or because they are executed by the device driver is a
> separate matter. So, I am inclined to agree with Pierre for that reason.
> ECA_APIE should be set only if ap=on (i.e., AP instructions are available
> on the host) and the user of those instructions (i.e., the driver) indicate
> an intent to use them.

ap=on -> set ECA_APIE is what I proposed.

>>
>>> I think it let us more doors open, what is your opinion?
>> In general, for now we don't care. The kernel is the only AP bus provider.
> True today, but not necessarily in the future.

I think so (vSIE).

>>
>> If KVM presents AP support -> AP feature can be enabled. And it should
>> always enable it.
> I disagree for the reasons stated above.

By always enable I of course mean "ap=on" (the point was: independent of
devices right now).




-- 

Thanks,

David / dhildenb

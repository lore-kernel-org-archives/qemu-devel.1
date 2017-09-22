Received: from eggs.gnu.org ([2001:4830:134:3::10]:38947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dvP69-0007yU-Nq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:38:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dvP66-0007qW-J5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:38:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dvP66-0007q7-A4
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:38:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MEZEKG115629
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:38:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d53q3krbe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:38:25 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 22 Sep 2017 15:38:23 +0100
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
	<5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
	<ccb6e3eb-320e-b5dd-f728-09d8cab440c4@de.ibm.com>
	<eee7e600-a8b0-6e23-580b-803f3b4e9efa@linux.vnet.ibm.com>
	<4a31c53b-98aa-747a-1402-1a93e74c565b@de.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 16:38:17 +0200
MIME-Version: 1.0
In-Reply-To: <4a31c53b-98aa-747a-1402-1a93e74c565b@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <3d27a8b0-b212-85f1-c59e-8ca9d972c476@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 22/09/2017 16:07, Christian Borntraeger wrote:
>=20
>=20
> On 09/22/2017 04:02 PM, Pierre Morel wrote:
>> On 22/09/2017 14:40, Christian Borntraeger wrote:
>>>
>>>
>>> On 09/22/2017 02:13 PM, Pierre Morel wrote:
>>>> On 22/09/2017 10:38, Christian Borntraeger wrote:
>>>>> Instead of unconditionally enabling the KVM AIS capability
>>>>> in the kvm arch init function, do this in the flic realize function
>>>>> when we know if migration is available. This requires to initialize
>>>>> flic before the CPUs.
>>>>
>>>> I am not sure to agree.
>>>>
>>>> AIS facility is used for PCI (currently only PCI)
>>>> We want to support PCI emulation and PCI VFIO
>>>>
>>>>
>>>> Not having AIS support in the host kernel or not supporting AISM in =
the host kernel does not affect the emulation.
>>>> Neither virtio-pci nor TCG.
>>>> The only devices, (currently), which can not work without AIS and is=
 not migratable without AISM are PCI VFIO devices.
>>>
>>> This patch enable the conditional enablement facility for the KVM hos=
t mask. The cpu model enablement is done
>>> differently for KVM and TCG anyway.
>>> Right now AIS is only enabled for KVM. For TCG AIS is not implemented=
 at all and disabled. So for whenever this
>>> is fixed in TCG it can be handled then.
>>>
>>> And for emulated devices under KVM you still need the kernel support =
- otherwise migration is really broken for
>>> the nimm/dimm values.
>>>
>>
>> Yes, that is right.
>> I do not pretend that it is working directly.
>>
>> To support AIS emulation we have some work to do there (the migration)=
, in kvm_s390_inject_airq() and other functions using ais_supported, to u=
se emulated values.
>>
>> Don't you think that we could use emulation instead of faulting when t=
he kernel can not handle values needed for pass-through?
>>
>> We can fault at the moment a VFIO device is realized.
>> Migration will be stopped on realizing VFIO PCI devices instead of fli=
c.
>>
>> I can miss something, is there a reason not to do so?
>=20
> The problem is not vfio vs emulation. The problem is that for KVM the k=
ernel is handling the interrupts.
> and it holds the state of the interrupt controller (nimm/dimm) and with=
out an interface to read/write these,
> the PCI core will be in a wrong state after migration regarding AIS.

I am aware of this.

>=20
> Really, this patch just moves the supported host kernel from >=3D4.12 t=
o >=3D4.13. It makes absolutely no
> sense to start having a mixed interrupt stack (qemu + kernel) just to m=
ake this work on 4.12.
>=20
>=20

In fact it would have been for much more than just the 4.12
But OK, I can understand that it makes no sense to discuss this now.
The urgency is to fence 4.12.
Eventually, we can discuss this later.

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany

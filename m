Received: from eggs.gnu.org ([2001:4830:134:3::10]:51600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1etWDs-0000WT-1X
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1etWDo-0001Jz-2g
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:23:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43190
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1etWDn-0001Je-TG
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:22:56 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27AJuvo072521
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 05:22:55 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gjaansc80-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 05:22:54 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 10:22:52 -0000
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<d4d35d0e-b8a4-f30f-f9ad-71c405e80d18@redhat.com>
	<555a7ff8-d724-f040-4ade-3fd4aceaca7d@linux.vnet.ibm.com>
	<4b9bb4fd-d34e-9f46-5414-d6c14e9a6ce8@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 11:22:47 +0100
MIME-Version: 1.0
In-Reply-To: <4b9bb4fd-d34e-9f46-5414-d6c14e9a6ce8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <82740dc5-7213-62b3-5b1c-37e287c31d60@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 06/03/2018 18:10, David Hildenbrand wrote:
>> If L2 forward devices to L3 through SIE ECA.28 but no bit is set is in
>> the CRYCB of L2,
>> L3 will not see any device.
> Exactly and this is the problem: How should L2 know that these devices
> are special and cannot be forwarded.
>
>>> This is what we call the nightmare of nested virtualization (see x86)=
,
>>> because we have to emulate L3 instructions in L1 - but even worse, no=
t
>>> even in L1 kernel space but in L1 user space.
>> As soon as one level begin to virtualize, all levels under it
>> must virtualize too so that L3 instructions will be handled in L2
>> which will issue instructions that will be handled in L1.
> By virtualize I assume you mean emulate? If so, yes.
>
>>> So we could never provide the AP feature reliably with the SIE featur=
e.
>> I think we should change a little this sentence to:
>> We can not provide SIE interpretation to a guest from which
>> any guest level N-1 does not use SIE interpretation.
> Exactly, and as said, there is no way to tell a guest that it has AP bu=
t
> cannot use AP interpretation but has to intercept and handle manually.


vSIE must clear ECA28 during running of the guest if the host itself do=20
not have ECA28 set.
Since ECA28 set for the host means AP instructions available for the host
then we can sum it up by: vSIE should never set ECA28 in the shadow SIE
if no AP instructions available.

Pierre


>
>> Nothing bad will occur for the host, the hardware or other guests,
>> but the guest will just not get any device.
>>
>>> We want to avoid interdependence between CPU features. (because
>>> everything else makes CPU feature detection ugly - CMMA is a good
>>> example and the only exception so far)
>>>
>>>
>>> Long story even shorter:
>>>
>>> No emulated AP devices with KVM.
>>>
>> I agree with: KVM should never set bits in CRYCB for emulated devices.
> I think this is stronger: emulated AP devices should not be used with
> KVM because it can potentially lead to architectural (v)SIE conflicts.
>
> But the details are buried in some AP documentation not accessible to m=
e.
>
> Anyhow, if the scenario I described cannot be worked around via:
>
> a) telling a guest that AP virtualization cannot be used - which doesn'=
t
> seem to be possible
> b) provoking for selected devices a SIE exit when an AP instruction is
> executed on these devices - and this is totally fine with the documente=
d
> AP architecture
>
> I assume we would have to live with !emualted AP devices.
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany

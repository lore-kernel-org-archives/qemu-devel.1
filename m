Received: from eggs.gnu.org ([2001:4830:134:3::10]:48544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1etG6j-0007C8-OD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1etG6g-0000P0-EN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 12:10:33 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<d4d35d0e-b8a4-f30f-f9ad-71c405e80d18@redhat.com>
	<555a7ff8-d724-f040-4ade-3fd4aceaca7d@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4b9bb4fd-d34e-9f46-5414-d6c14e9a6ce8@redhat.com>
Date: Tue, 6 Mar 2018 18:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <555a7ff8-d724-f040-4ade-3fd4aceaca7d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net


> If L2 forward devices to L3 through SIE ECA.28 but no bit is set is in=20
> the CRYCB of L2,
> L3 will not see any device.

Exactly and this is the problem: How should L2 know that these devices
are special and cannot be forwarded.

>=20
>>
>> This is what we call the nightmare of nested virtualization (see x86),
>> because we have to emulate L3 instructions in L1 - but even worse, not
>> even in L1 kernel space but in L1 user space.
>=20
> As soon as one level begin to virtualize, all levels under it
> must virtualize too so that L3 instructions will be handled in L2
> which will issue instructions that will be handled in L1.

By virtualize I assume you mean emulate? If so, yes.

>>
>> So we could never provide the AP feature reliably with the SIE feature=
.
>=20
> I think we should change a little this sentence to:
> We can not provide SIE interpretation to a guest from which
> any guest level N-1 does not use SIE interpretation.

Exactly, and as said, there is no way to tell a guest that it has AP but
cannot use AP interpretation but has to intercept and handle manually.

>=20
> Nothing bad will occur for the host, the hardware or other guests,
> but the guest will just not get any device.
>=20
>> We want to avoid interdependence between CPU features. (because
>> everything else makes CPU feature detection ugly - CMMA is a good
>> example and the only exception so far)
>>
>>
>> Long story even shorter:
>>
>> No emulated AP devices with KVM.
>>
> I agree with: KVM should never set bits in CRYCB for emulated devices.

I think this is stronger: emulated AP devices should not be used with
KVM because it can potentially lead to architectural (v)SIE conflicts.

But the details are buried in some AP documentation not accessible to me.

Anyhow, if the scenario I described cannot be worked around via:

a) telling a guest that AP virtualization cannot be used - which doesn't
seem to be possible
b) provoking for selected devices a SIE exit when an AP instruction is
executed on these devices - and this is totally fine with the documented
AP architecture

I assume we would have to live with !emualted AP devices.

--=20

Thanks,

David / dhildenb

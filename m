Received: from eggs.gnu.org ([2001:4830:134:3::10]:43399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1etFqw-0003Fc-Gx
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1etFqs-0002NW-W2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:54:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1etFqs-0002Mm-Na
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:54:10 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w26Grk9V138169
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 11:54:07 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ghx04k49a-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 11:54:06 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 6 Mar 2018 16:54:04 -0000
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<d4d35d0e-b8a4-f30f-f9ad-71c405e80d18@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 6 Mar 2018 17:53:58 +0100
MIME-Version: 1.0
In-Reply-To: <d4d35d0e-b8a4-f30f-f9ad-71c405e80d18@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <555a7ff8-d724-f040-4ade-3fd4aceaca7d@linux.vnet.ibm.com>
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

On 06/03/2018 11:01, David Hildenbrand wrote:
> On 27.02.2018 16:44, Tony Krowiak wrote:
>> This patch series is the QEMU counterpart to the KVM/kernel support fo=
r
>> guest dedicated crypto adapters. The KVM/kernel model is built on the
>> VFIO mediated device framework and provides the infrastructure for
>> granting exclusive guest access to crypto devices installed on the lin=
ux
>> host. This patch series introduces a new QEMU command line option, QEM=
U
>> object model and CPU model features to exploit the KVM/kernel model.
>>
>> See the detailed specifications for AP virtualization provided by this
>> patch set in docs/vfio-ap.txt for a more complete discussion of the
>> design introduced by this patch series.
>>
>> v1 -> v2 Change log:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> * Removed unnecessary S390APMatrixDevice, S390APMatrixDeviceClass
>> * Removed ioctl to configure the AP matrix for the guest: letting the
>>    vfio_ap device driver's 'open' callback configure the AP matrix
>>    for the guest
>> * Removed masks from object model: Unnecessary at this point because t=
hey
>>    are not currently used
>> * Renamed:
>>    * VFIOAPMatrixDevice to VFIOAPDevice
>>    * VFIOAPMatrixDeviceClass to VFIOAPDeviceClass
>>    * APMatrixDevice to APDevice
>>    * APMatrixDeviceClass to APDeviceClass
>>    * ap-matrix.c to ap.c (in hw/vfio)
>>    * ap-matrix-device.c to ap-device.c (in hw/s390x)
>>    * ap-matrix-device.h to ap-device.h (in include/hw/s390x)
>> * Added CPU model feature for AP facilities installed on guest and
>>    facilities features for QCI Instructions Available (STFLE.12) and A=
P
>>    Facilities Test facility installed (STFLE.15).
>>
>> Tony Krowiak (5):
>>    s390x/ap: base Adjunct Processor (AP) object
>>    s390x/vfio: ap: VFIO: linux header updates
>>    s390x/vfio: ap: Introduce VFIO AP device
>>    s390x/cpumodel: Set up CPU model for AP device support
>>    s390: doc: detailed specifications for AP virtualization
>>
> I'm going to highlight an issue that stems from bad HW design: The lack
> of an AP interpretation facility (indication). We e.g. have something
> like that for zPCI (and all other I/O besides AP as far as I remember).
>
> Let's assume L1 provides AP to L2.
> Let's assume L2 provides AP to L3.
>
> L2 can blindly forward APs to L3 because it sees the AP facility. This
> requires AP vSIE support. We have no separate way of indicating that
> support, it comes with the AP feature. So let's assume L2 does not
> emulate devices but uses interpretation for L3.
>
> Everything is fine as long as L1 does not emulate AP
> devices/instructions for L2. All instructions are interpreted by HW.

If L1 emulates AP, there is no need it sets any bit in the L2 SIE CRYCB.
In fact we better do not set any bit in the CRYCB.

>
> But what happens if L1 emulates AP devices for L2? intepretation is
> disabled. QEMU handles it.
>
> However L2 can simply forward AP devices to L3. At this point, we must
> also intercept and emulate AP instructions issued by L3 in _L1_.

If L2 forward devices to L3 through SIE ECA.28 but no bit is set is in=20
the CRYCB of L2,
L3 will not see any device.

>
> This is what we call the nightmare of nested virtualization (see x86),
> because we have to emulate L3 instructions in L1 - but even worse, not
> even in L1 kernel space but in L1 user space.

As soon as one level begin to virtualize, all levels under it
must virtualize too so that L3 instructions will be handled in L2
which will issue instructions that will be handled in L1.

>
>
> Long story short:
>
> Making this scenario work would require a _huge_ effort (going to user
> space with nested guest state - or communicating with the user space
> part using some other mechanism).

A funny game with big overhead but same virtualization whatever the=20
level is.

>
> So we could never provide the AP feature reliably with the SIE feature.

I think we should change a little this sentence to:
We can not provide SIE interpretation to a guest from which
any guest level N-1 does not use SIE interpretation.

Nothing bad will occur for the host, the hardware or other guests,
but the guest will just not get any device.

> We want to avoid interdependence between CPU features. (because
> everything else makes CPU feature detection ugly - CMMA is a good
> example and the only exception so far)
>
>
> Long story even shorter:
>
> No emulated AP devices with KVM.
>
I agree with: KVM should never set bits in CRYCB for emulated devices.


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany

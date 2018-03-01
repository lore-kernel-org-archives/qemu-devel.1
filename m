Received: from eggs.gnu.org ([2001:4830:134:3::10]:35261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1erPKB-0002CT-ED
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1erPK8-000249-A6
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:36:47 -0500
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<00b392ee-c928-3b22-4caf-33e7ce04f7f7@redhat.com>
	<e0b24000-0d2a-46f5-c880-89bf6a394bbb@linux.vnet.ibm.com>
	<bf963413-21ad-9b33-bd6c-e096e5686c59@redhat.com>
	<20180228124058.6166d957.cohuck@redhat.com>
	<b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c739f2ad-8e9a-1fa0-4277-3c4447c6ef15@redhat.com>
Date: Thu, 1 Mar 2018 15:36:27 +0100
MIME-Version: 1.0
In-Reply-To: <b60e70b9-f076-8cc9-7c29-2887954b1404@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 01.03.2018 15:12, Pierre Morel wrote:
> On 28/02/2018 12:40, Cornelia Huck wrote:
>> On Wed, 28 Feb 2018 11:26:30 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> Then I request the following change in KVM:
>>>
>>> If KVM_S390_VM_CPU_FEAT_AP is enabled in KVM, ECA.28 is _always_ set
>>> (not just if an AP device is configured). This especially makes thing=
s a
>>> lot easier when it comes to handling hotplugged CPUs and avoiding rac=
e
>>> conditions when enabling these bits as mentioned in the KVM series.
>>>
>>> KVM_S390_VM_CPU_FEAT_AP =3D=3D AP instructions available for the gues=
t
>>> (don't throw an operation exception).
>>>
>>> So this feature then really is guest ABI. The instructions are
>>> available. If there is no device configured, bad luck.
>> Sounds sensible from my POV.
>>
>=20
> I have a concern with this proposition and with the original code:

Very good, this is exactly what I talked to Conny about yesterday.

Short version: CPU model is guest ABI, everything else is configuration.

>=20
> 1) ap=3Don is a guest ABI feature saying to the guest you can use AP=20
> instructions

Indeed, that's what belongs into the CPU model.

>=20
> 2) How we provide AP instructions to the guest can be done in three=20
> different ways:
>  =C2=A0- SIE Interpretation
>  =C2=A0- interception with VFIO
>  =C2=A0- interception with emulation
>=20

Due to bad AP design we can't handle this like zPCI - completely in
QEMU. That's what should control it.

> 3) We implement this with a device in QEMU and a certain level kernel=20
> support.
>=20
> It seems possible to set or not ECA.28 , based on the type of kernel de=
vice:
> - SIE interpretation -> MATRIX KVM device -> ECA.28
> - Interception with VFIO and virtualization -> no ECA.28
> - interception with emulation -> no ECA.28
>=20
> I understand the concern with the vCPU but I think we can handle it wit=
h=20
> an indirect variable
> like:
>=20
> SIE interpretation Device + KVM_S390_VM_CPU_FEAT_AP -> set the variable=
=C2=A0=20
> ap_to_be_sie_interpreted=3D1
> Then in vCPU initialization set ECA.28 based on this variable.

That's exactly why we have the cpu feature interface. E.g. CMMA -> if
not enabled, not interpreted by HW (however also not intercepted to user
space - no sense in doing that right now).

>=20
> I think it let us more doors open, what is your opinion?

In general, for now we don't care. The kernel is the only AP bus provider=
.

If KVM presents AP support -> AP feature can be enabled. And it should
always enable it.

Once we have a QEMU AP bus implementation, things get more complicated.
We could provide the AP feature also without KVM (like zPCI).

But weather or not to enable the KVM control has to be concluded from
the other configuration. Only user space can now that and has to decide
before enabling AP in KVM.

So I think for now we are fine. Later, this might be tricky to check but
not impossible.

>=20
> Regards,
>=20
> Pierre
>=20
>=20


--=20

Thanks,

David / dhildenb

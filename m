Received: from eggs.gnu.org ([2001:4830:134:3::10]:46358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRJNU-00009A-1z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRJNK-0004hs-F3
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:00:20 -0500
References: <20171212051853.24583-1-aik@ozlabs.ru>
	<20171211224650.71237179@w520.home>
	<ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
	<20171219070919.42d90b94@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87e241ad-4d65-1b51-aa22-a84f18de1cb6@redhat.com>
Date: Tue, 19 Dec 2017 15:59:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171219070919.42d90b94@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: spapr/iommu: Enable in-kernel
 TCE acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 19/12/2017 15:09, Alex Williamson wrote:
> On Tue, 19 Dec 2017 12:12:35 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>> On 12/12/2017 06:46, Alex Williamson wrote:
>>>> +enum IOMMUMemoryRegionAttr {
>>>> +    IOMMU_ATTR_KVM_FD =20
>>>
>>> You're generalizing the wrong thing here, this is specifically a
>>> SPAPR_TCE_FD, call it that. =20
>>
>> ... and you're not even implementing set_attr, so let's drop it.
>>
>> My suggestion is to add a function in hw/vfio:
>>
>>     int vfio_container_attach_kvm_spapr_tce(VFIOContainer *cont,
>>                                             int tablefd);
>>
>> and an IOMMUMemoryRegionClass member:
>>
>>     int (*set_vfio_container_attrs)(IOMMUMemoryRegion *iommu,
>>                                     VFIOContainer *cont)
>>
>> Then your implementation for the latter is as simple as this:
>>
>>     if (!kvm_enabled() || !kvmppc_has_cap_spapr_vfio()) {
>>         sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iom=
mu);
>>         return vfio_container_attach_kvm_spapr_tce(cont, tcet->fd);
>>     }
>=20
> Ugh, exactly the sort of interface I've been trying to avoid, vfio
> specific callbacks on common data structures handing out vfio private
> data pointers,

True, VFIOContainer* is private, but in those declarations it's also opaq=
ue.

The VFIO container is the representation of the IOMMU, so it makes sense
to me to have a function to set it up according to QEMU's IOMMU object.
I don't think we will be introducing another object soon that is similar
to the VFIO container.

> requiring additional exported functions from vfio for
> each new user of it.  Why is this better?

I understand that you don't like having many exported functions, but you
are just pushing the problem on the memory.h side where you'd get many
attribute enums.

I suppose it would pay if you have many attributes and many clients,
and/or if the attributes need to be public similar to sysfs.  I mention
public vs. private because, before inventing a new mechanism for
attributes, it would make sense to look at QOM properties.  However,
here we have one client (VFIO) and one attribute (the KVM IOMMU fd) that
is pretty much internal to QEMU.

So, depending on the direction you want to pull/push the information to,
I would do either:

- as above, a generic IOMMU callback

     int (*set_vfio_container_attrs)(IOMMUMemoryRegion *iommu,
                                     VFIOContainer *cont);

- an object-type check in VFIO, followed by calling a new function

     int spapr_tce_iommu_get_kvm_fd(IOMMUMemoryRegion *iommu);

- if we foresee having more IOMMU devices in KVM, let's rename
KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE to KVM_DEV_VFIO_GROUP_ATTACH_IOMMU and
add a new function

     int iommu_memory_region_get_kvm_fd(IOMMUMemoryRegion *iommu);

that requires no object-type check in VFIO.

Paolo

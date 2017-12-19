Received: from eggs.gnu.org ([2001:4830:134:3::10]:60462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRFpI-0001rJ-4L
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRFpD-00072O-6R
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:12:48 -0500
References: <20171212051853.24583-1-aik@ozlabs.ru>
	<20171211224650.71237179@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
Date: Tue, 19 Dec 2017 12:12:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171211224650.71237179@w520.home>
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
To: Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 12/12/2017 06:46, Alex Williamson wrote:
>> +enum IOMMUMemoryRegionAttr {
>> +    IOMMU_ATTR_KVM_FD
>=20
> You're generalizing the wrong thing here, this is specifically a
> SPAPR_TCE_FD, call it that.

... and you're not even implementing set_attr, so let's drop it.

My suggestion is to add a function in hw/vfio:

    int vfio_container_attach_kvm_spapr_tce(VFIOContainer *cont,
                                            int tablefd);

and an IOMMUMemoryRegionClass member:

    int (*set_vfio_container_attrs)(IOMMUMemoryRegion *iommu,
                                    VFIOContainer *cont)

Then your implementation for the latter is as simple as this:

    if (!kvm_enabled() || !kvmppc_has_cap_spapr_vfio()) {
        sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu)=
;
        return vfio_container_attach_kvm_spapr_tce(cont, tcet->fd);
    }

Thanks,

Paolo

>> +};
>> +
>>  typedef struct IOMMUMemoryRegionClass {
>>      /* private */
>>      struct DeviceClass parent_class;
>> @@ -210,6 +214,12 @@ typedef struct IOMMUMemoryRegionClass {
>>                                  IOMMUNotifierFlag new_flags);
>>      /* Set this up to provide customized IOMMU replay function */
>>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier)=
;
>> +
>> +    /* Get/set IOMMU misc attributes */
>> +    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionA=
ttr,
>> +                    void *data);
>> +    int (*set_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionA=
ttr,
>> +                    void *data);

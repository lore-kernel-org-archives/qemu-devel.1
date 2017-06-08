Received: from eggs.gnu.org ([2001:4830:134:3::10]:54712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIxyN-0000G5-Tt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIxyI-0000QC-VN
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:59:39 -0400
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9c81b9d-56ce-b8e6-bedc-5140caf14798@redhat.com>
Date: Thu, 8 Jun 2017 15:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170608074250.GE25805@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v7] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 08/06/2017 09:42, David Gibson wrote:
> So.. this seems like an only halfway QOMification.  The main init
> function still takes an ops structure, whereas the QOMish way to do
> this would be to have the base IOMMUMemoryRegion be an abstract class,
> and have the IOMMUOps pointers as part of the IOMMUMemoryRegionClass.
>=20
> Maybe you can persuade me this is a useful interim step?

Well, it's definitely better than nothing, and MR already relies heavily
on the ops pattern.

The only changes I'd make are:

1) remove this unnecessary hunk

>      snprintf(tmp, sizeof(tmp), "tce-iommu-%x", tcet->liobn);
> -    memory_region_init_iommu(&tcet->iommu, tcetobj, &spapr_iommu_ops, =
tmp, 0);
> +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION,
> +                                  &tcet->iommu, tcetobj, &spapr_iommu_=
ops,
> +                                  tmp, 0);

thus delaying the introduction of memory_region_init_iommu_type to the
next step.

2) Leave is_iommu early in the "should fit in a cache line" part, for
example after dirty_log_mask, and since we have room move "bool
ram_device;" there too.

>=20
> -    const MemoryRegionIOMMUOps *iommu_ops;
> =20
>      const MemoryRegionOps *ops;
>      void *opaque;
> @@ -243,6 +246,13 @@ struct MemoryRegion {
>      const char *name;
>      unsigned ioeventfd_nb;
>      MemoryRegionIoeventfd *ioeventfds;
> +    bool is_iommu;

Thanks,

Paolo

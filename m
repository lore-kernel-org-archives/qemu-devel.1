Received: from eggs.gnu.org ([2001:4830:134:3::10]:54355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctZhF-0005W3-3k
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctZhC-0007LV-18
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:01:01 -0400
References: <20170330124707.28142-1-aik@ozlabs.ru>
	<20170330124707.28142-2-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <183be420-3192-56b7-eb76-29a2830c7244@redhat.com>
Date: Thu, 30 Mar 2017 15:00:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170330124707.28142-2-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/5] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>



On 30/03/2017 14:47, Alexey Kardashevskiy wrote:
> @@ -633,7 +663,7 @@ static inline bool memory_region_is_iommu(MemoryReg=
ion *mr)
>      if (mr->alias) {
>          return memory_region_is_iommu(mr->alias);
>      }
> -    return mr->iommu_ops;
> +    return object_dynamic_cast(OBJECT(mr), TYPE_IOMMU_MEMORY_REGION) !=
=3D NULL;
>  }

This is going to be too slow for all the places where fast paths use
address_space_translate.  You need a (slightly hackish) bool iommu flag
in MemoryRegion, and a regular C cast rather than the type-safe
IOMMU_MEMORY_REGION(mr) in address_space_translate.

You can set the flag in iommu_memory_region_instance_init for example.

Paolo

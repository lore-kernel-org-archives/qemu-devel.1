Received: from eggs.gnu.org ([2001:4830:134:3::10]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUUcJ-0002oY-D5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUUcG-0007Us-6a
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:32:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:5513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUUcF-0007UZ-TM
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:32:12 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 08:32:06 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C14FD2@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-2-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

> From: Peter Xu [mailto:peterx@redhat.com]
> Sent: Friday, January 13, 2017 11:06 AM
>=20
> From: Aviv Ben-David <bd.aviv@gmail.com>
>=20
> This capability asks the guest to invalidate cache before each map operat=
ion.
> We can use this invalidation to trap map operations in the hypervisor.
>=20
> Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c          | 5 +++++
>  hw/i386/intel_iommu_internal.h | 1 +
>  include/hw/i386/intel_iommu.h  | 2 ++
>  3 files changed, 8 insertions(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ec62239..2868e37 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2107,6 +2107,7 @@ static Property vtd_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
> +    DEFINE_PROP_BOOL("cache-mode", IntelIOMMUState, cache_mode_enabled,
> FALSE),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>=20
> @@ -2488,6 +2489,10 @@ static void vtd_init(IntelIOMMUState *s)
>          s->ecap |=3D VTD_ECAP_DT;
>      }
>=20
> +    if (s->cache_mode_enabled) {
> +        s->cap |=3D VTD_CAP_CM;
> +    }
> +

I think some of my old comments are not answered:

1) Better to use caching_mode to follow spec

2) Does it make sense to automatically set this flag if any VFIO device
has been statically assigned when starting Qemu? Also for hot-add
device path, some check of caching mode is required. If not set,=20
should we fail hot-add operation? I don't think we have such physical
platform with some devices behind IOMMU while others not.

>      vtd_reset_context_cache(s);
>      vtd_reset_iotlb(s);
>=20
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 356f188..4104121 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -202,6 +202,7 @@
>  #define VTD_CAP_MAMV                (VTD_MAMV << 48)
>  #define VTD_CAP_PSI                 (1ULL << 39)
>  #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
> +#define VTD_CAP_CM                  (1ULL << 7)
>=20
>  /* Supported Adjusted Guest Address Widths */
>  #define VTD_CAP_SAGAW_SHIFT         8
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.=
h
> index 405c9d1..749eef9 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -257,6 +257,8 @@ struct IntelIOMMUState {
>      uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns 0) =
*/
>      uint32_t version;
>=20
> +    bool cache_mode_enabled;        /* RO - is cap CM enabled? */
> +
>      dma_addr_t root;                /* Current root table pointer */
>      bool root_extended;             /* Type of root table (extended or n=
ot) */
>      bool dmar_enabled;              /* Set if DMA remapping is enabled *=
/
> --
> 2.7.4

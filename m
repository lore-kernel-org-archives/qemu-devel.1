Received: from eggs.gnu.org ([2001:4830:134:3::10]:53726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEo2U-0001fh-0y
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEo2P-0003tx-6X
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cEo2P-0003ti-1g
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:02:21 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15C2E8EB5A
	for <qemu-devel@nongnu.org>; Thu,  8 Dec 2016 02:02:20 +0000 (UTC)
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
	<1481089965-3888-2-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <819b97f5-c1c6-c599-f681-9612a0d1a9e4@redhat.com>
Date: Thu, 8 Dec 2016 10:02:15 +0800
MIME-Version: 1.0
In-Reply-To: <1481089965-3888-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] intel_iommu: check validity
 for GAW bits in CE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, mst@redhat.com



On 2016=E5=B9=B412=E6=9C=8807=E6=97=A5 13:52, Peter Xu wrote:
> Currently vt-d Context Entry (CE) only allows 39/48 bits address width.
> If guest software configured more than that, we complain and force
> shrink to the maximum supported, which is 48bits.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c          | 12 +++++++++++-
>   hw/i386/intel_iommu_internal.h |  2 ++
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5f3e351..98d45ef 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -601,7 +601,17 @@ static inline uint32_t vtd_get_level_from_context_=
entry(VTDContextEntry *ce)
>  =20
>   static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntr=
y *ce)
>   {
> -    return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
> +    uint8_t aw =3D (ce->hi & VTD_CONTEXT_ENTRY_AW);
> +    /*
> +     * According to vt-d spec 10.4.2 bits 12:8, SAGAW only allows
> +     * 39/48 bits.
> +     */
> +    if (aw > VTD_CE_AW_48BIT) {
> +        error_report("Context entry address width not supported (aw=3D=
%d), "
> +                     "Shrinking to maximum.", aw);
> +        aw =3D VTD_CE_AW_48BIT;
> +    }

Is this behavior specified by spec?

> +    return 30 + aw * 9;
>   }
>  =20
>   static const uint64_t vtd_paging_entry_rsvd_field[] =3D {
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_inter=
nal.h
> index 11abfa2..e808c67 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -406,6 +406,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CONTEXT_ENTRY_RSVD_LO   (0xff0ULL | ~VTD_HAW_MASK)
>   /* hi */
>   #define VTD_CONTEXT_ENTRY_AW        7ULL /* Adjusted guest-address-wi=
dth */
> +#define VTD_CE_AW_39BIT             1
> +#define VTD_CE_AW_48BIT             2
>   #define VTD_CONTEXT_ENTRY_DID(val)  (((val) >> 8) & VTD_DOMAIN_ID_MAS=
K)
>   #define VTD_CONTEXT_ENTRY_RSVD_HI   0xffffffffff000080ULL
>  =20

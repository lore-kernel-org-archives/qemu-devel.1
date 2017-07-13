Received: from eggs.gnu.org ([2001:4830:134:3::10]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVZgv-0003AU-8W
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVZgs-0000tz-2l
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVZgr-0000tS-S7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 04:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EEB083F43
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:41:40 +0000 (UTC)
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-2-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a03fa1c3-f8d8-1639-fc21-a53e7da355dd@redhat.com>
Date: Thu, 13 Jul 2017 16:41:32 +0800
MIME-Version: 1.0
In-Reply-To: <1499847223-8078-2-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/4] intel_iommu: fix VTD_PAGE_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>



On 2017=E5=B9=B407=E6=9C=8812=E6=97=A5 16:13, Peter Xu wrote:
> IOMMUTLBEntry.iova is returned incorrectly in one PT path (though mostl=
y
> we cannot really trigger this path, even if we do, we are mostly
> disgarding this value, so it didn't break anything). Fix it by
> converting the VTD_PAGE_MASK into normal definition (normally it should
> be pfn mask, not offset mask), then switch the other user of it.
>
> Fixes: b93130 ("intel_iommu: cleanup vtd_{do_}iommu_translate()")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c          | 2 +-
>   hw/i386/intel_iommu_internal.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 88dc042..392da45 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1141,7 +1141,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpac=
e *vtd_as, PCIBus *bus,
>       if (vtd_ce_get_type(&ce) =3D=3D VTD_CONTEXT_TT_PASS_THROUGH) {
>           entry->iova =3D addr & VTD_PAGE_MASK;
>           entry->translated_addr =3D entry->iova;
> -        entry->addr_mask =3D VTD_PAGE_MASK;
> +        entry->addr_mask =3D ~VTD_PAGE_MASK;
>           entry->perm =3D IOMMU_RW;
>           trace_vtd_translate_pt(source_id, entry->iova);
>  =20
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_inter=
nal.h
> index f50ecd8..754cf8a 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -384,7 +384,7 @@ typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvI=
nfo;
>   /* Pagesize of VTD paging structures, including root and context tabl=
es */
>   #define VTD_PAGE_SHIFT              12
>   #define VTD_PAGE_SIZE               (1ULL << VTD_PAGE_SHIFT)
> -#define VTD_PAGE_MASK               (VTD_PAGE_SIZE - 1)
> +#define VTD_PAGE_MASK               (~(VTD_PAGE_SIZE - 1))
>  =20
>   #define VTD_PAGE_SHIFT_4K           12
>   #define VTD_PAGE_MASK_4K            (~((1ULL << VTD_PAGE_SHIFT_4K) - =
1))

I wonder whether or not using VTD_PAGE_MASK_4K is more than enough.

Thanks

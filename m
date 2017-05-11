Received: from eggs.gnu.org ([2001:4830:134:3::10]:55458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d8eHl-0002Wd-CU
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d8eHi-0003fD-3R
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d8eHh-0003eW-Uw
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:56:58 -0400
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-10-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <722b6658-0169-584b-0d4d-e8f9d096be34@redhat.com>
Date: Thu, 11 May 2017 10:56:42 +0800
MIME-Version: 1.0
In-Reply-To: <1494403315-12760-10-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/12] intel_iommu: allow dev-iotlb
 context entry conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, yi.l.liu@intel.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 2017=E5=B9=B405=E6=9C=8810=E6=97=A5 16:01, Peter Xu wrote:
> When device-iotlb is not specified, we should fail this check.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 05ae631..1a7eba2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -836,6 +836,8 @@ static int vtd_dev_to_context_entry(IntelIOMMUState=
 *s, uint8_t bus_num,
>   {
>       VTDRootEntry re;
>       int ret_fr;
> +    bool type_fail =3D false;
> +    X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
>  =20
>       ret_fr =3D vtd_get_root_entry(s, bus_num, &re);
>       if (ret_fr) {
> @@ -872,10 +874,19 @@ static int vtd_dev_to_context_entry(IntelIOMMUSta=
te *s, uint8_t bus_num,
>       } else {
>           switch (vtd_ce_get_type(ce)) {
>           case VTD_CONTEXT_TT_MULTI_LEVEL:
> -            /* fall through */
> +            /* Always supported */
> +            break;
>           case VTD_CONTEXT_TT_DEV_IOTLB:
> +            if (!x86_iommu->dt_supported) {
> +                type_fail =3D true;
> +            }
>               break;
>           default:
> +            /* Unknwon type */
> +            type_fail =3D true;
> +            break;
> +        }
> +        if (type_fail) {
>               trace_vtd_ce_invalid(ce->hi, ce->lo);
>               return -VTD_FR_CONTEXT_ENTRY_INV;
>           }

How about e.g exclude the type if not supported in vtd_ce_get_type()?=20
This looks better than using something like type_fail.

Thanks

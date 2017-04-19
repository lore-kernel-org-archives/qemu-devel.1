Received: from eggs.gnu.org ([2001:4830:134:3::10]:56879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d0joK-0001Gi-Ea
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d0joH-0006l0-0W
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:13:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:30768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1d0joG-0006iq-N6
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:13:52 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Wed, 19 Apr 2017 07:13:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439054CF5@shsmsx102.ccr.corp.intel.com>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1492428730-13438-8-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Peter,

Besides the gPA->hPA mapping, pt mode enabling requires some sanity check o=
n
s->pt_supported. See comments inline.

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nongnu.o=
rg] On
> Behalf Of Peter Xu
> Sent: Monday, April 17, 2017 7:32 PM
> To: qemu-devel@nongnu.org
> Cc: Lan, Tianyu <tianyu.lan@intel.com>; Michael S . Tsirkin <mst@redhat.c=
om>;
> Jason Wang <jasowang@redhat.com>; peterx@redhat.com; Marcel Apfelbaum
> <marcel@redhat.com>; David Gibson <david@gibson.dropbear.id.au>
> Subject: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough (PT=
)
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c          | 109 +++++++++++++++++++++++++++++++++--=
------
>  hw/i386/intel_iommu_internal.h |   1 +
>  hw/i386/trace-events           |   1 +
>  hw/i386/x86-iommu.c            |   1 +
>  include/hw/i386/x86-iommu.h    |   1 +
>  5 files changed, 93 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c index
> 05ae631..deb2007 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -872,7 +872,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *=
s,
> uint8_t bus_num,
>      } else {
>          switch (vtd_ce_get_type(ce)) {
>          case VTD_CONTEXT_TT_MULTI_LEVEL:
> -            /* fall through */
> +        case VTD_CONTEXT_TT_PASS_THROUGH:

Passthru type is a reserved type if ecap.PT=3D0, so add a check here. If s-=
>pt_supported
is false, report this translation type as unsupported and report an invalid=
 context=20
programming to guest.

>          case VTD_CONTEXT_TT_DEV_IOTLB:
>              break;
>          default:
> @@ -883,6 +883,73 @@ static int vtd_dev_to_context_entry(IntelIOMMUState =
*s,
> uint8_t bus_num,
>      return 0;
>  }
>=20
> +/* Fetch translation type for specific device. Returns <0 if error
> + * happens, otherwise return the shifted type to check against
> + * VTD_CONTEXT_TT_*. */
> +static int vtd_dev_get_trans_type(VTDAddressSpace *as) {
> +    IntelIOMMUState *s;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    s =3D as->iommu_state;
> +
> +    ret =3D vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
> +                                   as->devfn, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_type(&ce);
> +}
> +
> +static bool vtd_dev_pt_enabled(VTDAddressSpace *as) {
> +    int ret;
> +
> +    assert(as);
> +
> +    ret =3D vtd_dev_get_trans_type(as);
> +    if (ret < 0) {
> +        /*
> +         * Possibly failed to parse the context entry for some reason
> +         * (e.g., during init, or any guest configuration errors on
> +         * context entries). We should assume PT not enabled for
> +         * safety.
> +         */
> +        return false;
> +    }
> +
> +    return ret =3D=3D VTD_CONTEXT_TT_PASS_THROUGH; }
> +
> +static void vtd_switch_address_space(VTDAddressSpace *as) {
> +    bool use_iommu;
> +
> +    assert(as);
> +
> +    use_iommu =3D as->iommu_state->dmar_enabled;
> +    if (use_iommu) {

if s->pt_supported is false, no need to check the context.TT, even
context.TT=3Dpt, then it should be an invalid context programming.

Regards,
Yi L

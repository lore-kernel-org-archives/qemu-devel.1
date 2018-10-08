Received: from eggs.gnu.org ([2001:4830:134:3::10]:59116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g9Lvf-0003za-Fl
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1g9Luc-0000xb-8U
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 23:08:54 -0400
References: <20180913075517.11140-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e7cc5dbe-d577-2b41-517d-0d32e9d6ebd7@redhat.com>
Date: Mon, 8 Oct 2018 11:08:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180913075517.11140-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: handle invalid ce for shadow
 sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Pei Zhang <pezhang@redhat.com>



On 2018=E5=B9=B409=E6=9C=8813=E6=97=A5 15:55, Peter Xu wrote:
> There are two callers for vtd_sync_shadow_page_table_range(), one
> provided a valid context entry and one not.  Move that fetching
> operation into the caller vtd_sync_shadow_page_table() where we need to
> fetch the context entry.
>
> Meanwhile, we should handle VTD_FR_CONTEXT_ENTRY_P properly when
> synchronizing shadow page tables.  Having invalid context entry there i=
s
> perfectly valid when we move a device out of an existing domain.  When
> that happens, instead of posting an error we invalidate the whole regio=
n.
>
> Without this patch, QEMU will crash if we do these steps:
>
> (1) start QEMU with VT-d IOMMU and two 10G NICs (ixgbe)
> (2) bind the NICs with vfio-pci in the guest
> (3) start testpmd with the NICs applied
> (4) stop testpmd
> (5) rebind the NIC back to ixgbe kernel driver
>
> The patch should fix it.
>
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Tested-by: Pei Zhang <pezhang@redhat.com>
> CC: Pei Zhang <pezhang@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: Maxime Coquelin <maxime.coquelin@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: QEMU Stable <qemu-stable@nongnu.org>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1627272
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 54 ++++++++++++++++++++++++++----------------=
-
>   1 file changed, 33 insertions(+), 21 deletions(-)

Reviewed-by: Jason Wang <jasowang@redhat.com>

Some nits, see below.

>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3dfada19a6..2509520d6f 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -37,6 +37,8 @@
>   #include "kvm_i386.h"
>   #include "trace.h"
>  =20
> +static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier=
 *n);
> +
>   static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t=
 val,
>                               uint64_t wmask, uint64_t w1cmask)
>   {
> @@ -1047,39 +1049,49 @@ static int vtd_sync_shadow_page_table_range(VTD=
AddressSpace *vtd_as,
>           .notify_unmap =3D true,
>           .aw =3D s->aw_bits,
>           .as =3D vtd_as,
> +        .domain_id =3D VTD_CONTEXT_ENTRY_DID(ce->hi),
>       };
> -    VTDContextEntry ce_cache;
> +
> +    return vtd_page_walk(ce, addr, addr + size, &info);
> +}
> +
> +static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> +{
>       int ret;
> +    VTDContextEntry ce;
> +    IOMMUNotifier *n;
>  =20
> -    if (ce) {
> -        /* If the caller provided context entry, use it */
> -        ce_cache =3D *ce;
> -    } else {
> -        /* If the caller didn't provide ce, try to fetch */
> -        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                       vtd_as->devfn, &ce_cache);
> -        if (ret) {
> +    ret =3D vtd_dev_to_context_entry(vtd_as->iommu_state,
> +                                   pci_bus_num(vtd_as->bus),
> +                                   vtd_as->devfn, &ce);
> +    if (ret) {
> +        if (ret =3D=3D -VTD_FR_CONTEXT_ENTRY_P) {
> +            /*
> +             * It's a valid scenario to have a context entry that is
> +             * not present.  For example, when a device is removed
> +             * from an existing domain then the context entry will be
> +             * zeroed by the guest before it was put into another
> +             * domain.  When this happens, instead of synchronizing
> +             * the shadow pages we should invalidate all existing
> +             * mappings and notify the backends.
> +             */
> +            IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
> +                vtd_address_space_unmap(vtd_as, n);
> +            }
> +        } else {
>               /*
>                * This should not really happen, but in case it happens,
>                * we just skip the sync for this time.  After all we eve=
n
>                * don't have the root table pointer!
>                */

It looks to me the comment is not accurate, no root pointer is not the=20
only reason for the failure of vtd_dev_to_context_entry().

>               error_report_once("%s: invalid context entry for bus 0x%x=
"
> -                              " devfn 0x%x",
> -                              __func__, pci_bus_num(vtd_as->bus),
> -                              vtd_as->devfn);
> -            return 0;

I'm not quite sure error_report_once() is really needed here since all=20
failures has been traced.

> +                              " devfn 0x%x", __func__,
> +                              pci_bus_num(vtd_as->bus), vtd_as->devfn)=
;
>           }
> +        return 0;
>       }
>  =20
> -    info.domain_id =3D VTD_CONTEXT_ENTRY_DID(ce_cache.hi);
> -
> -    return vtd_page_walk(&ce_cache, addr, addr + size, &info);
> -}
> -
> -static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
> -{
> -    return vtd_sync_shadow_page_table_range(vtd_as, NULL, 0, UINT64_MA=
X);
> +    return vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX=
);
>   }

As has been discussed, this will left addr UINT64_MAX, it's better to=20
have [start, end] instead of (start, range).

Thanks

>  =20
>   /*

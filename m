Received: from eggs.gnu.org ([2001:4830:134:3::10]:47693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1g9mQZ-0004uX-Ed
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1g9mQV-0006dN-NL
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1g9mQV-0006be-Ay
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 03:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C9D63081247
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 07:27:28 +0000 (UTC)
References: <20181008064713.27349-1-peterx@redhat.com>
	<20181008064713.27349-3-peterx@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ce62a481-0b10-2044-dadb-def25af5b77e@redhat.com>
Date: Tue, 9 Oct 2018 09:27:15 +0200
MIME-Version: 1.0
In-Reply-To: <20181008064713.27349-3-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] intel_iommu: handle invalid ce for
 shadow sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Pei Zhang <pezhang@redhat.com>

Hi Peter,

On 10/8/18 8:47 AM, Peter Xu wrote:
> We should handle VTD_FR_CONTEXT_ENTRY_P properly when synchronizing
> shadow page tables.  Having invalid context entry there is perfectly
> valid when we move a device out of an existing domain.  When that
> happens, instead of posting an error we invalidate the whole region.
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
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1627272
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d6b4f8705d..b0884e87e8 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -37,6 +37,8 @@
>  #include "kvm_i386.h"
>  #include "trace.h"
>  
> +static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +
>  static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                              uint64_t wmask, uint64_t w1cmask)
>  {
> @@ -1056,12 +1058,28 @@ static int vtd_sync_shadow_page_table(VTDAddressSpace *vtd_as)
>  {
>      int ret;
>      VTDContextEntry ce;
> +    IOMMUNotifier *n;
>  
>      ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
>                                     pci_bus_num(vtd_as->bus),
>                                     vtd_as->devfn, &ce);
>      if (ret) {
> -        return ret;
> +        if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
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
don't you want to return here also in this case?

Thanks

Eric
> +        } else {
> +            return ret;
> +        }
>      }
>  
>      return vtd_sync_shadow_page_table_range(vtd_as, &ce, 0, UINT64_MAX);
> 

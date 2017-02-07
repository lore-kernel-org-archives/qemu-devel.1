Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cayG4-00010M-CW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:24:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cayG1-0006wp-6u
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:24:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cayG1-0006wK-1L
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 00:24:01 -0500
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-6-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <33d2cae8-2e45-d1ce-43a2-95cb31266684@redhat.com>
Date: Tue, 7 Feb 2017 13:23:52 +0800
MIME-Version: 1.0
In-Reply-To: <1486110164-13797-6-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 05/18] intel_iommu: simplify irq region
 translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> Now we have a standalone memory region for MSI, all the irq region
> requests should be redirected there. Cleaning up the block with an
> assertion instead.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Jason Wang <jasowang@redhat.com>

> ---
>   hw/i386/intel_iommu.c | 28 ++++++----------------------
>   1 file changed, 6 insertions(+), 22 deletions(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 50251c3..86d19bb 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -818,28 +818,12 @@ static void vtd_do_iommu_translate(VTDAddressSpac=
e *vtd_as, PCIBus *bus,
>       bool writes =3D true;
>       VTDIOTLBEntry *iotlb_entry;
>  =20
> -    /* Check if the request is in interrupt address range */
> -    if (vtd_is_interrupt_addr(addr)) {
> -        if (is_write) {
> -            /* FIXME: since we don't know the length of the access her=
e, we
> -             * treat Non-DWORD length write requests without PASID as
> -             * interrupt requests, too. Withoud interrupt remapping su=
pport,
> -             * we just use 1:1 mapping.
> -             */
> -            VTD_DPRINTF(MMU, "write request to interrupt address "
> -                        "gpa 0x%"PRIx64, addr);
> -            entry->iova =3D addr & VTD_PAGE_MASK_4K;
> -            entry->translated_addr =3D addr & VTD_PAGE_MASK_4K;
> -            entry->addr_mask =3D ~VTD_PAGE_MASK_4K;
> -            entry->perm =3D IOMMU_WO;
> -            return;
> -        } else {
> -            VTD_DPRINTF(GENERAL, "error: read request from interrupt a=
ddress "
> -                        "gpa 0x%"PRIx64, addr);
> -            vtd_report_dmar_fault(s, source_id, addr, VTD_FR_READ, is_=
write);
> -            return;
> -        }
> -    }
> +    /*
> +     * We have standalone memory region for interrupt addresses, we
> +     * should never receive translation requests in this region.
> +     */
> +    assert(!vtd_is_interrupt_addr(addr));
> +
>       /* Try to fetch slpte form IOTLB */
>       iotlb_entry =3D vtd_lookup_iotlb(s, source_id, addr);
>       if (iotlb_entry) {

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUUSo-0007mK-3L
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:22:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUUSk-0003N7-QV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:22:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:56478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUUSk-0003KJ-GI
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:22:22 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 08:22:14 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-3-git-send-email-peterx@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 02/14] intel_iommu: simplify irq
 region translation
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
> Before we have int-remap, we need to bypass interrupt write requests.
> That's not necessary now - we have supported int-remap, and all the irq
> region requests should be redirected there. Cleaning up the block with
> an assertion instead.

This comment is not accurate. According to code, the reason why you
can do such simplification is because we have standalone memory
region now for interrupt addresses. There should be nothing to do=20
with int-remap, which can be disabled by guest... Maybe the standalone
region was added when developing int-remap, but functionally they
are not related. :-)

>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2868e37..77d467a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -818,28 +818,12 @@ static void vtd_do_iommu_translate(VTDAddressSpace =
*vtd_as,
> PCIBus *bus,
>      bool writes =3D true;
>      VTDIOTLBEntry *iotlb_entry;
>=20
> -    /* Check if the request is in interrupt address range */
> -    if (vtd_is_interrupt_addr(addr)) {
> -        if (is_write) {
> -            /* FIXME: since we don't know the length of the access here,=
 we
> -             * treat Non-DWORD length write requests without PASID as
> -             * interrupt requests, too. Withoud interrupt remapping supp=
ort,
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
> -            VTD_DPRINTF(GENERAL, "error: read request from interrupt add=
ress "
> -                        "gpa 0x%"PRIx64, addr);
> -            vtd_report_dmar_fault(s, source_id, addr, VTD_FR_READ, is_wr=
ite);
> -            return;
> -        }
> -    }
> +    /*
> +     * We have standalone memory region for interrupt addresses, we
> +     * should never receive translation requests in this region.
> +     */
> +    assert(!vtd_is_interrupt_addr(addr));
> +
>      /* Try to fetch slpte form IOTLB */
>      iotlb_entry =3D vtd_lookup_iotlb(s, source_id, addr);
>      if (iotlb_entry) {
> --
> 2.7.4

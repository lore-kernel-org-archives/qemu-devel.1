Received: from eggs.gnu.org ([209.51.188.92]:33583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gho2p-0004DY-CQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gho2o-00050s-L5
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:03:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gho2n-0004zx-Hk
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:03:41 -0500
References: <20190108114720.21760-1-peterx@redhat.com>
	<20190108114720.21760-2-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <68b091ff-f5d9-c49d-bdf2-597d235e6dbf@redhat.com>
Date: Fri, 11 Jan 2019 12:03:23 +0800
MIME-Version: 1.0
In-Reply-To: <20190108114720.21760-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] intel_iommu: fix operator in
 vtd_switch_address_space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>


On 2019/1/8 =E4=B8=8B=E5=8D=887:47, Peter Xu wrote:
> When calculating use_iommu, we wanted to first detect whether DMAR is
> enabled, then check whether PT is enabled if DMAR is enabled.  However
> in the current code we used "&" rather than "&&" so the ordering
> requirement is lost (instead it'll be an "AND" operation).  This could
> introduce errors dumped in QEMU console when rebooting a guest with
> both assigned device and vIOMMU, like:
>
>    qemu-system-x86_64: vtd_dev_to_context_entry: invalid root entry:
>    rsvd=3D0xf000ff53f000e2c3, val=3D0xf000ff53f000ff53 (reserved nonzer=
o)
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 8b72735650..6d5cc1d039 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1153,7 +1153,7 @@ static bool vtd_switch_address_space(VTDAddressSp=
ace *as)
>  =20
>       assert(as);
>  =20
> -    use_iommu =3D as->iommu_state->dmar_enabled & !vtd_dev_pt_enabled(=
as);
> +    use_iommu =3D as->iommu_state->dmar_enabled && !vtd_dev_pt_enabled=
(as);
>  =20
>       trace_vtd_switch_address_space(pci_bus_num(as->bus),
>                                      VTD_PCI_SLOT(as->devfn),


Acked-by: Jason Wang <jasowang@redhat.com>

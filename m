Received: from eggs.gnu.org ([2001:4830:134:3::10]:53035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dQmME-0007Yu-OY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 23:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dQmMA-0004pN-Pu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 23:12:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dQmMA-0004oP-Ja
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 23:12:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFF5683F40
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 03:12:28 +0000 (UTC)
References: <1498710417-7807-1-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8a708ab5-8869-2077-aa96-fdf521a94ef9@redhat.com>
Date: Fri, 30 Jun 2017 11:12:20 +0800
MIME-Version: 1.0
In-Reply-To: <1498710417-7807-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: fix migration breakage on mr
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 2017=E5=B9=B406=E6=9C=8829=E6=97=A5 12:26, Peter Xu wrote:
> Migration is broken after the vfio integration work:
>
> qemu-kvm: AHCI: Failed to start FIS receive engine: bad FIS receive buf=
fer address
> qemu-kvm: Failed to load ich9_ahci:ahci
> qemu-kvm: error while loading state for instance 0x0 of device '0000:00=
:1f.2/ich9_ahci'
> qemu-kvm: load of migration failed: Operation not permitted
>
> The problem is that vfio work introduced dynamic memory region
> switching (actually it is also used for future PT mode), and this memor=
y
> region layout is not properly delivered to destination when migration
> happens. Solution is to rebuild the layout in post_load.
>
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1459906
> Fixes: 558e0024 ("intel_iommu: allow dynamic switch of IOMMU region")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a9b59bd..36b231d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2332,11 +2332,28 @@ static void vtd_iommu_notify_flag_changed(Memor=
yRegion *iommu,
>       }
>   }
>  =20
> +static int vtd_post_load(void *opaque, int version_id)
> +{
> +    IntelIOMMUState *iommu =3D opaque;
> +
> +    /*
> +     * Since commit 558e00 ("intel_iommu: allow dynamic switch of
> +     * IOMMU region"), memory regions are dynamically turned on/off
> +     * depending on context entry configurations from the guest. After
> +     * migration, we need to make sure the memory regions are still
> +     * correct.
> +     */
> +    vtd_switch_address_space_all(iommu);
> +
> +    return 0;
> +}
> +
>   static const VMStateDescription vtd_vmstate =3D {
>       .name =3D "iommu-intel",
>       .version_id =3D 1,
>       .minimum_version_id =3D 1,
>       .priority =3D MIG_PRI_IOMMU,
> +    .post_load =3D vtd_post_load,
>       .fields =3D (VMStateField[]) {
>           VMSTATE_UINT64(root, IntelIOMMUState),
>           VMSTATE_UINT64(intr_root, IntelIOMMUState),

Reviewed-by: Jason Wang <jasowang@redhat.com>

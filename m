Received: from eggs.gnu.org ([2001:4830:134:3::10]:58979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPOb9-0003wh-Ux
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPOb6-0000Om-ON
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:05:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cPOb6-0000Nw-GN
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 02:05:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7599261B9C
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 07:05:56 +0000 (UTC)
References: <1483675573-12636-1-git-send-email-peterx@redhat.com>
	<1483675573-12636-3-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f62ec203-a644-9102-f5e6-4f41cca60d80@redhat.com>
Date: Fri, 6 Jan 2017 15:05:47 +0800
MIME-Version: 1.0
In-Reply-To: <1483675573-12636-3-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel_iommu: allow migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 2017=E5=B9=B401=E6=9C=8806=E6=97=A5 12:06, Peter Xu wrote:
> IOMMU needs to be migrated before all the PCI devices (in case there ar=
e
> devices that will request for address translation). So marking it with =
a
> priority higher than the default (which PCI devices and other belong).
> Migration framework handled the rest.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/i386/intel_iommu.c       | 22 +++++++++++++++++++++-
>   include/migration/vmstate.h |  1 +
>   2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5f3e351..119217b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1996,7 +1996,27 @@ static void vtd_iommu_notify_flag_changed(Memory=
Region *iommu,
>  =20
>   static const VMStateDescription vtd_vmstate =3D {
>       .name =3D "iommu-intel",
> -    .unmigratable =3D 1,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .priority =3D MIG_PRI_IOMMU,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(root, IntelIOMMUState),
> +        VMSTATE_UINT64(intr_root, IntelIOMMUState),
> +        VMSTATE_UINT64(iq, IntelIOMMUState),
> +        VMSTATE_UINT32(intr_size, IntelIOMMUState),
> +        VMSTATE_UINT16(iq_head, IntelIOMMUState),
> +        VMSTATE_UINT16(iq_tail, IntelIOMMUState),
> +        VMSTATE_UINT16(iq_size, IntelIOMMUState),
> +        VMSTATE_UINT16(next_frcd_reg, IntelIOMMUState),
> +        VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),

Do we need migrate wmask, w1cmask, womask too?

> +        VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
> +        VMSTATE_BOOL(root_extended, IntelIOMMUState),
> +        VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
> +        VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
> +        VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> +        VMSTATE_BOOL(intr_eime, IntelIOMMUState),
> +        VMSTATE_END_OF_LIST()
> +    }
>   };
>  =20
>   static const MemoryRegionOps vtd_mem_ops =3D {
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1a22887..2125829 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -188,6 +188,7 @@ enum VMStateFlags {
>  =20
>   typedef enum {
>       MIG_PRI_DEFAULT =3D 0,
> +    MIG_PRI_IOMMU,              /* Must happen before PCI devices */
>       MIG_PRI_MAX,
>   } MigrationPriority;
>  =20

I think we should reset iotlb and context cache in post_load() too.

Thanks

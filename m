Received: from eggs.gnu.org ([2001:4830:134:3::10]:38932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRwlV-0004B4-Cl
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRwlS-0001bd-Aw
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:59:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cRwlS-0001bD-3K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 02:59:10 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-10-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <11241cc6-139e-ee8f-ff54-e1ab83ecf45d@redhat.com>
Date: Fri, 13 Jan 2017 15:58:59 +0800
MIME-Version: 1.0
In-Reply-To: <1484276800-26814-10-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 09/14] memory: introduce
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> Generalizing the notify logic in memory_region_notify_iommu() into a
> single function. This can be further used in customized replay()
> functions for IOMMUs.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/exec/memory.h | 15 +++++++++++++++
>   memory.c              | 29 ++++++++++++++++++-----------
>   2 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 2233f99..f367e54 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -669,6 +669,21 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>                                   IOMMUTLBEntry entry);
>  =20
>   /**
> + * memory_region_notify_one: notify a change in an IOMMU translation
> + *                           entry to a single notifier
> + *
> + * This works just like memory_region_notify_iommu(), but it only
> + * notifies a specific notifier, not all of them.
> + *
> + * @notifier: the notifier to be notified
> + * @entry: the new entry in the IOMMU translation table.  The entry
> + *         replaces all old entries for the same virtual I/O address r=
ange.
> + *         Deleted entries have .@perm =3D=3D 0.
> + */
> +void memory_region_notify_one(IOMMUNotifier *notifier,
> +                              IOMMUTLBEntry *entry);
> +
> +/**
>    * memory_region_register_iommu_notifier: register a notifier for cha=
nges to
>    * IOMMU translation entries.
>    *
> diff --git a/memory.c b/memory.c
> index df62bd1..6e4c872 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1665,26 +1665,33 @@ void memory_region_unregister_iommu_notifier(Me=
moryRegion *mr,
>       memory_region_update_iommu_notify_flags(mr);
>   }
>  =20
> -void memory_region_notify_iommu(MemoryRegion *mr,
> -                                IOMMUTLBEntry entry)
> +void memory_region_notify_one(IOMMUNotifier *notifier,
> +                              IOMMUTLBEntry *entry)
>   {
> -    IOMMUNotifier *iommu_notifier;
>       IOMMUNotifierFlag request_flags;
>  =20
> -    assert(memory_region_is_iommu(mr));
> -
> -    if (entry.perm & IOMMU_RW) {
> +    if (entry->perm & IOMMU_RW) {
>           request_flags =3D IOMMU_NOTIFIER_MAP;
>       } else {
>           request_flags =3D IOMMU_NOTIFIER_UNMAP;
>       }

Nit: you can keep this outside the loop.

Thanks

>  =20
> +    if (notifier->notifier_flags & request_flags &&
> +        notifier->start <=3D entry->iova &&
> +        notifier->end >=3D entry->iova) {
> +        notifier->notify(notifier, entry);
> +    }
> +}
> +
> +void memory_region_notify_iommu(MemoryRegion *mr,
> +                                IOMMUTLBEntry entry)
> +{
> +    IOMMUNotifier *iommu_notifier;
> +
> +    assert(memory_region_is_iommu(mr));
> +
>       QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> -        if (iommu_notifier->notifier_flags & request_flags &&
> -            iommu_notifier->start <=3D entry.iova &&
> -            iommu_notifier->end >=3D entry.iova) {
> -            iommu_notifier->notify(iommu_notifier, &entry);
> -        }
> +        memory_region_notify_one(iommu_notifier, &entry);
>       }
>   }
>  =20

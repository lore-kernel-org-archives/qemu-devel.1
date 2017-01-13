Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRyJ2-0002Z9-Fk
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cRyIz-0000N0-Re
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:37:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cRyIz-0000Me-Ig
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:37:53 -0500
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-8-git-send-email-peterx@redhat.com>
	<eb0051ab-b555-4df0-c2d6-4230e395fa15@redhat.com>
	<20170113092345.GX4450@pxdev.xzpeter.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <57b08710-837f-26b7-1559-937b66c880d1@redhat.com>
Date: Fri, 13 Jan 2017 17:37:43 +0800
MIME-Version: 1.0
In-Reply-To: <20170113092345.GX4450@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 07/14] memory: add section range
 info for IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 17:23, Peter Xu wrote:
> On Fri, Jan 13, 2017 at 03:55:22PM +0800, Jason Wang wrote:
>>
>> On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
>>> In this patch, IOMMUNotifier.{start|end} are introduced to store sect=
ion
>>> information for a specific notifier. When notification occurs, we not
>>> only check the notification type (MAP|UNMAP), but also check whether =
the
>>> notified iova is in the range of specific IOMMU notifier, and skip th=
ose
>>> notifiers if not in the listened range.
>>>
>>> When removing an region, we need to make sure we removed the correct
>>> VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
>>>
>>> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   hw/vfio/common.c      | 7 ++++++-
>>>   include/exec/memory.h | 3 +++
>>>   memory.c              | 4 +++-
>>>   3 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 801578b..6f648da 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -455,6 +455,10 @@ static void vfio_listener_region_add(MemoryListe=
ner *listener,
>>>           giommu->container =3D container;
>>>           giommu->n.notify =3D vfio_iommu_map_notify;
>>>           giommu->n.notifier_flags =3D IOMMU_NOTIFIER_ALL;
>>> +        giommu->n.start =3D section->offset_within_region;
>>> +        llend =3D int128_add(int128_make64(giommu->n.start), section=
->size);
>>> +        llend =3D int128_sub(llend, int128_one());
>>> +        giommu->n.end =3D int128_get64(llend);
>>>           QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_n=
ext);
>>>           memory_region_register_iommu_notifier(giommu->iommu, &giomm=
u->n);
>>> @@ -525,7 +529,8 @@ static void vfio_listener_region_del(MemoryListen=
er *listener,
>>>           VFIOGuestIOMMU *giommu;
>>>           QLIST_FOREACH(giommu, &container->giommu_list, giommu_next)=
 {
>>> -            if (giommu->iommu =3D=3D section->mr) {
>>> +            if (giommu->iommu =3D=3D section->mr &&
>>> +                giommu->n.start =3D=3D section->offset_within_region=
) {
>>>                   memory_region_unregister_iommu_notifier(giommu->iom=
mu,
>>>                                                           &giommu->n)=
;
>>>                   QLIST_REMOVE(giommu, giommu_next);
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index bec9756..7649e74 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -84,6 +84,9 @@ typedef enum {
>>>   struct IOMMUNotifier {
>>>       void (*notify)(struct IOMMUNotifier *notifier, IOMMUTLBEntry *d=
ata);
>>>       IOMMUNotifierFlag notifier_flags;
>>> +    /* Notify for address space range start <=3D addr <=3D end */
>>> +    hwaddr start;
>>> +    hwaddr end;
>>>       QLIST_ENTRY(IOMMUNotifier) node;
>>>   };
>>>   typedef struct IOMMUNotifier IOMMUNotifier;
>>> diff --git a/memory.c b/memory.c
>>> index 2bfc37f..e88bb54 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -1671,7 +1671,9 @@ void memory_region_notify_iommu(MemoryRegion *m=
r,
>>>       }
>>>       QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
>>> -        if (iommu_notifier->notifier_flags & request_flags) {
>>> +        if (iommu_notifier->notifier_flags & request_flags &&
>>> +            iommu_notifier->start <=3D entry.iova &&
>>> +            iommu_notifier->end >=3D entry.iova) {
>>>               iommu_notifier->notify(iommu_notifier, &entry);
>>>           }
>>>       }
>> This seems breaks vhost device IOTLB. How about keep the the behavior
>> somehow?
> Thanks to point out. How about I squash this into this patch?
>
> --------8<--------
> diff --git a/memory.c b/memory.c
> index e88bb54..6de02dd 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1608,8 +1608,14 @@ void memory_region_register_iommu_notifier(Memor=
yRegion *mr,
>           return;
>       }
>  =20
> +    if (n->start =3D=3D 0 && n->end =3D=3D 0) {
> +        /* If these are not specified, we listen to the whole range */
> +        n->end =3D (hwaddr)(-1);
> +    }
> +
>       /* We need to register for at least one bitfield */
>       assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
> +    assert(n->start <=3D n->end);
>       QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
>       memory_region_update_iommu_notify_flags(mr);
>   }
> -------->8--------
>
> -- peterx

This should work, or you can introduce a=20
memory_region_iommu_notifier_init() to force user to explicitly=20
initialize start and end.

Thanks

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dvHp7-0004ge-SZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dvHp6-0000FK-Kd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:52:29 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Fri, 22 Sep 2017 06:52:18 +0000
Message-ID: <AM5PR0401MB254525F47824ADD5A73EF2DB9A670@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
	<1505807208-9063-10-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1505807208-9063-10-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v4 09/16] virtio-iommu: Implement translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "drjones@redhat.com" <drjones@redhat.com>, "wei@redhat.com" <wei@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "peterx@redhat.com" <peterx@redhat.com>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>



> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: Tuesday, September 19, 2017 1:17 PM
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
> qemu-arm@nongnu.org; qemu-devel@nongnu.org; jean-
> philippe.brucker@arm.com
> Cc: will.deacon@arm.com; kevin.tian@intel.com; marc.zyngier@arm.com;
> christoffer.dall@linaro.org; drjones@redhat.com; wei@redhat.com;
> tn@semihalf.com; Bharat Bhushan <bharat.bhushan@nxp.com>;
> peterx@redhat.com; linuc.decode@gmail.com
> Subject: [RFC v4 09/16] virtio-iommu: Implement translate
>=20
> This patch implements the translate callback
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/virtio/trace-events   |  1 +
>  hw/virtio/virtio-iommu.c | 39
> +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events index
> da298c1..9010fbd 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -45,3 +45,4 @@ virtio_iommu_put_as(uint32_t asid) "Free asid=3D%d"
>  virtio_iommu_unmap_left_interval(uint64_t low, uint64_t high, uint64_t
> next_low, uint64_t next_high) "Unmap left [0x%"PRIx64",0x%"PRIx64"],
> new interval=3D[0x%"PRIx64",0x%"PRIx64"]"
>  virtio_iommu_unmap_right_interval(uint64_t low, uint64_t high, uint64_t
> next_low, uint64_t next_high) "Unmap right [0x%"PRIx64",0x%"PRIx64"],
> new interval=3D[0x%"PRIx64",0x%"PRIx64"]"
>  virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc
> [0x%"PRIx64",0x%"PRIx64"]"
> +virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr,
> uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=3D%d"
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> 6f1a7d1..db46a91 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -496,19 +496,54 @@ static IOMMUTLBEntry
> virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                              IOMMUAccessFlags flag)  {
>      IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> +    VirtIOIOMMU *s =3D sdev->viommu;
>      uint32_t sid;
> +    viommu_dev *dev;
> +    viommu_mapping *mapping;
> +    viommu_interval interval;
> +
> +    interval.low =3D addr;
> +    interval.high =3D addr + 1;
>=20
>      IOMMUTLBEntry entry =3D {
>          .target_as =3D &address_space_memory,
>          .iova =3D addr,
>          .translated_addr =3D addr,
> -        .addr_mask =3D ~(hwaddr)0,
> -        .perm =3D IOMMU_NONE,
> +        .addr_mask =3D (1 << ctz32(s->config.page_size_mask)) - 1,
> +        .perm =3D flag,
>      };
>=20
>      sid =3D virtio_iommu_get_sid(sdev);
>=20
>      trace_virtio_iommu_translate(mr->parent_obj.name, sid, addr, flag);
> +    qemu_mutex_lock(&s->mutex);
> +
> +    dev =3D g_tree_lookup(s->devices, GUINT_TO_POINTER(sid));
> +    if (!dev) {
> +        /* device cannot be attached to another as */
> +        printf("%s sid=3D%d is not known!!\n", __func__, sid);
> +        goto unlock;
> +    }
> +
> +    mapping =3D g_tree_lookup(dev->as->mappings, (gpointer)(&interval));

Should check of !dev->as before accessing this.

Thanks
-Bharat=20

> +    if (!mapping) {
> +        printf("%s no mapping for 0x%"PRIx64" for sid=3D%d\n", __func__,
> +               addr, sid);
> +        goto unlock;
> +    }
> +
> +    if (((flag & IOMMU_RO) && !(mapping->flags &
> VIRTIO_IOMMU_MAP_F_READ)) ||
> +        ((flag & IOMMU_WO) && !(mapping->flags &
> VIRTIO_IOMMU_MAP_F_WRITE))) {
> +        error_report("Permission error on 0x%"PRIx64"(%d): allowed=3D%d"=
,
> +                     addr, flag, mapping->flags);
> +        entry.perm =3D IOMMU_NONE;
> +        goto unlock;
> +    }
> +    entry.translated_addr =3D addr - mapping->virt_addr + mapping-
> >phys_addr,
> +    trace_virtio_iommu_translate_out(addr, entry.translated_addr, sid);
> +
> +unlock:
> +    qemu_mutex_unlock(&s->mutex);
>      return entry;
>  }
>=20
> --
> 2.5.5

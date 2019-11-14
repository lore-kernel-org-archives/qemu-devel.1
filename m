Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73BA206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgggADVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73BA206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7N5-0001qR-HG
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Kr-0000AR-M1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Kq-0006jt-CK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7Kq-0006iw-8b
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEc/cDylF3HfgKBOefgDeM3LzSeco7rpvaLl8Mc/qNg=;
 b=CgggADVBpooS88nIsrfjDRwdXbHqx0to91vdPHWrjcW8sZCCx3sjdpq95TEJh4jzOqAgIZ
 PS/5aQki4PIk0e518KMRRasHcoTCFWMGUyXTogFLdtCCc5TBe5Gd+f7xshXGH3MmsKq18k
 VsAYFQAh6a4e3c79A9wqOoFSgBzTgHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-TuVwTvOFNxiue4-zVGeJ1g-1; Thu, 14 Nov 2019 00:06:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4224107ACC6;
 Thu, 14 Nov 2019 05:06:17 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86EDD1059FDF;
 Thu, 14 Nov 2019 05:06:16 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:06:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 14/15] vfio: Add ioctl to get dirty pages bitmap
 during dma unmap.
Message-ID: <20191113220615.7b2049ce@x1.home>
In-Reply-To: <1573578324-8389-15-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-15-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TuVwTvOFNxiue4-zVGeJ1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 22:35:23 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> With vIOMMU, IO virtual address range can get unmapped while in pre-copy =
phase
> of migration. In that case, unmap ioctl should return pages pinned in tha=
t range
> and QEMU should find its correcponding guest physical addresses and repor=
t

corresponding

> those dirty.
>=20
> Note: This patch is not yet tested. I'm trying to see how I can test this=
 code
> path.
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 61 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 66f1c64bf074..dc5768219d44 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -311,11 +311,30 @@ static bool vfio_devices_are_stopped_and_saving(voi=
d)
>      return true;
>  }
> =20
> +static bool vfio_devices_are_running_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                (vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {
> +                continue;
> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}

Suggests to generalize the other function to allow the caller to
provide the mask and value to test for.

> +
>  /*
>   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x=
86
>   */
>  static int vfio_dma_unmap(VFIOContainer *container,
> -                          hwaddr iova, ram_addr_t size)
> +                          hwaddr iova, ram_addr_t size,
> +                          VFIOGuestIOMMU *giommu)
>  {
>      struct vfio_iommu_type1_dma_unmap unmap =3D {
>          .argsz =3D sizeof(unmap),
> @@ -324,6 +343,44 @@ static int vfio_dma_unmap(VFIOContainer *container,
>          .size =3D size,
>      };
> =20
> +    if (giommu && vfio_devices_are_running_and_saving()) {
> +        int ret;
> +        uint64_t bitmap_size;
> +        struct vfio_iommu_type1_dma_unmap_bitmap unmap_bitmap =3D {
> +            .argsz =3D sizeof(unmap_bitmap),
> +            .flags =3D VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP,
> +            .iova =3D iova,
> +            .size =3D size,
> +        };
> +
> +        bitmap_size =3D BITS_TO_LONGS(size >> TARGET_PAGE_BITS) *
> +                      sizeof(uint64_t);
> +
> +        unmap_bitmap.bitmap =3D g_try_malloc0(bitmap_size);
> +        if (!unmap_bitmap.bitmap) {
> +            error_report("%s: Error allocating bitmap buffer of size 0x%=
lx",
> +                         __func__, bitmap_size);
> +            return -ENOMEM;
> +        }
> +
> +        unmap_bitmap.bitmap_size =3D bitmap_size;
> +
> +        ret =3D ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA_GET_BITMAP,
> +                    &unmap_bitmap);
> +
> +        if (!ret) {
> +            cpu_physical_memory_set_dirty_lebitmap(
> +                                        (uint64_t *)unmap_bitmap.bitmap,
> +                                        giommu->iommu_offset + giommu->n=
.start,
> +                                        bitmap_size >> TARGET_PAGE_BITS)=
;

+1 Yan's comments.

> +        } else {
> +            error_report("VFIO_IOMMU_GET_DIRTY_BITMAP: %d %d", ret, errn=
o);
> +        }
> +
> +        g_free(unmap_bitmap.bitmap);
> +        return ret;
> +    }
> +
>      while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>          /*
>           * The type1 backend has an off-by-one bug in the kernel (71a7d3=
d78e3c
> @@ -371,7 +428,7 @@ static int vfio_dma_map(VFIOContainer *container, hwa=
ddr iova,
>       * the VGA ROM space.
>       */
>      if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) =3D=3D 0 ||
> -        (errno =3D=3D EBUSY && vfio_dma_unmap(container, iova, size) =3D=
=3D 0 &&
> +        (errno =3D=3D EBUSY && vfio_dma_unmap(container, iova, size, NUL=
L) =3D=3D 0 &&
>           ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) =3D=3D 0)) {
>          return 0;
>      }
> @@ -511,7 +568,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, I=
OMMUTLBEntry *iotlb)
>                           iotlb->addr_mask + 1, vaddr, ret);
>          }
>      } else {
> -        ret =3D vfio_dma_unmap(container, iova, iotlb->addr_mask + 1);
> +        ret =3D vfio_dma_unmap(container, iova, iotlb->addr_mask + 1, gi=
ommu);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") =3D %d (%m)",
> @@ -814,7 +871,7 @@ static void vfio_listener_region_del(MemoryListener *=
listener,
>      }
> =20
>      if (try_unmap) {
> -        ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize));
> +        ret =3D vfio_dma_unmap(container, iova, int128_get64(llsize), NU=
LL);
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                           "0x%"HWADDR_PRIx") =3D %d (%m)",



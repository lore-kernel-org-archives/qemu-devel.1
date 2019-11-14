Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ECBC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0316A206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOajecPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0316A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7Mn-0001So-VA
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Kf-0008JU-BU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Kd-0006UM-TQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7Kd-0006TZ-OD
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNpElcnHoG09rAyJXXNdkKcrPQV4qT63e8TRXxSuiDQ=;
 b=YOajecPCrtx2YB8PNUe8q7ExuL+e4IBNnzyubf5Tj0xysf/dtmclx/mC1Q9Q42XmX/+1vm
 9Pv2O0KK4FAn+5+Bl4E70tHMjm3h9xct+WuCn075XGpE7NNgaZ3M6VbL6pFYqfQRHZtUDT
 9ReK+x3WKk8tElHcTanjyr8rJiUsrvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-atUQ3-NdPO6zZpLltkCgXg-1; Thu, 14 Nov 2019 00:06:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B93F9800686;
 Thu, 14 Nov 2019 05:06:05 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCDA5F787;
 Thu, 14 Nov 2019 05:06:04 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:06:03 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 13/15] vfio: Add vfio_listener_log_sync to mark
 dirty pages
Message-ID: <20191113220603.274548cc@x1.home>
In-Reply-To: <1573578324-8389-14-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-14-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: atUQ3-NdPO6zZpLltkCgXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Tue, 12 Nov 2019 22:35:22 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> vfio_listener_log_sync gets list of dirty pages from container using
> VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
> devices are stopped and saving state.
> Return early for the RAM block section of mapped MMIO region.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/common.c     | 103 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/vfio/trace-events |   1 +
>  2 files changed, 104 insertions(+)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ade9839c28a3..66f1c64bf074 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -29,6 +29,7 @@
>  #include "hw/vfio/vfio.h"
>  #include "exec/address-spaces.h"
>  #include "exec/memory.h"
> +#include "exec/ram_addr.h"
>  #include "hw/hw.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> @@ -38,6 +39,7 @@
>  #include "sysemu/reset.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/migration.h"
> =20
>  VFIOGroupList vfio_group_list =3D
>      QLIST_HEAD_INITIALIZER(vfio_group_list);
> @@ -288,6 +290,28 @@ const MemoryRegionOps vfio_region_ops =3D {
>  };
> =20
>  /*
> + * Device state interfaces
> + */
> +
> +static bool vfio_devices_are_stopped_and_saving(void)
> +{
> +    VFIOGroup *group;
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(group, &vfio_group_list, next) {
> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> +                !(vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING)) {

(device_state & MASK) =3D=3D SAVING

> +                continue;

Kind of silly to have a continue rather than just changing the polarity
of the test so that we only branch into the return case.

> +            } else {
> +                return false;
> +            }
> +        }
> +    }
> +    return true;
> +}
> +
> +/*
>   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x=
86
>   */
>  static int vfio_dma_unmap(VFIOContainer *container,
> @@ -813,9 +837,88 @@ static void vfio_listener_region_del(MemoryListener =
*listener,
>      }
>  }
> =20
> +static int vfio_get_dirty_bitmap(VFIOContainer *container,
> +                                 MemoryRegionSection *section)
> +{
> +    struct vfio_iommu_type1_dirty_bitmap range;
> +    uint64_t bitmap_size;
> +    int ret;
> +
> +    range.argsz =3D sizeof(range);
> +
> +    if (memory_region_is_iommu(section->mr)) {
> +        VFIOGuestIOMMU *giommu;
> +        IOMMUTLBEntry iotlb;
> +
> +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> +            if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr &&
> +                giommu->n.start =3D=3D section->offset_within_region) {
> +                break;
> +            }
> +        }
> +
> +        if (!giommu) {
> +            return -EINVAL;
> +        }
> +
> +        iotlb =3D address_space_get_iotlb_entry(container->space->as,
> +                       TARGET_PAGE_ALIGN(section->offset_within_address_=
space),
> +                       true, MEMTXATTRS_UNSPECIFIED);
> +        range.iova =3D iotlb.iova + giommu->iommu_offset;
> +        range.size =3D iotlb.addr_mask + 1;
> +    } else {
> +        range.iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_=
space);
> +        range.size =3D int128_get64(section->size);
> +    }
> +
> +    bitmap_size =3D BITS_TO_LONGS(range.size >> TARGET_PAGE_BITS) *
> +                                                             sizeof(uint=
64_t);
> +
> +    range.bitmap =3D g_try_malloc0(bitmap_size);
> +    if (!range.bitmap) {
> +        error_report("%s: Error allocating bitmap buffer of size 0x%lx",
> +                     __func__, bitmap_size);
> +        return -ENOMEM;

We could certainly iterate with a smaller bitmap rather than use a
single ioctl.  This doesn't seem like it scales well as VM memory size
increases.

> +    }
> +
> +    range.bitmap_size =3D bitmap_size;
> +
> +    ret =3D ioctl(container->fd, VFIO_IOMMU_GET_DIRTY_BITMAP, &range);
> +
> +    if (!ret) {
> +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range.bitmap,
> +                       TARGET_PAGE_ALIGN(section->offset_within_address_=
space),
> +                       bitmap_size >> TARGET_PAGE_BITS);


Like Yan, I think this is relative to the iova address space and needs
a translation for the vIOMMU case.

> +    } else {
> +        error_report("VFIO_IOMMU_GET_DIRTY_BITMAP: %d %d", ret, errno);
> +    }
> +
> +    trace_vfio_get_dirty_bitmap(container->fd, range.iova, range.size,
> +                                bitmap_size);
> +
> +    g_free(range.bitmap);
> +    return ret;
> +}
> +
> +static void vfio_listerner_log_sync(MemoryListener *listener,
> +        MemoryRegionSection *section)
> +{
> +    VFIOContainer *container =3D container_of(listener, VFIOContainer, l=
istener);
> +
> +    if (memory_region_is_ram_device(section->mr)) {
> +        return;
> +    }
> +
> +    if (vfio_devices_are_stopped_and_saving()) {

I think a comment is necessary here indicating why we're not
participating in an iterative dirty bitmap sync.  Additionally, how
will the kernel indicate that we can support real dirty tracking?

> +
> +        vfio_get_dirty_bitmap(container, section);
> +    }
> +}
> +
>  static const MemoryListener vfio_memory_listener =3D {
>      .region_add =3D vfio_listener_region_add,
>      .region_del =3D vfio_listener_region_del,
> +    .log_sync =3D vfio_listerner_log_sync,
>  };
> =20
>  static void vfio_listener_release(VFIOContainer *container)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ac065b559f4e..0dd1f2ffe648 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -160,3 +160,4 @@ vfio_save_complete_precopy(char *name) " (%s)"
>  vfio_load_device_config_state(char *name) " (%s)"
>  vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
>  vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t d=
ata_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bit=
map_size) "container fd=3D%d, iova=3D0x%"PRIx64" size=3D 0x%"PRIx64" bitmap=
_size=3D0x%"PRIx64



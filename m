Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60EC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B81206F8
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hb55/1AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B81206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJijp-0008BB-V1
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jJiiy-0007Hj-1c
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jJiiw-00046K-1J
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:08:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jJiiv-00045s-S1
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 15:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585768104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoMSq75DnmK9qJbnQfrI/aGDgoK3nyAPAFGiFoyoIL4=;
 b=Hb55/1AWuzYMLnPkKghtcdpahKrHrlPfIpN1YVnp/1HlKdl/NMU+BZ9KU/uoFI50XHk7HZ
 bPQaJqpfgWJ75pZt4td0tnHz9ejeJOUBHmvElbPwqz7VDOtrm2Lv1jXFfBefHqKWBk0RTQ
 Qf+C0Y3ePd7JFDaX5KPHRUeLsU2Zm6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-fveJ2xsiPIGR7J2qO7wmVg-1; Wed, 01 Apr 2020 15:08:20 -0400
X-MC-Unique: fveJ2xsiPIGR7J2qO7wmVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 471EF8017CE;
 Wed,  1 Apr 2020 19:08:18 +0000 (UTC)
Received: from work-vm (ovpn-115-201.ams2.redhat.com [10.36.115.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 298A710002BC;
 Wed,  1 Apr 2020 19:08:11 +0000 (UTC)
Date: Wed, 1 Apr 2020 20:08:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v16 QEMU 14/16] vfio: Add vfio_listener_log_sync to mark
 dirty pages
Message-ID: <20200401190808.GK52559@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-15-git-send-email-kwankhede@nvidia.com>
 <20200326134650.0c7245e9@x1.home>
MIME-Version: 1.0
In-Reply-To: <20200326134650.0c7245e9@x1.home>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Wed, 25 Mar 2020 02:39:12 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
> > vfio_listener_log_sync gets list of dirty pages from container using
> > VFIO_IOMMU_GET_DIRTY_BITMAP ioctl and mark those pages dirty when all
> > devices are stopped and saving state.
> > Return early for the RAM block section of mapped MMIO region.
> >=20
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > ---
> >  hw/vfio/common.c     | 200 +++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  hw/vfio/trace-events |   1 +
> >  2 files changed, 196 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 4a2f0d6a2233..6d41e1ac5c2f 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -29,6 +29,7 @@
> >  #include "hw/vfio/vfio.h"
> >  #include "exec/address-spaces.h"
> >  #include "exec/memory.h"
> > +#include "exec/ram_addr.h"
> >  #include "hw/hw.h"
> >  #include "qemu/error-report.h"
> >  #include "qemu/main-loop.h"
> > @@ -38,6 +39,7 @@
> >  #include "sysemu/reset.h"
> >  #include "trace.h"
> >  #include "qapi/error.h"
> > +#include "migration/migration.h"
> > =20
> >  VFIOGroupList vfio_group_list =3D
> >      QLIST_HEAD_INITIALIZER(vfio_group_list);
> > @@ -288,6 +290,28 @@ const MemoryRegionOps vfio_region_ops =3D {
> >  };
> > =20
> >  /*
> > + * Device state interfaces
> > + */
> > +
> > +static bool vfio_devices_are_stopped_and_saving(void)
> > +{
> > +    VFIOGroup *group;
> > +    VFIODevice *vbasedev;
> > +
> > +    QLIST_FOREACH(group, &vfio_group_list, next) {
> > +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> > +            if ((vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) &&
> > +                !(vbasedev->device_state & VFIO_DEVICE_STATE_RUNNING))=
 {
> > +                continue;
> > +            } else {
> > +                return false;
> > +            }
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> > +/*
> >   * DMA - Mapping and unmapping for the "type1" IOMMU interface used on=
 x86
> >   */
> >  static int vfio_dma_unmap(VFIOContainer *container,
> > @@ -408,8 +432,8 @@ static bool vfio_listener_skipped_section(MemoryReg=
ionSection *section)
> >  }
> > =20
> >  /* Called with rcu_read_lock held.  */
> > -static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
> > -                           bool *read_only)
> > +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> > +                               ram_addr_t *ram_addr, bool *read_only)
> >  {
> >      MemoryRegion *mr;
> >      hwaddr xlat;
> > @@ -440,9 +464,17 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, v=
oid **vaddr,
> >          return false;
> >      }
> > =20
> > -    *vaddr =3D memory_region_get_ram_ptr(mr) + xlat;
> > -    *read_only =3D !writable || mr->readonly;
> > +    if (vaddr) {
> > +        *vaddr =3D memory_region_get_ram_ptr(mr) + xlat;
> > +    }
> > =20
> > +    if (ram_addr) {
> > +        *ram_addr =3D memory_region_get_ram_addr(mr) + xlat;
> > +    }
> > +
> > +    if (read_only) {
> > +        *read_only =3D !writable || mr->readonly;
> > +    }
> >      return true;
> >  }
> > =20
> > @@ -467,7 +499,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n,=
 IOMMUTLBEntry *iotlb)
> >      rcu_read_lock();
> > =20
> >      if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> > -        if (!vfio_get_vaddr(iotlb, &vaddr, &read_only)) {
> > +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
> >              goto out;
> >          }
> >          /*
> > @@ -813,9 +845,167 @@ static void vfio_listener_region_del(MemoryListen=
er *listener,
> >      }
> >  }
> > =20
> > +static int vfio_get_dirty_bitmap(MemoryListener *listener,
> > +                                 MemoryRegionSection *section)
> > +{
> > +    VFIOContainer *container =3D container_of(listener, VFIOContainer,=
 listener);
> > +    VFIOGuestIOMMU *giommu;
> > +    IOMMUTLBEntry iotlb;
> > +    hwaddr granularity, address_limit, iova;
> > +    int ret;
> > +
> > +    if (memory_region_is_iommu(section->mr)) {
> > +        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> > +            if (MEMORY_REGION(giommu->iommu) =3D=3D section->mr &&
> > +                giommu->n.start =3D=3D section->offset_within_region) =
{
> > +                break;
> > +            }
> > +        }
> > +
> > +        if (!giommu) {
> > +            return -EINVAL;
> > +        }
> > +    }
> > +
> > +    if (memory_region_is_iommu(section->mr)) {
> > +        granularity =3D memory_region_iommu_get_min_page_size(giommu->=
iommu);
> > +
> > +        address_limit =3D MIN(int128_get64(section->size),
> > +                            memory_region_iommu_get_address_limit(giom=
mu->iommu,
> > +                                                 int128_get64(section-=
>size)));
> > +    } else {
> > +        granularity =3D memory_region_size(section->mr);
> > +        address_limit =3D int128_get64(section->size);
> > +    }
> > +
> > +    iova =3D TARGET_PAGE_ALIGN(section->offset_within_address_space);
> > +
> > +    RCU_READ_LOCK_GUARD();
> > +
> > +    while (iova < address_limit) {
> > +        struct vfio_iommu_type1_dirty_bitmap *dbitmap;
> > +        struct vfio_iommu_type1_dirty_bitmap_get *range;
> > +        ram_addr_t start, pages;
> > +        uint64_t iova_xlat, size;
> > +
> > +        if (memory_region_is_iommu(section->mr)) {
> > +            iotlb =3D address_space_get_iotlb_entry(container->space->=
as, iova,
> > +                                                 true, MEMTXATTRS_UNSP=
ECIFIED);
> > +            if ((iotlb.target_as =3D=3D NULL) || (iotlb.addr_mask =3D=
=3D 0)) {
> > +                if ((iova + granularity) < iova) {
> > +                    break;
> > +                }
> > +                iova +=3D granularity;
> > +                continue;
> > +            }
> > +            iova_xlat =3D iotlb.iova + giommu->iommu_offset;
> > +            size =3D iotlb.addr_mask + 1;
> > +        } else {
> > +            iova_xlat =3D iova;
> > +            size =3D address_limit;
> > +        }
> > +
> > +        dbitmap =3D g_malloc0(sizeof(*dbitmap) + sizeof(*range));
> > +        if (!dbitmap) {
>=20
> AIUI, QEMU aborts if this fails, so no need to check.  Because reasons.

It does if you use g_malloc0; however if the data is large you can
use g_try_malloc0 and then it will return NULL and you can fail the
migration rather than nuking the VM.
(We often argue whether it's worth testing or not, I think generally=20
if the size is 'large' or user defined then use try, if it's small
then assume it works.  We've never defined small or large; but somewhere
around a few pages is about right.

Dave

> > +            return -ENOMEM;
> > +        }
> > +
> > +        dbitmap->argsz =3D sizeof(*dbitmap) + sizeof(*range);
> > +        dbitmap->flags =3D VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> > +        range =3D (struct vfio_iommu_type1_dirty_bitmap_get *)&dbitmap=
->data;
> > +        range->iova =3D iova_xlat;
> > +        range->size =3D size;
> > +
> > +        /*
> > +         * cpu_physical_memory_set_dirty_lebitmap() expects pages in b=
itmap of
> > +         * TARGET_PAGE_SIZE to mark those dirty. Hence set bitmap's pg=
size to
> > +         * TARGET_PAGE_SIZE.
> > +         */
> > +        range->bitmap.pgsize =3D TARGET_PAGE_SIZE;
> > +
> > +        /*
> > +         * Comment from kvm_physical_sync_dirty_bitmap() since same ap=
plies here
> > +         * XXX bad kernel interface alert
> > +         * For dirty bitmap, kernel allocates array of size aligned to
> > +         * bits-per-long.  But for case when the kernel is 64bits and
> > +         * the userspace is 32bits, userspace can't align to the same
> > +         * bits-per-long, since sizeof(long) is different between kern=
el
> > +         * and user space.  This way, userspace will provide buffer wh=
ich
> > +         * may be 4 bytes less than the kernel will use, resulting in
> > +         * userspace memory corruption (which is not detectable by val=
grind
> > +         * too, in most cases).
> > +         * So for now, let's align to 64 instead of HOST_LONG_BITS her=
e, in
> > +         * a hope that sizeof(long) won't become >8 any time soon.
> > +         */
>=20
> This seems like the problem we've avoided by defining our bitmap as an
> array of u64s rather than an array of longs.  Does this comment really
> still apply?
>=20
> > +
> > +        pages =3D TARGET_PAGE_ALIGN(range->size) >> TARGET_PAGE_BITS;
> > +        range->bitmap.size =3D ROUND_UP(pages, 64) / 8;
>=20
> ROUND_UP(npages/8, sizeof(u64))?
>=20
> > +        range->bitmap.data =3D g_malloc0(range->bitmap.size);
>=20
> We don't require this to be pre-zero'd currently.
>=20
> > +        if (range->bitmap.data =3D=3D NULL) {
>=20
> Same as above.  Seems strange to me too.
>=20
> > +            error_report("Error allocating bitmap of size 0x%llx",
> > +                         range->bitmap.size);
> > +            ret =3D -ENOMEM;
> > +            goto err_out;
> > +        }
> > +
> > +        ret =3D ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
> > +        if (ret) {
> > +            error_report("Failed to get dirty bitmap for iova: 0x%llx =
"
> > +                         "size: 0x%llx err: %d",
> > +                         range->iova, range->size, errno);
> > +            goto err_out;
> > +        }
> > +
> > +        if (memory_region_is_iommu(section->mr)) {
> > +            if (!vfio_get_xlat_addr(&iotlb, NULL, &start, NULL)) {
> > +                ret =3D -EINVAL;
> > +                goto err_out;
> > +            }
> > +        } else {
> > +            start =3D memory_region_get_ram_addr(section->mr) +
> > +                    section->offset_within_region + iova -
> > +                    TARGET_PAGE_ALIGN(section->offset_within_address_s=
pace);
> > +        }
> > +
> > +        cpu_physical_memory_set_dirty_lebitmap((uint64_t *)range->bitm=
ap.data,
> > +                                               start, pages);
> > +
> > +        trace_vfio_get_dirty_bitmap(container->fd, range->iova, range-=
>size,
> > +                                    range->bitmap.size, start);
> > +err_out:
> > +        g_free(range->bitmap.data);
> > +        g_free(dbitmap);
> > +
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +
> > +        if ((iova + size) < iova) {
> > +            break;
> > +        }
> > +
> > +        iova +=3D size;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void vfio_listerner_log_sync(MemoryListener *listener,
> > +        MemoryRegionSection *section)
> > +{
> > +    if (vfio_listener_skipped_section(section)) {
> > +        return;
> > +    }
> > +
> > +    if (vfio_devices_are_stopped_and_saving()) {
> > +        vfio_get_dirty_bitmap(listener, section);
> > +    }
> > +}
> > +
> >  static const MemoryListener vfio_memory_listener =3D {
> >      .region_add =3D vfio_listener_region_add,
> >      .region_del =3D vfio_listener_region_del,
> > +    .log_sync =3D vfio_listerner_log_sync,
> >  };
> > =20
> >  static void vfio_listener_release(VFIOContainer *container)
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index ac065b559f4e..bc8f35ee9356 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -160,3 +160,4 @@ vfio_save_complete_precopy(char *name) " (%s)"
> >  vfio_load_device_config_state(char *name) " (%s)"
> >  vfio_load_state(char *name, uint64_t data) " (%s) data 0x%"PRIx64
> >  vfio_load_state_device_data(char *name, uint64_t data_offset, uint64_t=
 data_size) " (%s) Offset 0x%"PRIx64" size 0x%"PRIx64
> > +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t b=
itmap_size, uint64_t start) "container fd=3D%d, iova=3D0x%"PRIx64" size=3D =
0x%"PRIx64" bitmap_size=3D0x%"PRIx64" start=3D0x%"PRIx64
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



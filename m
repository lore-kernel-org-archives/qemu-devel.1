Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F19C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6EA206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6EA206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46049 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmu9-0007AN-WE
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jLmtL-0006Cp-Q8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jLmtJ-0008Pd-MQ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:59:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:11063)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jLmtJ-0008LG-D8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:59:41 -0400
IronPort-SDR: wgBVIOc0SPfUQtyn3WifZVRETCHAAGlP1j667DtYPsVZW1pnKDmyA9RAD6I2TqGS/HlX/9DDYW
 HFvdYncrON+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 04:59:32 -0700
IronPort-SDR: kMK/zu/aJoUi0E2mrUAM6ZdC4q3im9ha28J9BX8NywwllJ9PO1827g/SmVoXoO/TQiyTIunVtp
 o7OL99kH242w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,354,1580803200"; d="scan'208";a="242055406"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga007.fm.intel.com with ESMTP; 07 Apr 2020 04:59:32 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 04:59:32 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.7]) with mapi id 14.03.0439.000;
 Tue, 7 Apr 2020 19:59:28 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-container
Thread-Topic: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-container
Thread-Index: AQHWBkpwPIB1pnyyvEKzxsLxObMvUahjYc6AgAhVRjD//7AngIACM3gA
Date: Tue, 7 Apr 2020 11:59:28 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A224E90@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-10-git-send-email-yi.l.liu@intel.com>
 <55a767fb-ed98-bc30-5de1-0791f1ce8642@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A222FCD@SHSMSX104.ccr.corp.intel.com>
 <b9f3a991-cfb9-dcf4-f0e6-00e348a94827@redhat.com>
In-Reply-To: <b9f3a991-cfb9-dcf4-f0e6-00e348a94827@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "Wu,
 Hao" <hao.wu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, April 6, 2020 6:20 PM
> Subject: Re: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-cont=
ainer
>=20
> Hi Yi,
>=20
> On 4/6/20 9:12 AM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >> Sent: Wednesday, April 1, 2020 3:51 PM
> >> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> >> Subject: Re: [PATCH v2 09/22] vfio/common: init HostIOMMUContext
> >> per-container
> >>
> >> Hi Yi,
> >>
> >> On 3/30/20 6:24 AM, Liu Yi L wrote:
> >>> In this patch, QEMU firstly gets iommu info from kernel to check the
> >>> supported capabilities by a VFIO_IOMMU_TYPE1_NESTING iommu. And
> >>> inits HostIOMMUContet instance.
> >>>
> >>> Cc: Kevin Tian <kevin.tian@intel.com>
> >>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Peter Xu <peterx@redhat.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> >>> Cc: David Gibson <david@gibson.dropbear.id.au>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> ---
> >>>  hw/vfio/common.c | 99
> >>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 99 insertions(+)
> >>>
> >>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
> >>> 5f3534d..44b142c 100644
> >>> --- a/hw/vfio/common.c
> >>> +++ b/hw/vfio/common.c
> >>> @@ -1226,10 +1226,89 @@ static int
> >> vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
> >>>      return 0;
> >>>  }
> >>>
> >>> +/**
> >>> + * Get iommu info from host. Caller of this funcion should free
> >>> + * the memory pointed by the returned pointer stored in @info
> >>> + * after a successful calling when finished its usage.
> >>> + */
> >>> +static int vfio_get_iommu_info(VFIOContainer *container,
> >>> +                         struct vfio_iommu_type1_info **info) {
> >>> +
> >>> +    size_t argsz =3D sizeof(struct vfio_iommu_type1_info);
> >>> +
> >>> +    *info =3D g_malloc0(argsz);
> >>> +
> >>> +retry:
> >>> +    (*info)->argsz =3D argsz;
> >>> +
> >>> +    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
> >>> +        g_free(*info);
> >>> +        *info =3D NULL;
> >>> +        return -errno;
> >>> +    }
> >>> +
> >>> +    if (((*info)->argsz > argsz)) {
> >>> +        argsz =3D (*info)->argsz;
> >>> +        *info =3D g_realloc(*info, argsz);
> >>> +        goto retry;
> >>> +    }
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static struct vfio_info_cap_header * vfio_get_iommu_info_cap(struct
> >>> +vfio_iommu_type1_info *info, uint16_t
> >>> +id) {
> >>> +    struct vfio_info_cap_header *hdr;
> >>> +    void *ptr =3D info;
> >>> +
> >>> +    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
> >>> +        return NULL;
> >>> +    }
> >>> +
> >>> +    for (hdr =3D ptr + info->cap_offset; hdr !=3D ptr; hdr =3D ptr +=
 hdr->next) {
> >>> +        if (hdr->id =3D=3D id) {
> >>> +            return hdr;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    return NULL;
> >>> +}
> >>> +
> >>> +static int vfio_get_nesting_iommu_cap(VFIOContainer *container,
> >>> +                   struct vfio_iommu_type1_info_cap_nesting
> >>> +*cap_nesting) {
> >>> +    struct vfio_iommu_type1_info *info;
> >>> +    struct vfio_info_cap_header *hdr;
> >>> +    struct vfio_iommu_type1_info_cap_nesting *cap;
> >>> +    int ret;
> >>> +
> >>> +    ret =3D vfio_get_iommu_info(container, &info);
> >>> +    if (ret) {
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    hdr =3D vfio_get_iommu_info_cap(info,
> >>> +                        VFIO_IOMMU_TYPE1_INFO_CAP_NESTING);
> >>> +    if (!hdr) {
> >>> +        g_free(info);
> >>> +        return -errno;
> >>> +    }
> >>> +
> >>> +    cap =3D container_of(hdr,
> >>> +                struct vfio_iommu_type1_info_cap_nesting, header);
> >>> +    *cap_nesting =3D *cap;
> >>> +
> >>> +    g_free(info);
> >>> +    return 0;
> >>> +}
> >>> +
> >>>  static int vfio_init_container(VFIOContainer *container, int group_f=
d,
> >>>                                 Error **errp)  {
> >>>      int iommu_type, ret;
> >>> +    uint64_t flags =3D 0;
> >>>
> >>>      iommu_type =3D vfio_get_iommu_type(container, errp);
> >>>      if (iommu_type < 0) {
> >>> @@ -1257,6 +1336,26 @@ static int vfio_init_container(VFIOContainer
> >> *container, int group_fd,
> >>>          return -errno;
> >>>      }
> >>>
> >>> +    if (iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
> >>> +        struct vfio_iommu_type1_info_cap_nesting nesting =3D {
> >>> +                                         .nesting_capabilities =3D 0=
x0,
> >>> +                                         .stage1_formats =3D 0, };
> >>> +
> >>> +        ret =3D vfio_get_nesting_iommu_cap(container, &nesting);
> >>> +        if (ret) {
> >>> +            error_setg_errno(errp, -ret,
> >>> +                             "Failed to get nesting iommu cap");
> >>> +            return ret;
> >>> +        }
> >>> +
> >>> +        flags |=3D (nesting.nesting_capabilities & VFIO_IOMMU_PASID_=
REQS) ?
> >>> +                 HOST_IOMMU_PASID_REQUEST : 0;
> >> I still don't get why you can't transform your iommu_ctx into a
> >> pointer and do
> >> container->iommu_ctx =3D g_new0(HostIOMMUContext, 1);
> >> then
> >> host_iommu_ctx_init(container->iommu_ctx, flags);
> >>
> >> looks something similar to (hw/vfio/common.c). You may not even need
> >> to use a derived VFIOHostIOMMUContext object (As only VFIO does use
> >> that object)? Only the ops do change, no new field?
> >>         region->mem =3D g_new0(MemoryRegion, 1);
> >>         memory_region_init_io(region->mem, obj, &vfio_region_ops,
> >>                               region, name, region->size);
> >
> > In this way, the vfio hook can easily get the VFIOContainer from
> > HostIOMMUContext when call in the hook provided by vfio. e.g. the one
> > below.
> OK I get it. However in memory_region_init_io(), you also pass the owner,=
 eg.
> region so I think you could do the same. no?
Hmm, I can add it. But I've no idea about the proper owner for it so far.
any suggestion?

Regards,
Yi Liu


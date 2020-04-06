Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B0BC2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E98206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 07:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E98206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLLwU-0007nF-Vi
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 03:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jLLvu-0007JG-Du
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jLLvt-0002sJ-5P
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:12:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:11506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jLLvs-0002rh-Sp
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 03:12:33 -0400
IronPort-SDR: 5vjTSsTOEWzy4ku7QwphezE1ywlLkbGr9pkaUoYLkDMTvmGnIw84h6eGw66fl7FmB7tT19YtsR
 pGA0cwk+4dvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 00:12:31 -0700
IronPort-SDR: q7b4Rl2dOcvLvA9MVLTPLwqWk3MsHEYDhQCDmDuSHmjdtOvvI/1worceTUiao1ett5w4UxPAvh
 l/0KZc6yM4Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; d="scan'208";a="250806340"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga003.jf.intel.com with ESMTP; 06 Apr 2020 00:12:30 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Apr 2020 00:12:30 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Mon, 6 Apr 2020 15:12:27 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-container
Thread-Topic: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-container
Thread-Index: AQHWBkpwPIB1pnyyvEKzxsLxObMvUahjYc6AgAhVRjA=
Date: Mon, 6 Apr 2020 07:12:27 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A222FCD@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-10-git-send-email-yi.l.liu@intel.com>
 <55a767fb-ed98-bc30-5de1-0791f1ce8642@redhat.com>
In-Reply-To: <55a767fb-ed98-bc30-5de1-0791f1ce8642@redhat.com>
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
X-Received-From: 192.55.52.43
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
 "mst@redhat.com" <mst@redhat.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Wednesday, April 1, 2020 3:51 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; qemu-devel@nongnu.org;
> Subject: Re: [PATCH v2 09/22] vfio/common: init HostIOMMUContext per-cont=
ainer
>=20
> Hi Yi,
>=20
> On 3/30/20 6:24 AM, Liu Yi L wrote:
> > In this patch, QEMU firstly gets iommu info from kernel to check the
> > supported capabilities by a VFIO_IOMMU_TYPE1_NESTING iommu. And inits
> > HostIOMMUContet instance.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  hw/vfio/common.c | 99
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
> > 5f3534d..44b142c 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1226,10 +1226,89 @@ static int
> vfio_host_iommu_ctx_pasid_free(HostIOMMUContext *iommu_ctx,
> >      return 0;
> >  }
> >
> > +/**
> > + * Get iommu info from host. Caller of this funcion should free
> > + * the memory pointed by the returned pointer stored in @info
> > + * after a successful calling when finished its usage.
> > + */
> > +static int vfio_get_iommu_info(VFIOContainer *container,
> > +                         struct vfio_iommu_type1_info **info) {
> > +
> > +    size_t argsz =3D sizeof(struct vfio_iommu_type1_info);
> > +
> > +    *info =3D g_malloc0(argsz);
> > +
> > +retry:
> > +    (*info)->argsz =3D argsz;
> > +
> > +    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
> > +        g_free(*info);
> > +        *info =3D NULL;
> > +        return -errno;
> > +    }
> > +
> > +    if (((*info)->argsz > argsz)) {
> > +        argsz =3D (*info)->argsz;
> > +        *info =3D g_realloc(*info, argsz);
> > +        goto retry;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static struct vfio_info_cap_header *
> > +vfio_get_iommu_info_cap(struct vfio_iommu_type1_info *info, uint16_t
> > +id) {
> > +    struct vfio_info_cap_header *hdr;
> > +    void *ptr =3D info;
> > +
> > +    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
> > +        return NULL;
> > +    }
> > +
> > +    for (hdr =3D ptr + info->cap_offset; hdr !=3D ptr; hdr =3D ptr + h=
dr->next) {
> > +        if (hdr->id =3D=3D id) {
> > +            return hdr;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static int vfio_get_nesting_iommu_cap(VFIOContainer *container,
> > +                   struct vfio_iommu_type1_info_cap_nesting
> > +*cap_nesting) {
> > +    struct vfio_iommu_type1_info *info;
> > +    struct vfio_info_cap_header *hdr;
> > +    struct vfio_iommu_type1_info_cap_nesting *cap;
> > +    int ret;
> > +
> > +    ret =3D vfio_get_iommu_info(container, &info);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    hdr =3D vfio_get_iommu_info_cap(info,
> > +                        VFIO_IOMMU_TYPE1_INFO_CAP_NESTING);
> > +    if (!hdr) {
> > +        g_free(info);
> > +        return -errno;
> > +    }
> > +
> > +    cap =3D container_of(hdr,
> > +                struct vfio_iommu_type1_info_cap_nesting, header);
> > +    *cap_nesting =3D *cap;
> > +
> > +    g_free(info);
> > +    return 0;
> > +}
> > +
> >  static int vfio_init_container(VFIOContainer *container, int group_fd,
> >                                 Error **errp)  {
> >      int iommu_type, ret;
> > +    uint64_t flags =3D 0;
> >
> >      iommu_type =3D vfio_get_iommu_type(container, errp);
> >      if (iommu_type < 0) {
> > @@ -1257,6 +1336,26 @@ static int vfio_init_container(VFIOContainer
> *container, int group_fd,
> >          return -errno;
> >      }
> >
> > +    if (iommu_type =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
> > +        struct vfio_iommu_type1_info_cap_nesting nesting =3D {
> > +                                         .nesting_capabilities =3D 0x0=
,
> > +                                         .stage1_formats =3D 0, };
> > +
> > +        ret =3D vfio_get_nesting_iommu_cap(container, &nesting);
> > +        if (ret) {
> > +            error_setg_errno(errp, -ret,
> > +                             "Failed to get nesting iommu cap");
> > +            return ret;
> > +        }
> > +
> > +        flags |=3D (nesting.nesting_capabilities & VFIO_IOMMU_PASID_RE=
QS) ?
> > +                 HOST_IOMMU_PASID_REQUEST : 0;
> I still don't get why you can't transform your iommu_ctx into a  pointer =
and do
> container->iommu_ctx =3D g_new0(HostIOMMUContext, 1);
> then
> host_iommu_ctx_init(container->iommu_ctx, flags);
>=20
> looks something similar to (hw/vfio/common.c). You may not even need to u=
se a
> derived VFIOHostIOMMUContext object (As only VFIO does use that object)? =
Only
> the ops do change, no new field?
>         region->mem =3D g_new0(MemoryRegion, 1);
>         memory_region_init_io(region->mem, obj, &vfio_region_ops,
>                               region, name, region->size);

In this way, the vfio hook can easily get the VFIOContainer from
HostIOMMUContext when call in the hook provided by vfio. e.g. the
one below.

+static int vfio_host_iommu_ctx_pasid_alloc(HostIOMMUContext *iommu_ctx,
+                                           uint32_t min, uint32_t max,
+                                           uint32_t *pasid)
+{
+    VFIOContainer *container =3D container_of(iommu_ctx,
+                                            VFIOContainer, iommu_ctx);
=20
Regards,
Yi Liu


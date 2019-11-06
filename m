Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F1C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0826D217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0826D217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKLX-0004yF-93
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSKKt-0004Z1-9w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSKKr-0005BW-UI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:22:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:61597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSKKr-0005Ak-La
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:22:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 04:22:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="402339407"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 04:22:48 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 04:22:47 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.200]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 20:22:46 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
Subject: RE: [RFC v2 14/22] vfio/pci: add iommu_context notifier for pasid
 bind/unbind
Thread-Topic: [RFC v2 14/22] vfio/pci: add iommu_context notifier for pasid
 bind/unbind
Thread-Index: AQHVims1OZV2XVCCuEyc7KnxOKt2Oqd6t5AAgANrjkA=
Date: Wed, 6 Nov 2019 12:22:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EF2F1@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-15-git-send-email-yi.l.liu@intel.com>
 <20191104160228.GG3552@umbus.metropole.lan>
In-Reply-To: <20191104160228.GG3552@umbus.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGU5ZTIzNWYtNmY5My00NDlhLWI0ZjYtZTNkY2QyYjFlYzA3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN0VWdlJUYVA1T2lIZ21oeUd2Ykt2Y0JtbjV5VXk1ZVJrOVlTemRkXC82TFZNbWhjblU2ZFJyXC96eUpIWGtWcW1HIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: David Gibson
> Sent: Tuesday, November 5, 2019 12:02 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 14/22] vfio/pci: add iommu_context notifier for pasi=
d
> bind/unbind
>=20
> On Thu, Oct 24, 2019 at 08:34:35AM -0400, Liu Yi L wrote:
> > This patch adds notifier for pasid bind/unbind. VFIO registers this
> > notifier to listen to the dual-stage translation (a.k.a. nested
> > translation) configuration changes and propagate to host. Thus vIOMMU
> > is able to set its translation structures to host.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  hw/vfio/pci.c            | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/hw/iommu/iommu.h | 11 +++++++++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 8721ff6..012b8ed 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2767,6 +2767,41 @@ static void
> vfio_iommu_pasid_free_notify(IOMMUCTXNotifier *n,
> >      pasid_req->free_result =3D ret;
> >  }
> >
> > +static void vfio_iommu_pasid_bind_notify(IOMMUCTXNotifier *n,
> > +                                         IOMMUCTXEventData *event_data=
)
> > +{
> > +#ifdef __linux__
>=20
> Is hw/vfio/pci.c even built on non-linux hosts?

I'm not quite sure. It's based a comment from RFC v1. I think it could some=
how
prevent compiling issue when doing code porting. So I added it. If it's imp=
ossible
to build on non-linux hosts per your experience, I can remove it to make th=
ings
simple.

> > +    VFIOIOMMUContext *giommu_ctx =3D container_of(n, VFIOIOMMUContext,=
 n);
> > +    VFIOContainer *container =3D giommu_ctx->container;
> > +    IOMMUCTXPASIDBindData *pasid_bind =3D
> > +                              (IOMMUCTXPASIDBindData *) event_data->da=
ta;
> > +    struct vfio_iommu_type1_bind *bind;
> > +    struct iommu_gpasid_bind_data *bind_data;
> > +    unsigned long argsz;
> > +
> > +    argsz =3D sizeof(*bind) + sizeof(*bind_data);
> > +    bind =3D g_malloc0(argsz);
> > +    bind->argsz =3D argsz;
> > +    bind->bind_type =3D VFIO_IOMMU_BIND_GUEST_PASID;
> > +    bind_data =3D (struct iommu_gpasid_bind_data *) &bind->data;
> > +    *bind_data =3D *pasid_bind->data;
> > +
> > +    if (pasid_bind->flag & IOMMU_CTX_BIND_PASID) {
> > +        if (ioctl(container->fd, VFIO_IOMMU_BIND, bind) !=3D 0) {
> > +            error_report("%s: pasid (%llu:%llu) bind failed: %d", __fu=
nc__,
> > +                         bind_data->gpasid, bind_data->hpasid, -errno)=
;
> > +        }
> > +    } else if (pasid_bind->flag & IOMMU_CTX_UNBIND_PASID) {
> > +        if (ioctl(container->fd, VFIO_IOMMU_UNBIND, bind) !=3D 0) {
> > +            error_report("%s: pasid (%llu:%llu) unbind failed: %d", __=
func__,
> > +                         bind_data->gpasid, bind_data->hpasid, -errno)=
;
> > +        }
> > +    }
> > +
> > +    g_free(bind);
> > +#endif
> > +}
> > +
> >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> > @@ -3079,6 +3114,10 @@ static void vfio_realize(PCIDevice *pdev, Error =
**errp)
> >                                           iommu_context,
> >                                           vfio_iommu_pasid_free_notify,
> >                                           IOMMU_CTX_EVENT_PASID_FREE);
> > +        vfio_register_iommu_ctx_notifier(vdev,
> > +                                         iommu_context,
> > +                                         vfio_iommu_pasid_bind_notify,
> > +                                         IOMMU_CTX_EVENT_PASID_BIND);
> >      }
> >
> >      return;
> > diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
> > index 4352afd..4f21aa1 100644
> > --- a/include/hw/iommu/iommu.h
> > +++ b/include/hw/iommu/iommu.h
> > @@ -33,6 +33,7 @@ typedef struct IOMMUContext IOMMUContext;
> >  enum IOMMUCTXEvent {
> >      IOMMU_CTX_EVENT_PASID_ALLOC,
> >      IOMMU_CTX_EVENT_PASID_FREE,
> > +    IOMMU_CTX_EVENT_PASID_BIND,
> >      IOMMU_CTX_EVENT_NUM,
> >  };
> >  typedef enum IOMMUCTXEvent IOMMUCTXEvent;
> > @@ -50,6 +51,16 @@ union IOMMUCTXPASIDReqDesc {
> >  };
> >  typedef union IOMMUCTXPASIDReqDesc IOMMUCTXPASIDReqDesc;
> >
> > +struct IOMMUCTXPASIDBindData {
> > +#define IOMMU_CTX_BIND_PASID   (1 << 0)
> > +#define IOMMU_CTX_UNBIND_PASID (1 << 1)
> > +    uint32_t flag;
> > +#ifdef __linux__
> > +    struct iommu_gpasid_bind_data *data;
>=20
> Embedding a linux specific structure in the notification message seems
> dubious to me.

Just similar as your above comment in this thread. If we don't want to add
it there, then here it is also unnecessary.

@Eric, do you think it is still necessary to add the __linux__ marco here?

Thanks,
Yi Liu


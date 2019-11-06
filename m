Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C73C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:17:02 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E212920869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E212920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKFB-0002Bd-1x
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iSKDU-0001Fn-O1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iSKDO-00089i-Ha
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:15:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:42095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iSKDO-00088Y-7V
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:15:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 04:15:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; d="scan'208";a="214226967"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga002.jf.intel.com with ESMTP; 06 Nov 2019 04:15:03 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 04:15:03 -0800
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 Nov 2019 04:14:55 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.248]) with mapi id 14.03.0439.000;
 Wed, 6 Nov 2019 20:14:50 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Thread-Topic: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasid
 alloc/free
Thread-Index: AQHVimsw6XlsA5+cTkCxXGelXmRQYKdxCjoAgA0JSAA=
Date: Wed, 6 Nov 2019 12:14:50 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0EF2CE@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-10-git-send-email-yi.l.liu@intel.com>
 <20191029121544.GS3552@umbus.metropole.lan>
In-Reply-To: <20191029121544.GS3552@umbus.metropole.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDk5OWNhMzAtNjA3Mi00Y2U4LWE3NWItNTU5NDM1MWMyYmRmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib3d1cEpFa1NObE9rU0JQMHdXcm1lNDhDeE94VW5QMXY2ZkdGaVlDaTBrVHZMdXNcL3p2NnNBSWREYVJhK1d2T3MifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> Sent: Tuesday, October 29, 2019 8:16 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v2 09/22] vfio/pci: add iommu_context notifier for pasi=
d alloc/free
>=20
> On Thu, Oct 24, 2019 at 08:34:30AM -0400, Liu Yi L wrote:
> > This patch adds pasid alloc/free notifiers for vfio-pci. It is
> > supposed to be fired by vIOMMU. VFIO then sends PASID allocation
> > or free request to host.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  hw/vfio/common.c         |  9 ++++++
> >  hw/vfio/pci.c            | 81
> ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/iommu/iommu.h | 15 +++++++++
> >  3 files changed, 105 insertions(+)
> >
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index d418527..e6ad21c 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1436,6 +1436,7 @@ static void vfio_disconnect_container(VFIOGroup
> *group)
> >      if (QLIST_EMPTY(&container->group_list)) {
> >          VFIOAddressSpace *space =3D container->space;
> >          VFIOGuestIOMMU *giommu, *tmp;
> > +        VFIOIOMMUContext *giommu_ctx, *ctx;
> >
> >          QLIST_REMOVE(container, next);
> >
> > @@ -1446,6 +1447,14 @@ static void vfio_disconnect_container(VFIOGroup
> *group)
> >              g_free(giommu);
> >          }
> >
> > +        QLIST_FOREACH_SAFE(giommu_ctx, &container->iommu_ctx_list,
> > +                                                   iommu_ctx_next, ctx=
) {
> > +            iommu_ctx_notifier_unregister(giommu_ctx->iommu_ctx,
> > +                                                      &giommu_ctx->n);
> > +            QLIST_REMOVE(giommu_ctx, iommu_ctx_next);
> > +            g_free(giommu_ctx);
> > +        }
> > +
> >          trace_vfio_disconnect_container(container->fd);
> >          close(container->fd);
> >          g_free(container);
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 12fac39..8721ff6 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2699,11 +2699,80 @@ static void
> vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
> >      vdev->req_enabled =3D false;
> >  }
> >
> > +static void vfio_register_iommu_ctx_notifier(VFIOPCIDevice *vdev,
> > +                                             IOMMUContext *iommu_ctx,
> > +                                             IOMMUCTXNotifyFn fn,
> > +                                             IOMMUCTXEvent event)
> > +{
> > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > +    VFIOIOMMUContext *giommu_ctx;
> > +
> > +    giommu_ctx =3D g_malloc0(sizeof(*giommu_ctx));
> > +    giommu_ctx->container =3D container;
> > +    giommu_ctx->iommu_ctx =3D iommu_ctx;
> > +    QLIST_INSERT_HEAD(&container->iommu_ctx_list,
> > +                      giommu_ctx,
> > +                      iommu_ctx_next);
> > +    iommu_ctx_notifier_register(iommu_ctx,
> > +                                &giommu_ctx->n,
> > +                                fn,
> > +                                event);
> > +}
> > +
> > +static void vfio_iommu_pasid_alloc_notify(IOMMUCTXNotifier *n,
> > +                                          IOMMUCTXEventData *event_dat=
a)
> > +{
> > +    VFIOIOMMUContext *giommu_ctx =3D container_of(n, VFIOIOMMUContext,=
 n);
> > +    VFIOContainer *container =3D giommu_ctx->container;
> > +    IOMMUCTXPASIDReqDesc *pasid_req =3D
> > +                              (IOMMUCTXPASIDReqDesc *) event_data->dat=
a;
> > +    struct vfio_iommu_type1_pasid_request req;
> > +    unsigned long argsz;
> > +    int pasid;
> > +
> > +    argsz =3D sizeof(req);
> > +    req.argsz =3D argsz;
> > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > +    req.min_pasid =3D pasid_req->min_pasid;
> > +    req.max_pasid =3D pasid_req->max_pasid;
> > +
> > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > +    if (pasid < 0) {
> > +        error_report("%s: %d, alloc failed", __func__, -errno);
> > +    }
> > +    pasid_req->alloc_result =3D pasid;
>=20
> Altering the event data from the notifier doesn't make sense.  By
> definition there can be multiple notifiers on the chain, so in that
> case which one is responsible for updating the writable field?

I guess you mean multiple pasid_alloc nofitiers. right?

It works for VT-d now, as Intel vIOMMU maintains the IOMMUContext
per-bdf. And there will be only 1 pasid_alloc notifier in the chain. But, I
agree it is not good if other module just share an IOMMUConext across
devices. Definitely, it would have multiple pasid_alloc notifiers.

How about enforcing IOMMUContext layer to only invoke one successful
pasid_alloc/free notifier if PASID_ALLOC/FREE event comes? pasid
alloc/free are really special as it requires feedback. And a potential
benefit is that the pasid_alloc/free will not be affected by hot plug
scenario. There will be always a notifier to work for pasid_alloc/free
work unless all passthru devices are hot plugged. How do you think? Or
if any other idea?

> > +}
> > +
> > +static void vfio_iommu_pasid_free_notify(IOMMUCTXNotifier *n,
> > +                                          IOMMUCTXEventData *event_dat=
a)
> > +{
> > +    VFIOIOMMUContext *giommu_ctx =3D container_of(n, VFIOIOMMUContext,=
 n);
> > +    VFIOContainer *container =3D giommu_ctx->container;
> > +    IOMMUCTXPASIDReqDesc *pasid_req =3D
> > +                              (IOMMUCTXPASIDReqDesc *) event_data->dat=
a;
> > +    struct vfio_iommu_type1_pasid_request req;
> > +    unsigned long argsz;
> > +    int ret =3D 0;
> > +
> > +    argsz =3D sizeof(req);
> > +    req.argsz =3D argsz;
> > +    req.flag =3D VFIO_IOMMU_PASID_FREE;
> > +    req.pasid =3D pasid_req->pasid;
> > +
> > +    ret =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > +    if (ret !=3D 0) {
> > +        error_report("%s: %d, pasid %u free failed",
> > +                   __func__, -errno, (unsigned) pasid_req->pasid);
> > +    }
> > +    pasid_req->free_result =3D ret;
>=20
> Same problem here.

yep, as above proposal.

> > +}
> > +
> >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> >      VFIODevice *vbasedev_iter;
> >      VFIOGroup *group;
> > +    IOMMUContext *iommu_context;
> >      char *tmp, *subsys, group_path[PATH_MAX], *group_name;
> >      Error *err =3D NULL;
> >      ssize_t len;
> > @@ -3000,6 +3069,18 @@ static void vfio_realize(PCIDevice *pdev, Error =
**errp)
> >      vfio_register_req_notifier(vdev);
> >      vfio_setup_resetfn_quirk(vdev);
> >
> > +    iommu_context =3D pci_device_iommu_context(pdev);
> > +    if (iommu_context) {
> > +        vfio_register_iommu_ctx_notifier(vdev,
> > +                                         iommu_context,
> > +                                         vfio_iommu_pasid_alloc_notify=
,
> > +                                         IOMMU_CTX_EVENT_PASID_ALLOC);
> > +        vfio_register_iommu_ctx_notifier(vdev,
> > +                                         iommu_context,
> > +                                         vfio_iommu_pasid_free_notify,
> > +                                         IOMMU_CTX_EVENT_PASID_FREE);
> > +    }
> > +
> >      return;
> >
> >  out_teardown:
> > diff --git a/include/hw/iommu/iommu.h b/include/hw/iommu/iommu.h
> > index c22c442..4352afd 100644
> > --- a/include/hw/iommu/iommu.h
> > +++ b/include/hw/iommu/iommu.h
> > @@ -31,10 +31,25 @@
> >  typedef struct IOMMUContext IOMMUContext;
> >
> >  enum IOMMUCTXEvent {
> > +    IOMMU_CTX_EVENT_PASID_ALLOC,
> > +    IOMMU_CTX_EVENT_PASID_FREE,
> >      IOMMU_CTX_EVENT_NUM,
> >  };
> >  typedef enum IOMMUCTXEvent IOMMUCTXEvent;
> >
> > +union IOMMUCTXPASIDReqDesc {
> > +    struct {
> > +        uint32_t min_pasid;
> > +        uint32_t max_pasid;
> > +        int32_t alloc_result; /* pasid allocated for the alloc request=
 */
> > +    };
> > +    struct {
> > +        uint32_t pasid; /* pasid to be free */
> > +        int free_result;
> > +    };
> > +};
>=20
> Apart from theproblem with writable fields, using a big union for
> event data is pretty ugly.  If you need this different information for
> the different events, it might make more sense to have a separate
> notifier chain with a separate call interface for each event type,
> rather than trying to multiplex them together.

sure, I'll de-couple them. Nice catch.

Thanks,
Yi Liu



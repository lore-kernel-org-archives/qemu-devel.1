Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C741AC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A011920880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A011920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKf4-00008o-TK
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hnKet-00087t-6o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hnKer-0001EF-QR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:26:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:19623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hnKer-0001BM-Fc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:26:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 03:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,498,1557212400"; d="scan'208";a="194841602"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2019 03:26:00 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jul 2019 03:26:00 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jul 2019 03:25:57 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jul 2019 03:25:56 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.3]) with mapi id 14.03.0439.000;
 Tue, 16 Jul 2019 18:25:55 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Thread-Topic: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementation
Thread-Index: AQHVM+ylZdJ7a+KBXU2HFFh5qj+Ya6bKg4OAgAJ3NWA=
Date: Tue, 16 Jul 2019 10:25:55 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
In-Reply-To: <20190715025519.GE3440@umbus.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjY5YTdiNTgtOGIxMi00ZmRlLWFiNDktYTNmZWZkOTAwYWFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ21mRWlwNUcxbVFkSXlkczZmdjRnMlRKZlhTSCtqcGRna3hsaVdiQTgydVhkRk9pMFpxSUJLdElGXC83ZjBFMkgifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On Beh=
alf
> Of David Gibson
> Sent: Monday, July 15, 2019 10:55 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementation
>=20
> On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> > This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pasid(=
).
> > These two functions are used to propagate guest pasid allocation and
> > free requests to host via vfio container ioctl.
>=20
> As I said in an earlier comment, I think doing this on the device is
> conceptually incorrect.  I think we need an explcit notion of an SVM
> context (i.e. the namespace in which all the PASIDs live) - which will
> IIUC usually be shared amongst multiple devices.  The create and free
> PASID requests should be on that object.

Actually, the allocation is not doing on this device. System wide, it is
done on a container. So not sure if it is the API interface gives you a
sense that this is done on device. Also, curious on the SVM context
concept, do you mean it a per-VM context or a per-SVM usage context?
May you elaborate a little more. :-)

Thanks,
Yi Liu

> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  hw/vfio/pci.c | 61
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index ce3fe96..ab184ad 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2690,6 +2690,65 @@ static void vfio_unregister_req_notifier(VFIOPCI=
Device
> *vdev)
> >      vdev->req_enabled =3D false;
> >  }
> >
> > +static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
> > +                                               int32_t devfn,
> > +                                               uint32_t min_pasid,
> > +                                               uint32_t max_pasid)
> > +{
> > +    PCIDevice *pdev =3D bus->devices[devfn];
> > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > +    struct vfio_iommu_type1_pasid_request req;
> > +    unsigned long argsz;
> > +    int pasid;
> > +
> > +    argsz =3D sizeof(req);
> > +    req.argsz =3D argsz;
> > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > +    req.min_pasid =3D min_pasid;
> > +    req.max_pasid =3D max_pasid;
> > +
> > +    rcu_read_lock();
> > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > +    if (pasid < 0) {
> > +        error_report("vfio_pci_device_request_pasid_alloc:"
> > +                     " request failed, contanier: %p", container);
> > +    }
> > +    rcu_read_unlock();
> > +    return pasid;
> > +}
> > +
> > +static int vfio_pci_device_request_pasid_free(PCIBus *bus,
> > +                                              int32_t devfn,
> > +                                              uint32_t pasid)
> > +{
> > +    PCIDevice *pdev =3D bus->devices[devfn];
> > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > +    struct vfio_iommu_type1_pasid_request req;
> > +    unsigned long argsz;
> > +    int ret =3D 0;
> > +
> > +    argsz =3D sizeof(req);
> > +    req.argsz =3D argsz;
> > +    req.flag =3D VFIO_IOMMU_PASID_FREE;
> > +    req.pasid =3D pasid;
> > +
> > +    rcu_read_lock();
> > +    ret =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > +    if (ret !=3D 0) {
> > +        error_report("vfio_pci_device_request_pasid_free:"
> > +                     " request failed, contanier: %p", container);
> > +    }
> > +    rcu_read_unlock();
> > +    return ret;
> > +}
> > +
> > +static PCIPASIDOps vfio_pci_pasid_ops =3D {
> > +    .alloc_pasid =3D vfio_pci_device_request_pasid_alloc,
> > +    .free_pasid =3D vfio_pci_device_request_pasid_free,
> > +};
> > +
> >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> >  {
> >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> > @@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
> >      vfio_register_req_notifier(vdev);
> >      vfio_setup_resetfn_quirk(vdev);
> >
> > +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
> > +
> >      return;
> >
> >  out_teardown:
>=20
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other=
_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


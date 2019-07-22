Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB73AC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872D422296
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872D422296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpSMM-0005x7-LE
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 03:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hpSM4-0005VX-Qz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hpSLz-00081w-RG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:03:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:25264)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hpSLv-0007eE-BJ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:03:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2019 00:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,294,1559545200"; d="scan'208";a="180310555"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 22 Jul 2019 00:02:53 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 00:02:53 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 00:02:53 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.162]) with mapi id 14.03.0439.000;
 Mon, 22 Jul 2019 15:02:51 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Thread-Topic: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementation
Thread-Index: AQHVM+ylZdJ7a+KBXU2HFFh5qj+Ya6bKg4OAgAJ3NWCAALChAIAIjcJA
Date: Mon, 22 Jul 2019 07:02:51 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0140E0@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
 <20190715025519.GE3440@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A00D8BB@SHSMSX104.ccr.corp.intel.com>
 <20190717030640.GG9123@umbus.fritz.box>
In-Reply-To: <20190717030640.GG9123@umbus.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTIyNTIwM2UtYzAxNy00MjgzLWI0ZGItMWRlZmRmMTEwZmRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ0ZrQXpOY0R3R1VTNkdGaFlVemE2TVFUeGhXKzVWT1g3dkdYaHRiZXVXNWNXRXJpTzlOMkFpWlE4alkwNUhuSCJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
> Sent: Wednesday, July 17, 2019 11:07 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementation
>=20
> On Tue, Jul 16, 2019 at 10:25:55AM +0000, Liu, Yi L wrote:
> > > From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> Behalf
> > > Of David Gibson
> > > Sent: Monday, July 15, 2019 10:55 AM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [RFC v1 05/18] vfio/pci: add pasid alloc/free implementa=
tion
> > >
> > > On Fri, Jul 05, 2019 at 07:01:38PM +0800, Liu Yi L wrote:
> > > > This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pa=
sid().
> > > > These two functions are used to propagate guest pasid allocation an=
d
> > > > free requests to host via vfio container ioctl.
> > >
> > > As I said in an earlier comment, I think doing this on the device is
> > > conceptually incorrect.  I think we need an explcit notion of an SVM
> > > context (i.e. the namespace in which all the PASIDs live) - which wil=
l
> > > IIUC usually be shared amongst multiple devices.  The create and free
> > > PASID requests should be on that object.
> >
> > Actually, the allocation is not doing on this device. System wide, it i=
s
> > done on a container. So not sure if it is the API interface gives you a
> > sense that this is done on device.
>=20
> Sorry, I should have been clearer.  I can see that at the VFIO level
> it is done on the container.  However the function here takes a bus
> and devfn, so this qemu internal interface is per-device, which
> doesn't really make sense.

Got it. The reason here is to pass the bus and devfn info, so that VFIO
can figure out a container for the operation. So far in QEMU, there is
no good way to connect the vIOMMU emulator and VFIO regards to
SVM. hw/pci layer is a choice based on some previous discussion. But
yes, I agree with you that we may need to have an explicit notion for
SVM. Do you think it is good to introduce a new abstract layer for SVM
(may name as SVMContext). The idea would be that vIOMMU maintain
the SVMContext instances and expose explicit interface for VFIO to get
it. Then VFIO register notifiers on to the SVMContext. When vIOMMU
emulator wants to do PASID alloc/free, it fires the corresponding
notifier. After call into VFIO, the notifier function itself figure out the
container it is bound. In this way, it's the duty of vIOMMU emulator to
figure out a proper notifier to fire. From interface point of view, it is n=
o
longer per-device. Also, it leaves the PASID management details to
vIOMMU emulator as it can be vendor specific. Does it make sense?
Also, I'd like to know if you have any other idea on it. That would
surely be helpful. :-)

> > Also, curious on the SVM context
> > concept, do you mean it a per-VM context or a per-SVM usage context?
> > May you elaborate a little more. :-)
>=20
> Sorry, I'm struggling to find a good term for this.  By "context" I
> mean a namespace containing a bunch of PASID address spaces, those
> PASIDs are then visible to some group of devices.

I see. May be the SVMContext instance above can include multiple PASID
address spaces. And again, I think this relationship should be maintained
in vIOMMU emulator.

Thanks,
Yi Liu

>=20
> >
> > Thanks,
> > Yi Liu
> >
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > > > ---
> > > >  hw/vfio/pci.c | 61
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 61 insertions(+)
> > > >
> > > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > > index ce3fe96..ab184ad 100644
> > > > --- a/hw/vfio/pci.c
> > > > +++ b/hw/vfio/pci.c
> > > > @@ -2690,6 +2690,65 @@ static void
> vfio_unregister_req_notifier(VFIOPCIDevice
> > > *vdev)
> > > >      vdev->req_enabled =3D false;
> > > >  }
> > > >
> > > > +static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
> > > > +                                               int32_t devfn,
> > > > +                                               uint32_t min_pasid,
> > > > +                                               uint32_t max_pasid)
> > > > +{
> > > > +    PCIDevice *pdev =3D bus->devices[devfn];
> > > > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > > +    struct vfio_iommu_type1_pasid_request req;
> > > > +    unsigned long argsz;
> > > > +    int pasid;
> > > > +
> > > > +    argsz =3D sizeof(req);
> > > > +    req.argsz =3D argsz;
> > > > +    req.flag =3D VFIO_IOMMU_PASID_ALLOC;
> > > > +    req.min_pasid =3D min_pasid;
> > > > +    req.max_pasid =3D max_pasid;
> > > > +
> > > > +    rcu_read_lock();
> > > > +    pasid =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req)=
;
> > > > +    if (pasid < 0) {
> > > > +        error_report("vfio_pci_device_request_pasid_alloc:"
> > > > +                     " request failed, contanier: %p", container);
> > > > +    }
> > > > +    rcu_read_unlock();
> > > > +    return pasid;
> > > > +}
> > > > +
> > > > +static int vfio_pci_device_request_pasid_free(PCIBus *bus,
> > > > +                                              int32_t devfn,
> > > > +                                              uint32_t pasid)
> > > > +{
> > > > +    PCIDevice *pdev =3D bus->devices[devfn];
> > > > +    VFIOPCIDevice *vdev =3D DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > > > +    VFIOContainer *container =3D vdev->vbasedev.group->container;
> > > > +    struct vfio_iommu_type1_pasid_request req;
> > > > +    unsigned long argsz;
> > > > +    int ret =3D 0;
> > > > +
> > > > +    argsz =3D sizeof(req);
> > > > +    req.argsz =3D argsz;
> > > > +    req.flag =3D VFIO_IOMMU_PASID_FREE;
> > > > +    req.pasid =3D pasid;
> > > > +
> > > > +    rcu_read_lock();
> > > > +    ret =3D ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
> > > > +    if (ret !=3D 0) {
> > > > +        error_report("vfio_pci_device_request_pasid_free:"
> > > > +                     " request failed, contanier: %p", container);
> > > > +    }
> > > > +    rcu_read_unlock();
> > > > +    return ret;
> > > > +}
> > > > +
> > > > +static PCIPASIDOps vfio_pci_pasid_ops =3D {
> > > > +    .alloc_pasid =3D vfio_pci_device_request_pasid_alloc,
> > > > +    .free_pasid =3D vfio_pci_device_request_pasid_free,
> > > > +};
> > > > +
> > > >  static void vfio_realize(PCIDevice *pdev, Error **errp)
> > > >  {
> > > >      VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
> > > > @@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, Err=
or
> **errp)
> > > >      vfio_register_req_notifier(vdev);
> > > >      vfio_setup_resetfn_quirk(vdev);
> > > >
> > > > +    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
> > > > +
> > > >      return;
> > > >
> > > >  out_teardown:
> > >
> >
>=20
> --
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other=
_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


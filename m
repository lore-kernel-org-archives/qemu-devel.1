Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A422AC32751
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFB4206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFB4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbR5-0002pm-Qa
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kevin.tian@intel.com>) id 1hsbQN-0002ES-AG
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1hsbQM-0007cn-2y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:20:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:5726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1hsbQL-0007Xe-P0; Tue, 30 Jul 2019 19:20:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jul 2019 16:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; d="scan'208";a="323510383"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga004.jf.intel.com with ESMTP; 30 Jul 2019 16:20:48 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 30 Jul 2019 16:20:48 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 30 Jul 2019 16:20:47 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.112]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.80]) with mapi id 14.03.0439.000;
 Wed, 31 Jul 2019 07:20:45 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
Thread-Topic: [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the IOAPIC MSI
 reserved region when relevant
Thread-Index: AQHVRvuB+lYfnIqunUiYF7Ql9SMCpqbjCI0AgADC99A=
Date: Tue, 30 Jul 2019 23:20:44 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19CAF8E1B@SHSMSX104.ccr.corp.intel.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-12-eric.auger@redhat.com>
 <20190730153628-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190730153628-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDEyOWQyMWItNGIyNi00YjQxLThkMGUtNDk2MmI0ZDZhZDc0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNTFjOHhsWDRTZVdyUGZVXC8zRnh0bGxBV0tZZFNmME9MWHhrd29HMjBoYWdJN1wvczFmOUk2RWNmTEdNcWh4ZkdJIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the
 IOAPIC MSI reserved region when relevant
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, July 31, 2019 3:38 AM
>=20
> On Tue, Jul 30, 2019 at 07:21:33PM +0200, Eric Auger wrote:
> > We introduce a new msi_bypass field which indicates whether
> > the IOAPIC MSI window [0xFEE00000 - 0xFEEFFFFF] must be exposed

it's not good to call it IOAPIC MSI window. any write to this range, either
from IOAPIC or PCI device, is interpreted by the platform as interrupt
request. I'd call it "x86 interrupt address range".

> > as a reserved region. By default the field is set to true at
> > instantiation time. Later on we will introduce a property at
> > virtio pci proxy level to turn it off.
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >
> > ---
> >
> > v8 -> v9:
> > - pass IOAPIC_RANGE_END to virtio_iommu_register_resv_region
> > - take into account the change in the struct virtio_iommu_probe_resv_me=
m
> >   definition
> > - We just introduce the field here. A property will be introduced later=
 on
> >   at pci proxy level.
> > ---
> >  hw/virtio/virtio-iommu.c         | 36 ++++++++++++++++++++++++++++++++
> >  include/hw/virtio/virtio-iommu.h |  1 +
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > index 66be9a4627..74038288b0 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -39,6 +39,9 @@
> >  #define VIOMMU_DEFAULT_QUEUE_SIZE 256
> >  #define VIOMMU_PROBE_SIZE 512
> >
> > +#define IOAPIC_RANGE_START      (0xfee00000)
> > +#define IOAPIC_RANGE_END        (0xfeefffff)
> > +
> >  #define SUPPORTED_PROBE_PROPERTIES (\
> >      1 << VIRTIO_IOMMU_PROBE_T_RESV_MEM)
> >
>=20
> Sorry where are these numbers coming from?

this is architecturally defined in x86 SDM.

> Does this really work on all platforms?

x86 only.=20

> With all guests?

yes.

>=20
> > @@ -100,6 +103,30 @@ static void
> virtio_iommu_detach_endpoint_from_domain(viommu_endpoint *ep)
> >      ep->domain =3D NULL;
> >  }
> >
> > +static void virtio_iommu_register_resv_region(viommu_endpoint *ep,
> > +                                              uint8_t subtype,
> > +                                              uint64_t start, uint64_t=
 end)
> > +{
> > +    viommu_interval *interval;
> > +    struct virtio_iommu_probe_resv_mem *resv_reg_prop;
> > +    size_t prop_size =3D sizeof(struct virtio_iommu_probe_resv_mem);
> > +    size_t value_size =3D prop_size -
> > +                sizeof(struct virtio_iommu_probe_property);
> > +
> > +    interval =3D g_malloc0(sizeof(*interval));
> > +    interval->low =3D start;
> > +    interval->high =3D end;
> > +
> > +    resv_reg_prop =3D g_malloc0(prop_size);
> > +    resv_reg_prop->head.type =3D VIRTIO_IOMMU_PROBE_T_RESV_MEM;
> > +    resv_reg_prop->head.length =3D cpu_to_le64(value_size);
> > +    resv_reg_prop->subtype =3D cpu_to_le64(subtype);
> > +    resv_reg_prop->start =3D cpu_to_le64(start);
> > +    resv_reg_prop->end =3D cpu_to_le64(end);
> > +
> > +    g_tree_insert(ep->reserved_regions, interval, resv_reg_prop);
> > +}
> > +
> >  static viommu_endpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> >                                                    uint32_t ep_id)
> >  {
> > @@ -117,6 +144,12 @@ static viommu_endpoint
> *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
> >      ep->reserved_regions =3D
> g_tree_new_full((GCompareDataFunc)interval_cmp,
> >                                              NULL, (GDestroyNotify)g_fr=
ee,
> >                                              (GDestroyNotify)g_free);
> > +    if (s->msi_bypass) {
> > +        virtio_iommu_register_resv_region(ep,
> VIRTIO_IOMMU_RESV_MEM_T_MSI,
> > +                                          IOAPIC_RANGE_START,
> > +                                          IOAPIC_RANGE_END);
> > +    }
> > +
> >      return ep;
> >  }
> >
> > @@ -822,6 +855,9 @@ static void virtio_iommu_set_status(VirtIODevice
> *vdev, uint8_t status)
> >
> >  static void virtio_iommu_instance_init(Object *obj)
> >  {
> > +    VirtIOIOMMU *s =3D VIRTIO_IOMMU(obj);
> > +
> > +    s->msi_bypass =3D true;
> >  }
> >
> >  static const VMStateDescription vmstate_virtio_iommu =3D {
> > diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virti=
o-
> iommu.h
> > index f55f48d304..56c8b4e57f 100644
> > --- a/include/hw/virtio/virtio-iommu.h
> > +++ b/include/hw/virtio/virtio-iommu.h
> > @@ -59,6 +59,7 @@ typedef struct VirtIOIOMMU {
> >      GTree *domains;
> >      QemuMutex mutex;
> >      GTree *endpoints;
> > +    bool msi_bypass;
> >  } VirtIOIOMMU;
> >
> >  #endif
> > --
> > 2.20.1


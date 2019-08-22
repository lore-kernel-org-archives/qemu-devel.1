Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11609233FC
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 23:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11609233FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0wy4-0000N9-8L
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 19:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i0wxF-0007cf-6D
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i0wxD-0006Gp-67
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:57:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:18729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i0wxC-0006EH-V7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 19:57:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 16:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,419,1559545200"; d="scan'208";a="186721007"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2019 16:57:10 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 16:57:10 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 16:57:10 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.112]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.249]) with mapi id 14.03.0439.000;
 Fri, 23 Aug 2019 07:57:08 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kirti Wankhede
 <kwankhede@nvidia.com>
Thread-Topic: [PATCH v7 04/13] vfio: Add save and load functions for VFIO
 PCI devices
Thread-Index: AQHVNjwCXGgcT2JZ9ESxChTH7c7tTqbEz8SAgEGH1ICAAE7jgIAAoVgAgAAA1oCAANL+EA==
Date: Thu, 22 Aug 2019 23:57:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D543525@SHSMSX104.ccr.corp.intel.com>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-5-git-send-email-kwankhede@nvidia.com>
 <20190711120713.GM3971@work-vm>
 <d6400fd9-5f86-b9f2-a10a-1ad53813a066@nvidia.com>
 <20190822093235.GC3277@work-vm>
 <092a9a37-d018-1d6e-7c61-7f8ada8819a7@nvidia.com>
 <20190822191303.GO3277@work-vm>
In-Reply-To: <20190822191303.GO3277@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzQzZGU1MzgtMDIxOC00YmYwLTgzMDYtODRmNWUyMDE2YmQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNm9EN2pHV0Vsb0JsdkUzVGx2cXNpb2c5d0I1RkVSZU1WbzhmZDNMXC82U0hNK09LSzI4d3gzVjU3bjlWS2w0a0oifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH v7 04/13] vfio: Add save and load functions
 for VFIO PCI devices
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
Cc: "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Friday, August 23, 2019 3:13 AM
>=20
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> >
> >
> > On 8/22/2019 3:02 PM, Dr. David Alan Gilbert wrote:
> > > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > >> Sorry for delay to respond.
> > >>
> > >> On 7/11/2019 5:37 PM, Dr. David Alan Gilbert wrote:
> > >>> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > >>>> These functions save and restore PCI device specific data - config
> > >>>> space of PCI device.
> > >>>> Tested save and restore with MSI and MSIX type.
> > >>>>
> > >>>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > >>>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > >>>> ---
> > >>>>  hw/vfio/pci.c                 | 114
> ++++++++++++++++++++++++++++++++++++++++++
> > >>>>  include/hw/vfio/vfio-common.h |   2 +
> > >>>>  2 files changed, 116 insertions(+)
> > >>>>
> > >>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > >>>> index de0d286fc9dd..5fe4f8076cac 100644
> > >>>> --- a/hw/vfio/pci.c
> > >>>> +++ b/hw/vfio/pci.c
> > >>>> @@ -2395,11 +2395,125 @@ static Object
> *vfio_pci_get_object(VFIODevice *vbasedev)
> > >>>>      return OBJECT(vdev);
> > >>>>  }
> > >>>>
> > >>>> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *=
f)
> > >>>> +{
> > >>>> +    VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice,
> vbasedev);
> > >>>> +    PCIDevice *pdev =3D &vdev->pdev;
> > >>>> +    uint16_t pci_cmd;
> > >>>> +    int i;
> > >>>> +
> > >>>> +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> > >>>> +        uint32_t bar;
> > >>>> +
> > >>>> +        bar =3D pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 =
+ i *
> 4, 4);
> > >>>> +        qemu_put_be32(f, bar);
> > >>>> +    }
> > >>>> +
> > >>>> +    qemu_put_be32(f, vdev->interrupt);
> > >>>> +    if (vdev->interrupt =3D=3D VFIO_INT_MSI) {
> > >>>> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi =3D 0, msi_d=
ata;
> > >>>> +        bool msi_64bit;
> > >>>> +
> > >>>> +        msi_flags =3D pci_default_read_config(pdev, pdev->msi_cap=
 +
> PCI_MSI_FLAGS,
> > >>>> +                                            2);
> > >>>> +        msi_64bit =3D (msi_flags & PCI_MSI_FLAGS_64BIT);
> > >>>> +
> > >>>> +        msi_addr_lo =3D pci_default_read_config(pdev,
> > >>>> +                                         pdev->msi_cap + PCI_MSI_=
ADDRESS_LO, 4);
> > >>>> +        qemu_put_be32(f, msi_addr_lo);
> > >>>> +
> > >>>> +        if (msi_64bit) {
> > >>>> +            msi_addr_hi =3D pci_default_read_config(pdev,
> > >>>> +                                             pdev->msi_cap + PCI_=
MSI_ADDRESS_HI,
> > >>>> +                                             4);
> > >>>> +        }
> > >>>> +        qemu_put_be32(f, msi_addr_hi);
> > >>>> +
> > >>>> +        msi_data =3D pci_default_read_config(pdev,
> > >>>> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 :
> PCI_MSI_DATA_32),
> > >>>> +                2);
> > >>>> +        qemu_put_be32(f, msi_data);
> > >>>> +    } else if (vdev->interrupt =3D=3D VFIO_INT_MSIX) {
> > >>>> +        uint16_t offset;
> > >>>> +
> > >>>> +        /* save enable bit and maskall bit */
> > >>>> +        offset =3D pci_default_read_config(pdev,
> > >>>> +                                       pdev->msix_cap + PCI_MSIX_=
FLAGS + 1, 2);
> > >>>> +        qemu_put_be16(f, offset);
> > >>>> +        msix_save(pdev, f);
> > >>>> +    }
> > >>>> +    pci_cmd =3D pci_default_read_config(pdev, PCI_COMMAND, 2);
> > >>>> +    qemu_put_be16(f, pci_cmd);
> > >>>> +}
> > >>>> +
> > >>>> +static void vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *=
f)
> > >>>> +{
> > >>>> +    VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice,
> vbasedev);
> > >>>> +    PCIDevice *pdev =3D &vdev->pdev;
> > >>>> +    uint32_t interrupt_type;
> > >>>> +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi =3D 0, msi_data;
> > >>>> +    uint16_t pci_cmd;
> > >>>> +    bool msi_64bit;
> > >>>> +    int i;
> > >>>> +
> > >>>> +    /* retore pci bar configuration */
> > >>>> +    pci_cmd =3D pci_default_read_config(pdev, PCI_COMMAND, 2);
> > >>>> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > >>>> +                        pci_cmd & (!(PCI_COMMAND_IO |
> PCI_COMMAND_MEMORY)), 2);
> > >>>> +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> > >>>> +        uint32_t bar =3D qemu_get_be32(f);
> > >>>> +
> > >>>> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, b=
ar, 4);
> > >>>> +    }
> > >>>
> > >>> Is it possible to validate the bar's at all?  We just had a bug on =
a
> > >>> virtual device where one version was asking for a larger bar than t=
he
> > >>> other; our validation caught this in some cases so we could tell th=
at
> > >>> the guest had a BAR that was aligned at the wrong alignment.

I'm a bit confused here. Did you mean that src and dest include
different versions of the virtual device which implements different
BAR size? If that is the case, shouldn't the migration fail at the start
when doing compatibility check?

> > >>>
> > >>
> > >> "Validate the bars" does that means validate size of bars?
> > >
> > > I meant validate the address programmed into the BAR against the size=
,
> > > assuming you know the size; e.g. if it's a 128MB BAR, then make sure =
the
> > > address programmed in is 128MB aligned.
> > >
> >
> > If this validation fails, migration resume should fail, right?
>=20
> Yes I think so; if you've got a device that wants 128MB alignment and
> someone gives you a non-aligned address, who knows what will happen.

If misalignment is really caused by the guest, shouldn't we just follow
the hardware behavior, i.e. hard-wiring the lower bits to 0 before
updating the cfg space?=20

Thanks
Kevin


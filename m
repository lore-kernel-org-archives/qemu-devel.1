Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A19C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4010520663
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="q06ala5e";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="peH/Xc1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHhtw-0001aa-AI
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 01:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhtG-0000vv-T5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhtF-0000Y0-I7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:50:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:5032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhtB-0008R4-8m; Fri, 27 Mar 2020 01:50:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02R5jGow032453; Thu, 26 Mar 2020 22:50:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=FJkZLx0G70kyLZrKIwdIByY2uJ8d6utnGBq5EP3730U=;
 b=q06ala5e+kByp/27YmRkYrwqD7VNB0ksUUA5IUjoOs8FTTt6PVf4MWv5ltRef1T+b2EH
 YB6jWyzmHmYz3OrKa0XN3Y6k3hoC5tTrA+Lxs5r5X3nsX0jm6jKkSdTEjPsFbwE2dpP1
 ZG/8P6rzPxjFwhAgLPFuKbfbTcSF38Pzn3WCt7kUdEefeyjCzkJj1OYG/0qpBDXm5WbU
 OxSU3Kwv1xyfn3AxWy0aqWJ6E9habrJs986L4B75sTB2HfR3dsBiunNoMthrW29kb+GW
 CMd6Bj6WWDzQH9JNMQ+qNYbRA6GwA0obdOxFAPC7VR/iZzE8SAizTwLozXR9sUK/X4Up Rg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
 by mx0b-0016f401.pphosted.com with ESMTP id 300bpcyqvg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2020 22:50:30 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 26 Mar 2020 22:50:28 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 26 Mar 2020 22:50:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 26 Mar 2020 22:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqZevkVX13A6nXdlwhcGjt2Cd2SdXSzIShyXXWfkWhqy4YMrD+BiIb6Sa6GCV2D5Fm8mvS1d+n4sOljLwij3iTCzcz8hoKHgRIGGTHLVvbXgPb6Rj3+RrQQY4Rhmzhq7CLXtXdoyRZ7wZNUD2yWqY9W9/mBIJDiL1a+bfhimVqN8kpxl093wiH7pOHkHMStNy4lMHyCgnjXKp53Ph9ij6vCff7BsHfVGtY0iy47fuiXlGBKV6mYHYC40LDVSI95pw7jh+pmB9DLL7Qpg1HJYOrJLhvpAAIxcECWZLCz7SURTZqKhaGutZzm81SP8Do02pz5YUnnQxnHEuml6FbJ4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJkZLx0G70kyLZrKIwdIByY2uJ8d6utnGBq5EP3730U=;
 b=LWG5SfXKr1DaoGO1ou4iYUCiRD6Vz3US7u8Z+cpOkmUdH5KqxKmBFx/btuQORicifWLemr+uYptJPzRQDE2uILJqoU9F+HOnfG+Y5X/5Z3+usBPhhFSZbC+uoI9Dfa8dvZR4b4LpthmfSlVUdPcQjgjHGWaoBiidetbzLUqsWeuN/C5KpAJbOhAmOUK8qPMCPIhvK71KJ622lngXvakX7fcTsQ0KLxV1HUhrySRoReQDTZrzTkguBOvwQifSyH+v0NzW1cqRcWZ95ehynFetgGu0n/9EUP9B6CvDKVm/VTM2tgBuql+n2geatoYIGX5p7hmCnxTDFlXtD57RPsATPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJkZLx0G70kyLZrKIwdIByY2uJ8d6utnGBq5EP3730U=;
 b=peH/Xc1heB/QKdsYoKPEKQaqFEQhBFtiRzW/J68fzDoi53cPn480PvSvGBRXiC5jqdkH2rA0wlBWzBjnvQdrq8m8kvQuEsDLfqW/dEaDS/lK79j8ATk+7TOzsLfLMBqh1kn4Oj+9TteZ/jWOIuBLBDTh7BMfsoa3FbVo0ZgliRw=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2029.namprd18.prod.outlook.com
 (2603:10b6:301:63::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 05:50:26 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 05:50:26 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Alex Williamson <alex.williamson@redhat.com>, Auger Eric
 <eric.auger@redhat.com>
Subject: RE: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on
 mmio region translation by viommu
Thread-Topic: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on
 mmio region translation by viommu
Thread-Index: AQHWAO+QkxQYttOMmkGEh3oW5XA+3qhWzhWAgARaBACAAATkAIAAyCOg
Date: Fri, 27 Mar 2020 05:50:26 +0000
Message-ID: <MWHPR1801MB1966D4593BF88C59A7748319E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-2-bbhushan2@marvell.com>
 <20200323170835.5021f845@w520.home>
 <8ec6af3c-6bd7-a3dc-c531-16db6b2089c5@redhat.com>
 <20200326115318.094ab79a@x1.home>
In-Reply-To: <20200326115318.094ab79a@x1.home>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.182.231.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b974b0eb-ebd6-499f-0660-08d7d212bfeb
x-ms-traffictypediagnostic: MWHPR1801MB2029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1801MB2029DA3A2450C6D519CD945FE3CC0@MWHPR1801MB2029.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(66476007)(81156014)(5660300002)(81166006)(66946007)(66556008)(478600001)(8936002)(71200400001)(7416002)(66446008)(6506007)(2906002)(64756008)(33656002)(7696005)(53546011)(52536014)(76116006)(4326008)(186003)(26005)(86362001)(54906003)(8676002)(316002)(9686003)(110136005)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1801MB2029;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5O8YBNSXKLHZfv2r5AoPp5N27mK1hySvJo1zCAjWf8ItNI6xjaFawRAOkfQFxb6M/lS2v+Zp3BZahQH84yQwiMzmjhXAYmquaAz+kn822uUsz2QykcjE54tulkz6V5LEJLhNyJWlzgfBDduwLrYOt5WpjB/+g62eFa65bdD6m0Oymk87rs5rRU/XOWaSEl143Nz/Ya7u/F1elwcGf3nZMD1o3ElZfmLVK0BgBrfsNEYZXyRlA53CyJFgFjg+dPyNnR7itKPYfg/J+SJl+BesIRg1du5j8h4gY4zV3ahKKyJMZQgLHTYg7jY5sG0eYTPKsrRTT84GY6NNWGAZRQ0zs3MlK8ege4N/QFpHHv/mpTa2y6vkgJygg3nxIn2v7h4FBP0o/JOpAxnESCEvFWDmD1MViLXSEY2vp3IaleAD306OA16ROlHQvK1DL04e8Xv9
x-ms-exchange-antispam-messagedata: if/LTvVjKuwp1DCLsATh1qj2NoItq07ykcW4OR5AfL+L3Ehs1OMRPVHxKVuFWo9QeuxLIpfEVj1QboD5XOiigbkMm1jL3Xwm9NXSaDNao0GEfUTB5kehwNOp8zG9XMvs1xTnP5b3ItbLucOOQw3a9A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b974b0eb-ebd6-499f-0660-08d7d212bfeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:50:26.5990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EVrQ4e3c+RueOPxkPMQNs5UN1s6frEYK/gbszQUUrVtpr1VHtEglOtj/WbpUKwxpTPDfud35fLzZ64BoK/zIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2029
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-26_14:2020-03-26,
 2020-03-26 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.156.173
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
Cc: "yang.zhong@intel.com" <yang.zhong@intel.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "Tomasz Nowicki \[C\]" <tnowicki@marvell.com>,
 "mst@redhat.com" <mst@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bharatb.linux@gmail.com" <bharatb.linux@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex, Eric,

> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Thursday, March 26, 2020 11:23 PM
> To: Auger Eric <eric.auger@redhat.com>
> Cc: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
> peterx@redhat.com; eric.auger.pro@gmail.com; kevin.tian@intel.com;
> mst@redhat.com; Tomasz Nowicki [C] <tnowicki@marvell.com>;
> drjones@redhat.com; linuc.decode@gmail.com; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org; bharatb.linux@gmail.com; jean-philippe@linaro.org;
> yang.zhong@intel.com; David Gibson <david@gibson.dropbear.id.au>
> Subject: [EXT] Re: [PATCH v9 1/9] hw/vfio/common: Remove error print on m=
mio
> region translation by viommu
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, 26 Mar 2020 18:35:48 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
>=20
> > Hi Alex,
> >
> > On 3/24/20 12:08 AM, Alex Williamson wrote:
> > > [Cc +dwg who originated this warning]
> > >
> > > On Mon, 23 Mar 2020 14:16:09 +0530
> > > Bharat Bhushan <bbhushan2@marvell.com> wrote:
> > >
> > >> On ARM, the MSI doorbell is translated by the virtual IOMMU.
> > >> As such address_space_translate() returns the MSI controller MMIO
> > >> region and we get an "iommu map to non memory area"
> > >> message. Let's remove this latter.
> > >>
> > >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > >> ---
> > >>  hw/vfio/common.c | 2 --
> > >>  1 file changed, 2 deletions(-)
> > >>
> > >> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
> > >> 5ca11488d6..c586edf47a 100644
> > >> --- a/hw/vfio/common.c
> > >> +++ b/hw/vfio/common.c
> > >> @@ -426,8 +426,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb,
> void **vaddr,
> > >>                                   &xlat, &len, writable,
> > >>                                   MEMTXATTRS_UNSPECIFIED);
> > >>      if (!memory_region_is_ram(mr)) {
> > >> -        error_report("iommu map to non memory area %"HWADDR_PRIx"",
> > >> -                     xlat);
> > >>          return false;
> > >>      }
> > >>
> > >
> > > I'm a bit confused here, I think we need more justification beyond
> > > "we hit this warning and we don't want to because it's ok in this
> > > one special case, therefore remove it".  I assume the special case
> > > is that the device MSI address is managed via the SET_IRQS ioctl and
> > > therefore we won't actually get DMAs to this range.
> > Yes exactly. The guest creates a mapping between one giova and this
> > gpa (corresponding to the MSI controller doorbell) because MSIs are
> > mapped on ARM. But practically the physical device is programmed with
> > an host chosen iova that maps onto the physical MSI controller's
> > doorbell. so the device never performs DMA accesses to this range.
> >
> >   But I imagine the case that
> > > was in mind when adding this warning was general peer-to-peer
> > > between and assigned and emulated device.
> > yes makes sense.
> >
> >   Maybe there's an argument to be made
> > > that such a p2p mapping might also be used in a non-vIOMMU case.  We
> > > skip creating those mappings and drivers continue to work, maybe
> > > because nobody attempts to do p2p DMA with the types of devices we
> > > emulate, maybe because p2p DMA is not absolutely reliable on bare
> > > metal and drivers test it before using it.
> > MSI doorbells are mapped using the IOMMU_MMIO flag (dma-iommu.c
> > iommu_dma_get_msi_page).
> > One idea could be to pass that flag through the IOMMU Notifier
> > mechanism into the iotlb->perm. Eventually when we get this in
> > vfio_get_vaddr() we would not print the warning. Could that make sense?
>=20
> Yeah, if we can identify a valid case that doesn't need a warning, that's=
 fine by me.
> Thanks,

Will change as per above suggestion by Eric.

Thanks
-Bharat

>=20
> Alex



Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDEC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A35320663
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 05:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RxJkg9tL";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="MMiPA438"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A35320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHhJo-0001Kx-8n
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 01:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhJ7-0000pu-VW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhJ6-0004Wq-Oo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 01:13:25 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:47530
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2355768c4b=bbhushan2@marvell.com>)
 id 1jHhJ3-0004HK-Fj; Fri, 27 Mar 2020 01:13:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02R5AXvw032702; Thu, 26 Mar 2020 22:13:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Dgz7BF+2pWL+c+tW+4MOpoJp3BKg9Y2bXWHdwmdIJRs=;
 b=RxJkg9tLEC9TE20PqJ7Ec1wLlsrAc4EfKI5Q2cAdIxHxlbjF6el9PFEw5Dt+9DkAhsNr
 39W39QHIkNrQV+k8C6pBaD0X6ZhZByAJbIhD2Sr0eKg4/NC/TljuZkt9INcJ25/CqtGR
 XIkdB+CAUkjjTK2jO0z4snDScKxbmk3F/XtH4uPozsccpVBsFcb5AFOkAgCA3rxj38Fs
 1ugd/vY8+JrrTgU3jRGx1/Holh2qMSG+6KlgIQ2l11n/q4kX0Pxs/wKPB3AjSW25Njh4
 X799k3JlUVc8jciwNqPSIIJsitpy/IVtcVCy38jHNAjnxL/UkC1/ADasuGAqwZyNgjmy FQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 2ywg9p195y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2020 22:13:16 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Mar
 2020 22:13:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 26 Mar 2020 22:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li7sAHPsWh3whZaDm6UhUgj9SRM4ivOeMGWT7M3MdSeD4+k65YYEg5x5X2Yws4w/tvUZb7EwvjyEnqg3mIPaOPiWjRPm8AnvhW8ry2K8sIBaBeDwA/5ti0feFHwKGody2BG5F80KHDqZnJLimZGewvI1gKwIWG/wden9MqSOCLaMHM0f7iFgvZqmd52CMohZov0ifmZUSXl339kBpKy4inM4pXWsPlgIrv3v19ePzKtfsuMJjejv7wI9vSFD493qcj7OculZiloWYVQPc/JVs2eH5U8ivwHwBfW3YFIzp3qqMdIp4i646mCIiQDkBAmmDYTtQLpUddrETn1hf1Zh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgz7BF+2pWL+c+tW+4MOpoJp3BKg9Y2bXWHdwmdIJRs=;
 b=eHZ/mDifP2u4vnKC1SvSJFLbRRSwmE07iIKPamnQpW8oo9WmFVc3bZu/0CO9a+Mo0b8bImobO4O22BKWN6kV5h2upekNMXAOQJJGP3eO8c26V5cfboqZT7krfJaXjN4HCT6nW/TYv1I3vH7kViAYMt9VDNVblXgws14w1fo6KAoksMJJzOs/QxWJpBjDcgcoPbc/KbNC4MxpKKBNfrOxSF6zopsws2UhvqhbhiLTVVNeLoWACB0dMN/oN6Jh6B9VEmM86/OLg41i1PC+RU21sNvC1fVwET0b5YuVCFc5NGJVNRY/LpbeSlH05A4CmpuMyh5wKHhRPlyrT+pwQXawlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgz7BF+2pWL+c+tW+4MOpoJp3BKg9Y2bXWHdwmdIJRs=;
 b=MMiPA438yF7Z4Y4X/eWXi1K4yCaKdv8T1fvlczUYBr/26yxcXjEGgy3plOiVrPmogyXZEvhupEUJTz6CWmequZJ1R/qMoYRccvVZC8vxgSyTq7hROXRGnxJwZMIGUw6vawMVlcWxsR+pxylZQC5aEDwbNLBhgb+RNQHfayw+R/g=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2016.namprd18.prod.outlook.com
 (2603:10b6:301:69::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 05:13:12 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 05:13:12 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Auger Eric <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com"
 <mst@redhat.com>, "Tomasz Nowicki [C]" <tnowicki@marvell.com>,
 "drjones@redhat.com" <drjones@redhat.com>, "linuc.decode@gmail.com"
 <linuc.decode@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "bharatb.linux@gmail.com"
 <bharatb.linux@gmail.com>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "yang.zhong@intel.com" <yang.zhong@intel.com>
Subject: RE: [EXT] Re: [PATCH v9 4/9] virtio-iommu: set supported page size
 mask
Thread-Topic: [EXT] Re: [PATCH v9 4/9] virtio-iommu: set supported page size
 mask
Thread-Index: AQHWAO+bF+A5vVa7TEGj9CznMOtr2qhbCwYAgADe+IA=
Date: Fri, 27 Mar 2020 05:13:11 +0000
Message-ID: <MWHPR1801MB1966FFC12887DFDA34B2D5D8E3CC0@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <20200323084617.1782-1-bbhushan2@marvell.com>
 <20200323084617.1782-5-bbhushan2@marvell.com>
 <994d9a4f-b8a8-7bda-f5a2-81d65711f580@redhat.com>
In-Reply-To: <994d9a4f-b8a8-7bda-f5a2-81d65711f580@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.182.231.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d25cb2a-1277-4daf-3669-08d7d20d8c0e
x-ms-traffictypediagnostic: MWHPR1801MB2016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1801MB201692A77A1A85E034415E72E3CC0@MWHPR1801MB2016.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(478600001)(33656002)(6506007)(7696005)(110136005)(7416002)(53546011)(9686003)(86362001)(52536014)(66446008)(316002)(26005)(2906002)(66476007)(5660300002)(8676002)(66946007)(8936002)(81166006)(71200400001)(66556008)(186003)(81156014)(64756008)(76116006)(55016002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1801MB2016;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQRqyeAkszZmNfyNZ3BWiWSJg6aIPwmsCpQtapU5Fvz98TIcHudw3JMOikij27IlncsEalXOXo52tYQkZfXKVTAfv/KdCRyUoaov6ZSmSuH0/a7WC5HrglfUSfIzub49S9QkHi1HdtPXXHc/xVZ/aaTvjtHnkG/mAfAa8O4O6IUxUAt0SKcNw7bXoIYZbVbKyOyy41vkgpqdE2Hm7tTaz7yW1ejDU/Lkl/VBmqjNLx3nGYacGx3NVQb/3LTPBR8CgY4BQFjC5ipSkCpxP/3GpVJj2aEaqkip3vivpsmlaveIhhA8uS3oFFh2BKt9EmhKpJtza9Qq6jQ+2NldGFpD9oR0LAjTTsvFAbAUpCqo1ge0qfGju4jHfcpgJk+Plw3qdiLXXun1pTMq3ppvynd1mRODrhtE9z4uHC87Q8AiMnJ21w3dZkJ9kfXO4KnFirTa71U0LZjiOM3irN7qnAo12G4h0GcWs3wAH2oIiyagZujhVGbbocuWA+2hddyAKcCz
x-ms-exchange-antispam-messagedata: KkWVpNXTxgwykDZr1DKtmrRf49ojohDOoqOg2Fl0utC6uZzVY5GhDmHN9ST4Fg0drb2KHZRes81jA8UHuu0LN9yq/JO0w7lqiSXv3sDxhS8CacjyTWqXMDXV1310AUOJ/jLZpQGy2o2igGijNVQpKw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d25cb2a-1277-4daf-3669-08d7d20d8c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 05:13:12.0834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jqhVkldF+0nZMzG2N7LWHK5Lm/brl0AhtdkdeavFrDKw5C445lPWQywwhOuQuIg8edmnBQnLS0mCGVfw/0vfgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2016
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-26_14:2020-03-26,
 2020-03-26 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.148.174
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric,

> -----Original Message-----
> From: Auger Eric <eric.auger@redhat.com>
> Sent: Thursday, March 26, 2020 9:22 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>; peter.maydell@linaro.org;
> peterx@redhat.com; eric.auger.pro@gmail.com; alex.williamson@redhat.com;
> kevin.tian@intel.com; mst@redhat.com; Tomasz Nowicki [C]
> <tnowicki@marvell.com>; drjones@redhat.com; linuc.decode@gmail.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; bharatb.linux@gmail.com; jean-
> philippe@linaro.org; yang.zhong@intel.com
> Subject: [EXT] Re: [PATCH v9 4/9] virtio-iommu: set supported page size m=
ask
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi Bharat,
>=20
> On 3/23/20 9:46 AM, Bharat Bhushan wrote:
> > Add optional interface to set page size mask.
> > Currently this is set global configuration and not per endpoint.
> This allows to override the page size mask per end-point?

This patch adds per endpoint page-size-mask configuration in addition to gl=
obal page-size-mask.
endpoint page-size-mask will override global page-size-mask configuration f=
or that endpoint.

Thanks
-Bharat

> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  include/hw/virtio/virtio-iommu.h | 1 +
> >  hw/virtio/virtio-iommu.c         | 9 +++++++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/include/hw/virtio/virtio-iommu.h
> > b/include/hw/virtio/virtio-iommu.h
> > index 6f67f1020a..4efa09610a 100644
> > --- a/include/hw/virtio/virtio-iommu.h
> > +++ b/include/hw/virtio/virtio-iommu.h
> > @@ -35,6 +35,7 @@ typedef struct IOMMUDevice {
> >      void         *viommu;
> >      PCIBus       *bus;
> >      int           devfn;
> > +    uint64_t      page_size_mask;
> >      IOMMUMemoryRegion  iommu_mr;
> >      AddressSpace  as;
> >  } IOMMUDevice;
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c index
> > 4cee8083bc..a28818202c 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -650,6 +650,14 @@ static gint int_cmp(gconstpointer a, gconstpointer=
 b,
> gpointer user_data)
> >      return (ua > ub) - (ua < ub);
> >  }
> >
> > +static void virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
> > +                                            uint64_t page_size_mask)
> > +{
> > +    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
> > +
> > +    sdev->page_size_mask =3D page_size_mask; }
> > +
> >  static void virtio_iommu_device_realize(DeviceState *dev, Error
> > **errp)  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev); @@ -865,6 +873,7 @@
> > static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
> >      IOMMUMemoryRegionClass *imrc =3D
> IOMMU_MEMORY_REGION_CLASS(klass);
> >
> >      imrc->translate =3D virtio_iommu_translate;
> > +    imrc->iommu_set_page_size_mask =3D virtio_iommu_set_page_size_mask=
;
> >  }
> >
> >  static const TypeInfo virtio_iommu_info =3D {
> >
> Thanks
>=20
> Eric



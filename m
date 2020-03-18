Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FC8C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8EB2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="rb1tozcx";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="rMqswuJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8EB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEWlX-0000rY-7y
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEWkO-0008EV-GG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEWkM-0007jl-Iq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:20:28 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2346c1f04e=bbhushan2@marvell.com>)
 id 1jEWkG-0007dx-2n; Wed, 18 Mar 2020 07:20:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02IBBNbS029618; Wed, 18 Mar 2020 04:20:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=aGU9HS/+oqjJC7zIjy3CvkEITUgc3K9TujTy0gleeuA=;
 b=rb1tozcx7IjxT5LaXstxDKIa2J+CgegvXDETcuG602ElGVE1qkShiubX9AH7WPRKYT+O
 OR9OMiqj8jKxKljTh88TKrNUjHRkuJcSVM46Ank2E3N37ddLzqOJNQgHHjl5kNQiOchK
 s3jPTg01pmQYgEwmyYrUobuzjizczsbIGL9dluV8nTdguP5y9LUWtLi6yZkQ/pCZGxRa
 RLA+0pDReOofmhMpEzKxfNnUL3JRlBtPFijZhKPrt6ZaT4hLQl2sVXpSl5RAFt+FGax9
 +8stnBALJZ8qJKYE3wgVdSFBxXmCsaM7mfp34S3rtifRlNOOepjx6+fusFeqe/l2+hMi 9g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 2yu9rpa1py-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2020 04:20:17 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 18 Mar 2020 04:20:14 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 18 Mar 2020 04:20:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 18 Mar 2020 04:20:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eD0WP4m7RxrznJzgToJAtQ7CjzDKIadUT+GY5ymLthR/gFTkEAZzuomaRXHUvk3Lpijg6pwXA24aD2Ry1/bmEHp1mmKGNeDq93EGgVRw2bhcjNWxfrppEpqmTHcpXGLhJvgEaoc/+Q6ooYcOGpnAcVcVM9apjAfl0inzciyU/94gzkm+i0qDB4RMGTaCbNxSTYje2wvQSCiAi1LLWI5pL1aZCo0OnKIeh6xBTxMxiudZRNEXHBuA+NzMsvx4R/a/UpxfuQeFhjZE1dCJF0LRa9gnqNkTVnIC4C2G/lbA62Xs/w9S/gHZoMkEINPmStNhq2ocl7dAw5NtApNhNSWJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGU9HS/+oqjJC7zIjy3CvkEITUgc3K9TujTy0gleeuA=;
 b=jQTrAtzcxRhWa1YUv8IciESmyQZVd0EcUM7q4pVFdBHNESnJwU1P8rP0auDdohhN9a5OKr8N2A0UMaxw8dn4+GcNYmICZ0M9ru/4FOqY6DvoV32LWi76kWHmmEJrdfwoWhNZxIzZnPooa4mFx6XPgUVR5SY8GNWXiFDHE03otAywbFN4TVwTOlnNBtxyLUItvBKWFCwcklhELt9loKy5K4xmGUlQ+QaR5dXISN0lJmlSiuSjXxZoGI68HjXnFu6dKyG5rJCGkcA/bdUtD/Nt6jpjpnw3wt1nazsz5tvvN1AX+GN8RQf3MxmQrHIzQGpbJjT5i/0VxhRykJRDEZJQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGU9HS/+oqjJC7zIjy3CvkEITUgc3K9TujTy0gleeuA=;
 b=rMqswuJbu9ArrrNoXStq2FKyZIwbqv6BH/iQQf0NvbzOae2XuetfzHCt/NxgqkHuEH23qr2v/wiDzXYGRBkB4UqebWM+NPzQ4XyOMkGvH3lcoTIS1nBavTMWwikm8YuvlG0at1le/cHmeNtN2hA92mbupl7aFAtpzm3oC3Hs0WU=
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 (2603:10b6:301:66::20) by MWHPR1801MB2013.namprd18.prod.outlook.com
 (2603:10b6:301:6a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Wed, 18 Mar
 2020 11:20:12 +0000
Received: from MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1]) by MWHPR1801MB1966.namprd18.prod.outlook.com
 ([fe80::b417:ff60:caba:11a1%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 11:20:12 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Bharat Bhushan
 <bharatb.linux@gmail.com>
Subject: RE: [EXT] Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for
 attach/detach
Thread-Topic: [EXT] Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for
 attach/detach
Thread-Index: AQHV+QvO7MPYuBbO2EeqTUl5LqRYk6hGmMMAgAQw9ICAAA5TgIAAA52AgAAUVQCAAAHagIAAAWkAgAARKACAAV/UgIAAHJ4AgAAGqoCAAHB5gIABMtkAgAAQzICAAABGMA==
Date: Wed, 18 Mar 2020 11:20:12 +0000
Message-ID: <MWHPR1801MB19669B4653FC94E213B894C8E3F70@MWHPR1801MB1966.namprd18.prod.outlook.com>
References: <CAAeCc_ksAdoNJcFWkoB4YcySAb5Hw7D+kLyHx-Nt0hZJY17AXA@mail.gmail.com>
 <CAAeCc_nnM-DGCyXjFJuk-6L8F+Oetq076SEjeV8kUAGxfJVQTw@mail.gmail.com>
 <cc447790-d1c5-784b-9706-fbcd76f0c94b@redhat.com>
 <CAAeCc_mSobL4oGcK-J3WJJq8BCS6M_oyPTrzJ9bk8yFgsUDBUw@mail.gmail.com>
 <20200316101124.GA304669@myrica>
 <CAAeCc_kJq_TjbZxf3Un5rpwBrNrz-8gdL_SMS-gP_0=rARf0WQ@mail.gmail.com>
 <20200317085304.GA1057687@myrica>
 <CAAeCc_n8_sY0EJODeo_PrOZ22zp8nUMOmGx2tBewz8jLaU30kA@mail.gmail.com>
 <20200317155929.GB1057687@myrica>
 <CAAeCc_k_7Ny1Kf2ZiAAJe2xms2bdK-DqB1S2ro+omxp0EWi28g@mail.gmail.com>
 <20200318111751.GA1382151@myrica>
In-Reply-To: <20200318111751.GA1382151@myrica>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.171.176.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f69b34dc-6e76-4399-c803-08d7cb2e5349
x-ms-traffictypediagnostic: MWHPR1801MB2013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1801MB201393CBE7B8BA30658758CFE3F70@MWHPR1801MB2013.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(186003)(26005)(8936002)(76116006)(71200400001)(8676002)(81166006)(33656002)(81156014)(2906002)(66446008)(66476007)(64756008)(55016002)(66556008)(66946007)(6506007)(53546011)(9686003)(5660300002)(7416002)(498600001)(52536014)(7696005)(86362001)(110136005)(4326008)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1801MB2013;
 H:MWHPR1801MB1966.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/zHvOEiIZdX5SH7EORXAHS/a67EpexOAdkiZfUbtKtMZ2sL6lbaNatVnGjWYv/+hHVLbq3Tt59l5ky48bizzwKsDbj64u+EAwGGLHVguvXmNQbUN27RVfYUnDvelo5Y/HJzv7AXfCLKIYZftURFtj/3nNeUbW6Pq/EggFbhCAoGxf3lGYlBXi8zOF35LI6E2XRabfV0Cb1hWCP+rAR+Qw4T906O2MLgYrZYvmNjIXkMFlIEV8LtVeQDBpmMyh5q6OQU7mrB6JH5i2WSMgjmJ7souqIgmhM6qHKkyUUFQ00u4vI/EAvQwktx5BSplo+mWO/00A8reEwiNCeKDtylrPdHp0sMv9HRkTUSz8YlPHYZ9qwMR9bUCQPHsPUi8i/UPqXoMQWh5e+PR0khpmFsul2oGhtabski8d9nkAhZaBt9EXiUQv1QJzfFYsa2u4IJ
x-ms-exchange-antispam-messagedata: WcFD2rf+Mp/HJhlmt+pvBYHSRzAZ0zfDZZw9EBtDeZUfJ+ZFMsqyv5CYaPqYalcXa7/RxpBdiKxbb4LCwMUewskeokCXgCV13Cel4GHAjkwL8lnoTI2aGDj9sJpknj5cqolpUzhuRdAcbmDQ9FAMXQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f69b34dc-6e76-4399-c803-08d7cb2e5349
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 11:20:12.0803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FVKeWvzvTLFtQ5uUdYghlq0Gaca58faA+aTCLIl0NY80ObFZg/uJ+vAAg6Kw8l9FpGxNmEUvJQ86ASAG9S+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1801MB2013
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_04:2020-03-18,
 2020-03-18 signatures=0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "Tomasz Nowicki \[C\]" <tnowicki@marvell.com>,
 "mst@redhat.com" <mst@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "linuc.decode@gmail.com" <linuc.decode@gmail.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Wednesday, March 18, 2020 4:48 PM
> To: Bharat Bhushan <bharatb.linux@gmail.com>
> Cc: Auger Eric <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; kevin.tian@intel.com; Tomasz Nowicki [C]
> <tnowicki@marvell.com>; mst@redhat.com; drjones@redhat.com;
> peterx@redhat.com; qemu-devel@nongnu.org; alex.williamson@redhat.com;
> qemu-arm@nongnu.org; Bharat Bhushan <bbhushan2@marvell.com>;
> linuc.decode@gmail.com; eric.auger.pro@gmail.com
> Subject: [EXT] Re: [PATCH v7 3/5] virtio-iommu: Call iommu notifier for
> attach/detach
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Mar 18, 2020 at 03:47:44PM +0530, Bharat Bhushan wrote:
> > Hi Jean,
> >
> > On Tue, Mar 17, 2020 at 9:29 PM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > On Tue, Mar 17, 2020 at 02:46:55PM +0530, Bharat Bhushan wrote:
> > > > Hi Jean,
> > > >
> > > > On Tue, Mar 17, 2020 at 2:23 PM Jean-Philippe Brucker
> > > > <jean-philippe@linaro.org> wrote:
> > > > >
> > > > > On Tue, Mar 17, 2020 at 12:40:39PM +0530, Bharat Bhushan wrote:
> > > > > > Hi Jean,
> > > > > >
> > > > > > On Mon, Mar 16, 2020 at 3:41 PM Jean-Philippe Brucker
> > > > > > <jean-philippe@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Bharat,
> > > > > > >
> > > > > > > Could you Cc me on your next posting?  Unfortunately I don't
> > > > > > > have much hardware for testing this at the moment, but I
> > > > > > > might be able to help a little on the review.
> > > > > > >
> > > > > > > On Mon, Mar 16, 2020 at 02:40:00PM +0530, Bharat Bhushan wrot=
e:
> > > > > > > > > >>> First issue is: your guest can use 4K page and your
> > > > > > > > > >>> host can use 64KB pages. In that case VFIO_DMA_MAP
> > > > > > > > > >>> will fail with -EINVAL. We must devise a way to pass =
the host
> settings to the VIRTIO-IOMMU device.
> > > > > > > > > >>>
> > > > > > > > > >>> Even with 64KB pages, it did not work for me. I have
> > > > > > > > > >>> obviously not the storm of VFIO_DMA_MAP failures but
> > > > > > > > > >>> I have some, most probably due to some wrong notifica=
tions
> somewhere. I will try to investigate on my side.
> > > > > > > > > >>>
> > > > > > > > > >>> Did you test with VFIO on your side?
> > > > > > > > > >>
> > > > > > > > > >> I did not tried with different page sizes, only tested=
 with 4K page
> size.
> > > > > > > > > >>
> > > > > > > > > >> Yes it works, I tested with two n/w device assigned
> > > > > > > > > >> to VM, both interfaces works
> > > > > > > > > >>
> > > > > > > > > >> First I will try with 64k page size.
> > > > > > > > > >
> > > > > > > > > > 64K page size does not work for me as well,
> > > > > > > > > >
> > > > > > > > > > I think we are not passing correct page_size_mask here
> > > > > > > > > > (config.page_size_mask is set to TARGET_PAGE_MASK (
> > > > > > > > > > which is
> > > > > > > > > > 0xfffffffffffff000))
> > > > > > > > > I guess you mean with guest using 4K and host using 64K.
> > > > > > > > > >
> > > > > > > > > > We need to set this correctly as per host page size, co=
rrect?
> > > > > > > > > Yes that's correct. We need to put in place a control
> > > > > > > > > path to retrieve the page settings on host through VFIO t=
o inform the
> virtio-iommu device.
> > > > > > > > >
> > > > > > > > > Besides this issue, did you try with 64kB on host and gue=
st?
> > > > > > > >
> > > > > > > > I tried Followings
> > > > > > > >   - 4k host and 4k guest  - it works with v7 version
> > > > > > > >   - 64k host and 64k guest - it does not work with v7
> > > > > > > >     hard-coded config.page_size_mask to 0xffffffffffff0000
> > > > > > > > and it works
> > > > > > >
> > > > > > > You might get this from the iova_pgsize bitmap returned by
> > > > > > > VFIO_IOMMU_GET_INFO. The virtio config.page_size_mask is
> > > > > > > global so there is the usual problem of aggregating
> > > > > > > consistent properties, but I'm guessing using the host page s=
ize as a
> granule here is safe enough.
> > > > > > >
> > > > > > > If it is a problem, we can add a PROBE property for page
> > > > > > > size mask, allowing to define per-endpoint page masks. I
> > > > > > > have kernel patches somewhere to do just that.
> > > > > >
> > > > > > I do not see we need page size mask per endpoint.
> > > > > >
> > > > > > While I am trying to understand what "page-size-mask" guest
> > > > > > will work with
> > > > > >
> > > > > > - 4K page size host and 4k page size guest
> > > > > >   config.page_size_mask =3D 0xffffffffffff000 will work
> > > > > >
> > > > > > - 64K page size host and 64k page size guest
> > > > > >   config.page_size_mask =3D 0xfffffffffff0000 will work
> > > > > >
> > > > > > - 64K page size host and 4k page size guest
> > > > > >    1) config.page_size_mask =3D 0xffffffffffff000 will also not
> > > > > > work as VFIO in host expect iova and size to be aligned to 64k
> > > > > > (PAGE_SIZE in
> > > > > > host)
> > > > > >    2) config.page_size_mask =3D 0xfffffffffff0000 will not work=
,
> > > > > > iova initialization (in guest) expect minimum page-size
> > > > > > supported by h/w to be equal to 4k (PAGE_SIZE in guest)
> > > > > >        Should we look to relax this in iova allocation code?
> > > > >
> > > > > Oh right, that's not great. Maybe the BUG_ON() can be removed,
> > > > > I'll ask on the list.
> > > >
> > > > yes, the BUG_ON in iova_init.
> > > > I tried with removing same and it worked, but not analyzed side eff=
ects.
> > >
> > > It might break the assumption from device drivers that mapping a
> > > page is safe. For example they call alloc_page() followed by
> > > dma_map_page(). In our situation dma-iommu.c will oblige and create
> > > one 64k mapping to one 4k physical page. As a result the endpoint
> > > can access the neighbouring 60k of memory.
> > >
> > > This isn't too terrible. After all, even when the page sizes match,
> > > device drivers can call dma_map_single() on sub-page buffers, which
> > > will also let the endpoint access a whole page. The solution, if you
> > > don't trust the endpoint, is to use bounce buffers.
> > >
> > > But I suspect it's not as simple as removing the BUG_ON(), we'll
> > > need to go over dma-iommu.c first. And it seems like assigning
> > > endpoints to guest userspace won't work either in this config. In
> vfio_dma_do_map():
> > >
> > >         mask =3D ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) -
> > > 1;
> > >
> > >         WARN_ON(mask & PAGE_MASK);
> >
> > Yes, Agree
> >
> > >
> > > If I read this correctly the WARN will trigger in a 4k guest under
> > > 64k host, right?  So maybe we can just say that this config isn't
> > > supported, unless it's an important use-case for virtio-iommu?
> >
> > I sent v8 version of patch and with that guest and host with same page
> > size should work.
> > While i have not yet added analyzed how to mark 4k guest and 64k host
> > as un-supported configuration, will analyze and send patch.
>=20
> I don't think there is anything to do for QEMU, it's Linux that doesn't s=
upport the
> configuration. We could add something like the attached patch, in the vir=
tio-
> iommu driver, to abort more gracefully than with a BUG_ON().

Yes agree, we need to have change in Linux side.

Thanks
-Bharat

>=20
> Thanks,
> Jean


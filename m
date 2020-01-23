Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D371C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5802B21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="deJsIxyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5802B21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufa8-0000Ar-31
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1iudzO-0001Sg-DO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1iudzM-0006dd-Or
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:01:45 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:14112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1iudzM-0006WT-IK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:01:44 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00NEwVW9023917; Thu, 23 Jan 2020 07:01:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=44qZH3EBKlahzicQ/gCXNLfi1qeSt4M5Sou2Jhjcp+Q=;
 b=deJsIxyqTyFTSnIecJACgzbTrYzKL6AaIPaBHQT0OrDoKu+t9mPfAegNquwMdh5stKVE
 AxofQSV44b7/zQnUqCISKlCAsNaBUhr6PYVW+EsBCls0inkOGyVpa5xL1edvpQ1Q5Mlv
 VyHdmIfvM0Dp+GYLIkxN9I+vZPNA64JePxe7S6Hamo7W8W1tNMSkslOS8JttauqWmw78
 d9sctY8xbiMkQ9hIHuP6FAPR3z9wBGoXwR//a/pMcWZziIdtYueHG7l5vnCY1d+CA8FL
 kJnRzcSug3SaeTsmUhEr30IQnFhGml84EuGnStaM+Z/3kkkSZcgv5GLVyo0rmTnJHv2e KA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xm27n2unu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Jan 2020 07:01:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWVZwDOLywC5G/yeYSmzKLbjsw1tnt4qdbBma+6gvREbn1iLpIgzsRdM4H4++2g2067nS3gWVD3S3DTzGuwGzMYhwfald8vmj9zzGCxzuQxK3Ez63ZP72aEhSy+qRY3eq8Zbgh1Wa6FEBKRAKZ0or9vzAbI5CGMWmINYd5lzj+6FIaM4fXaowrfCm9lkTGo4o3Mx3M77ks1bzwyGANfHM+7/xBGypW8RJiMaaGNX3hsqPNQ/dj966nHjdAVJ8L/AN8q4oAqVY97mBK03IGFHgfE5vv+7KMcijxPXp/HXBDI7UBAJReyg/6nftRNfEZ/tDJKSoNlCGjSxX1TXWLIrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44qZH3EBKlahzicQ/gCXNLfi1qeSt4M5Sou2Jhjcp+Q=;
 b=eJ2bKOY+t9EybmJP7MPPr3+b6FPrr2E+eh8RVHmfSI2X7ZeaFYFLTISeasdYxmYsd0x8Js/WZUBTMZPTKbCL0jFnjaQ/Zm/Q0oAFQKYW2S6naDbQxENK21r2kDlbYZRRA73dB3Stvz1CmFILakrMbL62e+MHuppEJeARnM48A9rOACGdnjMvbBibbtXGEXceRuxEbzCLkt/n79VUoi7TSy8dEyidyJIb+WjbmLDLKGuGQkW0i2W+9RrfIeqjwC5r1RzcLDK+sMMFRASXZga4rWJaw4VSWdCrtQUy4TX9FMU61PKAJDK3RRFzfl/KU/zGfzQTSPcZKo/v+SDaZGiZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.174.145) by
 MN2PR02MB6029.namprd02.prod.outlook.com (52.132.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Thu, 23 Jan 2020 15:01:28 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::9d5e:4def:937e:7908]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::9d5e:4def:937e:7908%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 15:01:28 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: question about handling MSI-X by VFIO
Thread-Topic: question about handling MSI-X by VFIO
Thread-Index: AdXQX8Dj4uriAMRTRT6y/GFdZAK4vgAHyR+AAF91bdA=
Date: Thu, 23 Jan 2020 15:01:28 +0000
Message-ID: <MN2PR02MB62056D2CC033EA7E9F37AC448B0F0@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB6205CD9F680E4E7AEA7E5E518B0D0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200121101911.64701afd@w520.home>
In-Reply-To: <20200121101911.64701afd@w520.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5b0cf5b-63c4-4dc6-bba2-08d7a0151ff8
x-ms-traffictypediagnostic: MN2PR02MB6029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6029A6214BE0172D34F440748B0F0@MN2PR02MB6029.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(346002)(376002)(396003)(136003)(199004)(189003)(6916009)(316002)(76116006)(66556008)(64756008)(66446008)(66476007)(8676002)(66946007)(478600001)(107886003)(44832011)(33656002)(4326008)(81156014)(5660300002)(9686003)(2906002)(71200400001)(52536014)(81166006)(8936002)(55016002)(26005)(6506007)(186003)(54906003)(7696005)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6029;
 H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2dchmevZNeeQrp0t+Rb15iq5VYVYOTqm63EGaopSjSw6/FTf8yW0dh88vZ/t5YVNTdkdgSzVgtoFDjtSX8fz6bMSNmvoTo4ns0LDvN5l3ml/yf5Kq73zBl/rjDhTLhuxhl8D/aBaMrszFGRvQ/49lYsYv77FcB/RvLI9Gxlhq++o4Yq6F7luhGYfiYZcbtT7ux46z6c8MOlKlg8L+FahetnH7TEBVywgZe/qE/VG8/MCN3ILJ49losyEBAubCsrdxCsD6s/5w+zOMD88hmbnCQxF199GUfx59GvRXfxSe51hrHAo0N3AJ3kO2M8jYT5lVeum3pYqhdpRkUOazpHH0UZBgbjnYIyMkDgWAzOKTHyCNVuwbgajYc0MqHLXp240+sWpLbn/otHVi3iJragygJ9ZCU6fwmRwSKwa+fxSQuDReQ8Db7qDG0k/BB+pkEs
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b0cf5b-63c4-4dc6-bba2-08d7a0151ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 15:01:28.5907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59zAg7QTiaTgp6qILKnK9yNIIQsa99FP+KyPFnm+MeLaEAxTsATRO1SnAeCfGTutVlXkG+PEEBpM/BKS+ShXNUAQF1vaT8S7nmJRDdAglng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-23_08:2020-01-23,
 2020-01-23 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.155.12
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > I'm passing through a virtual PCI device to a QEMU guest via VFIO/mdev
> and I
> > notice that MSI-X interrupts are disabled in the device (MSIXCAP.MXC.MX=
E
> is
> > zero) and the BARs containing the table and PBA (4 and 5 in my case) ar=
e
> never
> > accessed.  However, whenever I fire an MSI-X interrupt from the virtual
> device
> > (although I'm not supposed to do so as they're disabled), the guest see=
ms
> to
> > correctly receive it. I've started looking at hw/vfio/pci.c and it seem=
s that
> > VFIO handles MSI-X interrupts there, including masking etc?
>=20
> Yes, the vector table and PBA are emulated in QEMU, the latter lazily
> only when vectors are masked, iirc.  The backing device vector table
> should never be directly accessed by the user (it can be, but you can
> just discard those accesses), MSI-X is configured via the
> VFIO_DEVICE_SET_IRQS ioctl, which configures the eventfd through which
> an mdev driver would trigger an MSI.  When you say that you "fire and
> MSI-X interrupt from the virtual device" does this mean that you're
> signaling via one of these eventfds?  It looks to me like emulating the
> MSI-X enable bit in the MSI-X capability is probably the responsibility
> of the mdev vendor driver.  With vfio-pci the VFIO_DEVICE_SET_IRQS ioctl
> would enable MSI-X on the physical device and the MSI-X capability seen
> by the user would reflect that.  Are you missing a bit of code that
> updates the mdev config space as part of the SET_IRQS ioctl?  Thanks,

Indeed I fire interrupts via the eventfd and it works correctly. I just
couldn't understand how it could possibly work since the table and PBA BARs=
=20
were never accessed and the MSI-X enable bit was not set.  It makes perfect
sense now why it works since QEMU does it all.


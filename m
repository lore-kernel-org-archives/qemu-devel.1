Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C9BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1E12070C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="XET6Rrax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1E12070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ituQv-0002cg-Dh
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thanos.makatos@nutanix.com>) id 1itthq-0007AB-25
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1itthl-0001CN-Pl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:36:33 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:29082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1itthl-0001Bo-K8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 08:36:29 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00LDZ4cr009539; Tue, 21 Jan 2020 05:36:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=7Yo1vWkN/nVZASt94OBYaR8j+Q3Y8TGBS0UyQLI8csw=;
 b=XET6Rrax0daxzE25vfzcNkS2UnShJ+xDJz/8xfsqfc8WhkI89cgur5DFJ3D99qvZ2av1
 Hcej+PybUl69qAMYbXNZeSZvhHRaKGqpHR7L9F4AxdqMxVGu0/OAE7ckhEI+Q0Gbx30i
 HJVOcIReVPy4M+GnIHPUV9/m4MDvK2kSO2nTT0XU5laEnDklFCUak1QT5Xa1Pd/cB+eX
 4iINOknzH9KXBNosySsJ4yH3GxCAhgwVppi4gfjs3A5BA/KIIN4dPKyuXmlHyApwNZOE
 yPxnf2qoJw7P3TDHq8byiV3vJf6lWJByW/y9mcISKaEFuJ8uPZgYq7saqpuvwA7o/wwv 9g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by mx0b-002c1b01.pphosted.com with ESMTP id 2xm2e6554s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2020 05:36:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbJLzfxzNdqV8WTqXhaYioTYezDC219mr08IQFx2G8kTV3Ck03/hYECqYL+2OS2X5UqcrvcCU56cI14QwAs0yqOjMq0PHZHf13O5zd8jCQ2MVp0sQ7v0HkcX/yrl4Oni8Tc/QT8nqESMMZEVOKiXxenyXnNuch/3FKW9VJDvQ31CZkiQFdsxLpyVQ5pPHL3fILKjaYywzjoZQjtrz2lDClySymzhmB24eDwUEWx0eWvyG4h6GpZ3VepTKyCukP6LUXPbZCOzT81j9/LjZh0MDf6wl07Ph/kldGFbN14xJzhTdNgaviilHtM1fkDjeZb74ul63hY3u/ub4Yi2HlIGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yo1vWkN/nVZASt94OBYaR8j+Q3Y8TGBS0UyQLI8csw=;
 b=OpkJhXUloL6AOSzZiWk2PmgW0M5aVroclHuZ5RjhV5hFwfe4S0xeTAZRh7U/gkwC5oe03jID2cB3f0aJOI34I/g60HMB8NAADAsixZtjTHFmRFJDsR+cLZ+gaPvdJ8PimNC+Ko4JeLJhL6NdtaDk7vuiVTMO7y1+7e+KfEAF9Ra1wOPGUj4PxUyRBI3VXO0VxbdLY/QTRYxZnr0dfbE5w5QebBSp8abcXgqZjzRYBN8mPbE72B+uKoOj+9ZnmtOQ0jUmu6PiX2zBzCxxij3Sa4Lr1nOYCvcIwzIHoqfwUJyX0nMlBYYlRg+547H7+IWlTn2aADx6ZTfUbTzxqdhA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.174.145) by
 MN2PR02MB6110.namprd02.prod.outlook.com (52.132.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Tue, 21 Jan 2020 13:36:26 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::9d5e:4def:937e:7908]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::9d5e:4def:937e:7908%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 13:36:26 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: question about handling MSI-X by VFIO
Thread-Topic: question about handling MSI-X by VFIO
Thread-Index: AdXQX8Dj4uriAMRTRT6y/GFdZAK4vg==
Date: Tue, 21 Jan 2020 13:36:26 +0000
Message-ID: <MN2PR02MB6205CD9F680E4E7AEA7E5E518B0D0@MN2PR02MB6205.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d9b449-4980-422c-346f-08d79e76ea2c
x-ms-traffictypediagnostic: MN2PR02MB6110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6110C809C1B5F76F19C485488B0D0@MN2PR02MB6110.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(39860400002)(366004)(376002)(199004)(189003)(107886003)(71200400001)(2906002)(186003)(7696005)(6506007)(44832011)(4744005)(26005)(33656002)(5660300002)(66946007)(81156014)(81166006)(55016002)(76116006)(66476007)(9686003)(6916009)(8676002)(66556008)(64756008)(66446008)(4326008)(316002)(478600001)(54906003)(86362001)(8936002)(52536014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6110;
 H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGheEQRBLmyPPkwZlw3oR0wgFwc0wp5e6B1TJeWe92XtSRNxWAso3TqpGZOHCLfmHW5PQzXKrdF/3DMmjLW782RzNGs77SPRveVQI117+Mn4LjvBpRrgd4X8CP18awUxM0qIoV+fd9ho9gU3OvSNBmYoJinveIsDrnt2JIm7hWdo6SPb7Hb9kRLjW/254zR1SoveH1FG+vGz6Cl/DMiWx0oum/avH44W8r0pRZJyR4TqL1M92Q1LeYVKTLPSKBfaP4NIUfTkDpUuvLdsobHQT71wH6cqPsFUBB5r3N6fJ1olRvNGjbROkGJLnnruuQ9Qtn7B4fgwRC34nYuh2KZnA4oLHm9ODhes3pyusI8opxf473rvHtvY4N09OHLq41RlXK7r/NyBAcEbV6KS5NMJrr8iwqFNpT9G8BpoR4VWD6DgDdKJ9jcaQpygNwthVucz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d9b449-4980-422c-346f-08d79e76ea2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 13:36:26.7220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHThwvbLLVkH6rxrZhxFaQX7OVoj+lYrvq2JWxSfxVZ+tXhdfG/wMw5mVt6Ohd3jtsyMm3vhb6uJGu+4XyTSA2BmOMTAyB4md5FrigC/9QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6110
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-21_04:2020-01-21,
 2020-01-21 signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm passing through a virtual PCI device to a QEMU guest via VFIO/mdev and =
I
notice that MSI-X interrupts are disabled in the device (MSIXCAP.MXC.MXE is
zero) and the BARs containing the table and PBA (4 and 5 in my case) are ne=
ver
accessed.  However, whenever I fire an MSI-X interrupt from the virtual dev=
ice
(although I'm not supposed to do so as they're disabled), the guest seems t=
o
correctly receive it. I've started looking at hw/vfio/pci.c and it seems th=
at
VFIO handles MSI-X interrupts there, including masking etc?


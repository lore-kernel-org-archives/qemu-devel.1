Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FC2C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B255020850
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="JjJUqx92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B255020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbokt-0006Me-Ly
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thanos.makatos@nutanix.com>) id 1hboYp-0006w4-Dj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thanos.makatos@nutanix.com>) id 1hboYo-0002sh-Cp
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:56:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:36864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thanos.makatos@nutanix.com>)
 id 1hboYn-0002qx-VL
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:56:14 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5EFt21a006934; Fri, 14 Jun 2019 08:56:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=tpRdhNHy3qFb8dD99wtF+en+QYw5VIt86vH83ZYk0LI=;
 b=JjJUqx92g3EcK98CvigD3assSue70+TohaVLZDnw/UXWPr1xSNYGCSExgKJYBdTSascL
 LF+7/uRb8x1nCc87EG3s76uNcq7Q/hVFFqUpItktU3u+ogn+uSxrwt9MbMLHxTdkYII3
 yEe/09gpK06mEfR+uvgDEHZ+qHdtxSxDmU/UmO+JREwT0gN6XWhOd4QWvzNwdjEBaWu1
 j816m4FkpjrORs3UTrYtj3UvCni1vvxuxE3w6wcHm+wbZDQlUeQgPJD2Gfpi7ehtkee/
 ZJg8AjwSd9wmdJ+73E+WEQsRrwguLU65k65ne19/l2VcTNGHUxziDHeRbqk1PM7fmN9o pg== 
Received: from nam04-co1-obe.outbound.protection.outlook.com
 (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
 by mx0a-002c1b01.pphosted.com with ESMTP id 2t4ak08cfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2019 08:56:09 -0700
Received: from MN2PR02MB6205.namprd02.prod.outlook.com (52.132.174.26) by
 MN2PR02MB6190.namprd02.prod.outlook.com (52.132.173.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 15:56:07 +0000
Received: from MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::25d5:60b3:a680:7ebd]) by MN2PR02MB6205.namprd02.prod.outlook.com
 ([fe80::25d5:60b3:a680:7ebd%3]) with mapi id 15.20.1965.017; Fri, 14 Jun 2019
 15:56:07 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>, Alex Williamson
 <alex.williamson@redhat.com>
Thread-Topic: [Qemu-devel] QEMU tries to register to VFIO memory that is not
 RAM
Thread-Index: AdUXtUBrTZM56mQoR86m4RxpHSXlmQACSDQAAAGm+pAAAIfRAADKIYpQAfZ8hsA=
Date: Fri, 14 Jun 2019 15:56:06 +0000
Message-ID: <MN2PR02MB6205D122DE896A3CE5775EA58BEE0@MN2PR02MB6205.namprd02.prod.outlook.com>
References: <MN2PR02MB62053CE40CA6B4A97B32FA048B190@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20190531083732.37ecbb1e@x1.home>
 <MN2PR02MB620549D68EB53487C6FCF51F8B190@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20190531094002.29030716@x1.home>
 <MN2PR02MB6205917DCA53968D8F50D27E8B150@MN2PR02MB6205.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6205917DCA53968D8F50D27E8B150@MN2PR02MB6205.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cdce673-d9ee-42d0-5ab6-08d6f0e0cfe5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:MN2PR02MB6190; 
x-ms-traffictypediagnostic: MN2PR02MB6190:
x-proofpoint-crosstenant: true
x-microsoft-antispam-prvs: <MN2PR02MB619068658DC2C174CCFABABA8BEE0@MN2PR02MB6190.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39860400002)(376002)(366004)(136003)(199004)(189003)(229853002)(26005)(5660300002)(55016002)(86362001)(4744005)(9686003)(102836004)(3846002)(8676002)(478600001)(6116002)(14454004)(6506007)(68736007)(66066001)(52536014)(81156014)(7696005)(6436002)(76176011)(2906002)(81166006)(305945005)(7736002)(73956011)(71200400001)(64756008)(66446008)(446003)(74316002)(66476007)(6246003)(99286004)(76116006)(8936002)(4326008)(54906003)(44832011)(66556008)(186003)(25786009)(107886003)(476003)(11346002)(486006)(53936002)(256004)(110136005)(316002)(66946007)(33656002)(71190400001)(64030200001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR02MB6190;
 H:MN2PR02MB6205.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 75uoObAH7wHzxAl9UQB/uHKsN3dnlj0hr6jaY4bu1+D9nAXA/3zTnY2mJB6Cs1M2wOvsH7IBqzZyx5jLRkxAYyRLVA9Zf4dWnU50gXEqBe6kFrjz8T8BWtzXYcHo2jlDCrD0kPflFx8FpdfAJLc8wYFWjX5/Tcc3RfZ2xKB2FaxzNJslT0nShrXHoXg4YFBn1otIzdZ6vjV80aNpM1AhNUMiXNcRg8DUGm6eqt0z1ksN7E1WcKzxzwUp1YBG/+dmaKGqux4clvBN4feqNIYoThOCoGDEXMFq5Ez4U9u42p73AmugLRhvxgZSUJbGyWBNd2In94aO1JN7IR+zIbQ/rFzCShvviFQEr1SPgk5nurfjupUYYrnYjhX+Xj2OtkSxeEq9ZFP6tyLirwu3k9Oa4xFDpClC8yQvSfcQpbAK+sc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdce673-d9ee-42d0-5ab6-08d6f0e0cfe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:56:06.8910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thanos.makatos@nutanix.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6190
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-14_07:, , signatures=0
X-Proofpoint-Spam-Reason: safe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.151.68
Subject: Re: [Qemu-devel] QEMU tries to register to VFIO memory that is not
 RAM
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
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index 4374cc6176..d9d3b1277a 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -430,6 +430,9 @@ static void
> > vfio_listener_region_add(MemoryListener *listener,
> > >      VFIOHostDMAWindow *hostwin;
> > >      bool hostwin_found;
> > >
> > > +    if (!section->mr->ram_device)
> > > +        return;
> > > +
> >
> > Nope, this would prevent IOMMU mapping of assigned device MMIO
> > regions
> > which would prevent peer-to-peer DMA between assigned devices.
> Thanks,
>=20
> Understood.
>=20
> Is there a strong reason why QEMU allocates memory for these address
> spaces without MAP_SHARED? In our use case it would solve our problem if
> we could make QEMU use MAP_SHARED. I understand that this isn't strictly
> correct, so would it be acceptable to enable this behavior with a command=
-
> line option or an #ifdef?

Ping!



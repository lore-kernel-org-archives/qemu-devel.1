Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01F8C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FBE21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GZIVLSvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FBE21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1him2U-0001kf-K0
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1him1p-0001LP-8U
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1him1o-0003nk-1x
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:38:57 -0400
Received: from mail-eopbgr730098.outbound.protection.outlook.com
 ([40.107.73.98]:31265 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1him1n-0003nO-SW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7NyXFNG0SO9MC0KXMyFP+F7K7dfd0J5ofBSQXJ839o=;
 b=GZIVLSvhI7wuALlALgGZSS6QWU2UC0M9dL8HJfPdWpQ7pRYhh4TN+Jri5fh5g4wwgg5qTJPp3RXdnRvuSvMHaZ/cLyv54+gVx9AnXv1DW2Ztt7AVVxBuRRr2IQBkMor6cbQzFjJhQi6RjlS80gCLReo8QdRD90WxJc+yIhvwpIY=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1460.namprd22.prod.outlook.com (10.174.85.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 20:38:54 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 20:38:54 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [BUG] Inappropriate size of target_sigset_t
Thread-Index: AQHVMdW9rYddusddyUKgOhYBGFbH+qa5UEcAgAAEMzSAAAOwAIAAAfip
Date: Wed, 3 Jul 2019 20:38:54 +0000
Message-ID: <BN6PR2201MB1251C9187E8090183C012E22C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <c2660cf1-d23d-69ed-0f6b-2c450542cb18@vivier.eu>
 <BN6PR2201MB1251AE1CACDAD8DC61CDC39CC6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <CAFEAcA9n+NqrOvejcCe5aNAOEai+9gRQQtforjKDMMJnNBLxOw@mail.gmail.com>
In-Reply-To: <CAFEAcA9n+NqrOvejcCe5aNAOEai+9gRQQtforjKDMMJnNBLxOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfb7b8ab-9f6d-4f78-0d39-08d6fff676f7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1460; 
x-ms-traffictypediagnostic: BN6PR2201MB1460:
x-microsoft-antispam-prvs: <BN6PR2201MB14604BE32182887BBF510B3EC6FB0@BN6PR2201MB1460.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(376002)(366004)(396003)(346002)(189003)(199004)(3846002)(256004)(74316002)(6116002)(54906003)(76176011)(33656002)(71190400001)(6246003)(9686003)(6506007)(316002)(53936002)(55236004)(55016002)(102836004)(7696005)(99286004)(2906002)(71200400001)(68736007)(76116006)(91956017)(66946007)(73956011)(6916009)(8676002)(186003)(66066001)(5660300002)(25786009)(7736002)(52536014)(476003)(229853002)(66556008)(478600001)(305945005)(66446008)(66476007)(64756008)(81166006)(81156014)(14454004)(4326008)(26005)(8936002)(446003)(11346002)(6436002)(86362001)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1460;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yKwcMbc/GLP/mFC/GF7nI5WYXSUqCK00DQ0T6wit8V30qnK+rLC3ZL6CjuWo6Zr1b80ZpOiL9yrx28d9jhCeW9mmojSNv9Gw+o5EE5hdRVlshTEo6E9sx67t3TdQQt48Baf9r6m4cNmhhCAV6Y+B4f/OpRhCV7AO5mURc1oz7guxN6J7IcMEf1JtjdOP7xw0tJR0RY321wOVvUZPpahdmxmEqiYPqgEnsdYYu10ixm1tY7zUqswzPuKKDsFjte3lqgpXK6FWlkjCmfTI6IiYq6ghqS5JTDh5cB3MwiMIWew/03J/CoKf48ZRQHnBTezwFx4J8qYSviBJFlwzLyFhlaTN0I31yPYmTXCqs16AUDnEjMSLprTfN1UyG01WL/CeC2OQmiUJJ+JlIPwnaR/elcvj02lCVigNpSnmZjpYupE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb7b8ab-9f6d-4f78-0d39-08d6fff676f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 20:38:54.1903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1460
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.98
Subject: Re: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Peter Maydell <peter.maydell@linaro.org>=0A=
> =0A=
> On Wed, 3 Jul 2019 at 21:20, Aleksandar Markovic <amarkovic@wavecomp.com>=
 wrote:=0A=
> >=0A=
> > From: Laurent Vivier <laurent@vivier.eu>=0A=
> > > If I compare with kernel, it looks good:=0A=
> > > ...=0A=
> > > I think there is no problem.=0A=
> >=0A=
> > Sure, thanks for such fast response - again, I am glad if you are right=
. However, for some reason, glibc (and musl too) define sigset_t differentl=
y than kernel. Please take a look. I am not sure if this is covered fine in=
 our code.=0A=
> =0A=
> Yeah, the libc definitions of sigset_t don't match the=0A=
> kernel ones (this is for obscure historical reasons IIRC).=0A=
> We're providing implementations of the target=0A=
> syscall interface, so our target_sigset_t should be the=0A=
> target kernel's version (and the target libc's version doesn't=0A=
> matter to us). On the other hand we will be using the=0A=
> host libc version, I think, so a little caution is required=0A=
> and it's possible we have some bugs in our code.=0A=
=0A=
OK, I gather than this is not something that requires our immediate attenti=
on (for 4.1), but we can analyze it later on.=0A=
=0A=
Thanks for response!!=0A=
=0A=
Sincerely,=0A=
Aleksandar=0A=
=0A=
> thanks=0A=
> -- PMM=0A=


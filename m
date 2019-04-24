Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55582C282E5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2ED218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HvzTpCmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2ED218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFkF-0001bS-TJ
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 07:07:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJFiF-0008HY-7c
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJFfu-0000Tu-Ht
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:02:51 -0400
Received: from mail-eopbgr820139.outbound.protection.outlook.com
	([40.107.82.139]:37120
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hJFfu-0000T5-6g
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=DDe+CLWxSDBAiuZT2rw8AK4hHwuSfoMtyhZmmpRf6nU=;
	b=HvzTpCmm/xCZz7zrDKAPM8dhTlAuD4vebweuIEv5rkIQWgrfIYZBev9JibK/MJb8Z9bUkYAPc0rND6ENa63WIOI8Bmth6rZXyVouaUsDNPzcShD4zn1rfB9HoCezaCxzFiPGziViFMiU1JXnCbZbFeuZRYaCKma5WQSyNvw7sKs=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1699.namprd22.prod.outlook.com (10.161.156.21) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.17; Wed, 24 Apr 2019 11:02:44 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1835.010;
	Wed, 24 Apr 2019 11:02:43 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar
	Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info and,
	for mips only, init field fp_abi
Thread-Index: AQHU+fr2DslJH3aor0ygJW6aUCY0ZKZKV8oAgADOMv0=
Date: Wed, 24 Apr 2019 11:02:43 +0000
Message-ID:
 <BN6PR2201MB125177C4249FB6094A09E7BCC63C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1556040926-23931-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556040926-23931-5-git-send-email-aleksandar.markovic@rt-rk.com>,
	<8303cc43-6bc4-6225-e632-e02629ef74ff@redhat.com>
In-Reply-To: <8303cc43-6bc4-6225-e632-e02629ef74ff@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a1a58f1-0f19-4b65-ad27-08d6c8a46093
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1699; 
x-ms-traffictypediagnostic: BN6PR2201MB1699:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR2201MB169929C8AD44B844FE233ADFC63C0@BN6PR2201MB1699.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(39850400004)(366004)(376002)(136003)(189003)(199004)(99286004)(966005)(76176011)(6246003)(7696005)(81166006)(55236004)(2906002)(486006)(26005)(305945005)(4326008)(74316002)(3846002)(6116002)(5660300002)(33656002)(66476007)(81156014)(4744005)(9686003)(54906003)(55016002)(66946007)(6306002)(86362001)(91956017)(73956011)(8936002)(66556008)(2501003)(76116006)(66066001)(53936002)(66446008)(64756008)(6506007)(446003)(97736004)(52536014)(11346002)(6436002)(53546011)(110136005)(186003)(478600001)(68736007)(14454004)(7736002)(8676002)(71190400001)(102836004)(25786009)(71200400001)(316002)(476003)(229853002)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1699;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fp19HfMmJunKz1ZnkHneWsr9CQSIzFhajpN/C10MCN2ZW0YnUDlIfJXT8WMr5pbbckth8E1Rqt3ssXfxMTzVWnREGn493K921/Q8AcGAq9L+UM1XytBNiJhatcLMlfNK4hxISct4XAFbjV+UPBVfcUTMthmyr/pkj9iPslfI0pU9y4R47CuQDIcbwZdmOpXuLar5e/VFA/zcJ9736HzYTxYa828QCYWlv+pNOB8laV+i/yp+anSzxdNBYDe7ElsL+nwsDKCRYf1BCFtUp482fc8cyxiNSufrGMPxu7i3wQsKyl835JUEZbZ96AZVSOAaD4GzBAtoQBy/K4Evy2EGs8mBPreneXyK3X/9Haz08mxOKyIpTY/OtahOfULdDTBpdVDsJTO/Yl6RJME/fugmDMH8uOmgOJcdCAGJ92OrFcQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1a58f1-0f19-4b65-ad27-08d6c8a46093
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 11:02:43.7754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1699
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.139
Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
	"thuth@redhat.com" <thuth@redhat.com>,
	"daniel.santos@pobox.com" <daniel.santos@pobox.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424110243.Wvu9YSRJEcBJm_tM1w8Sjn8-V2B56KAYSj4M9hFhnwM@z>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH 4/4] linux-user: Sanitize interp_info an=
d, for mips only, init field fp_abi
>
> Hi Aleksandar,
>=20
> On 4/23/19 7:35 PM, Aleksandar Markovic wrote:
> > From: Daniel Santos <daniel.santos@pobox.com>
> >
> > Sanitize interp_info structure in load_elf_binary() and, for mips only,
> > init its field fp_abi. This fixes appearances of "Unexpected FPU mode"
> > message in some MIPS use cases.
> >
>=20
> Please add:
>=20
> Fixes: https://bugs.launchpad.net/qemu/+bug/1825002
>=20

Will do, Philippe. Thanks a bunch!

Aleksandar


Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE20FC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7CD20881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ct19uZ/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7CD20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvMd-0002it-N6
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55792)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hhvLu-0002Hv-Iu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hhvLt-0003qG-Md
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:24:10 -0400
Received: from mail-eopbgr820130.outbound.protection.outlook.com
 ([40.107.82.130]:15626 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hhvLt-0003p0-AK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:24:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=OIDat6sxbTcKHyPn0TUL3kBF+itH2nzayf6/KkyiJYPBPtB0LYqZSaaP8DQGST6bUJHQ6gMt9mMOIdsbEH/p1QRKJNSg/ff49Zys4SXfnZmOJX3GycGycy6Mddh1aH3W7b8TDxACxTmWRZ4m3Bk1wFrQXghracVOuCPetiQIT5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uDWWpx356MXLQCSxZhgVBHNdJgbulDUF7f4soK0YkY=;
 b=ZIxgZiKQsN9yQ6DjFVxa21Co7DqXeQWl7g69zJ/POp2hhoTKTBlqDWoadI+KlBhcf7RBjbcYKz4Q06dAXKQ+gFoAfiprMqP7tN7th9JOvpYhLS0Mrih7aeMdf2l6fup8j27uk5Ozg/uqhJB/NMgOQHLCT7bWKXgOzV044aRY6ek=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uDWWpx356MXLQCSxZhgVBHNdJgbulDUF7f4soK0YkY=;
 b=ct19uZ/bZ5cGElV5POAdiYovSQTximf7a/q3vI12RvYCbx2BWrsD0hZDRbPBFtmNjC/+HwFEpt1FyLq7bNCWb9Iq7YHGeWCv3mp+uOKZ50MSCmV1QT6gTiOyh3OxZSIg7bK/g0jPC9LLhoojq51vy0shQvIaL2An5k7muLvSzCU=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1106.namprd22.prod.outlook.com (10.174.88.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 1 Jul 2019 12:24:05 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 12:24:05 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v4 4/4] hw/mips: Express dependencies of the r4k platform
 with Kconfig
Thread-Index: AQHVL//ZT54288W8BkS4mtxXFu2KSqa1r2Ct
Date: Mon, 1 Jul 2019 12:24:05 +0000
Message-ID: <BN6PR2201MB125152F910768F89916AEB34C6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190701112612.14758-1-philmd@redhat.com>,
 <20190701112612.14758-5-philmd@redhat.com>
In-Reply-To: <20190701112612.14758-5-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e739fa7-672e-4491-24e5-08d6fe1f0261
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1106; 
x-ms-traffictypediagnostic: BN6PR2201MB1106:
x-microsoft-antispam-prvs: <BN6PR2201MB1106E4CC8EE21A8A086D2436C6F90@BN6PR2201MB1106.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39840400004)(199004)(189003)(316002)(81166006)(52536014)(110136005)(26005)(76176011)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(6506007)(53546011)(55236004)(102836004)(7696005)(8676002)(33656002)(54906003)(6116002)(81156014)(73956011)(3846002)(91956017)(4744005)(186003)(68736007)(5660300002)(99286004)(229853002)(8936002)(6246003)(4326008)(486006)(476003)(86362001)(25786009)(11346002)(446003)(7736002)(305945005)(2906002)(74316002)(71200400001)(66066001)(478600001)(2501003)(14454004)(256004)(71190400001)(53936002)(107886003)(55016002)(6436002)(9686003)(42413003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1106;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5+xkuUZH2rKfiylQxSlNo0OZQizXmETgdECpUNznFN76im6uXe++d944qora39rxZFP401sbkwubbU0vxrthVQNUxvHyB2ZqugmvMAju+3ZQdfx1D07Zy9RVpNJFYTLsd+TkP9zlFyOg8QRBRh0Dbb4Rt0AiGuONxg/slyFJGntTUyaw49G2gBiDTzGL/HZjB9HLdIeTHG6h7h9hqYpBb9/bL0iB1s1JjG+eGv8M1+i294IDBatCu0ceg1UCDTufLZc+OWi1QtFjMusT2H953gBPxiJ5Idf5lOAT2mJj2vWe+2qSa5k594/Qn5EOzi2Q7mXer8n1aPKze+laQsm1/RRznBB/Ba4ZrbbjfPu5twMS83hp+YieyB/j7gTbFJPSiWl2Dx8qNFLWV88jUN7+6ZSKByEhWIKaWPdvJqB9/Fk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e739fa7-672e-4491-24e5-08d6fe1f0261
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 12:24:05.5775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1106
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.130
Subject: Re: [Qemu-devel] [PATCH v4 4/4] hw/mips: Express dependencies of
 the r4k platform with Kconfig
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Thomas Huth <thuth@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Sent: Monday, July 1, 2019 1:26 PM
> Subject: [PATCH v4 4/4] hw/mips: Express dependencies of the r4k platform=
 with Kconfig
>=20
> This platform use standard PC devices connected to an ISA bus.
> Networking is provided by a ne2000 chipset.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=


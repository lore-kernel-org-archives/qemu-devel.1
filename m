Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58289C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 20:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E9C206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 20:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="TObr3LEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E9C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59333 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGrEA-0007pr-9E
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 16:32:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGrDD-0007WV-N8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGrDB-0001Yz-QC
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:31:18 -0400
Received: from mail-eopbgr790127.outbound.protection.outlook.com
	([40.107.79.127]:30000
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGrDB-0001Tx-Bv
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=mjkDUyTeMGAtgaS3zODn70Y4re6MIW7bBDfIgXwwhWo=;
	b=TObr3LEgbqEtMQbnbnkwO4tRxHjA4kfAMNtKW7cdzDsbLcUR5NAOQvVYL1olpaR9UbMmT4DlnDLrnxtkqTuHg3RNv+bcYjY9L6IzVC+t+KogPkOLfhcIQCkcB9Y7m2C+HezalVoJ7OkTKdTIcJcmb4tvGKKiyhrLL4v5TmNvZVc=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1330.namprd22.prod.outlook.com (10.174.81.137) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.11; Wed, 17 Apr 2019 20:31:13 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1813.011;
	Wed, 17 Apr 2019 20:31:13 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH v7 0/6] target/mips: Optimize MSA interleave instructions
Thread-Index: AQHU9TLthNcRWt5liE6H4iwqbwfh5aZAzhgn
Date: Wed, 17 Apr 2019 20:31:13 +0000
Message-ID:
 <BN6PR2201MB1251F5D12066080D6B6F940AC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1555515206-9352-1-git-send-email-mateja.marjanovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74692c05-d53f-4fe6-5eaf-08d6c373a261
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1330; 
x-ms-traffictypediagnostic: BN6PR2201MB1330:
x-microsoft-antispam-prvs: <BN6PR2201MB13307005E03674B9DBAE97CDC6250@BN6PR2201MB1330.namprd22.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(396003)(376002)(39850400004)(366004)(199004)(189003)(55016002)(107886003)(74316002)(106356001)(81166006)(81156014)(54906003)(6436002)(33656002)(6246003)(105586002)(8676002)(2906002)(5660300002)(14454004)(53936002)(97736004)(76176011)(316002)(4326008)(99286004)(7696005)(25786009)(8936002)(3846002)(305945005)(7736002)(229853002)(486006)(71190400001)(11346002)(9686003)(476003)(478600001)(66066001)(110136005)(4744005)(446003)(52536014)(71200400001)(2501003)(55236004)(102836004)(86362001)(26005)(6506007)(186003)(256004)(68736007)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1330;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k6cU7eX3s8Jk/qyWmqpqs5h1EBP9zKXeuBcKQATnx9O14N5a39wvpGmVQCAXd0W+DsvBHUjURsouSniHgvAsGFmLD3mmPZ9IAf0nqhF5rREQhVjbR9pz77N4FBaRPkkGQYqZHYs5Rnaf6xClicgP69sWaoQG0PtF9hO5D4DvcW1SVaKso4gViqejNw3Hz6o+zdZ7dgM8bQQGsqTlj1kg3nnRCwHogiLrPbi4Hcy3/14sHerUNh6nK8/AmELW3uDw1fTli5oCS2NL9FFYbNvnDTzFcQKX+m1ZScivhu1JtoGdzuuDpS30QO8UUJWnFwUCMfFCf1BNVrEleFmJ6UwHXnHJ5jjjmMAG4+uA6cP5v8yrPcJaaTs/CWiRnyAIG/awcv4YoyqX+vXKRnVdff2O1bo7dz3n/3uv6s3ZvL5Cl88=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74692c05-d53f-4fe6-5eaf-08d6c373a261
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 20:31:13.1468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1330
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.127
Subject: Re: [Qemu-devel] [PATCH v7 0/6] target/mips: Optimize MSA
 interleave instructions
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"philmd@redhat.com" <philmd@redhat.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417203113.H1TvseIVA2uFDnc3_AptYZl8SoH6ZhYq67slh-1tB9s@z>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v7 0/6] target/mips: Optimize MSA interleave instructions
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> Optimize and refactor MSA instructions ILVEV.<B|H|W|D>,
> ILVOD.<B|H|W|D>, ILVL.<B|H|W|D> and ILVR.<B|H|W|D>.

Patch number 5/6 seems to be for some reason lost. Please resend the
complete series.

Thanks,
Aleksandar


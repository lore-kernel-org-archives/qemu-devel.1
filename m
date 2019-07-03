Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E452C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB5D21850
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="D7bStEbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB5D21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hill0-0004BU-7A
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hilkE-0003QW-NV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hilkD-0006Uv-Rc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:20:46 -0400
Received: from mail-eopbgr710120.outbound.protection.outlook.com
 ([40.107.71.120]:44180 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hilkD-0006UF-EX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRpHzxl0c5wA9yYy7BVrUq/DKE5I6/Xo8mJ8d2FizjI=;
 b=D7bStEbiHResLAIdJbs89lbZ3e5xjjEuLOT9geLb0eRXbZDVI2R9VsU/sK0KQdBdGxr10tVfTO/Lfnk+IJpOXm3n4tMP5jOP90iguALrJXln61Bomf1BCGK/yqSeTU47cr0+qQM/CSasRfosgXD1dzx619S1Z8fOs19GFEYAuBU=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1732.namprd22.prod.outlook.com (10.161.155.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 20:20:41 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 20:20:41 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, Peter Maydell
 <peter.maydell@linaro.org>
Thread-Topic: [BUG] Inappropriate size of target_sigset_t
Thread-Index: AQHVMdW9rYddusddyUKgOhYBGFbH+qa5UEcAgAAEMzQ=
Date: Wed, 3 Jul 2019 20:20:41 +0000
Message-ID: <BN6PR2201MB1251AE1CACDAD8DC61CDC39CC6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <c2660cf1-d23d-69ed-0f6b-2c450542cb18@vivier.eu>
In-Reply-To: <c2660cf1-d23d-69ed-0f6b-2c450542cb18@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c5e8b67-0007-46dd-2a5d-08d6fff3eb99
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1732; 
x-ms-traffictypediagnostic: BN6PR2201MB1732:
x-microsoft-antispam-prvs: <BN6PR2201MB1732D8DE995403F728ACF561C6FB0@BN6PR2201MB1732.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(39840400004)(376002)(366004)(189003)(199004)(8676002)(7696005)(81166006)(86362001)(102836004)(76176011)(74316002)(7736002)(8936002)(186003)(81156014)(305945005)(26005)(446003)(229853002)(55236004)(25786009)(55016002)(256004)(476003)(486006)(11346002)(14454004)(6506007)(2906002)(71200400001)(5660300002)(71190400001)(33656002)(76116006)(478600001)(91956017)(316002)(99286004)(3846002)(9686003)(6116002)(4326008)(52536014)(68736007)(66066001)(110136005)(6246003)(53936002)(66476007)(64756008)(4744005)(6436002)(66446008)(73956011)(66556008)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1732;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UZoy2DrxRffeBFFlll9oodNckiUuoLgz2t5klimu55+FODruXDEhtill4mdwJck6khqITOmVLKHId7u7DF4Oo6Um9MscYCxrucSEKa60F3HGNaGVZ2yTxFiNSxFTa7vKL+ol3e/7QdGvp6Id+X5HBdLNbkrD0+PgPGmfMvWhrutAgGnXMeWDi3rootIJiBpw+nDixEET3oyBelupDtsXo+vc1XL+5YhzoZEOkitwE1AbJyCtUf6jeCWB+Z1BdsW2+1DI/7nq3e40YU6h2gRG4u6j2YdKahxK8SqafLpRksPsGSFngyPUBwWf0wk44PRVRas+QS/FoqoyeBK4VKyuDt/qN+sSgytnevmPxfDc66KTyIQenkrTZ0/Ctv8OzOn1XAIpHu83R0kZxD5LSKaGVjbO9DqBlXXIVDZaLfQ5rD8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5e8b67-0007-46dd-2a5d-08d6fff3eb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 20:20:41.2942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1732
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.120
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>=0A=
> If I compare with kernel, it looks good:=0A=
> ...=0A=
> I think there is no problem.=0A=
=0A=
Sure, thanks for such fast response - again, I am glad if you are right. Ho=
wever, for some reason, glibc (and musl too) define sigset_t differently th=
an kernel. Please take a look. I am not sure if this is covered fine in our=
 code.=0A=
=0A=
Yours,=0A=
Aleksandar=0A=
=0A=
> Thanks,=0A=
> Laurent=0A=


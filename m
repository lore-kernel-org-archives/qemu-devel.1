Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D279DC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFBE20881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="mm/8aFyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFBE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvQH-0004w9-Ey
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hhvOQ-0003zD-Gz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hhvOP-0006VX-G1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:26:46 -0400
Received: from mail-eopbgr820104.outbound.protection.outlook.com
 ([40.107.82.104]:14368 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hhvOP-0006UZ-9k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=G0Ex9LT1CsdlgLz+ptXxwxvkMbQPJ7Qx+3oru7PS6OsRYDab1U26y6HyfvTiIqHGXHMUvhWm5cfc3z0RgzGa/mGlJECISq3549/uFHK7/pnHj6M5JGSTxMeKEHIafHrD1e5i59U3WJlpCN8tuQwhfdn3bR7vHr+ilAFgZCLG8RE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMq27z1Ij/xBfzJtRRq/xEt79t+8G4PFEilGDCrMfL4=;
 b=ntzUC09CqN/6sqMHSiGzwV62V95uIIOHpxkOvb6/5FrvIWj1LQDoq0qicARsG4ZSvmuHHoVtDotsPowuM2SAOpJTuGL/e8ePo74eUU5u2gm23A3xmf9qHVXBsA7HM2CLW7EJ6F8EghyfbqbuGMgLO4DwnADzZMFBJdg3dSiX8yM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMq27z1Ij/xBfzJtRRq/xEt79t+8G4PFEilGDCrMfL4=;
 b=mm/8aFyYioVe/6zcrOX7TJRnejY9pcdvVxJsEKwy4xYzYOxR2NC51ms1ULHTmkX+4MW2I3c6DOjhECWc4ljkMpPEVxEODNg9i7G3NZdT/65lpSS6F5UebZEQogtNtL1r1HueRjqzRiP/Vkt6iGGO7H1piQPFNBT4hu4wMQDoRHg=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1106.namprd22.prod.outlook.com (10.174.88.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 1 Jul 2019 12:26:44 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 12:26:44 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v4 1/4] hw/mips: Explicit the semi-hosting feature is
 always required
Thread-Index: AQHVL//VzTtxpANaV0mOg4QS60yYraa1r+//
Date: Mon, 1 Jul 2019 12:26:43 +0000
Message-ID: <BN6PR2201MB1251C813EE805834538F5B50C6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190701112612.14758-1-philmd@redhat.com>,
 <20190701112612.14758-2-philmd@redhat.com>
In-Reply-To: <20190701112612.14758-2-philmd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7fba68c-f8a2-4097-8480-08d6fe1f60be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1106; 
x-ms-traffictypediagnostic: BN6PR2201MB1106:
x-microsoft-antispam-prvs: <BN6PR2201MB11063761A579C5E71F4A4462C6F90@BN6PR2201MB1106.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39840400004)(199004)(189003)(316002)(81166006)(52536014)(110136005)(26005)(76176011)(76116006)(64756008)(66556008)(66476007)(66946007)(66446008)(6506007)(53546011)(55236004)(102836004)(7696005)(8676002)(33656002)(54906003)(6116002)(81156014)(73956011)(3846002)(91956017)(4744005)(186003)(68736007)(5660300002)(99286004)(229853002)(8936002)(6246003)(4326008)(486006)(476003)(86362001)(25786009)(11346002)(446003)(7736002)(305945005)(2906002)(74316002)(71200400001)(66066001)(478600001)(2501003)(14454004)(14444005)(256004)(71190400001)(53936002)(107886003)(55016002)(6436002)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1106;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rSNYodFuGbGN1DQJuQOucidTwDK/OcmXfuC4Ija0X/XRFvC/Ieh9GGlUtgXzWQXEYyAwNhNdIK9O6VY/f5VYnVXSweDda22TXTWzD21B6yJI60CgGhNI5YCkn/o1r4Y+UyXeoyUIkD3zdLrmnHsbfan7OPIQzyz0ESw3njEnMdNfP62B3Eh/beBJeyG48zYgSZQclGgwWaebDEfBsnZ5omTc+lO+HFXbYowY4s6DfpS7j62cdNOZOxp9xqDi1/2AX/G7G1bTM4xiiDrV0Cqh4fTij8maM5uRALo3u0G+tm+ZOc25Z/jhrFTgyEDCEOMRrqrVmRcRm67GnluRKJSStNtTgIwvlkZvpbY3MybzN6HkgsLUL2quwvz1s3pnasALN6I3PzV4YNztHZuQnIap8gGCjLWQpOERUjO97FGdktY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fba68c-f8a2-4097-8480-08d6fe1f60be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 12:26:43.8422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1106
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.104
Subject: Re: [Qemu-devel] [PATCH v4 1/4] hw/mips: Explicit the semi-hosting
 feature is always required
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
> Subject: [PATCH v4 1/4] hw/mips: Explicit the semi-hosting feature is alw=
ays required
>=20
> Disabling the semi-hosting feature leads to build failure:

...

> Add a comment to avoid this feature to be disabled.

Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E3C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E272084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="TtpUoAvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E272084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZT2-000362-Js
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <arikalo@wavecomp.com>) id 1hdZS0-0002h8-RO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arikalo@wavecomp.com>) id 1hdZRz-0004QJ-Oq
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:12:28 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com
 ([40.107.69.131]:13575 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
 id 1hdZRz-0004Ox-EL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikMTAgcUR5BCdHPG52EEiZ5TXBjuI1ilqSKmq7xIGj4=;
 b=TtpUoAvXvyMU1gg6/PPpWSMZLBRG3/fvp8RQ1TMR9jRlW/ehcsaGy4CcbRB+wy2lUJpymel1C+NtZ65pP/Fsp77bWtolDlQ9ZwiPh/QD2oFguMsW9Q6cgoVSFXQnMGnoC1NadVLv8IHc5ZpuA9MiIrQyg28wHz2rCEdcQKpCkoQ=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
 DM5PR22MB0396.namprd22.prod.outlook.com (10.173.176.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Wed, 19 Jun 2019 12:12:22 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9]) by DM5PR22MB1658.namprd22.prod.outlook.com
 ([fe80::3579:1b6c:1f31:c6b9%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 12:12:22 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for statx()
 syscall
Thread-Index: AQHVHRzKTQuNOQL9ykewDMeZY8PrY6aZcC+AgAmFrv8=
Date: Wed, 19 Jun 2019 12:12:22 +0000
Message-ID: <DM5PR22MB1658725207C159300EEC786AD2E50@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1559903719-7162-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1559903719-7162-4-git-send-email-aleksandar.markovic@rt-rk.com>,
 <6ceaa114-887b-b060-17b2-7d801e9f266b@vivier.eu>
In-Reply-To: <6ceaa114-887b-b060-17b2-7d801e9f266b@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86afc600-1f65-4dc6-e2d7-08d6f4af6241
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM5PR22MB0396; 
x-ms-traffictypediagnostic: DM5PR22MB0396:
x-microsoft-antispam-prvs: <DM5PR22MB03960DC948D5676F7CB6CBD2D2E50@DM5PR22MB0396.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(6116002)(3846002)(66946007)(91956017)(76116006)(73956011)(486006)(66066001)(66556008)(66476007)(64756008)(66446008)(14454004)(81166006)(81156014)(476003)(68736007)(8676002)(446003)(8936002)(74316002)(7736002)(11346002)(86362001)(2906002)(186003)(26005)(7696005)(53936002)(6436002)(19627405001)(25786009)(5660300002)(71190400001)(6606003)(55236004)(71200400001)(6506007)(102836004)(2501003)(256004)(4326008)(478600001)(316002)(110136005)(54906003)(55016002)(99286004)(54896002)(9686003)(76176011)(6246003)(107886003)(52536014)(33656002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0396;
 H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZLIL1+ESxyj0w0uDIfFUYIacOX8boS7Kfz0AHW5nA7VyUhO69tjksOeoT2Lq8i3qn+tYWioG5zRcNfjolKbrlP2yE0iJRrBBPew5a2rRE7TdNsdaeTAaFVSmc1HjBQdC6x4TytzlALlfmzRFT/YeK7pX2yWFIMFPt8mdjWSabYUCk7FAxArJSq+JSyguVntFij79uIhRkmwqSjC6j63t2WHqjsS6SuzQORk8czuFXgQvyubm0U6uzRzjDWgw0bF6X0UHj2t7EIh6Q1pE3SYECe7TCKdP0FWwz2s3LRktbR11a1+RKqjoGoTtVrfXtiWL9n5qNahT30tyxIsi1mECt/bZz0BIc5XZ2Dq+JlaP2GKiGRe9mBwAe72CpviXYIAXUWwaP6/6v2qR0f4pEExRcygd4rdIIGIiSmpkKc3Vy3Y=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86afc600-1f65-4dc6-e2d7-08d6f4af6241
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 12:12:22.3453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0396
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.131
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v10 3/3] linux-user: Add support for
 statx() syscall
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laurent,

> s/arhitecture/architecture/

Done.

> You should define sys_statx() using _syscall5() macro and use it.

Done.

> ret !=3D -TARGET_ENOSYS

Done.

> You already checked above p is not NULL and exited with -TARGET_EFAULT.

Done.

> BTW, do we really need to emulate the syscall if it is not available?
>
> I think the user-space application calling statx() should be ready to
> receive ENOSYS and define some kinds of fallback (like you do below). So
> it should not be done by QEMU.

nanoMIPS linux port doesn't support any of "stats" but the statx, so there
is no fallback in nanoMIPS user-space applications.

I think, we can expect similar situation for any new linux port.

> Why do we divide the case in two parts, fstatat() should work here too.

fstat() uses file descriptor, but here we have string which represents
file name with absolute path.

All system calls from 'stat' group whose name starts with letter f require
file descriptor as an argument. Whereas remaining system calls require
file name / path as string. In that sense, statx() is a hybrid between
the two, hence the solution I propose.

Aleksandar Rikalo


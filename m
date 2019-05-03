Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6687C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948162081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Xi064OjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948162081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMdFb-00021b-Mj
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:49:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hMdEm-0001ib-QX
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hMdEl-0001sI-9j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:48:48 -0400
Received: from mail-eopbgr740107.outbound.protection.outlook.com
	([40.107.74.107]:9575
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hMdEj-0001gQ-Hw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=43d9Z+ZKBch6JopnDre/EkhjkGnx5AoS0AqH82s/T6Y=;
	b=Xi064OjVEmNL3HJrO+h+kzR+CsvGqL4xaNhhJcY61EvdZ/3H1/Rjr2PoOqP4wXtBoBndPrdCLlwO5Wr+v41Y3uX5kDZjGCSlj9ChZu2d29Wd8wERIBKA3GMY9GM6LwAwTBGEPGkWucUK5kESYE3ZDHVocuoF3A93WY0PuV0jdGs=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1201.namprd22.prod.outlook.com (10.174.81.151) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Fri, 3 May 2019 18:48:37 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1856.012;
	Fri, 3 May 2019 18:48:37 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jakub Jermar <jakub.jermar@kernkonzept.com>,
	=?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
	map_address
Thread-Index: AQHU+cP8brqMejMBkUymdQqBjF7MzqZJwv4AgAATlYCAD2RwAIAAklVf
Date: Fri, 3 May 2019 18:48:37 +0000
Message-ID:
 <BN6PR2201MB12510885B97E6D4312580C24C6350@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>,
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
In-Reply-To: <1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77f2db40-bcd0-4a87-404f-08d6cff7f40c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1201; 
x-ms-traffictypediagnostic: BN6PR2201MB1201:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR2201MB120163C05FAC2305F67D7220C6350@BN6PR2201MB1201.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(396003)(39850400004)(376002)(346002)(199004)(189003)(6436002)(55236004)(66066001)(2906002)(99286004)(53936002)(229853002)(8676002)(81156014)(81166006)(110136005)(86362001)(6506007)(305945005)(6246003)(186003)(476003)(74316002)(316002)(54906003)(486006)(2501003)(76176011)(4744005)(966005)(55016002)(8936002)(7696005)(68736007)(6306002)(5660300002)(478600001)(64756008)(33656002)(52536014)(25786009)(6116002)(3846002)(446003)(26005)(9686003)(11346002)(66446008)(4326008)(71200400001)(14454004)(76116006)(73956011)(102836004)(71190400001)(256004)(66946007)(66476007)(66556008)(91956017)(7736002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1201;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0uW7+1c/at+XDRzLjqgNnRPiIa3EylkISTNLoEjvVz4aGkD/emULJC9sWGqN6NqxQjW8iMwFnNMqp/afI3CrfBHaPRu0eiNV+YjVYtOAWxRvYPPaDHOwp/IBlJSjz38m98I/dcrOBVVaP5HAK4GcFARhklkR09hROCg82zddP3oCCRRfBrzCwBUCC8UCYBkEoXKdqJEHrmqXuY3NeI39c/LP/5HYScYo7UTKkqI1sjF7Hi8gJ13LCsnDbnQUasyDNevqT22Z/H1/gLgDuUMJ+fVIBhQVuqeussKyb8yft1t1rZ8hl9Aj0jBhVi7XmhRwWHkdY6/mBXl1GrUiUFMqQcih0m63O8YalGrwBRmQtHdRHwuUGIYzdtW95chBvXRKz3xj5maDS6W2nMhfRNpWxxxffGMpbAnU/JsuD6EoJoU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f2db40-bcd0-4a87-404f-08d6cff7f40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 18:48:37.7248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1201
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.107
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
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
	Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503184837.irhIuDjftuaUCxUaZ3ZSwyU11uQjLZQGeLQ7kpJ2yy8@z>

> (ping)
>=20
> Is there anything else I can do to help to get this merged?
>=20
> https://patchew.org/QEMU/20190423110034.1260142-1-jakub.jermar@kernkonzep=
t.com/

Hello, Jakub.

I will be reviewing your patch next week, please be patient. In any case, t=
hanks for
your involving in solving this issue!

Aleksandar=


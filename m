Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6FC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F03218C3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HbKwSoqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F03218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56477 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIyND-0007uk-P0
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 12:34:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIyIk-0004OA-RX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIyA6-0000B3-1P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:20:52 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
	([40.107.15.133]:17379
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIy9z-0008Pn-2W; Tue, 23 Apr 2019 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Ygyq6FJTddrsByXwdgzElEHx0Zuxk44OFx1743ZG2xY=;
	b=HbKwSoqpP6kG9uIdgcObxUQaEJXLIF/+oskniPQ8zpEJk1pS5DIlR1LsRy6qatBOVcS2qmOwOsx71MNSyT7g53ByAbfR+rQydlDFcTZCudsO+vhA2jpc1efwTDajMefCJxrUsQRzRl6qoe6g2MO9tpHdyQw2k6TlsREMpkqrDxQ=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3532.eurprd08.prod.outlook.com (20.177.120.82) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Tue, 23 Apr 2019 16:20:27 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Tue, 23 Apr 2019 16:20:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH 0/9] block: buffer-based io
Thread-Index: AQHU+RviZ5ABO6SIx0WfOA0ibhwB5qZJuIKAgAA2LgA=
Date: Tue, 23 Apr 2019 16:20:27 +0000
Message-ID: <66748c66-f2d3-c33b-cd76-52c158fa3519@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
	<20190423130629.GH32465@stefanha-x1.localdomain>
In-Reply-To: <20190423130629.GH32465@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0013.EURP189.PROD.OUTLOOK.COM
	(2603:10a6:3:8b::23) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190423192024785
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6118c826-80fe-4f7c-34af-08d6c807989e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3532; 
x-ms-traffictypediagnostic: DB7PR08MB3532:
x-microsoft-antispam-prvs: <DB7PR08MB3532E12348ABA3C71FD42763C1230@DB7PR08MB3532.eurprd08.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(53754006)(4326008)(81166006)(81156014)(446003)(6916009)(11346002)(66946007)(478600001)(8936002)(316002)(66476007)(76176011)(8676002)(54906003)(229853002)(14454004)(66556008)(6246003)(64756008)(486006)(476003)(186003)(66446008)(73956011)(66066001)(26005)(386003)(6506007)(53936002)(256004)(52116002)(2616005)(102836004)(31696002)(99286004)(6436002)(5660300002)(68736007)(107886003)(25786009)(86362001)(71200400001)(71190400001)(2906002)(36756003)(97736004)(6512007)(305945005)(6486002)(31686004)(3846002)(6116002)(7736002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3532;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vfyQTD04ugjjIpcMHUo7Bga4UQGFD1nORJyLQpo5Arp9I5F8GORRVsNfLPsc8tqv35JeGD9iBjM3xKwYn9HAMg00D+DM6yKPu6s/rPDCU6+MCajNOJ85KkEwnAR+ChN9j0Aw5xibCZ6qZ5+uyuqDTsXR2Pt7h//H+QXq7WK23BiEBon06NMOPw4EVorH4DhlCHKjeeMRLulLo4w9GizCL/RkquoO/lHX85qsb+mI+haDiN4O82u+81694bMa3fjntqBPhVtlGDPszYM73HLSPQTkoYN+BZ/7NV2d86bGbMMWhk8oww7Zzmg4VmCdPB6EcF9J+z8+jCRLrEgXWM6pGUXExczAaSChz/gYSXE9dqeaG4nR8gan2Z6MgfwWPYPyNfeC2G2WBMclyimGFSaZmumtEKPhTL7L1RglEaKpBWk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <DF0C9ADB4484944CB0464F3EE19AB530@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6118c826-80fe-4f7c-34af-08d6c807989e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 16:20:27.2906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3532
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.133
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423162027.WYX5HIvPuJ59STHnnwRjDTsBVPWIljg-9Dqcv4eufg4@z>

23.04.2019 16:06, Stefan Hajnoczi wrote:
> On Mon, Apr 22, 2019 at 05:58:29PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> We often need to do read/write with buffer, not qiov. Instead of
>> creating qiov in such cases, let's introduce corresponding helpers.
>>
>> Vladimir Sementsov-Ogievskiy (9):
>>    block: introduce byte-based io helpers
>>    block/qcow2: use buffer-based io
>>    block/qcow: use buffer-based io
>>    block/qed: use buffer-based io
>>    block/parallels: use buffer-based io
>>    block/backup: use buffer-based io
>>    block/commit: use buffer-based io
>>    block/stream: use buffer-based io
>>    qemu-img: use buffer-based io
>>
>>   include/block/block_int.h      | 16 ++++++++++++++++
>>   include/sysemu/block-backend.h | 19 +++++++++++++++++++
>>   block/backup.c                 | 14 ++++++--------
>>   block/commit.c                 |  5 ++---
>>   block/parallels.c              | 14 ++++++--------
>>   block/qcow.c                   | 19 ++++++-------------
>>   block/qcow2.c                  |  9 ++-------
>>   block/qed-table.c              | 12 +++++-------
>>   block/qed.c                    |  6 ++----
>>   block/stream.c                 |  4 +---
>>   qemu-img.c                     | 13 ++++---------
>>   11 files changed, 69 insertions(+), 62 deletions(-)
>>
>> --=20
>> 2.18.0
>>
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

Thanks!

--=20
Best regards,
Vladimir


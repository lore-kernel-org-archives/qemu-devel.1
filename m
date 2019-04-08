Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5622C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F09C2148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KLJupIYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F09C2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW0u-0002S6-Jq
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:16:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDVzW-0001g0-UK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDVzU-0006de-SF
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:15:22 -0400
Received: from mail-am5eur03on0703.outbound.protection.outlook.com
	([2a01:111:f400:fe08::703]:8302
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDVzH-0005zf-S4; Mon, 08 Apr 2019 11:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=a7DF5XP9AaGUHV9NYPdQbSXcNt0bStzKw5kqjc1Yul0=;
	b=KLJupIYpkXt9TcsiCnWXHMt7hiLP2euZNkbtY8joZnwvRxednx3K0qpms0gFCvhAUQTgJLwG/Hc3I1ZZFxMO7RNW0tjycSPBQkNB1Sf5MtGP7gkJtXWqPspHYeoH3ZWqa/vYxqCufuDQCOq3t7mFKMfFzdb5fMaEFeytVTarmfM=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB4217.eurprd08.prod.outlook.com (20.178.47.91) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.18; Mon, 8 Apr 2019 15:14:54 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Mon, 8 Apr 2019 15:14:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, Andrey Shinkevich
	<andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 1/3] block: include base when checking image chain for
	block allocation
Thread-Index: AQHU69CGPjowE3ZEGUaHKvWY/mymRaYyYOMAgAADG4A=
Date: Mon, 8 Apr 2019 15:14:54 +0000
Message-ID: <61c30faa-ef13-bcc8-7a98-097421b5c854@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ec4y1wv.fsf@maestria.local.igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0072.eurprd04.prod.outlook.com
	(2603:10a6:3:19::40) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190408181451334
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 063f3918-e132-4d5b-dc64-08d6bc34f423
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB4217; 
x-ms-traffictypediagnostic: DB7PR08MB4217:
x-microsoft-antispam-prvs: <DB7PR08MB421774C91F2064F38B08C22AC12C0@DB7PR08MB4217.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(5660300002)(6486002)(71200400001)(14454004)(76176011)(486006)(6512007)(97736004)(71190400001)(386003)(6506007)(107886003)(6436002)(102836004)(2616005)(4326008)(476003)(52116002)(6246003)(446003)(25786009)(105586002)(186003)(11346002)(8936002)(53936002)(26005)(54906003)(256004)(2501003)(99286004)(86362001)(110136005)(3846002)(68736007)(31686004)(2906002)(8676002)(66066001)(81156014)(305945005)(229853002)(478600001)(81166006)(7736002)(316002)(36756003)(2201001)(106356001)(31696002)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB4217;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8iEDrTE78dr2evaZ1KuPL/D1L4N69RUUaW9PG63CvhcVGl0R68s8MZvbKNhSH88QEkIlsmXSNFUrkgCU9cWub4WQHMsmOfaqCTXJAXFXRNusA5/cQt60sBHRZUBRCMHVCkwlWFfNCzNMrUXa7ycQoxbeGNW9QdzQoIqD36chxutkdhol6e6XUJDlmNuoY5DXRilGVTk3eAkhk2YqvcLDLW5ztKcsqMKpkzRJ1vW5MBy0EqeprOmzK2Ff7cykazN9To0NAzCbDFVcz3/7NIK8zlyapFxD4oZ7L7RYtttko5jY9FqcVGQTpKMmHjJIGOMnGH8dJlgAplD/8g4pC5gQX3LO60wOFaevK7ohcvS+pswlU0RniUdqlvZUoVGJw8ZkWK/tEeOQOz2oKjwTW6DQobQdarlnap8+i9+HI4VLz20=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <0479A4AD5F78FF42B1793E5B72E939D9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063f3918-e132-4d5b-dc64-08d6bc34f423
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 15:14:54.3428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4217
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe08::703
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408151454.8w830wSgvq2FzuMfM35R1UJrxihJ2BOYcffwkMMUVYA@z>

MDguMDQuMjAxOSAxODowMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIEZyaSAwNSBBcHIg
MjAxOSAwNjo1NjoxNyBQTSBDRVNULCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+ICtpbnQg
YmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoQmxvY2tEcml2ZXJTdGF0ZSAqdG9wLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpiYXNlLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IG9mZnNldCwgaW50NjRfdCBieXRlcywgaW50
NjRfdCAqcG51bSkNCj4+ICt7DQo+PiArICAgIHJldHVybiBiZHJ2X2RvX2lzX2FsbG9jYXRlZF9h
Ym92ZSh0b3AsIGJhc2UsIGZhbHNlLCBvZmZzZXQsIGJ5dGVzLCBwbnVtKTsNCj4+ICt9DQo+PiAr
DQo+PiAraW50IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlX2luY2x1c2l2ZShCbG9ja0RyaXZlclN0
YXRlICp0b3AsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9j
a0RyaXZlclN0YXRlICpiYXNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0ZXMsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90ICpwbnVtKQ0KPj4gK3sNCj4+ICsgICAgcmV0
dXJuIGJkcnZfZG9faXNfYWxsb2NhdGVkX2Fib3ZlKHRvcCwgYmFzZSwgdHJ1ZSwgb2Zmc2V0LCBi
eXRlcywgcG51bSk7DQo+PiArfQ0KPiANCj4gSW5zdGVhZCBvZiBoYXZpbmcgdGhlc2UgdHdvLCBp
c24ndCBpdCBzaW1wbGVyIHRvIGFkZCBhbiAnaW5jbHVkZV9iYXNlJw0KPiBwYXJhbWV0ZXIgdG8g
dGhlIG9yaWdpbmFsIGZ1bmN0aW9uPw0KPiANCj4gQW5vdGhlciBhbHRlcm5hdGl2ZSAoSSBoYXZl
bid0IGNoZWNrZWQgdGhpcyBvbmUgc28gaXQgY291bGQgYmUgbW9yZQ0KPiBjdW1iZXJzb21lKTog
Y2hhbmdlIHRoZSBzZW1hbnRpY3Mgb2YgdGhlIGZ1bmN0aW9uIHRvIGFsd2F5cyBpbmNsdWRlIHRo
ZQ0KPiBiYXNlIGFuZCBtb2RpZnkgdGhlIGNhbGxlcnMuDQo+IA0KDQpUaGUgaWRlYSB3YXMgZXhh
Y3RseSB0byBhdm9pZCBtb2RpZnlpbmcgYWxsIGNhbGxlcnMuLiBBbmQgaXQgc2VlbXMgZ29vZCwg
YXQgbGVhc3QgYXMgZmlyc3Qgc3RlcC4NCldlIG1heSB3YW50IHRvIG1vZGlmeSBvdGhlciBjYWxs
ZXJzIGJ1dCBpdCBpcyBvdXQgb2Ygc3RyZWFtIHNlcmllcy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K


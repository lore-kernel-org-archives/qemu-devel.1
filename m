Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E51C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721C82148E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SircMwMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721C82148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54721 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDW3i-0004KL-L5
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 11:19:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDW0l-0002a2-6p
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDW0e-0000ZW-6e
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:34 -0400
Received: from mail-eopbgr60139.outbound.protection.outlook.com
	([40.107.6.139]:48454
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDW0Y-0000Id-2W; Mon, 08 Apr 2019 11:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=zEFxmQyCDPIjDfzG9LF7RvhEsyZ9w/neSISTHWvQN5M=;
	b=SircMwMmd58FRdnAp8mAyBxRmzV2Nh+0RBeje21+62399N2nHN7BmAroaOGG3Mz/cfUPqso6RUxGt9mXCdJ5QYKcP5jb9ndnGGIL2RUQ5Y7KcroLGPY5CCT5oqXBXh3aLfMsoqiQiZQvkBS1c7KcWrV3kBqFYwwEqTH3c1X7qh8=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB3895.eurprd08.prod.outlook.com (20.178.91.20) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Mon, 8 Apr 2019 15:16:22 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 15:16:22 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 1/3] block: include base when checking image chain for
	block allocation
Thread-Index: AQHU69CGFpR0vRnjgEOtWNirAAI9w6YyYOMAgAADhQA=
Date: Mon, 8 Apr 2019 15:16:22 +0000
Message-ID: <3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ec4y1wv.fsf@maestria.local.igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0001.eurprd08.prod.outlook.com
	(2603:10a6:3:bd::11) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3a0b90-74d2-4d11-603d-08d6bc3528f9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3895; 
x-ms-traffictypediagnostic: AM6PR08MB3895:
x-microsoft-antispam-prvs: <AM6PR08MB3895F9CAEC5A7D7CF98FB54DF42C0@AM6PR08MB3895.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(366004)(396003)(39850400004)(376002)(43544003)(189003)(199004)(478600001)(186003)(2906002)(71200400001)(2501003)(26005)(86362001)(229853002)(71190400001)(31696002)(6486002)(14454004)(31686004)(6436002)(53936002)(36756003)(256004)(6116002)(3846002)(6512007)(11346002)(446003)(6506007)(66066001)(44832011)(25786009)(97736004)(107886003)(476003)(2201001)(316002)(53546011)(4326008)(52116002)(99286004)(54906003)(76176011)(5660300002)(7736002)(110136005)(106356001)(305945005)(2616005)(68736007)(102836004)(105586002)(8936002)(486006)(8676002)(81156014)(81166006)(6246003)(386003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3895;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6QvsTrCl2Y8WFk2qm1rBoCqSWaZ4QpWM6Bk3ce73CXKosrp64uT7lW8ceVHA7qteZw89u+uokQKAEI0zobnLoVCBVzXRWCsWMd6IPjGrn1n006pAAr7o3sGkHYOtHdYvZ+Vch+q8rizoKI/umXPd3CXWpzEvtpzSz9NzF7tWjtZEF60l28uFuhWIZDfhsCFv8PNAVyHMXY9l3IVgJxvJ0klJ/xsG6netTtHA5x7aAkjMwjz36DEq/xjplV+xAM0ZfHXNC8gtRDTp2PsIJa4/EfMHKVqCKWooO8UDxkcYXuoHOfpyFmQUS7skZZAdGkDPehz3IbsvpEhmadTXyHB5dPZJuuk4fjW6Il5xQ6gk6R0CC89MBQyw8lwSTlq7PmpWLoyWT8yPBbpOWZFAwuQCbqV8gppT9k/ts4eapVdFulU=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <E954B542076A6A409DB6571CB1407C61@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3a0b90-74d2-4d11-603d-08d6bc3528f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 15:16:22.8265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3895
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.139
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408151622.PDIdZKDRnO3NHn4zP1Aj4sKfW7AI-irBKKu7mHqkLGU@z>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MDMsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTcgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiAraW50IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0
ZXMsIGludDY0X3QgKnBudW0pDQo+PiArew0KPj4gKyAgICByZXR1cm4gYmRydl9kb19pc19hbGxv
Y2F0ZWRfYWJvdmUodG9wLCBiYXNlLCBmYWxzZSwgb2Zmc2V0LCBieXRlcywgcG51bSk7DQo+PiAr
fQ0KPj4gKw0KPj4gK2ludCBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZV9pbmNsdXNpdmUoQmxvY2tE
cml2ZXJTdGF0ZSAqdG9wLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludDY0X3Qgb2Zmc2V0LCBpbnQ2NF90IGJ5dGVzLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCAqcG51bSkNCj4+ICt7DQo+PiAr
ICAgIHJldHVybiBiZHJ2X2RvX2lzX2FsbG9jYXRlZF9hYm92ZSh0b3AsIGJhc2UsIHRydWUsIG9m
ZnNldCwgYnl0ZXMsIHBudW0pOw0KPj4gK30NCj4gDQo+IEluc3RlYWQgb2YgaGF2aW5nIHRoZXNl
IHR3bywgaXNuJ3QgaXQgc2ltcGxlciB0byBhZGQgYW4gJ2luY2x1ZGVfYmFzZScNCj4gcGFyYW1l
dGVyIHRvIHRoZSBvcmlnaW5hbCBmdW5jdGlvbj8NCj4gDQo+IEFub3RoZXIgYWx0ZXJuYXRpdmUg
KEkgaGF2ZW4ndCBjaGVja2VkIHRoaXMgb25lIHNvIGl0IGNvdWxkIGJlIG1vcmUNCj4gY3VtYmVy
c29tZSk6IGNoYW5nZSB0aGUgc2VtYW50aWNzIG9mIHRoZSBmdW5jdGlvbiB0byBhbHdheXMgaW5j
bHVkZSB0aGUNCj4gYmFzZSBhbmQgbW9kaWZ5IHRoZSBjYWxsZXJzLg0KPiANCj4gQmVydG8NCj4g
DQoNClRoZSBpZGVhIGJlaGluZCB0aG9zZSB0d28gZnVuY3Rpb25zIHdhcyB0byBrZWVwIHRoZSBy
ZXN0IG9mIHRoZSBjb2RlDQp1bm1vZGlmaWVkLiBDdXJyZW50bHksIHdlIGhhdmUgdGhlIGlzc3Vl
IHdpdGggdGhlIGJsb2NrLXN0cmVhbQ0KcGFyYWxsZWwgam9icy4gV2hhdCBpZiB3ZSBtYW5hZ2Ug
dGhpcyBjYXNlIGZpcnN0IGFuZCB0aGVuLCB3aGVuDQpwcm92ZWQgdG8gYmUgcm9idXN0LCB0YWtl
IGNhcmUgb2YgdGhlIHJlc3Q/DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBT
aGlua2V2aWNoDQo=


Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AF1C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58D620830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dXz+bahi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58D620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59335 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgmg-0003Qh-42
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:48:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNglj-0002wd-4O
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNgli-0000PZ-6d
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:47:11 -0400
Received: from mail-eopbgr120125.outbound.protection.outlook.com
	([40.107.12.125]:46854
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNglf-0000Mk-Tu; Mon, 06 May 2019 12:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ixk0OcbFvs3XPmreUhVEi+8V8Tbvr/RNGd6xCCBTl8o=;
	b=dXz+bahilgtNZQkDkymWTvMnVBEDmRm4h5ms/K6tCxkFa9R6bNVVXcoOv/C7YksropAdUcR2bACtQwP1PS6EX9o35BK1dWQLXhK5//Kx+B45yvdcU8qU+RBBhHT3xxX2cnD//BJIwIQW+El6coZ9UdrgIqwJljhCkwrudDbFs/g=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4923.eurprd08.prod.outlook.com (52.133.110.83) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Mon, 6 May 2019 16:47:04 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 16:47:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read, write}()
	with bdrv_{pread, pwrite}()
Thread-Index: AQHVAErQYNmfHrX4XUG7LuH1I77KcaZeVhIA
Date: Mon, 6 May 2019 16:47:04 +0000
Message-ID: <8bff27c1-a93c-d9f0-c95c-6d10d5700f91@virtuozzo.com>
References: <cover.1556732434.git.berto@igalia.com>
	<524e211cb818a20f521d6e271e782ab62b8e5e80.1556732434.git.berto@igalia.com>
In-Reply-To: <524e211cb818a20f521d6e271e782ab62b8e5e80.1556732434.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0241.eurprd05.prod.outlook.com
	(2603:10a6:3:fb::17) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506194702518
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2536f57-76a3-42b9-bcff-08d6d242783b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4923; 
x-ms-traffictypediagnostic: PR2PR08MB4923:
x-microsoft-antispam-prvs: <PR2PR08MB49230FA3F662F16CB4BFD325C1300@PR2PR08MB4923.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(346002)(366004)(39840400004)(376002)(199004)(189003)(2906002)(102836004)(99286004)(6506007)(386003)(5660300002)(66066001)(86362001)(486006)(2501003)(305945005)(52116002)(31696002)(6116002)(76176011)(3846002)(68736007)(14454004)(31686004)(6436002)(53936002)(7736002)(6486002)(25786009)(6246003)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(229853002)(478600001)(4326008)(186003)(316002)(256004)(36756003)(26005)(446003)(476003)(2616005)(54906003)(6512007)(71190400001)(110136005)(8936002)(11346002)(71200400001)(8676002)(81156014)(81166006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4923;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EA8s3I8WnvXPvLdTZOJvGqqurZHduw2zjfKNnRzGbpHPM419spAkSBxkqhwC9HjL+NXZBmkY+K9fualAJJqKEmVU7vaBI+s+XymwxqfnEJyLeCkNB38JjhdAPzQw0XaqLgRGRiWFsiZ8Q6wZPebZ0qLoxCWTGFTRdsE4HsZxAOhho3jwcaRE+dPWBre0YM3GBISuEJkbJQyN2BQPJRsDugX9X4Q0zAxYZwk6ILLFMIqZ4YQudgas4HnoUagqXGMIr4tShwmmi+5C7LmzEWmqVjMPKcSljHo43xbhWnJrGMHmKyAsEE2RKLs2fBA+C4/u2lxzYBYzC09+a3c72X9BcwTX6VIiNUkJLLBAbClXxUdzTEs8ShObysnx/XMgr9MyNTDSbJQRHyGBbNsq/3kWCZh5bI8atWJfcstVbxMCYw0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <306FC3A39314234FADB8595E9020725D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2536f57-76a3-42b9-bcff-08d6d242783b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:47:04.8761 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4923
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.125
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDUuMjAxOSAyMToxMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IFRoZXJlJ3Mgb25seSBh
IGNvdXBsZSBvZiBiZHJ2X3JlYWQoKSBhbmQgYmRydl93cml0ZSgpIGNhbGxzIGxlZnQgaW4NCj4g
dGhlIHZ2ZmF0IGNvZGUsIGFuZCB0aGV5IGNhbiBiZSB0cml2aWFsbHkgcmVwbGFjZWQgd2l0aCB0
aGUgYnl0ZS1iYXNlZA0KPiBiZHJ2X3ByZWFkKCkgYW5kIGJkcnZfcHdyaXRlKCkuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4gLS0tDQo+
ICAgYmxvY2svdnZmYXQuYyB8IDEyICsrKysrKystLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2sv
dnZmYXQuYyBiL2Jsb2NrL3Z2ZmF0LmMNCj4gaW5kZXggNWY2Njc4Nzg5MC4uMjUzY2M3MTZkZCAx
MDA2NDQNCj4gLS0tIGEvYmxvY2svdnZmYXQuYw0KPiArKysgYi9ibG9jay92dmZhdC5jDQo+IEBA
IC0xNDk0LDggKzE0OTQsOCBAQCBzdGF0aWMgaW50IHZ2ZmF0X3JlYWQoQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsIGludDY0X3Qgc2VjdG9yX251bSwNCj4gICAgICAgICAgICAgICAgICAgRExPRyhmcHJp
bnRmKHN0ZGVyciwgInNlY3RvcnMgJSIgUFJJZDY0ICIrJSIgUFJJZDY0DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiIGFsbG9jYXRlZFxuIiwgc2VjdG9yX251bSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG4gPj4gQkRSVl9TRUNUT1JfQklUUykpOw0KPiAtICAg
ICAgICAgICAgICAgIGlmIChiZHJ2X3JlYWQocy0+cWNvdywgc2VjdG9yX251bSwgYnVmICsgaSAq
IDB4MjAwLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbiA+PiBCRFJWX1NFQ1RP
Ul9CSVRTKSkgew0KPiArICAgICAgICAgICAgICAgIGlmIChiZHJ2X3ByZWFkKHMtPnFjb3csIHNl
Y3Rvcl9udW0gKiBCRFJWX1NFQ1RPUl9TSVpFLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJ1ZiArIGkgKiAweDIwMCwgbikgPCAwKSB7DQoNClNob3VsZG4ndCB3ZSB1c2UgUUVN
VV9BTElHTl9ET1dOKG4sIEJEUlZfU0VDVE9SX1NJWkUpID8NCkNvdWxkIGJkcnZfaXNfYWxsb2Nh
dGVkIGdpdmUgdW5hbGlnbmVkIG4/DQoNCj4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
MTsNCj4gICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgICBpICs9IChuID4+
IEJEUlZfU0VDVE9SX0JJVFMpIC0gMTsNCj4gQEAgLTE5ODMsOCArMTk4Myw5IEBAIHN0YXRpYyB1
aW50MzJfdCBnZXRfY2x1c3Rlcl9jb3VudF9mb3JfZGlyZW50cnkoQkRSVlZWRkFUU3RhdGUqIHMs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJlcykgew0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
fQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgcmVzID0gYmRydl93cml0ZShzLT5xY293LCBv
ZmZzZXQsIHMtPmNsdXN0ZXJfYnVmZmVyLCAxKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
IGlmIChyZXMpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHJlcyA9IGJkcnZfcHdyaXRl
KHMtPnFjb3csIG9mZnNldCAqIEJEUlZfU0VDVE9SX1NJWkUsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5jbHVzdGVyX2J1ZmZlciwgQkRSVl9TRUNUT1Jf
U0laRSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBpZiAocmVzIDwgMCkgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLTI7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiBAQCAtMzA1MCw3ICszMDUx
LDggQEAgRExPRyhjaGVja3BvaW50KCkpOw0KPiAgICAgICAgKiBVc2UgcWNvdyBiYWNrZW5kLiBD
b21taXQgbGF0ZXIuDQo+ICAgICAgICAqLw0KPiAgIERMT0coZnByaW50ZihzdGRlcnIsICJXcml0
ZSB0byBxY293IGJhY2tlbmQ6ICVkICsgJWRcbiIsIChpbnQpc2VjdG9yX251bSwgbmJfc2VjdG9y
cykpOw0KPiAtICAgIHJldCA9IGJkcnZfd3JpdGUocy0+cWNvdywgc2VjdG9yX251bSwgYnVmLCBu
Yl9zZWN0b3JzKTsNCj4gKyAgICByZXQgPSBiZHJ2X3B3cml0ZShzLT5xY293LCBzZWN0b3JfbnVt
ICogQkRSVl9TRUNUT1JfU0laRSwgYnVmLA0KPiArICAgICAgICAgICAgICAgICAgICAgIG5iX3Nl
Y3RvcnMgKiBCRFJWX1NFQ1RPUl9TSVpFKTsNCj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAg
ICAgICAgIGZwcmludGYoc3RkZXJyLCAiRXJyb3Igd3JpdGluZyB0byBxY293IGJhY2tlbmRcbiIp
Ow0KPiAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K


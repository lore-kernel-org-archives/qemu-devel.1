Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56E9C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A842620665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DhUNV7A3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A842620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3RO-0001iC-Sr
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:02:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hi3CW-0000VG-QJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hi3CS-0000f6-Tb
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:46:58 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:6561 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hi3CQ-0000cw-Pf; Mon, 01 Jul 2019 16:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhaEybfDhm8Srr/0VH9eJ9kVjJewuQ/Z1VjHlItkM1k=;
 b=DhUNV7A3Vj3JpbhIYF9p9pyoDrjBgfguJQGO/i3vh0OOr2baqF/VC8ujXy45Ck3HlfUv/K0Am2tvlPjBquESyuRUZFubYzJUESzjRgiObEkqjTwmP6CCm6DbqMSXozPn2UQ/akbrwDrQ8Yh5fUYWY/rqcjXVs1QQGtwsl0+cZ/M=
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com (52.134.111.155) by
 DB7PR08MB3834.eurprd08.prod.outlook.com (20.178.45.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 16:46:11 +0000
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf]) by DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf%3]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 16:46:11 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 1/5] block: Add BDS.never_freeze
Thread-Index: AQHVLThQbyChzmNjYk+4eSAnxd+X9qa1/oUA
Date: Mon, 1 Jul 2019 16:46:10 +0000
Message-ID: <5cb461e3-deb4-b852-1fe4-4eb3415b358d@virtuozzo.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-2-mreitz@redhat.com>
In-Reply-To: <20190627223255.3789-2-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0005.eurprd03.prod.outlook.com
 (2603:10a6:3:76::15) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:20::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41152d55-f843-4e3b-8a3e-08d6fe439f15
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB7PR08MB3834; 
x-ms-traffictypediagnostic: DB7PR08MB3834:
x-microsoft-antispam-prvs: <DB7PR08MB3834B00884D4FAB3F6A94D16F4F90@DB7PR08MB3834.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:222;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(199004)(189003)(53936002)(31686004)(14454004)(73956011)(66946007)(186003)(256004)(81166006)(6506007)(53546011)(8676002)(68736007)(52116002)(26005)(486006)(476003)(2616005)(11346002)(446003)(25786009)(66446008)(66066001)(2906002)(81156014)(66556008)(64756008)(386003)(6486002)(229853002)(4326008)(6512007)(6436002)(66476007)(498600001)(71200400001)(99286004)(86362001)(44832011)(305945005)(31696002)(7736002)(2501003)(6116002)(5660300002)(3846002)(76176011)(36756003)(6246003)(110136005)(54906003)(8936002)(102836004)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3834;
 H:DB7PR08MB3258.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pouYEqVDhUww2wJ4ADIBYNtCtcgl+KTv8g4EEifSzajeXJ3gzmoEtFbxOVEfDfVEIwjQCaKTyhN5m2Egoc+EWMWKUUl7FqLdRYpZwTndh5jfIx2T/etz73jkKI0JfSTostIQq5nfGZMMmODdBIxv6jAN0mlubMfrLkr8T/8I60BgK+3FfidGuqRajYLrAYIxq2oTfDtZSsD1zXONwLAA7h4bo7J2BjmaCGrYW5I98EeRaA+O9AkNKy/WAggX6plnA8ysB0cZVblB5jyK+JfOYOtKkktCChh9i5xDg2vpYYiF69yrDw7fzjHwXnmxnvF8+W+CtjoWXgVDPyQnfQ1DZ5q35fHaK4tsHLE3tg0B75nU5oG4ERR2ymIhViqOJikAPL16UJOqWG8i3toLXmRBYH8HPAw767m8nL+nYocZ7kw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B90ABBD8D570044A2138EC2651BAA4B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41152d55-f843-4e3b-8a3e-08d6fe439f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 16:46:11.0293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3834
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.139
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add BDS.never_freeze
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LzA2LzIwMTkgMDE6MzIsIE1heCBSZWl0eiB3cm90ZToNCj4gVGhlIGNvbW1pdCBh
bmQgdGhlIG1pcnJvciBibG9jayBqb2IgbXVzdCBiZSBhYmxlIHRvIGRyb3AgdGhlaXIgZmlsdGVy
DQo+IG5vZGUgYXQgYW55IHBvaW50LiAgSG93ZXZlciwgdGhpcyB3aWxsIG5vdCBiZSBwb3NzaWJs
ZSBpZiBhbnkgb2YgdGhlDQo+IEJkcnZDaGlsZCBsaW5rcyB0byB0aGVtIGlzIGZyb3plbi4gIFRo
ZXJlZm9yZSwgd2UgbmVlZCB0byBwcmV2ZW50IHRoZW0NCj4gZnJvbSBldmVyIGJlY29taW5nIGZy
b3plbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+
DQo+IC0tLQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggfCAzICsrKw0KPiAgIGJsb2Nr
LmMgICAgICAgICAgICAgICAgICAgfCA4ICsrKysrKysrDQo+ICAgYmxvY2svY29tbWl0LmMgICAg
ICAgICAgICB8IDQgKysrKw0KPiAgIGJsb2NrL21pcnJvci5jICAgICAgICAgICAgfCA0ICsrKysN
Cj4gICA0IGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oIGIvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaA0K
PiBpbmRleCBkNjQxNWI1M2MxLi41MDkwMjUzMWI3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Js
b2NrL2Jsb2NrX2ludC5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmgNCj4gQEAg
LTg4NSw2ICs4ODUsOSBAQCBzdHJ1Y3QgQmxvY2tEcml2ZXJTdGF0ZSB7DQo+ICAgDQo+ICAgICAg
IC8qIE9ubHkgcmVhZC93cml0dGVuIGJ5IHdob2V2ZXIgaGFzIHNldCBhY3RpdmVfZmx1c2hfcmVx
IHRvIHRydWUuICAqLw0KPiAgICAgICB1bnNpZ25lZCBpbnQgZmx1c2hlZF9nZW47ICAgICAgICAg
ICAgIC8qIEZsdXNoZWQgd3JpdGUgZ2VuZXJhdGlvbiAqLw0KPiArDQo+ICsgICAgLyogQmRydkNo
aWxkIGxpbmtzIHRvIHRoaXMgbm9kZSBtYXkgbmV2ZXIgYmUgZnJvemVuICovDQo+ICsgICAgYm9v
bCBuZXZlcl9mcmVlemU7DQo+ICAgfTsNCj4gICANCj4gICBzdHJ1Y3QgQmxvY2tCYWNrZW5kUm9v
dFN0YXRlIHsNCj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMgYi9ibG9jay5jDQo+IGluZGV4IGMxMzk1
NDBmMmIuLjY1NjUxOTJiOTEgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrLmMNCj4gKysrIGIvYmxvY2su
Yw0KPiBAQCAtNDQxNiw2ICs0NDE2LDE0IEBAIGludCBiZHJ2X2ZyZWV6ZV9iYWNraW5nX2NoYWlu
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCbG9ja0RyaXZlclN0YXRlICpiYXNlLA0KPiAgICAgICAg
ICAgcmV0dXJuIC1FUEVSTTsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAgIGZvciAoaSA9IGJzOyBp
ICE9IGJhc2U7IGkgPSBiYWNraW5nX2JzKGkpKSB7DQo+ICsgICAgICAgIGlmIChpLT5iYWNraW5n
ICYmIGJhY2tpbmdfYnMoaSktPm5ldmVyX2ZyZWV6ZSkgew0KPiArICAgICAgICAgICAgZXJyb3Jf
c2V0ZyhlcnJwLCAiQ2Fubm90IGZyZWV6ZSAnJXMnIGxpbmsgdG8gJyVzJyIsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGktPmJhY2tpbmctPm5hbWUsIGJhY2tpbmdfYnMoaSktPm5vZGVfbmFt
ZSk7DQo+ICsgICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0KPiArICAgICAgICB9DQo+ICsgICAg
fQ0KPiArDQo+ICAgICAgIGZvciAoaSA9IGJzOyBpICE9IGJhc2U7IGkgPSBiYWNraW5nX2JzKGkp
KSB7DQo+ICAgICAgICAgICBpZiAoaS0+YmFja2luZykgew0KPiAgICAgICAgICAgICAgIGktPmJh
Y2tpbmctPmZyb3plbiA9IHRydWU7DQo+IGRpZmYgLS1naXQgYS9ibG9jay9jb21taXQuYyBiL2Js
b2NrL2NvbW1pdC5jDQo+IGluZGV4IGNhN2U0MDhiMjYuLjJjNWE2ZDRlYmMgMTAwNjQ0DQo+IC0t
LSBhL2Jsb2NrL2NvbW1pdC5jDQo+ICsrKyBiL2Jsb2NrL2NvbW1pdC5jDQo+IEBAIC0yOTgsNiAr
Mjk4LDEwIEBAIHZvaWQgY29tbWl0X3N0YXJ0KGNvbnN0IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2
ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIGlmICghZmlsdGVyX25vZGVfbmFtZSkgew0KPiAgICAgICAg
ICAgY29tbWl0X3RvcF9icy0+aW1wbGljaXQgPSB0cnVlOw0KPiAgICAgICB9DQo+ICsNCj4gKyAg
ICAvKiBTbyB0aGF0IHdlIGNhbiBhbHdheXMgZHJvcCB0aGlzIG5vZGUgKi8NCj4gKyAgICBjb21t
aXRfdG9wX2JzLT5uZXZlcl9mcmVlemUgPSB0cnVlOw0KPiArDQo+ICAgICAgIGNvbW1pdF90b3Bf
YnMtPnRvdGFsX3NlY3RvcnMgPSB0b3AtPnRvdGFsX3NlY3RvcnM7DQo+ICAgDQo+ICAgICAgIGJk
cnZfYXBwZW5kKGNvbW1pdF90b3BfYnMsIHRvcCwgJmxvY2FsX2Vycik7DQo+IGRpZmYgLS1naXQg
YS9ibG9jay9taXJyb3IuYyBiL2Jsb2NrL21pcnJvci5jDQo+IGluZGV4IDJmY2VjNzBlMzUuLjhj
Yjc1ZmI0MDkgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL21pcnJvci5jDQo+ICsrKyBiL2Jsb2NrL21p
cnJvci5jDQo+IEBAIC0xNTUxLDYgKzE1NTEsMTAgQEAgc3RhdGljIEJsb2NrSm9iICptaXJyb3Jf
c3RhcnRfam9iKA0KPiAgICAgICBpZiAoIWZpbHRlcl9ub2RlX25hbWUpIHsNCj4gICAgICAgICAg
IG1pcnJvcl90b3BfYnMtPmltcGxpY2l0ID0gdHJ1ZTsNCj4gICAgICAgfQ0KPiArDQo+ICsgICAg
LyogU28gdGhhdCB3ZSBjYW4gYWx3YXlzIGRyb3AgdGhpcyBub2RlICovDQo+ICsgICAgbWlycm9y
X3RvcF9icy0+bmV2ZXJfZnJlZXplID0gdHJ1ZTsNCj4gKw0KPiAgICAgICBtaXJyb3JfdG9wX2Jz
LT50b3RhbF9zZWN0b3JzID0gYnMtPnRvdGFsX3NlY3RvcnM7DQo+ICAgICAgIG1pcnJvcl90b3Bf
YnMtPnN1cHBvcnRlZF93cml0ZV9mbGFncyA9IEJEUlZfUkVRX1dSSVRFX1VOQ0hBTkdFRDsNCj4g
ICAgICAgbWlycm9yX3RvcF9icy0+c3VwcG9ydGVkX3plcm9fZmxhZ3MgPSBCRFJWX1JFUV9XUklU
RV9VTkNIQU5HRUQgfA0KPiANCg0KUmV2aWV3ZWQtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRy
ZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMs
DQpBbmRyZXkgU2hpbmtldmljaA0K


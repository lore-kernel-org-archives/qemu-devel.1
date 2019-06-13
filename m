Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEEDC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BDEA20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="InpAlSSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDEA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPzK-00049H-CN
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOoS-00059R-6m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbOoP-0006HW-HS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:26:39 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:16558 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbOoM-0006E6-MJ; Thu, 13 Jun 2019 08:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5vwKilyVRSDdTVShFUmm45SsP54bGriA1AsCSls/kw=;
 b=InpAlSSF2+P69WtqBfzftZ6z5lFnMTY4Vy1bmllneadFHF9zXYWWLImiNu1L5kUu+gcILaB9QvCXiW7Vv9zFZu9YcztisF7DILn0la+Q/sbYUCDMRzFrJyRc4E1boaGUtSHM51FJiXVu6GM/mkBLo0jn9vZI8u1z3wYOb5HOsKw=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB2977.eurprd08.prod.outlook.com (52.134.124.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Thu, 13 Jun 2019 12:26:28 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 12:26:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 05/42] block: Add chain helper functions
Thread-Index: AQHVIWuh7B3h27XEKUev7jD0r+BxDKaZg5gA
Date: Thu, 13 Jun 2019 12:26:28 +0000
Message-ID: <6ef1a5a1-756a-7a48-f386-517c6f46e69b@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-6-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-6-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::33) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613152626846
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde4cff8-0cde-4716-79b3-08d6effa5c12
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB2977; 
x-ms-traffictypediagnostic: AM0PR08MB2977:
x-microsoft-antispam-prvs: <AM0PR08MB29774DBE4B88BC6C53C8D6C8C1EF0@AM0PR08MB2977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(31696002)(71190400001)(476003)(6116002)(73956011)(71200400001)(6506007)(6486002)(6246003)(66066001)(446003)(486006)(54906003)(5660300002)(2616005)(229853002)(11346002)(25786009)(110136005)(66946007)(4326008)(81156014)(2501003)(99286004)(8676002)(7736002)(14444005)(86362001)(316002)(81166006)(66556008)(8936002)(66476007)(66446008)(64756008)(305945005)(256004)(53936002)(14454004)(6436002)(52116002)(26005)(76176011)(102836004)(186003)(478600001)(3846002)(386003)(36756003)(68736007)(31686004)(2906002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB2977;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tBLs/DKiM9pG5Pssseih+aOOLkAZ5lp90QuX8eal4CHi4zd0E7pdv92biIOPx6wq+0kkgdWg3PT9//uOxdB7hZi4jP/KMH7JHEJwue0PtsE08gALrpetj8CYm9HUSaTgGOWVWeiYn2tsm190kQbNNshQG1c+ghx2yNGUiFVyO89f6iKFMDq3Jxww1m4lteklMiyarNusUrdcWC+tyLktomSMvNR4Z4+CRVpXSs9hPAnmIQU3CmZtcfeYkh07My6kA7wAToFZP770zRGnC9FuAM7uHGR1qqNF5ThctVTNn3HyiXuTztMJP02704uS/YJxEjJF+CPrAABEdIhD06Jj0BLbMSB0nWdLPpC/z2NZn7pId0buK543pgm/DnYeo0GQ3mspgtjGmIxSbT2eEKMX386asXPF9dWcXEz3u/OZO70=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6536C9A062B6F4398AAA0AD49B02B5E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde4cff8-0cde-4716-79b3-08d6effa5c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:26:28.7379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.94
Subject: Re: [Qemu-devel] [PATCH v5 05/42] block: Add chain helper functions
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IEFkZCBzb21lIGhlbHBlciBmdW5j
dGlvbnMgZm9yIHNraXBwaW5nIGZpbHRlcnMgaW4gYSBjaGFpbiBvZiBibG9jaw0KPiBub2Rlcy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0t
LQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggfCAgMyArKysNCj4gICBibG9jay5jICAg
ICAgICAgICAgICAgICAgIHwgNTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50
LmgNCj4gaW5kZXggN2NlNzE2MjNmOC4uODc1YTMzZjI1NSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ibG9jay9ibG9ja19pbnQuaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+
IEBAIC0xMjY0LDYgKzEyNjQsOSBAQCBCZHJ2Q2hpbGQgKmJkcnZfZmlsdGVyZWRfY2hpbGQoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiAgIEJkcnZDaGlsZCAqYmRydl9tZXRhZGF0YV9jaGlsZChC
bG9ja0RyaXZlclN0YXRlICpicyk7DQo+ICAgQmRydkNoaWxkICpiZHJ2X3N0b3JhZ2VfY2hpbGQo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiAgIEJkcnZDaGlsZCAqYmRydl9wcmltYXJ5X2NoaWxk
KEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4gK0Jsb2NrRHJpdmVyU3RhdGUgKmJkcnZfc2tpcF9p
bXBsaWNpdF9maWx0ZXJzKEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4gK0Jsb2NrRHJpdmVyU3Rh
dGUgKmJkcnZfc2tpcF9yd19maWx0ZXJzKEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4gK0Jsb2Nr
RHJpdmVyU3RhdGUgKmJkcnZfYmFja2luZ19jaGFpbl9uZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJz
KTsNCj4gICANCj4gICBzdGF0aWMgaW5saW5lIEJsb2NrRHJpdmVyU3RhdGUgKmNoaWxkX2JzKEJk
cnZDaGlsZCAqY2hpbGQpDQo+ICAgew0KPiBkaWZmIC0tZ2l0IGEvYmxvY2suYyBiL2Jsb2NrLmMN
Cj4gaW5kZXggNzI0ZDg4ODlhNi4uYmUxODEzMDk0NCAxMDA2NDQNCj4gLS0tIGEvYmxvY2suYw0K
PiArKysgYi9ibG9jay5jDQo+IEBAIC02NDk0LDMgKzY0OTQsNTggQEAgQmRydkNoaWxkICpiZHJ2
X3ByaW1hcnlfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAgew0KPiAgICAgICByZXR1
cm4gYmRydl9maWx0ZXJlZF9yd19jaGlsZChicykgPzogYnMtPmZpbGU7DQo+ICAgfQ0KPiArDQo+
ICtzdGF0aWMgQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9za2lwX2ZpbHRlcnMoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Ym9vbCBzdG9wX29uX2V4cGxpY2l0X2ZpbHRlcikNCj4gK3sNCj4gKyAgICBCZHJ2Q2hpbGQgKmZp
bHRlcmVkOw0KPiArDQo+ICsgICAgaWYgKCFicykgew0KPiArICAgICAgICByZXR1cm4gTlVMTDsN
Cj4gKyAgICB9DQo+ICsNCj4gKyAgICB3aGlsZSAoIShzdG9wX29uX2V4cGxpY2l0X2ZpbHRlciAm
JiAhYnMtPmltcGxpY2l0KSkgew0KPiArICAgICAgICBmaWx0ZXJlZCA9IGJkcnZfZmlsdGVyZWRf
cndfY2hpbGQoYnMpOw0KPiArICAgICAgICBpZiAoIWZpbHRlcmVkKSB7DQo+ICsgICAgICAgICAg
ICBicmVhazsNCj4gKyAgICAgICAgfQ0KPiArICAgICAgICBicyA9IGZpbHRlcmVkLT5iczsNCj4g
KyAgICB9DQo+ICsgICAgLyoNCj4gKyAgICAgKiBOb3RlIHRoYXQgdGhpcyB0cmVhdHMgbm9kZXMg
d2l0aCBicy0+ZHJ2ID09IE5VTEwNCg0KYXMgd2VsbCBhcyBmaWx0ZXJzIHdpdGhvdXQgZmlsdGVy
ZWRfcncgY2hpbGQNCg0KICBhcyBub3QgYmVpbmcNCj4gKyAgICAgKiBSL1cgZmlsdGVycyAoYnMt
PmRydiA9PSBOVUxMIHNob3VsZCBiZSByZXBsYWNlZCBieSBzb21ldGhpbmcNCj4gKyAgICAgKiBl
bHNlIGFueXdheSkuDQo+ICsgICAgICogVGhlIGFkdmFudGFnZSBvZiB0aGlzIGJlaGF2aW9yIGlz
IHRoYXQgdGhpcyBmdW5jdGlvbiB3aWxsIHRodXMNCj4gKyAgICAgKiBhbHdheXMgcmV0dXJuIGEg
bm9uLU5VTEwgdmFsdWUgKGdpdmVuIGEgbm9uLU5VTEwgQGJzKS4NCg0KYW5kIHRoaXMgaXMgdGhl
IGFkdmFudGFnZSBvZiB3aGF0IEkndmUgd3JpdHRlbiwgbm90IGFib3V0IGJzLT5kcnYuDQoNCj4g
KyAgICAgKi8NCj4gKw0KPiArICAgIHJldHVybiBiczsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAq
IFJldHVybiB0aGUgZmlyc3QgQkRTIHRoYXQgaGFzIG5vdCBiZWVuIGFkZGVkIGltcGxpY2l0bHkg
b3IgdGhhdA0KPiArICogZG9lcyBub3QgaGF2ZSBhbiBSVy1maWx0ZXJlZCBjaGlsZCBkb3duIHRo
ZSBjaGFpbiBzdGFydGluZyBmcm9tIEBicw0KPiArICogKGluY2x1ZGluZyBAYnMgaXRzZWxmKS4N
Cj4gKyAqLw0KPiArQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICt7DQo+ICsgICAgcmV0dXJuIGJkcnZfc2tpcF9maWx0
ZXJzKGJzLCB0cnVlKTsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIFJldHVybiB0aGUgZmlyc3Qg
QkRTIHRoYXQgZG9lcyBub3QgaGF2ZSBhbiBSVy1maWx0ZXJlZCBjaGlsZCBkb3duDQo+ICsgKiB0
aGUgY2hhaW4gc3RhcnRpbmcgZnJvbSBAYnMgKGluY2x1ZGluZyBAYnMgaXRzZWxmKS4NCj4gKyAq
Lw0KPiArQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9za2lwX3J3X2ZpbHRlcnMoQmxvY2tEcml2ZXJT
dGF0ZSAqYnMpDQo+ICt7DQo+ICsgICAgcmV0dXJuIGJkcnZfc2tpcF9maWx0ZXJzKGJzLCBmYWxz
ZSk7DQo+ICt9DQo+ICsNCj4gKy8qDQo+ICsgKiBGb3IgYSBiYWNraW5nIGNoYWluLCByZXR1cm4g
dGhlIGZpcnN0IG5vbi1maWx0ZXIgYmFja2luZyBpbWFnZSBvZg0KPiArICogdGhlIGZpcnN0IG5v
bi1maWx0ZXIgaW1hZ2UuDQo+ICsgKi8NCj4gK0Jsb2NrRHJpdmVyU3RhdGUgKmJkcnZfYmFja2lu
Z19jaGFpbl9uZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiArew0KPiArICAgIHJldHVybiBi
ZHJ2X3NraXBfcndfZmlsdGVycyhiZHJ2X2ZpbHRlcmVkX2Nvd19icyhiZHJ2X3NraXBfcndfZmls
dGVycyhicykpKTsNCj4gK30NCj4gDQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K


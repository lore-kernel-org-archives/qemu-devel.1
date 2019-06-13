Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA60C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82BA20679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZRU0k3NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82BA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQKt-0003Fc-Qi
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbP0w-0006m7-VZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbP0u-0006qe-KJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:39:34 -0400
Received: from mail-eopbgr130108.outbound.protection.outlook.com
 ([40.107.13.108]:24754 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbP0u-0006pF-C1; Thu, 13 Jun 2019 08:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEmdLPQSNhoiWy9M7sFT9Nggje2Hg1hlwEtTU/AVYOg=;
 b=ZRU0k3NTWSMKXqrzYER7SVSf79+9h87TWtOD1gTonqplJ1qipoLW7601YTNTKs1AiBDefd3Gzro46NeXDbIUUAYskBATnIu178WxRzNmcw9cBDhCVw8pZQioZCc0aTw+UjMNFSb3ldCFG2qxUElfzBF0fFPM7laS0JPWilViryU=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3587.eurprd08.prod.outlook.com (20.177.110.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 12:39:29 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 12:39:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 05/42] block: Add chain helper functions
Thread-Index: AQHVIWuh7B3h27XEKUev7jD0r+BxDKaZteMA///PyQCAAAGPgA==
Date: Thu, 13 Jun 2019 12:39:29 +0000
Message-ID: <3bd28165-f90d-3c64-f5f7-10f9cd35f6c6@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-6-mreitz@redhat.com>
 <6ef1a5a1-756a-7a48-f386-517c6f46e69b@virtuozzo.com>
 <2d0d8641-e404-3f0c-893e-88ac8f59f8ed@redhat.com>
In-Reply-To: <2d0d8641-e404-3f0c-893e-88ac8f59f8ed@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0056.eurprd09.prod.outlook.com
 (2603:10a6:3:45::24) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613153927476
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdda7421-a835-4116-df28-08d6effc2d50
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3587; 
x-ms-traffictypediagnostic: AM0PR08MB3587:
x-microsoft-antispam-prvs: <AM0PR08MB3587DAA93519A162A0D06BC4C1EF0@AM0PR08MB3587.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(136003)(39850400004)(366004)(189003)(199004)(186003)(31686004)(36756003)(229853002)(486006)(5660300002)(6512007)(6436002)(8936002)(81156014)(81166006)(6486002)(7736002)(2616005)(476003)(305945005)(8676002)(25786009)(446003)(11346002)(53936002)(76176011)(52116002)(2501003)(102836004)(478600001)(66946007)(6506007)(53546011)(73956011)(386003)(64756008)(86362001)(54906003)(66476007)(66446008)(31696002)(68736007)(26005)(66066001)(110136005)(316002)(14454004)(99286004)(14444005)(256004)(71200400001)(71190400001)(3846002)(4326008)(66556008)(6116002)(2906002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3587;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ko8xxj3O5YPcQitGSMRKE3WmagFsqd2uZ8A6QDDWKbD58tayA5Z4X7Apb9Qm4XNfHOqhfueTDciFN9R/2ngMPZ7JJ4qHfv/GB9ryKXqMPZM9fqoRKS6N3pFLNcdBYRsNkEjViXwIVCh5um0GrebDUCGzmSriqxeWgicTjAeL5s3nAohZzRBaySH/Gze5ucGTmGrXRfEIX3Kan9Pequa+avsx4Rpl+gcgEspd4630E+f1wo29ECj7BD7ZYxvD9++Xmelzzx0JiNAo5irnKXIDIm70Qu91iwmvaE3NxbNleeVghxQKpZjG6c8eyxUUdATr1Q0npWpDmUZyXLcTphlwt5Q4R6nwGwkRrVIDuRq/nKCP0pglWaNfqELdF1dEwJkk4+jPeFCwDk4S/JKtRt5C/CtRDrveEE61BMNiO1TDmHI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <146D52BBDDCC2147B8762DEDF60CC405@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdda7421-a835-4116-df28-08d6effc2d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:39:29.2824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3587
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.108
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

MTMuMDYuMjAxOSAxNTozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wNi4xOSAxNDoyNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IEFkZCBzb21lIGhlbHBlciBmdW5jdGlvbnMgZm9yIHNraXBw
aW5nIGZpbHRlcnMgaW4gYSBjaGFpbiBvZiBibG9jaw0KPj4+IG5vZGVzLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiAg
ICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oIHwgIDMgKysrDQo+Pj4gICAgYmxvY2suYyAgICAg
ICAgICAgICAgICAgICB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggYi9pbmNsdWRlL2Jsb2NrL2Jsb2Nr
X2ludC5oDQo+Pj4gaW5kZXggN2NlNzE2MjNmOC4uODc1YTMzZjI1NSAxMDA2NDQNCj4+PiAtLS0g
YS9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+Pj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9j
a19pbnQuaA0KPj4+IEBAIC0xMjY0LDYgKzEyNjQsOSBAQCBCZHJ2Q2hpbGQgKmJkcnZfZmlsdGVy
ZWRfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPj4+ICAgIEJkcnZDaGlsZCAqYmRydl9t
ZXRhZGF0YV9jaGlsZChCbG9ja0RyaXZlclN0YXRlICpicyk7DQo+Pj4gICAgQmRydkNoaWxkICpi
ZHJ2X3N0b3JhZ2VfY2hpbGQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPj4+ICAgIEJkcnZDaGls
ZCAqYmRydl9wcmltYXJ5X2NoaWxkKEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4+PiArQmxvY2tE
cml2ZXJTdGF0ZSAqYmRydl9za2lwX2ltcGxpY2l0X2ZpbHRlcnMoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMpOw0KPj4+ICtCbG9ja0RyaXZlclN0YXRlICpiZHJ2X3NraXBfcndfZmlsdGVycyhCbG9ja0Ry
aXZlclN0YXRlICpicyk7DQo+Pj4gK0Jsb2NrRHJpdmVyU3RhdGUgKmJkcnZfYmFja2luZ19jaGFp
bl9uZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4+PiAgICANCj4+PiAgICBzdGF0aWMgaW5s
aW5lIEJsb2NrRHJpdmVyU3RhdGUgKmNoaWxkX2JzKEJkcnZDaGlsZCAqY2hpbGQpDQo+Pj4gICAg
ew0KPj4+IGRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPj4+IGluZGV4IDcyNGQ4ODg5
YTYuLmJlMTgxMzA5NDQgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2suYw0KPj4+ICsrKyBiL2Jsb2Nr
LmMNCj4+PiBAQCAtNjQ5NCwzICs2NDk0LDU4IEBAIEJkcnZDaGlsZCAqYmRydl9wcmltYXJ5X2No
aWxkKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPj4+ICAgIHsNCj4+PiAgICAgICAgcmV0dXJuIGJk
cnZfZmlsdGVyZWRfcndfY2hpbGQoYnMpID86IGJzLT5maWxlOw0KPj4+ICAgIH0NCj4+PiArDQo+
Pj4gK3N0YXRpYyBCbG9ja0RyaXZlclN0YXRlICpiZHJ2X3NraXBfZmlsdGVycyhCbG9ja0RyaXZl
clN0YXRlICpicywNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgc3RvcF9vbl9leHBsaWNpdF9maWx0ZXIpDQo+Pj4gK3sNCj4+PiArICAgIEJkcnZD
aGlsZCAqZmlsdGVyZWQ7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKCFicykgew0KPj4+ICsgICAgICAg
IHJldHVybiBOVUxMOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIHdoaWxlICghKHN0b3Bf
b25fZXhwbGljaXRfZmlsdGVyICYmICFicy0+aW1wbGljaXQpKSB7DQo+Pj4gKyAgICAgICAgZmls
dGVyZWQgPSBiZHJ2X2ZpbHRlcmVkX3J3X2NoaWxkKGJzKTsNCj4+PiArICAgICAgICBpZiAoIWZp
bHRlcmVkKSB7DQo+Pj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4+ICsgICAgICAgIH0NCj4+PiAr
ICAgICAgICBicyA9IGZpbHRlcmVkLT5iczsNCj4+PiArICAgIH0NCj4+PiArICAgIC8qDQo+Pj4g
KyAgICAgKiBOb3RlIHRoYXQgdGhpcyB0cmVhdHMgbm9kZXMgd2l0aCBicy0+ZHJ2ID09IE5VTEwN
Cj4+DQo+PiBhcyB3ZWxsIGFzIGZpbHRlcnMgd2l0aG91dCBmaWx0ZXJlZF9ydyBjaGlsZA0KPiAN
Cj4gQSBmaWx0ZXIgYWx3YXlzIG11c3QgaGF2ZSBhIGZpbHRlcmVkX3J3IGNoaWxkLCB0aG91Z2gu
ICBTbyBJIGRvbuKAmXQgcXVpdGUNCj4gdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGhlcmUuLi4N
Cj4gDQo+IE1heA0KPiANCj4+ICAgIGFzIG5vdCBiZWluZw0KPj4+ICsgICAgICogUi9XIGZpbHRl
cnMgKGJzLT5kcnYgPT0gTlVMTCBzaG91bGQgYmUgcmVwbGFjZWQgYnkgc29tZXRoaW5nDQo+Pj4g
KyAgICAgKiBlbHNlIGFueXdheSkuDQo+Pj4gKyAgICAgKiBUaGUgYWR2YW50YWdlIG9mIHRoaXMg
YmVoYXZpb3IgaXMgdGhhdCB0aGlzIGZ1bmN0aW9uIHdpbGwgdGh1cw0KPj4+ICsgICAgICogYWx3
YXlzIHJldHVybiBhIG5vbi1OVUxMIHZhbHVlIChnaXZlbiBhIG5vbi1OVUxMIEBicykuDQo+Pg0K
Pj4gYW5kIHRoaXMgaXMgdGhlIGFkdmFudGFnZSBvZiB3aGF0IEkndmUgd3JpdHRlbiwgbm90IGFi
b3V0IGJzLT5kcnYuDQoNCkkgbWVhbiwgdGhhdCBhZHZhbnRhZ2Ugc2VlbXMgdW5yZWxhdGVkIHRv
IHRoZSByZWFzb24gYWJvdXQgYnMtPmRydiA9PSBOVUxMLA0KYXMgZXZlbiB3aXRoIGJzLT5kcnYg
PT0gTlVMTCB3ZSBjYW4gZ28gdG8gYnMtPmJhY2tpbmcgb3IgYnMtPmZpbGUuLg0KDQpCdXQgSSBk
b24ndCAgcmVhbGx5IGNhcmUsIG15IHItYiBzdGF5cyBoZXJlIGFueXdheQ0KDQo+Pg0KPj4+ICsg
ICAgICovDQo+Pj4gKw0KPj4+ICsgICAgcmV0dXJuIGJzOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICsv
Kg0KPj4+ICsgKiBSZXR1cm4gdGhlIGZpcnN0IEJEUyB0aGF0IGhhcyBub3QgYmVlbiBhZGRlZCBp
bXBsaWNpdGx5IG9yIHRoYXQNCj4+PiArICogZG9lcyBub3QgaGF2ZSBhbiBSVy1maWx0ZXJlZCBj
aGlsZCBkb3duIHRoZSBjaGFpbiBzdGFydGluZyBmcm9tIEBicw0KPj4+ICsgKiAoaW5jbHVkaW5n
IEBicyBpdHNlbGYpLg0KPj4+ICsgKi8NCj4+PiArQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9za2lw
X2ltcGxpY2l0X2ZpbHRlcnMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4gK3sNCj4+PiArICAg
IHJldHVybiBiZHJ2X3NraXBfZmlsdGVycyhicywgdHJ1ZSk7DQo+Pj4gK30NCj4+PiArDQo+Pj4g
Ky8qDQo+Pj4gKyAqIFJldHVybiB0aGUgZmlyc3QgQkRTIHRoYXQgZG9lcyBub3QgaGF2ZSBhbiBS
Vy1maWx0ZXJlZCBjaGlsZCBkb3duDQo+Pj4gKyAqIHRoZSBjaGFpbiBzdGFydGluZyBmcm9tIEBi
cyAoaW5jbHVkaW5nIEBicyBpdHNlbGYpLg0KPj4+ICsgKi8NCj4+PiArQmxvY2tEcml2ZXJTdGF0
ZSAqYmRydl9za2lwX3J3X2ZpbHRlcnMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4gK3sNCj4+
PiArICAgIHJldHVybiBiZHJ2X3NraXBfZmlsdGVycyhicywgZmFsc2UpOw0KPj4+ICt9DQo+Pj4g
Kw0KPj4+ICsvKg0KPj4+ICsgKiBGb3IgYSBiYWNraW5nIGNoYWluLCByZXR1cm4gdGhlIGZpcnN0
IG5vbi1maWx0ZXIgYmFja2luZyBpbWFnZSBvZg0KPj4+ICsgKiB0aGUgZmlyc3Qgbm9uLWZpbHRl
ciBpbWFnZS4NCj4+PiArICovDQo+Pj4gK0Jsb2NrRHJpdmVyU3RhdGUgKmJkcnZfYmFja2luZ19j
aGFpbl9uZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPj4+ICt7DQo+Pj4gKyAgICByZXR1cm4g
YmRydl9za2lwX3J3X2ZpbHRlcnMoYmRydl9maWx0ZXJlZF9jb3dfYnMoYmRydl9za2lwX3J3X2Zp
bHRlcnMoYnMpKSk7DQo+Pj4gK30NCj4+Pg0KPj4NCj4+DQo+PiBSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4NCj4g
DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


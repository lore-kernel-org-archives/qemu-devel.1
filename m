Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06059C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2ED2588F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JG4ZCSQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2ED2588F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJez-0004U6-Tb
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:55:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWJeA-00045Z-FN
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWJe7-0005Eh-HV
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:55:01 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com
	([40.107.1.119]:14337
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWJdx-0004Jy-Bi; Thu, 30 May 2019 07:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=R13ckOdXD+sFg9Gr+unP23LfzoE9wcKghITSU81bRwI=;
	b=JG4ZCSQUmpXYeVUVzRs8GD4LVk1TQqsHdB2QR22dXuRdDycN2aXtFS5uWHisUdWlfGn9hHJdoRZjsSrzJa9CdmZA8PFdKEC5TRyUIpHFQkSBXrvff9oapqx2U34g4MzTkfyWnfqTGQ819H7dSa028gxu+4wcoZ41j1OQ/xChYac=
Received: from DB7PR08MB2972.eurprd08.prod.outlook.com (52.134.109.150) by
	DB7PR08MB3433.eurprd08.prod.outlook.com (20.176.238.142) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.17; Thu, 30 May 2019 11:54:44 +0000
Received: from DB7PR08MB2972.eurprd08.prod.outlook.com
	([fe80::e5eb:4576:5a22:7f82]) by
	DB7PR08MB2972.eurprd08.prod.outlook.com
	([fe80::e5eb:4576:5a22:7f82%7]) with mapi id 15.20.1943.016;
	Thu, 30 May 2019 11:54:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
	reopening logic
Thread-Index: AQHVEX7kb+YUVuiEF0SEYwFufr/zvqaBNhAAgACjxgCAAJZXAIABIQwAgAAItIA=
Date: Thu, 30 May 2019 11:54:43 +0000
Message-ID: <b516aeb7-4da8-131f-7320-042fd54b4778@virtuozzo.com>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
	<20190523154733.54944-4-vsementsov@virtuozzo.com>
	<c63d4dae-6fa5-a47f-9aca-791f36963262@redhat.com>
	<a00207af-97f3-fd24-90a5-2860473ace17@virtuozzo.com>
	<50d29692-51df-3880-58d0-e151deae7471@redhat.com>
	<3c695d7d-0ae1-a96c-17f8-0c1c72466122@virtuozzo.com>
In-Reply-To: <3c695d7d-0ae1-a96c-17f8-0c1c72466122@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0013.eurprd02.prod.outlook.com
	(2603:10a6:3:8c::23) To DB7PR08MB2972.eurprd08.prod.outlook.com
	(2603:10a6:5:1c::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190530145439680
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b32c211e-b198-438e-c58a-08d6e4f599e3
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DB7PR08MB3433; 
x-ms-traffictypediagnostic: DB7PR08MB3433:
x-microsoft-antispam-prvs: <DB7PR08MB343372248BC975E7E8255E0BC1180@DB7PR08MB3433.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39850400004)(199004)(189003)(99286004)(486006)(5024004)(66446008)(476003)(110136005)(305945005)(386003)(54906003)(25786009)(66066001)(11346002)(2616005)(6506007)(52116002)(6116002)(4326008)(6512007)(102836004)(229853002)(66476007)(256004)(8936002)(6246003)(3846002)(6486002)(2501003)(26005)(76176011)(446003)(7736002)(8676002)(107886003)(71200400001)(73956011)(81166006)(71190400001)(64756008)(186003)(66946007)(81156014)(53936002)(68736007)(66556008)(86362001)(478600001)(2201001)(2906002)(14454004)(6436002)(5660300002)(36756003)(316002)(31696002)(31686004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3433;
	H:DB7PR08MB2972.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fx00XealFpLxMZOs38LOKquRk+Rt9N8l0asAH1RxqqMZiL8kL/y9MoGsiF+XsHJ/Ct4c17NgFzL3pE/iDactSYXpZql3nW0kIP6/0nVy7Vzy6uXsF3IUVgWYsFpulYQTlEgivgnpBTTjTjqkZJgpatH4d8w6kaHtAOOzEHp2bk6ZQjrjHIIiC4Mpl5IeZvUMsvJq/e0z1sTiQuQlBq0RRGA9UbSYTdmCsnO4LMvRgOqKgIm+NFw8+jAFArlDWV8SlvXiM/DXQOzB34v7e1tsPep6l4YFbFIXJ3jjziu14s454VRQC4AtyaLt1EAd8gFQ7jU/dUP1n99sWGAN4CcVY18kkrHhgX4ydDxEo4WBpDxJF5vfQgTZJw0HQwJOnFfBRDiX6pOLZmM092pTGIA3sf0IFbTOx1VIfDR5x4GcBh8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <994EBB9CC5E3A841B65D938F60BC3DE3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32c211e-b198-438e-c58a-08d6e4f599e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 11:54:44.6629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3433
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.119
Subject: Re: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
 reopening logic
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
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDUuMjAxOSAxMToyMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjkuMDUuMjAxOSAyMTowOCwgSm9obiBTbm93IHdyb3RlOg0KPj4gTWF4IGhhcyBwaWNrZWQgdGhp
cyB0aHJlYWQgdXAgZm9yIGJsb2NrIGRpc2N1c3Npb24sIHNvIEknbSBnb2luZyB0bw0KPj4gc3Rp
Y2sgdG8gc2xpZ2h0bHkgbW9yZSBiaXRtYXAgcmVsYXRlZCBkaXNjdXNzaW9uIGhlcmU7IHdlJ2xs
IHJlc3VtZQ0KPj4gYmxvY2sgZGlzY3Vzc2lvbiBpbiB0aGUgb3RoZXIgdGFpbCBvZiB0aGlzIHRo
cmVhZC4NCj4+DQoNCg0KWy4uXQ0KDQo+Pj4+IEFuZCB3ZSBtYXJrIGl0IGFzIGluY29uc2lzdGVu
dCBiZWNhdXNlIHdlJ3JlIG5vdCBzdXJlIGhvdyB3ZSBtaXNzZWQgaXQNCj4+Pj4gZWFybGllci4g
T0suDQo+Pj4+DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAoIWJkcnZfZGlydHlfYml0bWFwX3Jl
YWRvbmx5KGJpdG1hcCkpIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29ycnVwdGlvbiA9DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgIkNvcnJ1cHRpb246IGJpdG1hcCAnJXMnIGlzIG5vdCBtYXJrZWQgSU5fVVNFIGluIHRoZSAi
DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImltYWdlICcl
cycgYW5kIG5vdCBtYXJrZWQgcmVhZG9ubHkgaW4gUkFNLiBXaWxsIHRyeSB0byAiDQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInNldCBJTl9VU0UgZmxhZy4i
Ow0KPj4+Pj4gKw0KPj4+Pg0KPj4+PiBBbmQgaW4gdGhpcyBjYXNlLCB3ZSBmaW5kIHRoZSBiaXRt
YXAgYnV0IGl0J3Mgbm90IG1hcmtlZCByZWFkb25seSBmb3INCj4+Pj4gc29tZSByZWFzb24uDQo+
Pj4+DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJkcnZfZGlydHlfYml0
bWFwX3NldF9yZWFkb25seShiaXRtYXAsIHRydWUpOw0KPj4+Pg0KPj4+PiBXaHkgc2V0IGl0IHJl
YWRvbmx5IGFnYWluPw0KPj4+DQo+Pj4gSXQgaXMgYmVjYXVzZSBpbmNvbnNpc3RhbmNlIGlzIG5v
dCBzeW5jZWQgdG8gdGhlIGltYWdlLiAicmVhZG9ubHkiIGV4YWN0bHkNCj4+PiBtZWFucywgdGhh
dCBmb3Igc29tZSByZWFzb25zIHdlIGRpZCBub3QgbWFya2VkIGJpdG1hcCBJTl9VU0UgaW4gdGhl
IGltYWdlIGFuZA0KPj4+IHRoZXJlZm9yZSBtdXN0IG5vdCB3cml0ZSB0byBpdC4NCj4+Pg0KPj4N
Cj4+IFRoYXQncyBvbmUgd2F5IG9mIGxvb2tpbmcgYXQgd2hhdCByZWFkb25seSBtZWFucy4gQW5v
dGhlciB3YXM6ICJUaGUNCj4+IGltYWdlIHRoaXMgYml0bWFwIGlzIGF0dGFjaGVkIHRvIGlzIHJl
YWQgb25seSwgYW5kIGFueSB3cml0ZXMgdG8gdGhpcw0KPj4gYml0bWFwIGFyZSBhIGxvZ2lzdGlj
YWwgZXJyb3IuIg0KPj4NCj4+PiBTbywgeWVzLCBoZXJlIG9jY3VycyBuZXcgdGhpbmc6IHJlYWRv
bmx5LWluY29uc2lzdGVudCBiaXRtYXAuIEl0IGJsb2NrcyBndWVzdA0KPj4+IHdyaXRlcyB1bnRp
bCB3ZSBzeW5jIGl0IHNvbWVob3cgdG8gdGhlIGltYWdlIG9yIHJlbW92ZS4gQW5kIHdlIGFyZSBn
b2luZyB0byBzeW5jDQo+Pj4gaXQgYXQgdGhlIGVuZCBvZiB0aGlzIGZ1bmN0aW9uLg0KPj4+DQo+
Pg0KPj4gUmlnaHQsIHdlJ3ZlIG5vdCByZWFsbHkgdXNlZCByZWFkb25seSBpbiB0aGlzIHdheSBi
ZWZvcmUuIEl0IG1ha2VzIHNlbnNlDQo+PiB0byBhIHBvaW50LCBidXQgaXQncyBhIGJpdCBvZiBh
IHNlbWFudGljIG92ZXJsb2FkIC0tIHRoZSBkaXNrIGlzDQo+PiBhY3R1YWxseSBSVyBidXQgdGhl
IGJpdG1hcCBpcyBSTzsgdGhlIHByb2JsZW0gdGhhdCBJIGhhdmUgd2l0aCB0aGlzIGlzDQo+PiB0
aGF0IHdlIGd1YXJkIFJPIGJpdG1hcHMgd2l0aCBhc3NlcnRpb25zIGFuZCBub3QgZXJyb3JzLA0K
PiANCj4gT29wcywgeW91IGFyZSByaWdodC4gSSB0aG91Z2h0IHdlIGhhdmUgZXJyb3JzIGZvciBn
dWVzdCB3cml0ZXMgaW4gdGhpcyBjYXNlLg0KDQpBaGEsIEkgd2FzIChwYXJ0aWFsbHkpIHJpZ2h0
LCB3ZSBoYXZlIGluIGJkcnZfYWxpZ25lZF9wd3JpdGV2Og0KICAgICBpZiAoYmRydl9oYXNfcmVh
ZG9ubHlfYml0bWFwcyhicykpIHsNCiAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCiAgICAgICB9
DQoNCmJ1dCB3aGF0IGFib3V0IGRpc2NhcmQsIC4uLj8gc2VlbXMgaXQncyBub3QgaGFuZGxlZC4N
Cg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


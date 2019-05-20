Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19111C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1872081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BMl5omDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1872081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSfkN-0002DY-2W
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:42:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSfjX-0001nY-Cw
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hSfjW-0005SW-9Q
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:41:31 -0400
Received: from mail-eopbgr00132.outbound.protection.outlook.com
	([40.107.0.132]:56290
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hSfjW-0005Rq-40; Mon, 20 May 2019 06:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=3VH8CHt2iDAY3p7gs3zQTezxJY7ObWhr5bf5fxLn850=;
	b=BMl5omDV/Kc5w7tdoA4JXS6Gy/2KKn0FiwcWJeNCJipO4wnGQ20cy9upq2hIff11HcQ4VP6G/ct3K9Fa69tKnpKAFJSkB2zFWqCJ13l3vYHSfraJluaJfBUg60HvS2sJFApSdEMJBEu5xydMYPU3dje798h8iDe4KOzjLZLetN4=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB5256.eurprd08.prod.outlook.com (10.255.123.148) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Mon, 20 May 2019 10:41:27 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Mon, 20 May 2019 10:41:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 03/11] block: Storage child access
	function
Thread-Index: AQHU79s4qmA/oNS9hkyzhfemLzwTO6Z0EW6A
Date: Mon, 20 May 2019 10:41:26 +0000
Message-ID: <5fd51d1a-c9a9-f310-a3a3-369b2c1c27d0@virtuozzo.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
	<20190410202033.28617-4-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-4-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:3:f7::25) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190520134125141
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12769339-4c02-4edf-ee0c-08d6dd0fb5eb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB5256; 
x-ms-traffictypediagnostic: AM6PR08MB5256:
x-microsoft-antispam-prvs: <AM6PR08MB52565DD072271D96157D9A09C1060@AM6PR08MB5256.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39850400004)(366004)(136003)(396003)(376002)(199004)(189003)(8936002)(5660300002)(25786009)(36756003)(478600001)(14454004)(4326008)(229853002)(2906002)(71190400001)(71200400001)(7736002)(66556008)(386003)(6506007)(316002)(66446008)(64756008)(66476007)(305945005)(186003)(66946007)(73956011)(3846002)(6116002)(102836004)(486006)(76176011)(99286004)(31696002)(52116002)(86362001)(2616005)(446003)(31686004)(476003)(66066001)(11346002)(2501003)(81156014)(256004)(14444005)(8676002)(6512007)(54906003)(53936002)(6486002)(110136005)(6246003)(81166006)(26005)(68736007)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5256;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GZ7ABkumCwtz8pgmQnx8NxSU+fMgK4UAMoltTMgJANrGEnKRnDA3dInZYQ8OdGXRRjeGLl12lWz6zTdSK1sxh81Wp0slBVazTsjrZnyzW5vG88KzeEGbqUth0F+ui5Z9hWKfwkwmdEg4vZTQhp9ScHdZMlscWkpq4GL35dprCSKSjx6CdNGlxedV+pKGIerD93i3Hvaj+j65/EKQis3fnVydWL+3OKU54Jl5DIutxGC7Qa4/n9D7rLN1sSJBsFR+myq9vBnIydSscsgF7YHjB0Fv5RrDDdCekfrsSW3o7KnWC4EIys6/pBhCR+NNv61keiChhVdm8Cz/GXtOk9xnMGCS9MvmEx8dAoqQnLggqttSOHBRBSA8NVdGOZZwRy8xWudY6oHHHOu17Vq3HFJkGSkhm+gTsrun2V6PTGHGjd8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40EC92B903630A49B7D9DC5AD616B71D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12769339-4c02-4edf-ee0c-08d6dd0fb5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 10:41:27.0876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5256
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.132
Subject: Re: [Qemu-devel] [PATCH v4 03/11] block: Storage child access
 function
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
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDQuMjAxOSAyMzoyMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBGb3IgY29tcGxldGVuZXNzJyBz
YWtlLCBhZGQgYSBmdW5jdGlvbiBmb3IgYWNjZXNzaW5nIGEgbm9kZSdzIHN0b3JhZ2UNCj4gY2hp
bGQsIHRvby4gIEZvciBmaWx0ZXJzLCB0aGlzIGlzIHRoZWlyIGZpbHRlcmVkIGNoaWxkOyBmb3Ig
bm9uLWZpbHRlcnMsDQo+IHRoaXMgaXMgYnMtPmZpbGUuDQo+IA0KPiBTb21lIHBsYWNlcyBhcmUg
ZGVsaWJlcmF0ZWx5IGxlZnQgdW5jb252ZXJ0ZWQ6DQo+IC0gQkRTIG9wZW5pbmcvY2xvc2luZyBm
dW5jdGlvbnMgd2hlcmUgYnMtPmZpbGUgaXMgaGFuZGxlZCBzcGVjaWFsbHkNCj4gICAgKHdoaWNo
IGlzIGJhc2ljYWxseSB3cm9uZywgYnV0IGF0IGxlYXN0IHNpbXBsaWZpZXMgcHJvYmluZykNCj4g
LSBiZHJ2X2NvX2Jsb2NrX3N0YXR1c19mcm9tX2ZpbGUoKSwgYmVjYXVzZSBpdHMgbmFtZSBpbXBs
aWVzIHRoYXQgaXQNCj4gICAgcG9pbnRzIHRvIC0+ZmlsZQ0KPiAtIGJkcnZfc25hcHNob3RfZ290
bygpIGluIG9uZSBwbGFjZXMgdW5yZWZzIGJzLT5maWxlLiAgU3VjaCBhDQo+ICAgIG1vZGlmaWNh
dGlvbiBpcyBub3QgY292ZXJlZCBieSB0aGlzIHBhdGNoIGFuZCBpcyB0aGVyZWZvcmUganVzdA0K
PiAgICBzYWZlZ3VhcmRlZCBieSBhbiBhZGRpdGlvbmFsIGFzc2VydCgpLCBidXQgb3RoZXJ3aXNl
IGtlcHQgYXMtaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRo
YXQuY29tPg0KDQpbLi5dDQoNCj4gLS0tIGEvYmxvY2svaW8uYw0KPiArKysgYi9ibG9jay9pby5j
DQoNClsuLl0NCg0KPiBAQCAtMjU1OSw3ICsyNTU0LDcgQEAgaW50IGNvcm91dGluZV9mbiBiZHJ2
X2NvX2ZsdXNoKEJsb2NrRHJpdmVyU3RhdGUgKmJzKQ0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAg
IC8qIFdyaXRlIGJhY2sgY2FjaGVkIGRhdGEgdG8gdGhlIE9TIGV2ZW4gd2l0aCBjYWNoZT11bnNh
ZmUgKi8NCj4gLSAgICBCTEtEQkdfRVZFTlQoYnMtPmZpbGUsIEJMS0RCR19GTFVTSF9UT19PUyk7
DQo+ICsgICAgQkxLREJHX0VWRU5UKGJkcnZfc3RvcmFnZV9jaGlsZChicyksIEJMS0RCR19GTFVT
SF9UT19PUyk7DQoNCkhtbSwgcHJlZXhpc3RlbnQsIGJ1dCBzdHJhbmdlIHRoYXQgd2UgY2FsbCBF
VkVOVCBmb3IgYnMtPmZpbGUgYmVmb3JlIGFjdGlvbiBvbiBicy4uLg0KDQo+ICAgICAgIGlmIChi
cy0+ZHJ2LT5iZHJ2X2NvX2ZsdXNoX3RvX29zKSB7DQo+ICAgICAgICAgICByZXQgPSBicy0+ZHJ2
LT5iZHJ2X2NvX2ZsdXNoX3RvX29zKGJzKTsNCj4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+
IEBAIC0yNTc3LDcgKzI1NzIsNyBAQCBpbnQgY29yb3V0aW5lX2ZuIGJkcnZfY29fZmx1c2goQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMpDQo+ICAgICAgICAgICBnb3RvIGZsdXNoX3BhcmVudDsNCj4gICAg
ICAgfQ0KPiAgIA0KPiAtICAgIEJMS0RCR19FVkVOVChicy0+ZmlsZSwgQkxLREJHX0ZMVVNIX1RP
X0RJU0spOw0KPiArICAgIEJMS0RCR19FVkVOVChiZHJ2X3N0b3JhZ2VfY2hpbGQoYnMpLCBCTEtE
QkdfRkxVU0hfVE9fRElTSyk7DQo+ICAgICAgIGlmICghYnMtPmRydikgew0KPiAgICAgICAgICAg
LyogYnMtPmRydi0+YmRydl9jb19mbHVzaCgpIG1pZ2h0IGhhdmUgZWplY3RlZCB0aGUgQkRTDQo+
ICAgICAgICAgICAgKiAoZXZlbiBpbiBjYXNlIG9mIGFwcGFyZW50IHN1Y2Nlc3MpICovDQo+IEBA
IC0yNjIyLDcgKzI2MTcsOCBAQCBpbnQgY29yb3V0aW5lX2ZuIGJkcnZfY29fZmx1c2goQmxvY2tE
cml2ZXJTdGF0ZSAqYnMpDQo+ICAgICAgICAqIGluIHRoZSBjYXNlIG9mIGNhY2hlPXVuc2FmZSwg
c28gdGhlcmUgYXJlIG5vIHVzZWxlc3MgZmx1c2hlcy4NCj4gICAgICAgICovDQo+ICAgZmx1c2hf
cGFyZW50Og0KPiAtICAgIHJldCA9IGJzLT5maWxlID8gYmRydl9jb19mbHVzaChicy0+ZmlsZS0+
YnMpIDogMDsNCj4gKyAgICBzdG9yYWdlX2JzID0gYmRydl9zdG9yYWdlX2JzKGJzKTsNCj4gKyAg
ICByZXQgPSBzdG9yYWdlX2JzID8gYmRydl9jb19mbHVzaChzdG9yYWdlX2JzKSA6IDA7DQo+ICAg
b3V0Og0KPiAgICAgICAvKiBOb3RpZnkgYW55IHBlbmRpbmcgZmx1c2hlcyB0aGF0IHdlIGhhdmUg
Y29tcGxldGVkICovDQo+ICAgICAgIGlmIChyZXQgPT0gMCkgew0KDQpbLi5dDQoNCj4gLS0tIGEv
YmxvY2svc25hcHNob3QuYw0KPiArKysgYi9ibG9jay9zbmFwc2hvdC5jDQoNClsuLl0NCg0KPiBA
QCAtMTg0LDYgKzE4Niw3IEBAIGludCBiZHJ2X3NuYXBzaG90X2dvdG8oQmxvY2tEcml2ZXJTdGF0
ZSAqYnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+ICAgew0K
PiAgICAgICBCbG9ja0RyaXZlciAqZHJ2ID0gYnMtPmRydjsNCj4gKyAgICBCbG9ja0RyaXZlclN0
YXRlICpzdG9yYWdlX2JzOw0KPiAgICAgICBpbnQgcmV0LCBvcGVuX3JldDsNCj4gICANCj4gICAg
ICAgaWYgKCFkcnYpIHsNCj4gQEAgLTIwNCwzOSArMjA3LDQwIEBAIGludCBiZHJ2X3NuYXBzaG90
X2dvdG8oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAg
ICAgICB9DQo+ICAgDQo+IC0gICAgaWYgKGJzLT5maWxlKSB7DQo+IC0gICAgICAgIEJsb2NrRHJp
dmVyU3RhdGUgKmZpbGU7DQo+ICsgICAgc3RvcmFnZV9icyA9IGJkcnZfc3RvcmFnZV9icyhicyk7
DQo+ICsgICAgaWYgKHN0b3JhZ2VfYnMpIHsNCj4gICAgICAgICAgIFFEaWN0ICpvcHRpb25zID0g
cWRpY3RfY2xvbmVfc2hhbGxvdyhicy0+b3B0aW9ucyk7DQo+ICAgICAgICAgICBRRGljdCAqZmls
ZV9vcHRpb25zOw0KPiAgICAgICAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+ICAgDQo+
IC0gICAgICAgIGZpbGUgPSBicy0+ZmlsZS0+YnM7DQo+ICAgICAgICAgICAvKiBQcmV2ZW50IGl0
IGZyb20gZ2V0dGluZyBkZWxldGVkIHdoZW4gZGV0YWNoZWQgZnJvbSBicyAqLw0KPiAtICAgICAg
ICBiZHJ2X3JlZihmaWxlKTsNCj4gKyAgICAgICAgYmRydl9yZWYoc3RvcmFnZV9icyk7DQo+ICAg
DQo+ICAgICAgICAgICBxZGljdF9leHRyYWN0X3N1YnFkaWN0KG9wdGlvbnMsICZmaWxlX29wdGlv
bnMsICJmaWxlLiIpOw0KPiAgICAgICAgICAgcW9iamVjdF91bnJlZihmaWxlX29wdGlvbnMpOw0K
PiAtICAgICAgICBxZGljdF9wdXRfc3RyKG9wdGlvbnMsICJmaWxlIiwgYmRydl9nZXRfbm9kZV9u
YW1lKGZpbGUpKTsNCj4gKyAgICAgICAgcWRpY3RfcHV0X3N0cihvcHRpb25zLCAiZmlsZSIsIGJk
cnZfZ2V0X25vZGVfbmFtZShzdG9yYWdlX2JzKSk7DQo+ICAgDQo+ICAgICAgICAgICBpZiAoZHJ2
LT5iZHJ2X2Nsb3NlKSB7DQo+ICAgICAgICAgICAgICAgZHJ2LT5iZHJ2X2Nsb3NlKGJzKTsNCj4g
ICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBhc3NlcnQoYnMtPmZpbGUtPmJzID09IHN0b3Jh
Z2VfYnMpOw0KDQpIbW0sIGJ1dCB3aGF0IHNhdmUgdXMgZnJvbSB0aGlzIGFzc2VydGlvbiBmYWls
IGZvciBiYWNraW5nLWZpbHRlcnM/IEJlZm9yZSB5b3VyDQpwYXRjaCBpdCB3YXMgdW5yZWFjaGFi
bGUgZm9yIHRoZW0uIE9yIHdoYXQgSSBtaXNzPw0KDQo+ICAgICAgICAgICBiZHJ2X3VucmVmX2No
aWxkKGJzLCBicy0+ZmlsZSk7DQo+ICAgICAgICAgICBicy0+ZmlsZSA9IE5VTEw7DQo+ICAgDQo+
IC0gICAgICAgIHJldCA9IGJkcnZfc25hcHNob3RfZ290byhmaWxlLCBzbmFwc2hvdF9pZCwgZXJy
cCk7DQo+ICsgICAgICAgIHJldCA9IGJkcnZfc25hcHNob3RfZ290byhzdG9yYWdlX2JzLCBzbmFw
c2hvdF9pZCwgZXJycCk7DQo+ICAgICAgICAgICBvcGVuX3JldCA9IGRydi0+YmRydl9vcGVuKGJz
LCBvcHRpb25zLCBicy0+b3Blbl9mbGFncywgJmxvY2FsX2Vycik7DQo+ICAgICAgICAgICBxb2Jq
ZWN0X3VucmVmKG9wdGlvbnMpOw0KPiAgICAgICAgICAgaWYgKG9wZW5fcmV0IDwgMCkgew0KPiAt
ICAgICAgICAgICAgYmRydl91bnJlZihmaWxlKTsNCj4gKyAgICAgICAgICAgIGJkcnZfdW5yZWYo
c3RvcmFnZV9icyk7DQo+ICAgICAgICAgICAgICAgYnMtPmRydiA9IE5VTEw7DQo+ICAgICAgICAg
ICAgICAgLyogQSBiZHJ2X3NuYXBzaG90X2dvdG8oKSBlcnJvciB0YWtlcyBwcmVjZWRlbmNlICov
DQo+ICAgICAgICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+ICAg
ICAgICAgICAgICAgcmV0dXJuIHJldCA8IDAgPyByZXQgOiBvcGVuX3JldDsNCj4gICAgICAgICAg
IH0NCj4gICANCj4gLSAgICAgICAgYXNzZXJ0KGJzLT5maWxlLT5icyA9PSBmaWxlKTsNCj4gLSAg
ICAgICAgYmRydl91bnJlZihmaWxlKTsNCj4gKyAgICAgICAgYXNzZXJ0KGJzLT5maWxlLT5icyA9
PSBzdG9yYWdlX2JzKTsNCj4gKyAgICAgICAgYmRydl91bnJlZihzdG9yYWdlX2JzKTsNCj4gICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgIH0NCj4gICANCg0KDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==


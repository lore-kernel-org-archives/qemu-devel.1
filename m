Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E8C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64192077C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZPDUjOUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64192077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEb1s-0001DY-2K
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:50:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEb0J-0000QJ-0O
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEb0H-0005mH-VQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:48:38 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
	([40.107.8.138]:32993
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEb0H-0005lc-9B; Thu, 11 Apr 2019 10:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9duP2xbeWLYNYj5xvH4msH+5HWN1+E2RMdc8fwmrPos=;
	b=ZPDUjOUc3jqkk1AYndW3sOWSqdVT6z8E3uk8KKTqjVbSkn4P7tigQSsCZPrYrVc/ppECuZmMS8cymcSmcc4aALpz5YoQZK/hapRU3PiSRuppdUuqJfO++fi877eervNBe3M5Gqaa98kYrj4Y95dH44Wvd7P2ot0XUWBfGLhmbSk=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3339.eurprd08.prod.outlook.com (52.134.111.146) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.18; Thu, 11 Apr 2019 14:48:34 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 14:48:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
	AioContext switch
Thread-Index: AQHUzR9xRI5FuNnn4EOD4L0Dttict6Y3cGSA///XewCAAAkmAA==
Date: Thu, 11 Apr 2019 14:48:34 +0000
Message-ID: <1391b876-74ed-21f0-c41f-f2fb22d2eae7@virtuozzo.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
	<20190225152053.15976-17-kwolf@redhat.com>
	<4f9792a1-4702-62d0-cad4-4da1169baa3b@virtuozzo.com>
	<20190411141548.GE5694@linux.fritz.box>
In-Reply-To: <20190411141548.GE5694@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0115.eurprd02.prod.outlook.com
	(2603:10a6:7:29::44) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411174832579
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 391ff629-88ae-4dd1-abc7-08d6be8cc5ea
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3339; 
x-ms-traffictypediagnostic: DB7PR08MB3339:
x-microsoft-antispam-prvs: <DB7PR08MB33397F51F87B79DEB93258B9C12F0@DB7PR08MB3339.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39840400004)(199004)(189003)(2906002)(229853002)(86362001)(3846002)(8676002)(256004)(6116002)(106356001)(105586002)(81156014)(81166006)(6246003)(6916009)(14444005)(102836004)(31696002)(305945005)(36756003)(8936002)(76176011)(25786009)(316002)(6436002)(7736002)(4326008)(53936002)(93886005)(68736007)(6512007)(5024004)(54906003)(386003)(6486002)(186003)(446003)(71200400001)(99286004)(478600001)(52116002)(5660300002)(71190400001)(26005)(66066001)(97736004)(2616005)(476003)(31686004)(11346002)(14454004)(486006)(6506007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3339;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mpByK2nQe3w8fkjDuYq89IsHPMXrBzHH7ONVyHCeY28DJzW2yhNvJSK8wEeKNyxHOW3ZL2wphVUqlto99hyAcWkAHnmTGvDbG1bCbJVZxVVowfub75pSvEWJWHOMy8yY1uIntEcCHzcO2u0WOjiK0pcXY806wq5/3OHaoTRqAevNy2bEMzYZsQznJXg7VZ2KxDrT/k5YpgnE4907ufbPH1fOPxqu9SBbR4WnjAZKT+dvHSrn3o7AAnhWcX4UBt057NmjymIWposkvMwFLUmZ9qkn0eOYG30IEtLXGoyAJLwEsryd+IVplRkcoAKRqXYzZhTCbHHLILyXtENEIFTq9k7imBUD0J08wESwm4IrcPMKbpPa1KzyeqjjZyVLKFVLABKTOH3EsGzwhyR/v0cf+BSc9NLmRt16j52aoPevJcM=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <E9EE2ADBB56E354E88D16BB86987D596@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391ff629-88ae-4dd1-abc7-08d6be8cc5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 14:48:34.7385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3339
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.138
Subject: Re: [Qemu-devel] [PULL 16/71] nbd: Increase bs->in_flight during
 AioContext switch
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411144834.EjFGRDNfAXm1APxW98VGrThNGM8iMElyQXELuZZxfIE@z>

MTEuMDQuMjAxOSAxNzoxNSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTEuMDQuMjAxOSB1bSAx
NTo0MCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDI1
LjAyLjIwMTkgMTg6MTksIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gYmRydl9kcmFpbigpIG11c3Qg
bm90IGxlYXZlIGNvbm5lY3Rpb25fY28gc2NoZWR1bGVkLCBzbyBicy0+aW5fZmxpZ2h0DQo+Pj4g
bmVlZHMgdG8gYmUgaW5jcmVhc2VkIHdoaWxlIHRoZSBjb3JvdXRpbmUgaXMgd2FpdGluZyB0byBi
ZSBzY2hlZHVsZWQNCj4+PiBpbiB0aGUgbmV3IEFpb0NvbnRleHQgYWZ0ZXIgbmJkX2NsaWVudF9h
dHRhY2hfYWlvX2NvbnRleHQoKS4NCj4+DQo+PiBIaSENCj4+DQo+PiBJIGhhdmUgc29tZSBxdWVz
dGlvbnMsIGNvdWxkIHlvdSBleHBsYWluLCBwbGVhc2U/DQo+Pg0KPj4gImJkcnZfZHJhaW4oKSBt
dXN0IG5vdCBsZWF2ZSBjb25uZWN0aW9uX2NvIHNjaGVkdWxlZCIgLSBpdCdzIGJlY2F1c2Ugd2Ug
d2FudCB0byBiZQ0KPj4gc3VyZSB0aGF0IGNvbm5lY3Rpb25fY28geWllbGRlZCBmcm9tIG5iZF9y
ZWFkX2VvZiwgeWVzPw0KPj4NCj4+IEJ1dCBpdCBpcyBndWFyYW50ZWVkIGJ5IGFpb193YWl0X2Jo
X29uZXNob3QuLiBXaHkgZG8gd2UgbmVlZCBhZGRpdGlvaW5hbGx5IGluYy9kZWMNCj4+IGJzLT5p
bl9mbGlnaHQgPw0KPiANCj4gV2l0aG91dCBpbmNyZW1lbnRpbmcgYnMtPmluX2ZsaWdodCwgbm90
aGluZyB3b3VsZCBndWFyYW50ZWUgdGhhdA0KPiBhaW9fcG9sbCgpIGlzIGNhbGxlZCBhbmQgdGhl
IEJIIGlzIGFjdHVhbGx5IGV4ZWN1dGVkIGJlZm9yZSBiZHJ2X2RyYWluKCkNCj4gcmV0dXJucy4N
Cg0KRG9uJ3QgZm9sbG93Li4gRG9uJ3Qgd2Ugd2FudCBleGFjdGx5IHRoaXMsIHdlIHdhbnQgQkgg
dG8gYmUgZXhlY3V0ZWQgd2hpbGUgbm9kZSBpcyBzdGlsbA0KZHJhaW5lZCwgYXMgeW91IHdyaXRl
IGluIGNvbW1lbnQ/DQoNCj4gDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXb2xmIDxr
d29sZkByZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGJsb2NrL25iZC1jbGllbnQuYyB8IDIw
ICsrKysrKysrKysrKysrKysrKy0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svbmJkLWNs
aWVudC5jIGIvYmxvY2svbmJkLWNsaWVudC5jDQo+Pj4gaW5kZXggNjBmMzhmMDMyMC4uYmZiYWY3
ZWJlOSAxMDA2NDQNCj4+PiAtLS0gYS9ibG9jay9uYmQtY2xpZW50LmMNCj4+PiArKysgYi9ibG9j
ay9uYmQtY2xpZW50LmMNCj4+PiBAQCAtOTc3LDE0ICs5NzcsMzAgQEAgdm9pZCBuYmRfY2xpZW50
X2RldGFjaF9haW9fY29udGV4dChCbG9ja0RyaXZlclN0YXRlICpicykNCj4+PiAgICAgICAgcWlv
X2NoYW5uZWxfZGV0YWNoX2Fpb19jb250ZXh0KFFJT19DSEFOTkVMKGNsaWVudC0+aW9jKSk7DQo+
Pj4gICAgfQ0KPj4+ICAgIA0KPj4+ICtzdGF0aWMgdm9pZCBuYmRfY2xpZW50X2F0dGFjaF9haW9f
Y29udGV4dF9iaCh2b2lkICpvcGFxdWUpDQo+Pj4gK3sNCj4+PiArICAgIEJsb2NrRHJpdmVyU3Rh
dGUgKmJzID0gb3BhcXVlOw0KPj4+ICsgICAgTkJEQ2xpZW50U2Vzc2lvbiAqY2xpZW50ID0gbmJk
X2dldF9jbGllbnRfc2Vzc2lvbihicyk7DQo+Pj4gKw0KPj4+ICsgICAgLyogVGhlIG5vZGUgaXMg
c3RpbGwgZHJhaW5lZCwgc28gd2Uga25vdyB0aGUgY29yb3V0aW5lIGhhcyB5aWVsZGVkIGluDQo+
Pj4gKyAgICAgKiBuYmRfcmVhZF9lb2YoKSwgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgYnMtPmluX2Zs
aWdodCBjYW4gcmVhY2ggMCwgb3IgaXQgaXMNCj4+PiArICAgICAqIGVudGVyZWQgZm9yIHRoZSBm
aXJzdCB0aW1lLiBCb3RoIHBsYWNlcyBhcmUgc2FmZSBmb3IgZW50ZXJpbmcgdGhlDQo+Pj4gKyAg
ICAgKiBjb3JvdXRpbmUuKi8NCj4+PiArICAgIHFlbXVfYWlvX2Nvcm91dGluZV9lbnRlcihicy0+
YWlvX2NvbnRleHQsIGNsaWVudC0+Y29ubmVjdGlvbl9jbyk7DQo+Pj4gKyAgICBiZHJ2X2RlY19p
bl9mbGlnaHQoYnMpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICAgIHZvaWQgbmJkX2NsaWVudF9hdHRh
Y2hfYWlvX2NvbnRleHQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBaW9Db250ZXh0ICpuZXdfY29udGV4dCkNCj4+PiAgICB7
DQo+Pj4gICAgICAgIE5CRENsaWVudFNlc3Npb24gKmNsaWVudCA9IG5iZF9nZXRfY2xpZW50X3Nl
c3Npb24oYnMpOw0KPj4+ICAgICAgICBxaW9fY2hhbm5lbF9hdHRhY2hfYWlvX2NvbnRleHQoUUlP
X0NIQU5ORUwoY2xpZW50LT5pb2MpLCBuZXdfY29udGV4dCk7DQo+Pj4gICAgDQo+Pj4gLSAgICAv
KiBGSVhNRSBSZWFsbHkgbmVlZCBhIGJkcnZfaW5jX2luX2ZsaWdodCgpIGhlcmUgKi8NCj4+PiAt
ICAgIGFpb19jb19zY2hlZHVsZShuZXdfY29udGV4dCwgY2xpZW50LT5jb25uZWN0aW9uX2NvKTsN
Cj4+PiArICAgIGJkcnZfaW5jX2luX2ZsaWdodChicyk7DQo+Pj4gKw0KPj4+ICsgICAgLyogTmVl
ZCB0byB3YWl0IGhlcmUgZm9yIHRoZSBCSCB0byBydW4gYmVjYXVzZSB0aGUgQkggbXVzdCBydW4g
d2hpbGUgdGhlDQo+Pj4gKyAgICAgKiBub2RlIGlzIHN0aWxsIGRyYWluZWQuICovDQo+Pj4gKyAg
ICBhaW9fd2FpdF9iaF9vbmVzaG90KG5ld19jb250ZXh0LCBuYmRfY2xpZW50X2F0dGFjaF9haW9f
Y29udGV4dF9iaCwgYnMpOw0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiAgICB2b2lkIG5iZF9jbGll
bnRfY2xvc2UoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4NCj4+DQo+Pg0KPj4gLS0gDQo+PiBC
ZXN0IHJlZ2FyZHMsDQo+PiBWbGFkaW1pcg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==


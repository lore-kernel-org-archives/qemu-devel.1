Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9AFC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED03020673
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jwra/8Ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED03020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFSl-00034d-8H
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:04:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heF13-0005l5-E2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heF11-0001Sx-An
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 04:35:25 -0400
Received: from mail-eopbgr130124.outbound.protection.outlook.com
 ([40.107.13.124]:24046 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heF0q-0001Kf-Qd; Fri, 21 Jun 2019 04:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0Lep+h646LcVG3BhU9b8gEUvgloDdZWFVwwwyqdAvY=;
 b=Jwra/8Ev9cDKgbG2iRjRsm7wau34IVOpB5TA2fm7N23KT2QwnPasvsC6+nKIGYlH57gLagCD5AZgiNrGyluSuvEG7B2AUQlC55M7RvNrpe5tzpJQyGqN2aSBumZsRdy3R0M+jxnfAzbyFeTOR4ITHe0vjFezBkS++Qrb9AI966o=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4538.eurprd08.prod.outlook.com (20.179.44.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 08:34:52 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 08:34:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 1/3] block: include base when checking image chain for
 block allocation
Thread-Index: AQHVFkfpJI7HPY/3OU+RVp+FXgzRGKajfZmAgAJuN4A=
Date: Fri, 21 Jun 2019 08:34:52 +0000
Message-ID: <af775092-de7c-0068-bf64-16f3037d04b9@virtuozzo.com>
References: <1559152576-281803-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1559152576-281803-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com>
In-Reply-To: <e3cf99ae-62e9-8b6e-5a06-d3c8b9363b85@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0050.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::18) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621113449163
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14cd3e2a-089d-4f92-887a-08d6f623548e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4538; 
x-ms-traffictypediagnostic: DBBPR08MB4538:
x-microsoft-antispam-prvs: <DBBPR08MB4538520B77BD7CD397130CC9C1E70@DBBPR08MB4538.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(39840400004)(376002)(136003)(199004)(189003)(71200400001)(7736002)(99286004)(486006)(107886003)(6512007)(53546011)(446003)(478600001)(102836004)(81166006)(52116002)(6436002)(8936002)(305945005)(7416002)(71190400001)(6246003)(54906003)(316002)(110136005)(2906002)(6116002)(76176011)(476003)(68736007)(2201001)(3846002)(5660300002)(36756003)(26005)(8676002)(6486002)(86362001)(66066001)(81156014)(73956011)(64756008)(25786009)(2501003)(11346002)(66556008)(66476007)(66946007)(4326008)(31696002)(256004)(229853002)(53936002)(186003)(6506007)(66446008)(14454004)(2616005)(386003)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4538;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: juLc1r14+R/a7JXKPEZtE2+ciGthvHYl1DCChAcUX44b/vgyUvFgvBP0QwanLGr07BfagraCXILKQooMDI4w2OaApR9yXWOvz+7Ohb+fbLVIbe6W6wUOKv9POrYszoKGZr2ntgFxK+e3cQK+CIM8qsPW1p0z1tdGnQKKSTlPS+clTYk/lLarUdMxK27l5B67J2K0m/94mZblWjSdywFYwYBc9ZAKijypefYy+gs0B6XUUi7yw2NMLj0ml3FTx+ejHRaSo601slUp2Y4VHc1CsOiAyMw1w5MdRjljDT5MJbjmYMPh0nIi6TNEfggus90oC49xEfNSa7+siuk45JvhUr9Tm96ExhRCQ39Wp4ziq4C3bee3zJit4dSpQaD/Tap3C9S1QS0uVF0mmMuudlVCKd/ZbNGUcWo5imdC4mdECJo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3BD8211DA364A4D9ED0FDD125B453E9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cd3e2a-089d-4f92-887a-08d6f623548e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 08:34:52.5147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4538
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.124
Subject: Re: [Qemu-devel] [PATCH v7 1/3] block: include base when checking
 image chain for block allocation
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDYuMjAxOSAyMjoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4wNS4xOSAxOTo1Niwg
QW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBUaGlzIHBhdGNoIGlzIHVzZWQgaW4gdGhlICdi
bG9jay9zdHJlYW06IGludHJvZHVjZSBhIGJvdHRvbSBub2RlJw0KPj4gdGhhdCBpcyBmb2xsb3dp
bmcuIEluc3RlYWQgb2YgdGhlIGJhc2Ugbm9kZSwgdGhlIGNhbGxlciBtYXkgcGFzcw0KPj4gdGhl
IG5vZGUgdGhhdCBoYXMgdGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1hZ2UgdG8gdGhlIGZ1bmN0
aW9uDQo+PiBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSgpIHdpdGggYSBuZXcgcGFyYW1ldGVyIGlu
Y2x1ZGVfYmFzZSA9IHRydWUNCj4+IGFuZCBnZXQgcmlkIG9mIHRoZSBkZXBlbmRlbmN5IG9uIHRo
ZSBiYXNlIHRoYXQgbWF5IGNoYW5nZSBkdXJpbmcNCj4+IGNvbW1pdC9zdHJlYW0gcGFyYWxsZWwg
am9icy4gTm93LCBpZiB0aGUgc3BlY2lmaWVkIGJhc2UgaXMgbm90DQo+PiBmb3VuZCBpbiB0aGUg
YmFja2luZyBpbWFnZSBjaGFpbiwgdGhlIFFFTVUgd2lsbCBhYm9ydC4NCj4+DQo+PiBTdWdnZXN0
ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtl
dmljaEB2aXJ0dW96em8uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBbGJl
cnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9jb21taXQu
YyAgICAgICAgfCAgMiArLQ0KPj4gICBibG9jay9pby5jICAgICAgICAgICAgfCAyMSArKysrKysr
KysrKysrKystLS0tLS0NCj4+ICAgYmxvY2svbWlycm9yLmMgICAgICAgIHwgIDIgKy0NCj4+ICAg
YmxvY2svcmVwbGljYXRpb24uYyAgIHwgIDIgKy0NCj4+ICAgYmxvY2svc3RyZWFtLmMgICAgICAg
IHwgIDIgKy0NCj4+ICAgaW5jbHVkZS9ibG9jay9ibG9jay5oIHwgIDMgKystDQo+PiAgIDYgZmls
ZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBUaGlz
IG5lZWRzIHRoZSBmb2xsb3dpbmcgaHVuayBzcXVhc2hlZCBpbiBzbyBpdCBzdGlsbCBjb21waWxl
czoNCj4gDQo+IChJIGNhbiBkbyB0aGF0LCBpZiB5b3UgYWdyZWUuKQ0KDQpJdCB3aWxsIGJlIGdy
ZWF0LCB0aGFua3MhIChBbmRyZXkgaXMgb24gdm9jYXRpb24gbm93KQ0KDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4gaW5kZXggOTM5NmQ0OTBkNS4u
MmE1OWViMjdmZSAxMDA2NDQNCj4gLS0tIGEvYmxvY2svcWNvdzIuYw0KPiArKysgYi9ibG9jay9x
Y293Mi5jDQo+IEBAIC0yMTQ4LDcgKzIxNDgsOCBAQCBzdGF0aWMgYm9vbCBpc191bmFsbG9jYXRl
ZChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0ZXMp
DQo+ICAgew0KPiAgICAgICBpbnQ2NF90IG5yOw0KPiAgICAgICByZXR1cm4gIWJ5dGVzIHx8DQo+
IC0gICAgICAgICghYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoYnMsIE5VTEwsIG9mZnNldCwgYnl0
ZXMsICZucikgJiYgbnINCj4gPT0gYnl0ZXMpOw0KPiArICAgICAgICAoIWJkcnZfaXNfYWxsb2Nh
dGVkX2Fib3ZlKGJzLCBOVUxMLCBmYWxzZSwgb2Zmc2V0LCBieXRlcywgJm5yKSAmJg0KPiArICAg
ICAgICAgbnIgPT0gYnl0ZXMpOw0KPiAgIH0NCj4gDQo+ICAgc3RhdGljIGJvb2wgaXNfemVyb19j
b3coQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFDb3dMMk1ldGEgKm0pDQo+IGRpZmYgLS1naXQgYS9x
ZW11LWltZy5jIGIvcWVtdS1pbWcuYw0KPiBpbmRleCAxNThiM2E1MDVmLi43OTk4Mzc3MmRlIDEw
MDY0NA0KPiAtLS0gYS9xZW11LWltZy5jDQo+ICsrKyBiL3FlbXUtaW1nLmMNCj4gQEAgLTM1MTgs
NyArMzUxOCw3IEBAIHN0YXRpYyBpbnQgaW1nX3JlYmFzZShpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
DQo+ICAgICAgICAgICAgICAgICAgICAqIHRvIHRha2UgYWN0aW9uDQo+ICAgICAgICAgICAgICAg
ICAgICAqLw0KPiAgICAgICAgICAgICAgICAgICByZXQgPSBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92
ZShiYWNraW5nX2JzKGJzKSwNCj4gcHJlZml4X2NoYWluX2JzLA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldCwgbiwgJm4pOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZhbHNlLCBvZmZzZXQsIG4s
ICZuKTsNCj4gICAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAgICAgICAgICAg
ICAgICAgICAgIGVycm9yX3JlcG9ydCgiZXJyb3Igd2hpbGUgcmVhZGluZyBpbWFnZSBtZXRhZGF0
YTogJXMiLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmVycm9yKC1y
ZXQpKTsNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


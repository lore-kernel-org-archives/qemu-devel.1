Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E91C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 08:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948CE2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="f6lzBcNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948CE2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxoUd-0006kI-NU
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 04:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxoTx-0006Ft-B7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 04:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxoTw-0004Jj-0T
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 04:18:09 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:13191 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxoTs-0004F3-HT; Wed, 14 Aug 2019 04:18:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOKK6UZQ54yT8dE1O+w+gF1mr3Gf72Q9V94lGrC+M6layL0hJXVKWOErGy1k6hvvRDsYjdOyS0huqop6DDzgTUQTd8MZuutqJTP/sMGko2g0Hu3x4cgPFoKKB4/k/jYMRPYqXPABWF6LErnKcLJrAhiTFGKDoJrmxI5g6tEAZIHnU9pAQVYRKMSn70TDMiRgw1vkmOqaUWtVb0o8AYd+0ZiCqq19eERxI1MLLwQiPsDGiFXdQpCC088xpEAC3AYWyaCQa1vcYLAFIJQ97gG9a3AeKrWmj/BWUtn2G8IoW6wmcCR4e1dtq1AZE+GvrY3W+N4iSpCDsE34Cl0VU9CF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du8+NwJWe0TK+ciT+hrBCwFozwKZ0KoPHjC1sbK5v3I=;
 b=k4sNEYOgYGLyzYvgeNmMtTo55ePXu6CSrR1mQFheHBbUTPkFGPhl5TxXSigfr8k1akVJx52SDOqy0Uutxqb7zBO1NmmGxjPiTlomy9Th6AWipXdjNIvd5bps6TD552l/qZ7LchDbZXcVX1rvNE412QRAOmLNYrZkEhsu1qrC5uFMuIZ5RmtNzCNLnX7FP4pRMACVldvNDko7YQqJ8tYMxjhvEerv+EfkmNKYMfVbLuAvi0RKoMfO6wR68EDINVw3wCji6sr0Lp5Pa1vzdfBT+XjpTzrNpFxVbCiJHpW7ctPtcUMr41EQ2FYEHXTIUUHzNwr8GUrmxfwarlZiDuWr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du8+NwJWe0TK+ciT+hrBCwFozwKZ0KoPHjC1sbK5v3I=;
 b=f6lzBcNlWKXFchNGaldZPZaMLr6phz1bv1Gr2PlkjGc60Qt//Jeml29/U9i5WlRx3VG79vgSRBCbW1X8Pv8sjbQ2HTD3JsGc5E6aWYuh8JOxl7aLa7CNd+vQHkdYZqEYmzKZxmfRnt3VAnkuk5/wqoW4E4EK2ovKPtfysVCLr2s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4185.eurprd08.prod.outlook.com (20.179.10.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.22; Wed, 14 Aug 2019 08:18:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 08:18:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 1/4] block: introduce aio task pool
Thread-Index: AQHVRuGrRpz9ghdHQk2DJGVJHbCgxqb5ouGAgADA6oA=
Date: Wed, 14 Aug 2019 08:18:00 +0000
Message-ID: <59ac37f1-33fa-f9b6-fd08-3ab710573063@virtuozzo.com>
References: <20190730141826.709849-1-vsementsov@virtuozzo.com>
 <20190730141826.709849-2-vsementsov@virtuozzo.com>
 <565ee3a9-d606-cc64-3748-21f9c54cffb7@redhat.com>
In-Reply-To: <565ee3a9-d606-cc64-3748-21f9c54cffb7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0056.eurprd09.prod.outlook.com
 (2603:10a6:3:45::24) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190814111757925
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 009286f1-5bd8-4bd7-b3cc-08d7208febb5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4185; 
x-ms-traffictypediagnostic: DB8PR08MB4185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB41853F75982F94E37BC910EEC1AD0@DB8PR08MB4185.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(376002)(136003)(366004)(396003)(199004)(189003)(2201001)(256004)(11346002)(86362001)(446003)(99286004)(6246003)(2616005)(4326008)(26005)(486006)(31696002)(476003)(305945005)(53936002)(76176011)(53546011)(6506007)(386003)(102836004)(25786009)(52116002)(186003)(110136005)(8936002)(54906003)(316002)(8676002)(31686004)(6512007)(7736002)(81166006)(66066001)(71190400001)(229853002)(2501003)(6116002)(14454004)(71200400001)(6436002)(66476007)(3846002)(64756008)(66556008)(36756003)(6486002)(66446008)(5660300002)(66946007)(81156014)(2906002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4185;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iJD4rAEApArhLw2Oqtd6haNzeR+nqDIj2FL64QWTSJUlp0hgWOfrQjpQ0ylyPy3i79Zc3fkWvuRBqGhkS+1cZllGtr3m0gsA8SfHbqaHcCGVc5IlxTB9nCrIG9DdCCuApIhG7UoiNeGINWaPYEl94e5igLBj8ZxZYg28k6iyoeAxHAZOKndYNP1RGC5uVZx89SoHrrkujKKf6qb0JNoZbvSMWlVVAN2AwAKYdRBVSoJeE57TKaEPrO/8pbVfbzyPjp2JrW5A5GbANGiN3dA70EDwC8I50AuEFHw61iAjjYlRVxNAttClTdDULUVda0FEQQHCAgoFtCgTQCRzAjhm0CeqwzdwMkVD/QlWkv0NRQ96wBC1cL1WuJmYDupe8hIgH+mRosskLRWQWNdaOf+6yq/K6yLaVEMY8lxii7PZuQ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <648367A042E6F84F85C2ECAFE1C95566@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009286f1-5bd8-4bd7-b3cc-08d7208febb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 08:18:00.4391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJHKOSsi6iQYtuypQ0q3xSUCssUoSDphtCRHp4tRUFEVDvGLiJbaTYUgTg0kMfBQIUeIByf12IYz0XYWtRr8przYgodvfi60TiQJHfvvc1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4185
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.97
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: introduce aio task pool
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAyMzo0NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4wNy4xOSAxNjoxOCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IENvbW1vbiBpbnRlcmZhY2Ug
Zm9yIGFpbyB0YXNrIGxvb3BzLiBUbyBiZSB1c2VkIGZvciBpbXByb3ZpbmcNCj4+IHBlcmZvcm1h
bmNlIG9mIHN5bmNocm9ub3VzIGlvIGxvb3BzIGluIHFjb3cyLCBibG9jay1zdHJlYW0sDQo+PiBj
b3B5LW9uLXJlYWQsIGFuZCBtYXkgYmUgb3RoZXIgcGxhY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCj4+IC0tLQ0KPiANCj4gTG9va3MgZ29vZCB0byBtZSBvdmVyYWxsLg0KPiANCj4+ICAgYmxv
Y2svYWlvX3Rhc2suaCAgICB8ICA1MiArKysrKysrKysrKysrKysrKysrDQo+IA0KPiBJ4oCZdmUg
bW92ZSB0aGlzIHRvIGluY2x1ZGUvYmxvY2svLg0KPiANCj4+ICAgYmxvY2svYWlvX3Rhc2suYyAg
ICB8IDExOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
ICBibG9jay9NYWtlZmlsZS5vYmpzIHwgICAyICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNzMg
aW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svYWlvX3Rhc2suaA0K
Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYmxvY2svYWlvX3Rhc2suYw0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9ibG9jay9haW9fdGFzay5oIGIvYmxvY2svYWlvX3Rhc2suaA0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjkzM2FmMWQ4ZTcNCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL2Jsb2NrL2Fpb190YXNrLmgNCj4gDQo+IFsuLi5dDQo+IA0KPj4gK3R5cGVk
ZWYgc3RydWN0IEFpb1Rhc2tQb29sIEFpb1Rhc2tQb29sOw0KPj4gK3R5cGVkZWYgc3RydWN0IEFp
b1Rhc2sgQWlvVGFzazsNCj4+ICt0eXBlZGVmIGludCAoKkFpb1Rhc2tGdW5jKShBaW9UYXNrICp0
YXNrKTsNCj4gDQo+ICtjb3JvdXRpbmVfZm4NCj4gDQo+PiArc3RydWN0IEFpb1Rhc2sgew0KPj4g
KyAgICBBaW9UYXNrUG9vbCAqcG9vbDsNCj4+ICsgICAgQWlvVGFza0Z1bmMgZnVuYzsNCj4+ICsg
ICAgaW50IHJldDsNCj4+ICt9Ow0KPj4gKw0KPj4gKy8qDQo+PiArICogYWlvX3Rhc2tfcG9vbF9u
ZXcNCj4+ICsgKg0KPj4gKyAqIFRoZSBjYWxsZXIgaXMgcmVzcG9uc2libGUgdG8gZ19mcmVlIEFp
b1Rhc2tQb29sIHBvaW50ZXIgYWZ0ZXIgdXNlLg0KPiANCj4gcy90byBnX2ZyZWUvZm9yIGdfZnJl
ZWluZy8gb3Igc29tZXRoaW5nIHNpbWlsYXIuDQo+IA0KPiBPciB5b3XigJlkIGp1c3QgYWRkIGFp
b190YXNrX3Bvb2xfZnJlZSgpLg0KPiANCj4+ICsgKi8NCj4+ICtBaW9UYXNrUG9vbCAqYWlvX3Rh
c2tfcG9vbF9uZXcoaW50IG1heF9idXN5X3Rhc2tzKTsNCj4+ICtpbnQgYWlvX3Rhc2tfcG9vbF9z
dGF0dXMoQWlvVGFza1Bvb2wgKnBvb2wpOw0KPiANCj4gQSBjb21tZW50IHdvdWxkbuKAmXQgaHVy
dC4gIEl0IHdhc27igJl0IGltbWVkaWF0ZWx5IGNsZWFyIHRvIG1lIHRoYXQgc3RhdHVzDQo+IHJl
ZmVycyB0byB0aGUgZXJyb3IgY29kZSBvZiBhIGZhaWxpbmcgdGFzayAob3IgMCksIGFsdGhvdWdo
IGl0IHdhc27igJl0DQo+IHRvbyBtdWNoIG9mIGEgc3VycHJpc2UgZWl0aGVyLg0KPiANCj4+ICti
b29sIGFpb190YXNrX3Bvb2xfZW1wdHkoQWlvVGFza1Bvb2wgKnBvb2wpOw0KPj4gK3ZvaWQgYWlv
X3Rhc2tfcG9vbF9zdGFydF90YXNrKEFpb1Rhc2tQb29sICpwb29sLCBBaW9UYXNrICp0YXNrKTsN
Cj4gDQo+IE1heWJlIG1ha2UgYSBub3RlIHRoYXQgdGFzay0+cG9vbCB3aWxsIGJlIHNldCBhdXRv
bWF0aWNhbGx5Pw0KPiANCj4+ICt2b2lkIGFpb190YXNrX3Bvb2xfd2FpdF9zbG90KEFpb1Rhc2tQ
b29sICpwb29sKTsNCj4+ICt2b2lkIGFpb190YXNrX3Bvb2xfd2FpdF9vbmUoQWlvVGFza1Bvb2wg
KnBvb2wpOw0KPj4gK3ZvaWQgYWlvX3Rhc2tfcG9vbF93YWl0X2FsbChBaW9UYXNrUG9vbCAqcG9v
bCk7DQo+IA0KPiBTaG91bGRu4oCZdCBhbGwgb2YgdGhlc2UgYnV0IGFpb190YXNrX3Bvb2xfZW1w
dHkoKSBhbmQNCj4gYWlvX3Rhc2tfcG9vbF9zdGF0dXMoKSBiZSBjb3JvdXRpbmVfZm5zPw0KPiAN
Cj4+ICsjZW5kaWYgLyogQkxPQ0tfQUlPX1RBU0tfSCAqLw0KPj4gZGlmZiAtLWdpdCBhL2Jsb2Nr
L2Fpb190YXNrLmMgYi9ibG9jay9haW9fdGFzay5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
Pj4gaW5kZXggMDAwMDAwMDAwMC4uODA3YmU4ZGViNQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysr
IGIvYmxvY2svYWlvX3Rhc2suYw0KPiANCj4gWy4uLl0NCj4gDQo+PiArc3RhdGljIHZvaWQgYWlv
X3Rhc2tfY28odm9pZCAqb3BhcXVlKQ0KPiANCj4gK2Nvcm91dGluZV9mbg0KPiANCj4gWy4uLl0N
Cj4gDQo+PiArdm9pZCBhaW9fdGFza19wb29sX3dhaXRfb25lKEFpb1Rhc2tQb29sICpwb29sKQ0K
Pj4gK3sNCj4+ICsgICAgYXNzZXJ0KHBvb2wtPmJ1c3lfdGFza3MgPiAwKTsNCj4+ICsgICAgYXNz
ZXJ0KHFlbXVfY29yb3V0aW5lX3NlbGYoKSA9PSBwb29sLT5tYWluX2NvKTsNCj4+ICsNCj4+ICsg
ICAgcG9vbC0+d2FpdF9kb25lID0gdHJ1ZTsNCj4gDQo+IEhtbW0sIGJ1dCB0aGUgd2FpdCBhY3R1
YWxseSBpc27igJl0IGRvbmUgeWV0LiA6LSkNCj4gDQo+IE1heWJlIHMvd2FpdF9kb25lL3dhaXRp
bmcvPw0KPiANCg0KDQpBaGEsIHJlYWxseSBiYWQgdmFyaWFibGUgbmFtZS4gSSBtZWFudCAid2Fp
dCBmb3Igb25lIHRhc2sgZG9uZSIuIEp1c3QgIndhaXRpbmciIHdvdWxkIGJlIGFwcHJvcHJpYXRl
Lg0KDQpUaGFua3MgZm9yIHJldmlld2luZyENCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K


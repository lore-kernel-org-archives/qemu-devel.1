Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ABEC468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D480D20657
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="clGBFOOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D480D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHHg-0000hK-W8
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZGKf-0000i3-Up
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZGKd-0004Ag-VP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:59:05 -0400
Received: from mail-he1eur01on0728.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::728]:56853
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZGKY-0003zZ-Jm; Fri, 07 Jun 2019 10:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnABFiH96TEJ4nkwZvD4NUtUY/ta2qvgTectGcJwoW4=;
 b=clGBFOOZalNtB5QkQ2oznwE3PbNbFBae1PptclCpm+fD5oi3XmC+OcIuCBl21SSsqKxhdSO2QSGHp0AHSFPB/vgg7S9fxqsvCQTPTylElzI3wbiAhl69pXRxaI4K85/EtmKOpyVLiW1BSag8OZd19lzWiNAMuqX4AKVZaYQNHb0=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB4611.eurprd08.prod.outlook.com (20.178.83.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 14:58:46 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 14:58:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 4/5] block/qcow2-bitmap: Count queued bitmaps towards
 nb_bitmaps
Thread-Index: AQHVHJeOecSMIw5za0ewwA4NqO79jqaQSdEA
Date: Fri, 7 Jun 2019 14:58:46 +0000
Message-ID: <2e39ffe1-779f-1d9d-4df9-26188386a0ee@virtuozzo.com>
References: <20190606184159.979-1-jsnow@redhat.com>
 <20190606184159.979-5-jsnow@redhat.com>
In-Reply-To: <20190606184159.979-5-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0035.eurprd09.prod.outlook.com
 (2603:10a6:7:15::24) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607175843997
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 147ff441-2696-418e-dedc-08d6eb58a3e1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4611; 
x-ms-traffictypediagnostic: AM0PR08MB4611:
x-microsoft-antispam-prvs: <AM0PR08MB4611520A45D68BE107093C53C1100@AM0PR08MB4611.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(486006)(11346002)(2501003)(6512007)(6486002)(6436002)(446003)(2616005)(476003)(229853002)(66476007)(53936002)(256004)(2201001)(6246003)(26005)(14444005)(186003)(36756003)(4326008)(25786009)(66556008)(31696002)(14454004)(73956011)(66446008)(64756008)(66946007)(71190400001)(71200400001)(305945005)(110136005)(54906003)(99286004)(31686004)(316002)(386003)(6506007)(102836004)(5660300002)(68736007)(86362001)(8936002)(52116002)(66066001)(6116002)(3846002)(7736002)(76176011)(81156014)(2906002)(81166006)(8676002)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4611;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3so1rZLFRgUqy8n8ThbBWvic4Ztw0r+HJ1FdetQdeZWahP42hYcjR1MflVqgDzZMh+/oBhYxJyDwiJ67WI0P/uA9TPRDBmi/doBdTqU2hn8CuYqNXhtoR88i6CvnCNnLdLpuIGG3WKxgtwZHelAxaUH0EDN+F2AU+B1uBfdF8QNEfBBRI1XvauJbGfgqBeG6qb23OG/eg8qlxl8vYMK84mCSkALq/5VvsU9fNjyEf7mjdaMHI0AmE4n52K3YmJ9vNs91l6lHDAxOax6WgcZvfmxPvys2Fo6SMBCdyl0O+uPWH13ZKruGbXyhDqx5i1zg0Mxb9KwgcBohAqkUuaP7zQFp4EGQRZrnbGBQ6YIqqOy/FPzVjd+r6ASOQApQEjixETzXgA9Xog8Tt3Z8OJgfGbm42JMCav4q1JevdvUbNU4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89394A9D2ACC684CBF65D85861D36958@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147ff441-2696-418e-dedc-08d6eb58a3e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 14:58:46.0820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4611
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1e::728
Subject: Re: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Count queued
 bitmaps towards nb_bitmaps
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAyMTo0MSwgSm9obiBTbm93IHdyb3RlOg0KPiBXaGVuIHdlIGNoZWNrIHRvIHNl
ZSBpZiB3ZSBjYW4gc3RvcmUgYSBiaXRtYXAsIHdlIGRvbid0IGNoZWNrIGhvdyBtYW55DQo+IHdl
J3ZlIHF1ZXVlZCB1cC4gVGhpcyBjYW4gY2F1c2UgYSBwcm9ibGVtIHNhdmluZyBiaXRtYXBzIG9u
IGNsb3NlDQo+IGluc3RlYWQgb2Ygd2hlbiB3ZSByZXF1ZXN0IHRoZW0gdG8gYmUgYWRkZWQuIFdp
dGggdGhlIHN0cmljdGVyIGFkZA0KPiBpbnRlcmZhY2UsIHByb2hpYml0IHRoZXNlIGJpdG1hcHMg
c3BlY2lmaWNhbGx5Lg0KPiANCj4gVG8gbWF0Y2gsIG1ha2UgdGhlIHJlbW92ZSBpbnRlcmZhY2Ug
bW9yZSBzdHJpY3QgYXMgd2VsbDsgbm93IHJlamVjdGluZw0KPiBhbnkgcmVxdWVzdHMgdG8gcmVt
b3ZlIGJpdG1hcHMgdGhhdCB3ZXJlIG5ldmVyIHF1ZXVlZCBmb3Igc3RvcmFnZS4NCj4gDQo+IFdl
IGRvbid0IG5lZWQgdG8gImZpbmQiIHRoZSBiaXRtYXAgd2hlbiB0aGUgaW50ZXJmYWNlIGhhcyBi
ZWVuIGdpdmVuIHRoZQ0KPiBiaXRtYXAgZXhwbGljaXRseSwgYnV0IHRoaXMgaXMgZG9uZSB0byBt
YWtlIHN1cmUgdGhhdCB0aGUgYml0bWFwIGdpdmVuDQo+IGFjdHVhbGx5IGRvZXMgYmVsb25nIHRv
IHRoZSBicyB3ZSB3ZXJlIHBhc3NlZCBhcyBhIHBhcmFub2lhIGNoZWNrIHRvDQo+IGVuZm9yY2Ug
Y29uc2lzdGVuY3kuDQoNCklmIHlvdSB3YW50IHRvIGNoZWNrIGl0LCBJJ2QgcmVhbGx5IHByZWZl
ciB0byBkbyBpdCBleHBsaWN0bHksDQpieSBhZGRpbmcgImJvb2wgYmRydl9oYXNfZGlydHlfYml0
bWFwKGJzLCBiaXRtYXApIGhhbmRsZXIsIG9yIGJpdG1hcC5icyBmaWVsZCIsDQppbnN0ZWFkIG9m
IGhpZGluZyBpdCB1bmRlciBpbmNvbnZlbmllbnQgaW50ZXJmYWNlIG9mIGhlbHBlciwgc28gd2Ug
YWN0dWFsbHkgZG8NCg0KbmFtZSA9IGJkcnZfZGlydHlfYml0bWFwX25hbWUoYml0bWFwKTsNCmJp
dG1hcCA9IGJkcnZfZmluZF9kaXJ0eV9iaXRtYXAoYnMsIG5hbWUpOw0KDQppdCByZWFsbHkgbG9v
a3Mgc3RyYW5nZS4NCg0KSG1tbSwgd2hlbiBJIHJlYWQgc2VyaWVzIGNvdmVyIGxldHRlciBhbmQg
dGhpcyBjb21taXQgbWVzc2FnZSwgSSB0aG91Z2h0DQp0aGF0IHlvdSdsbCBqdXN0IGNhbGN1bGF0
ZSBjdXJyZW50IG51bWJlciBvZiBwZXJzaXN0ZW50IGJpdG1hcHMgb24gYnMuLg0KRG8gd2UgcmVh
bGx5IG5lZWQgdG8gaW50cm9kdWNlIGFkZGl0aW9uYWwgY291bnRlcnMgb24gcWNvdzIgc3RhdGU/
DQoNClNvLCB5b3Ugd2FudCB0byBjaGVjayBuYl9xdWV1ZWQgKyBzLT5uYl9iaXRtYXBzIGluc3Rl
YWQgb2YganVzdCBzLT5uYl9iaXRtYXBzLg0KDQpJIHRoaW5rIHdlIGNhbiBqdXN0IGNvdW50IHBl
cnNpc3RlbnQgZGlydHkgYml0bWFwcyBhbmQgdGFrZSB0aGF0IG51bWJlcg0KKGFzLCB0aGVyZSBz
aG91bGQgbm90IGJlIGluLWltYWdlIGJpdG1hcHMsIGZvciB3aGljaCB3ZSBkb24ndCBoYXZlIGlu
LXJhbQ0KdmVyc2lvbiwgYnV0IHdlIGNhbiBjaGVjayBpdCB0b28gYW5kIHJldHVybiBhbiBlcnJv
ciBvbiBtaXNtYXRjaCAob3IgY291bnQNCmluLWltYWdlLW5vdC1pbi1yYW0gYml0bWFwcyBhbmQg
dGhpcyBjb3VudCB0byBudW1iZXIgb2YgaW4tcmFtIHBlcnNpc3RlbnQNCmJpdG1hcHMgaXQgc2Vl
bXMgYW4gZXh0cmEgdGhpbmcpLi4NCg0KPiANCj4gLS0tDQo+IA0KPiAiV2hhdCBhYm91dCBkaXJl
Y3Rvcnkgc2l6ZT8iIFBsZWFzZSBzZWUgdGhlIGZvbGxvd2luZyBwYXRjaC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2sv
cWNvdzIuaCAgICAgICAgfCAgMSArDQo+ICAgYmxvY2svZGlydHktYml0bWFwLmMgfCAgOCArKyst
LS0tLQ0KPiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTAgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuaCBiL2Jsb2NrL3Fjb3cy
LmgNCj4gaW5kZXggY2UwN2YwMDNmNy4uZWJmNjBhYzIzNiAxMDA2NDQNCj4gLS0tIGEvYmxvY2sv
cWNvdzIuaA0KPiArKysgYi9ibG9jay9xY293Mi5oDQo+IEBAIC0zMTcsNiArMzE3LDcgQEAgdHlw
ZWRlZiBzdHJ1Y3QgQkRSVlFjb3cyU3RhdGUgew0KPiAgICAgICBRQ293U25hcHNob3QgKnNuYXBz
aG90czsNCj4gICANCj4gICAgICAgdWludDMyX3QgbmJfYml0bWFwczsNCj4gKyAgICB1aW50MzJf
dCBuYl9xdWV1ZWRfYml0bWFwczsNCj4gICAgICAgdWludDY0X3QgYml0bWFwX2RpcmVjdG9yeV9z
aXplOw0KPiAgICAgICB1aW50NjRfdCBiaXRtYXBfZGlyZWN0b3J5X29mZnNldDsNCj4gICANCj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2RpcnR5LWJpdG1hcC5jIGIvYmxvY2svZGlydHktYml0bWFwLmMN
Cj4gaW5kZXggNDY2N2Y5ZTY1YS4uMDg0YzQyYWY1NyAxMDA2NDQNCj4gLS0tIGEvYmxvY2svZGly
dHktYml0bWFwLmMNCj4gKysrIGIvYmxvY2svZGlydHktYml0bWFwLmMNCj4gQEAgLTQ1MCwxMSAr
NDUwLDkgQEAgdm9pZCBiZHJ2X3JlbGVhc2VfbmFtZWRfZGlydHlfYml0bWFwcyhCbG9ja0RyaXZl
clN0YXRlICpicykNCj4gICB9DQo+ICAgDQo+ICAgLyoqDQo+IC0gKiBSZW1vdmUgcGVyc2lzdGVu
dCBkaXJ0eSBiaXRtYXAgZnJvbSB0aGUgc3RvcmFnZSBpZiBpdCBleGlzdHMuDQo+IC0gKiBBYnNl
bmNlIG9mIGJpdG1hcCBpcyBub3QgYW4gZXJyb3IsIGJlY2F1c2Ugd2UgaGF2ZSB0aGUgZm9sbG93
aW5nIHNjZW5hcmlvOg0KPiAtICogQmRydkRpcnR5Qml0bWFwIGNhbiBoYXZlIC5wZXJzaXN0ZW50
ID0gdHJ1ZSBidXQgbm90IHlldCBzYXZlZCBhbmQgaGF2ZSBubw0KPiAtICogc3RvcmVkIHZlcnNp
b24uIEZvciBzdWNoIGJpdG1hcCBiZHJ2X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCgp
IHNob3VsZA0KPiAtICogbm90IGZhaWwuDQo+ICsgKiBSZW1vdmUgYSBwZXJzaXN0ZW50IGRpcnR5
IGJpdG1hcCBmcm9tIHN0b3JhZ2UsDQo+ICsgKiBvciBkZXF1ZXVlIGl0IGZyb20gYmVpbmcgc3Rv
cmVkIGlmIGl0IGlzIGVucXVldWVkLg0KPiArICoNCj4gICAgKiBUaGlzIGZ1bmN0aW9uIGRvZXNu
J3QgcmVsZWFzZSB0aGUgY29ycmVzcG9uZGluZyBCZHJ2RGlydHlCaXRtYXAuDQo+ICAgICovDQo+
ICAgaW50IGJkcnZfcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzItYml0bWFwLmMgYi9ibG9jay9xY293
Mi1iaXRtYXAuYw0KPiBpbmRleCA5MzBhNmM5MWZmLi43MTkzYzY2Nzg3IDEwMDY0NA0KPiAtLS0g
YS9ibG9jay9xY293Mi1iaXRtYXAuYw0KPiArKysgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KPiBA
QCAtMTQwMiw2ICsxNDAyLDIzIEBAIHN0YXRpYyBRY293MkJpdG1hcCAqZmluZF9iaXRtYXBfYnlf
bmFtZShRY293MkJpdG1hcExpc3QgKmJtX2xpc3QsDQo+ICAgICAgIHJldHVybiBOVUxMOw0KPiAg
IH0NCj4gICANCj4gK3N0YXRpYyBpbnQgcWNvdzJfcmVtb3ZlX3F1ZXVlZF9kaXJ0eV9iaXRtYXAo
DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IGNoYXIgKm5hbWUsIEVycm9yICoq
ZXJycCkNCj4gK3sNCj4gKyAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+ICsg
ICAgQmRydkRpcnR5Qml0bWFwICpiaXRtYXAgPSBiZHJ2X2ZpbmRfZGlydHlfYml0bWFwKGJzLCBu
YW1lKTsNCj4gKyAgICBpZiAoIWJpdG1hcCkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJOb2RlICclcycgaGFzIG5vIHN0b3JlZCBvciBlbnF1ZXVlZCBiaXRtYXAgJyVzJyIsDQo+ICsg
ICAgICAgICAgICAgICAgICAgYmRydl9nZXRfbm9kZV9uYW1lKGJzKSwgbmFtZSk7DQo+ICsgICAg
ICAgIHJldHVybiAtRU5PRU5UOw0KPiArICAgIH0NCj4gKyAgICBhc3NlcnQocy0+bmJfcXVldWVk
X2JpdG1hcHMgPiAwKTsNCj4gKyAgICBhc3NlcnQoYmRydl9kaXJ0eV9iaXRtYXBfZ2V0X3BlcnNp
c3RlbmNlKGJpdG1hcCkpOw0KPiArICAgIHMtPm5iX3F1ZXVlZF9iaXRtYXBzIC09IDE7DQo+ICsN
Cj4gKyAgICByZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgIGludCBxY293Ml9yZW1vdmVfcGVyc2lz
dGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCwNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkN
Cj4gQEAgLTE0MTMsOSArMTQzMCw3IEBAIGludCBxY293Ml9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0
eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgIGNvbnN0IGNoYXIgKm5hbWUg
PSBiZHJ2X2RpcnR5X2JpdG1hcF9uYW1lKGJpdG1hcCk7DQo+ICAgDQo+ICAgICAgIGlmIChzLT5u
Yl9iaXRtYXBzID09IDApIHsNCj4gLSAgICAgICAgLyogQWJzZW5jZSBvZiB0aGUgYml0bWFwIGlz
IG5vdCBhbiBlcnJvcjogc2VlIGV4cGxhbmF0aW9uIGFib3ZlDQo+IC0gICAgICAgICAqIGJkcnZf
cmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKCkgZGVmaW5pdGlvbi4gKi8NCj4gLSAgICAg
ICAgcmV0dXJuIDA7DQo+ICsgICAgICAgIHJldHVybiBxY293Ml9yZW1vdmVfcXVldWVkX2RpcnR5
X2JpdG1hcChicywgbmFtZSwgZXJycCk7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgaWYgKChy
ZXQgPSBiaXRtYXBfbGlzdF9sb2FkKGJzLCAmYm1fbGlzdCwgZXJycCkpKSB7DQo+IEBAIC0xNDI0
LDYgKzE0MzksNyBAQCBpbnQgcWNvdzJfcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgIA0KPiAgICAgICBibSA9IGZpbmRfYml0bWFwX2J5X25h
bWUoYm1fbGlzdCwgbmFtZSk7DQo+ICAgICAgIGlmIChibSA9PSBOVUxMKSB7DQo+ICsgICAgICAg
IHJldCA9IHFjb3cyX3JlbW92ZV9xdWV1ZWRfZGlydHlfYml0bWFwKGJzLCBuYW1lLCBlcnJwKTsN
Cj4gICAgICAgICAgIGdvdG8gZmFpbDsNCj4gICAgICAgfQ0KPiAgIA0KPiBAQCAtMTU0NCw2ICsx
NTYwLDcgQEAgdm9pZCBxY293Ml9zdG9yZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcHMoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgIGVycm9yX3NldGdfZXJy
bm8oZXJycCwgLXJldCwgIkZhaWxlZCB0byB1cGRhdGUgYml0bWFwIGV4dGVuc2lvbiIpOw0KPiAg
ICAgICAgICAgZ290byBmYWlsOw0KPiAgICAgICB9DQo+ICsgICAgcy0+bmJfcXVldWVkX2JpdG1h
cHMgPSAwOw0KPiAgIA0KPiAgICAgICAvKiBCaXRtYXAgZGlyZWN0b3J5IHdhcyBzdWNjZXNzZnVs
bHkgdXBkYXRlZCwgc28sIG9sZCBkYXRhIGNhbiBiZSBkcm9wcGVkLg0KPiAgICAgICAgKiBUT0RP
IGl0IGlzIGJldHRlciB0byByZXVzZSB0aGVzZSBjbHVzdGVycyAqLw0KPiBAQCAtMTYxOCw2ICsx
NjM1LDcgQEAgaW50IHFjb3cyX2FkZF9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZl
clN0YXRlICpicywNCj4gICAgICAgUWNvdzJCaXRtYXBMaXN0ICpibV9saXN0Ow0KPiAgICAgICBj
b25zdCBjaGFyICpuYW1lID0gYmRydl9kaXJ0eV9iaXRtYXBfbmFtZShiaXRtYXApOw0KPiAgICAg
ICB1aW50MzJfdCBncmFudWxhcml0eSA9IGJkcnZfZGlydHlfYml0bWFwX2dyYW51bGFyaXR5KGJp
dG1hcCk7DQo+ICsgICAgdWludDMyX3QgbmJfYml0bWFwczsNCj4gICAgICAgaW50IHJldCA9IDA7
DQo+ICAgDQo+ICAgICAgIGlmIChzLT5xY293X3ZlcnNpb24gPCAzKSB7DQo+IEBAIC0xNjM2LDEx
ICsxNjU0LDEyIEBAIGludCBxY293Ml9hZGRfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICBnb3RvIGZhaWw7DQo+ICAgICAgIH0NCj4gICAN
Cj4gLSAgICBpZiAocy0+bmJfYml0bWFwcyA9PSAwKSB7DQo+ICsgICAgbmJfYml0bWFwcyA9IHMt
Pm5iX2JpdG1hcHMgKyBzLT5uYl9xdWV1ZWRfYml0bWFwczsNCj4gKyAgICBpZiAobmJfYml0bWFw
cyA9PSAwKSB7DQo+ICAgICAgICAgICByZXR1cm4gMDsNCj4gICAgICAgfQ0KPiAgIA0KPiAtICAg
IGlmIChzLT5uYl9iaXRtYXBzID49IFFDT1cyX01BWF9CSVRNQVBTKSB7DQo+ICsgICAgaWYgKG5i
X2JpdG1hcHMgPj0gUUNPVzJfTUFYX0JJVE1BUFMpIHsNCj4gICAgICAgICAgIGVycm9yX3NldGco
ZXJycCwNCj4gICAgICAgICAgICAgICAgICAgICAgIk1heGltdW0gbnVtYmVyIG9mIHBlcnNpc3Rl
bnQgYml0bWFwcyBpcyBhbHJlYWR5IHJlYWNoZWQiKTsNCj4gICAgICAgICAgIHJldCA9IC1FT1ZF
UkZMT1c7DQo+IEBAIC0xNjY3LDYgKzE2ODYsOCBAQCBpbnQgcWNvdzJfYWRkX3BlcnNpc3RlbnRf
ZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgZ290byBmYWls
Ow0KPiAgICAgICB9DQo+ICAgDQo+ICsgICAgcy0+bmJfcXVldWVkX2JpdG1hcHMgKz0gMTsNCj4g
Kw0KPiAgICAgICByZXR1cm4gMDsNCj4gICBmYWlsOg0KPiAgICAgICBlcnJvcl9wcmVwZW5kKGVy
cnAsICJDYW4ndCBtYWtlIGJpdG1hcCAnJXMnIHBlcnNpc3RlbnQgaW4gJyVzJzogIiwNCj4gDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


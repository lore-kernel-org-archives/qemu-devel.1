Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE0C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1272F2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cpuSzLyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1272F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGqk-0001v4-CW
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47171)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGol-0008A5-V6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGoj-0003J2-Uv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:42:19 -0400
Received: from mail-eopbgr70112.outbound.protection.outlook.com
 ([40.107.7.112]:59253 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haGoe-0003Dp-0B; Mon, 10 Jun 2019 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdWH9WLuXHpoEtv6zCV0mwOt5fARztxeAU3elwLSL3I=;
 b=cpuSzLyWlO9RBrLLo+VXz2G4BSt53rnltToCJRB9rSeJupD8VRIMK4GCOwmYzCPJJ17NzDonEeKl1gydIhEHmREuh5uzNfB9dx2Ks7H6VG4PrH9pQ8fS0r3RKKkB+00tfOsJheKFUj3CRoVGYKek4CU8K3hm0GWCM8PW1jiyYvQ=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5106.eurprd08.prod.outlook.com (10.255.30.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 09:42:06 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 09:42:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
Thread-Index: AQHVGgPwBj3MFoZcyE+HgKuZ0A6+WqaQz8YAgAQNsAD//9AHAA==
Date: Mon, 10 Jun 2019 09:42:06 +0000
Message-ID: <39132feb-128d-004b-f40c-bb64f75c3298@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <20190603120005.37394-3-vsementsov@virtuozzo.com>
 <1e937a40-5ce2-467a-a50b-e8f822f2dcdc@redhat.com>
 <f26f5edb-279e-8153-86bf-767cb04c4c74@virtuozzo.com>
In-Reply-To: <f26f5edb-279e-8153-86bf-767cb04c4c74@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::29)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610124204235
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ccad88c-1cb1-45f8-6d28-08d6ed87e68b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5106; 
x-ms-traffictypediagnostic: AM0PR08MB5106:
x-microsoft-antispam-prvs: <AM0PR08MB5106E22EBD37D948AB464183C1130@AM0PR08MB5106.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(136003)(376002)(39840400004)(52314003)(199004)(189003)(25786009)(52116002)(110136005)(76176011)(102836004)(26005)(2201001)(6116002)(6512007)(3846002)(305945005)(7736002)(6436002)(31686004)(2906002)(53936002)(6486002)(4326008)(99286004)(2501003)(8936002)(71200400001)(478600001)(186003)(14454004)(31696002)(81156014)(107886003)(316002)(229853002)(68736007)(6246003)(8676002)(14444005)(86362001)(5660300002)(256004)(71190400001)(66066001)(54906003)(486006)(446003)(476003)(2616005)(66446008)(386003)(11346002)(64756008)(6506007)(53546011)(73956011)(36756003)(66946007)(81166006)(66556008)(66476007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5106;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yicPC4E71gDr6XMS9gzj2E+d8sg5mRKfhaM8WMYf1A/6T/HpQVrZyTYxAhTlixgOh2ds7UeKGxcykHC6h6rvmfOdFJMb7AVxkSXBUaPXsnZoUHbgJZAzQt3WddbMMx9y8FXJb9TZj7LAgCBphw8hmyobGINdauoN7JWPwvLOM/G/o/U/q0f2mk7WOK/KqLXBs9K0AY4QgLKdt+fXNlGaBkMe22s8TGMcNwv0WkmODCHxSAxv5je4ChDKgxZM4QVIhe586rEs3vEWLExTZpA8E92wjywnH46E0EaKqyIfRUbB2AGlISgGQtOsN+3CpXmZWh1zQgpwbDLSfA5j9ltHsQNupdqGLKlqfiv1HOdMP15T6EhymhcK8PAITcvZJdU/a9w6Jl53+B1SKzXy1MKiMXHZiDKD7pzn2HQ0WTmJ8ZE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAB54AEE0F3AD34395E1D4D67904A417@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccad88c-1cb1-45f8-6d28-08d6ed87e68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 09:42:06.6177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5106
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.112
Subject: Re: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
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
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDYuMjAxOSAxMjozMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDguMDYuMjAxOSAxOjM5LCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDYvMy8xOSA4
OjAwIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4+IEFkZCBmdW5j
dGlvbmFsaXR5IHRvIG1ha2UgYml0bWFwIHRlbXBvcmFyeSBhbm9ueW1vdXMuIEl0IHdpbGwgYmUg
dXNlZA0KPj4+IHRvIGltcGxlbWVudCBiaXRtYXAgcmVtb3ZlIHRyYW5zYWN0aW9uIGFjdGlvbi4g
V2UgbmVlZCBoaWRlIGJpdG1hcA0KPj4+IHBlcnNpc3RlbmNlIHRvbywgYXMgdGhlcmUgYXJlIHNo
b3VsZCBub3QgYmUgdW5uYW1lZCBwZXJzaXN0ZW50IGJpdG1hcHMuDQo+Pj4NCj4+DQo+PiBBaCwg
c28gdGhpcyBlZmZlY3RpdmVseSAuLi4gImhpZGVzIiBhIGJpdG1hcCBmcm9tIGFueSBmdXJ0aGVy
DQo+PiB0cmFuc2FjdGlvbiBhY3Rpb25zLiBJdCBhbHNvICJoaWRlcyIgaXQgZnJvbSBnZXR0aW5n
IGZsdXNoZWQgdG8gZGlzay4uLg0KPj4gc29ydCBvZj8NCj4+DQo+PiBUaGUgb3V0ZXIgbG9vcCBp
biBzdG9yZSB3b3JrcyB3aXRoIGJkcnZfZGlydHlfYml0bWFwX25leHQsIGFuZCB3ZSdsbA0KPj4g
c2tpcCB0aGlzIGJpdG1hcCBiZWNhdXNlIGl0J3MgYW5vbnltb3VzL25vdCBwZXJzaXN0ZW50Lg0K
Pj4NCj4+IFRoZXJlJ3MgYSBzZWNvbmQgbG9vcCB3aGVyZSB3ZSBpdGVyYXRlIGJtX2xpc3QsIGFu
ZCB3ZSdsbCBza2lwIHN0b3JpbmcNCj4+IHRoaXMgYml0bWFwIGJlY2F1c2UgdGhhdCBlbnRyeSB3
b24ndCBoYXZlIGFuIGluLW1lbW9yeSBiaXRtYXAgYXNzb2NpYXRlZA0KPj4gd2l0aCBpdCBpbiBi
bV9saXN0Lg0KPj4NCj4+IC4uLkJ1dCB0aGVuIHdlJ2xsIGNhbGwgdXBkYXRlX2V4dF9oZWFkZXJf
YW5kX2RpciB3aXRoIHRoZSBzdGFsZSBlbnRyaWVzDQo+PiBpbiBibV9saXN0Pw0KPiANCj4gSGlk
ZGVuIGlzIGEgdGVtcHJvcnkgc3RhdGUsIHNvLCB3ZSBzaG91bGQgbm90IGdvIHRvIGNsb3NlKCkg
aW4gdGhpcyBzdGF0ZS4NCj4gSXQncyBhIHN0YXRlIGluc2lkZSBhIHRyYW5zYWN0aW9uLg0KPiAN
Cj4gU3RhbGUgZW50cmllcyBpbiBsaXN0IHdpbGwgYmUgbWFya2VkIElOX1VTRSBhbnl3YXksIHNv
IHRoZXJlIGlzIG5vIGRhbWFnZSBhbnl3YXkuDQoNCkknbSB3cm9uZywgc3RvcmluZyBpbnNpZGUg
dHJhbnNhY3Rpb24gaXMgZXhhY3RseSB3aGF0IHRlc3QgZG9lcy4uIEhtbSwgc28sIHNlZW1zIHlv
dQ0KYXJlIHJpZ2h0LCB3ZSBhcmUgc3RvcmluZyBzdGFsZSBJTl9VU0UgYml0bWFwcy4gTm8gc2Vy
aW91cyBkYW1hZ2UsIGJ1dCBiYWQgZGVzaWduOg0KY3JlYXRpbmcgaW5jb25zaXN0ZW50IGJpdG1h
cHMgaW4gZWFjaCBzbmFwc2hvdC4gSSBuZWVkIHRvIGZpeCBpdCBpbiB2MiBzb21laG93Lg0KDQo+
IA0KPj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgaW5jbHVkZS9ibG9jay9k
aXJ0eS1iaXRtYXAuaCB8wqAgMiArKw0KPj4+IMKgIGJsb2NrL2RpcnR5LWJpdG1hcC5jwqDCoMKg
wqDCoMKgwqDCoCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqAgMiBmaWxl
cyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCBiL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmgNCj4+
PiBpbmRleCA4MDQ0YWNlNjNlLi41NDJlNDM3MTIzIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUv
YmxvY2svZGlydHktYml0bWFwLmgNCj4+PiArKysgYi9pbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1h
cC5oDQo+Pj4gQEAgLTExNiw1ICsxMTYsNyBAQCBib29sIGJkcnZfZGlydHlfYml0bWFwX25leHRf
ZGlydHlfYXJlYShCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCwNCj4+PiDCoCBCZHJ2RGlydHlCaXRt
YXAgKmJkcnZfcmVjbGFpbV9kaXJ0eV9iaXRtYXBfbG9ja2VkKEJsb2NrRHJpdmVyU3RhdGUgKmJz
LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBCZHJ2
RGlydHlCaXRtYXAgKmJpdG1hcCwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgRXJyb3IgKiplcnJwKTsNCj4+PiArdm9pZCBiZHJ2X2RpcnR5X2JpdG1h
cF9oaWRlKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwKTsNCj4+PiArdm9pZCBiZHJ2X2RpcnR5X2Jp
dG1hcF91bmhpZGUoQmRydkRpcnR5Qml0bWFwICpiaXRtYXApOw0KPj4+IMKgICNlbmRpZg0KPj4+
IGRpZmYgLS1naXQgYS9ibG9jay9kaXJ0eS1iaXRtYXAuYyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5j
DQo+Pj4gaW5kZXggNDk2NDZhMzBlNi4uNTkyOTY0NjM1ZSAxMDA2NDQNCj4+PiAtLS0gYS9ibG9j
ay9kaXJ0eS1iaXRtYXAuYw0KPj4+ICsrKyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+Pj4gQEAg
LTM1LDYgKzM1LDEwIEBAIHN0cnVjdCBCZHJ2RGlydHlCaXRtYXAgew0KPj4+IMKgwqDCoMKgwqAg
Ym9vbCBidXN5O8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQml0bWFwIGlz
IGJ1c3ksIGl0IGNhbid0IGJlIHVzZWQgdmlhIFFNUCAqLw0KPj4+IMKgwqDCoMKgwqAgQmRydkRp
cnR5Qml0bWFwICpzdWNjZXNzb3I7IC8qIEFub255bW91cyBjaGlsZCwgaWYgYW55LiAqLw0KPj4+
IMKgwqDCoMKgwqAgY2hhciAqbmFtZTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBPcHRpb25hbCBub24tZW1wdHkgdW5pcXVlIElEICovDQo+Pj4gK8KgwqDCoCBjaGFyICpoaWRk
ZW5fbmFtZTvCoMKgwqDCoMKgwqDCoMKgwqAgLyogQmFja3VwIG9mIEBuYW1lIGZvciByZW1vdmFs
IHRyYW5zYWN0aW9uDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFjdGlvbi4gVXNlZCBmb3IgaGlkZS91bmhp
ZGUgQVBJLiAqLw0KPj4+ICvCoMKgwqAgYm9vbCBoaWRkZW5fcGVyc2lzdGVudDvCoMKgwqDCoCAv
KiBCYWNrdXAgb2YgQHBlcnNpc3RlbnQgZm9yIHJlbW92YWwgdHJhbnNhY3Rpb24NCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYWN0aW9uLiAqLw0KPj4+IMKgwqDCoMKgwqAgaW50NjRfdCBzaXplO8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogU2l6ZSBvZiB0aGUgYml0bWFwLCBpbiBieXRlcyAqLw0K
Pj4+IMKgwqDCoMKgwqAgYm9vbCBkaXNhYmxlZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBCaXRtYXAgaXMgZGlzYWJsZWQuIEl0IGlnbm9yZXMgYWxsIHdyaXRlcyB0bw0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0aGUgZGV2aWNlICovDQo+Pj4gQEAgLTg0OSwzICs4NTMsMjUgQEAgb3V0Og0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X211dGV4X3VubG9jayhzcmMtPm11dGV4KTsNCj4+
PiDCoMKgwqDCoMKgIH0NCj4+PiDCoCB9DQo+Pj4gKw0KPj4+ICt2b2lkIGJkcnZfZGlydHlfYml0
bWFwX2hpZGUoQmRydkRpcnR5Qml0bWFwICpiaXRtYXApDQo+Pj4gK3sNCj4+PiArwqDCoMKgIHFl
bXVfbXV0ZXhfbG9jayhiaXRtYXAtPm11dGV4KTsNCj4+PiArwqDCoMKgIGFzc2VydCghYml0bWFw
LT5oaWRkZW5fbmFtZSk7DQo+Pj4gK8KgwqDCoCBiaXRtYXAtPmhpZGRlbl9uYW1lID0gYml0bWFw
LT5uYW1lOw0KPj4+ICvCoMKgwqAgYml0bWFwLT5oaWRkZW5fcGVyc2lzdGVudCA9IGJpdG1hcC0+
cGVyc2lzdGVudDsNCj4+PiArwqDCoMKgIGJpdG1hcC0+bmFtZSA9IE5VTEw7DQo+Pj4gK8KgwqDC
oCBiaXRtYXAtPnBlcnNpc3RlbnQgPSBmYWxzZTsNCj4+PiArwqDCoMKgIHFlbXVfbXV0ZXhfdW5s
b2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICt2b2lkIGJkcnZfZGlydHlf
Yml0bWFwX3VuaGlkZShCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCkNCj4+PiArew0KPj4+ICvCoMKg
wqAgcWVtdV9tdXRleF9sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+ICvCoMKgwqAgYXNzZXJ0KCFi
aXRtYXAtPm5hbWUpOw0KPj4+ICvCoMKgwqAgYml0bWFwLT5uYW1lID0gYml0bWFwLT5oaWRkZW5f
bmFtZTsNCj4+PiArwqDCoMKgIGJpdG1hcC0+cGVyc2lzdGVudCA9IGJpdG1hcC0+aGlkZGVuX3Bl
cnNpc3RlbnQ7DQo+Pj4gK8KgwqDCoCBiaXRtYXAtPmhpZGRlbl9uYW1lID0gTlVMTDsNCj4+PiAr
wqDCoMKgIGJpdG1hcC0+aGlkZGVuX3BlcnNpc3RlbnQgPSBmYWxzZTsNCj4+PiArwqDCoMKgIHFl
bXVfbXV0ZXhfdW5sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+ICt9DQo+Pj4NCj4gDQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

